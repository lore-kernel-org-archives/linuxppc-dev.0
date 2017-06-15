Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpSt56JdZzDqLN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 02:01:33 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5FFx7Zx059152
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 12:01:31 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b3gvqrrg6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 12:01:31 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 02:01:28 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5FG1Q9b4260194
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 02:01:26 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5FG1NJr018668
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 02:01:24 +1000
Subject: Re: [PATCH v2 3/6] ima: Log the same audit cause whenever a file
 has no signature
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org
Cc: linux-ima-devel@lists.sourceforge.net, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Jessica Yu <jeyu@redhat.com>, Rusty Russell
 <rusty@rustcorp.com.au>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, "AKASHI, Takahiro"
 <takahiro.akashi@linaro.org>
Date: Thu, 15 Jun 2017 12:00:56 -0400
In-Reply-To: <1496886555-10082-4-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1496886555-10082-4-git-send-email-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1497542456.4287.57.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-07 at 22:49 -0300, Thiago Jung Bauermann wrote:
> If the file doesn't have an xattr, ima_appraise_measurement sets cause to
> "missing-hash" while if there's an xattr but it's a digest instead of a
> signature it sets cause to "IMA-signature-required".
> 
> Fix it by setting cause to "IMA-signature-required" in both cases.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Thank you.  Queued to be upstreamed.

Mimi
> ---
>  security/integrity/ima/ima_appraise.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index ea36a4f134f4..809ba70fbbbf 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -217,7 +217,8 @@ int ima_appraise_measurement(enum ima_hooks func,
>  		if (rc && rc != -ENODATA)
>  			goto out;
> 
> -		cause = "missing-hash";
> +		cause = iint->flags & IMA_DIGSIG_REQUIRED ?
> +				"IMA-signature-required" : "missing-hash";
>  		status = INTEGRITY_NOLABEL;
>  		if (opened & FILE_CREATED)
>  			iint->flags |= IMA_NEW_FILE;
