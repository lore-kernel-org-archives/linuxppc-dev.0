Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNXj74cGnzDqjP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 00:38:03 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v73EZZLk004296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 10:37:59 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c45c89p63-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 10:37:59 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 00:37:56 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v73EbrYq28901628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 00:37:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v73Ebq3d011290
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 00:37:53 +1000
Subject: Re: [PATCH v3 7/7] ima: Support module-style appended signatures
 for appraisal
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Jessica Yu <jeyu@redhat.com>, Rusty Russell
 <rusty@rustcorp.com.au>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, "AKASHI, Takahiro"
 <takahiro.akashi@linaro.org>
Date: Thu, 03 Aug 2017 10:37:45 -0400
In-Reply-To: <1501714334.27872.38.camel@linux.vnet.ibm.com>
References: <20170706221753.17380-1-bauerman@linux.vnet.ibm.com>
 <20170706221753.17380-8-bauerman@linux.vnet.ibm.com>
 <1501424988.9230.67.camel@linux.vnet.ibm.com>
 <87fud9yig8.fsf@linux.vnet.ibm.com>
 <1501714334.27872.38.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1501771065.27872.63.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 18:52 -0400, Mimi Zohar wrote:
> On Wed, 2017-08-02 at 14:42 -0300, Thiago Jung Bauermann wrote:
> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> > >> @@ -229,8 +251,24 @@ int ima_appraise_measurement(enum ima_hooks func,
> > >>  		goto out;
> > >>  	}
> > >> 
> > >> -	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
> > >> -	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN)) {
> > >> +	/*
> > >> +	 * Appended signatures aren't protected by EVM but we still call
> > >> +	 * evm_verifyxattr to check other security xattrs, if they exist.
> > >> +	 */
> > >> +	if (appraising_modsig) {
> > >> +		xattr_value_evm = NULL;
> > >> +		xattr_len_evm = 0;
> > >> +	} else {
> > >> +		xattr_value_evm = xattr_value;
> > >> +		xattr_len_evm = xattr_len;
> > >> +	}
> > >> +
> > >> +	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value_evm,
> > >> +				 xattr_len_evm, iint);
> > >> +	if (appraising_modsig && status == INTEGRITY_FAIL) {
> > >> +		cause = "invalid-HMAC";
> > >> +		goto out;
> > >
> > > "modsig" is special, because having any security xattrs is not
> > > required. This test doesn't prevent status from being set to
> > > "missing-HMAC". This test is redundant with the original tests below.
> > 
> > Indeed, that is wrong. I'm still a bit fuzzy about how EVM works and how
> > it interacts with IMA. The only way I can think of singling out modsig
> > without reintroduced the complex expression you didn't like in v2 is as
> > below. What do you think?
> 
> The original code, without any extra tests, should be fine.

There is one major difference.

EVM verifies a file's metadata has not been modified based on either
an HMAC or signature stored as security.evm.  Prior to the appended
signatures patch set, all files in policy required a security.evm
xattr. With IMA enabled we could guarantee that at least one security
xattr existed.  The only exception were new files, which hadn't yet
been labeled. 

With appended signatures, there is now no guarantee that at least one
security xattr exists.

Perhaps the code snippet below will help clarify the meaning of the
integrity_status results. 

        switch (status) {
        case INTEGRITY_PASS:
        case INTEGRITY_UNKNOWN:      
              break;		
        case INTEGRITY_NOXATTRS:        /* no EVM protected xattrs */
                if (appraising_modsig)
                        break;
        case INTEGRITY_NOLABEL:         /* no security.evm xattr */
                cause = "missing-HMAC";
                fail = 1;
                break;
        case INTEGRITY_FAIL:            /* invalid HMAC/signature */
        default:
                cause = "invalid-HMAC";
                fail = 1;
                break;
        }

Mimi
