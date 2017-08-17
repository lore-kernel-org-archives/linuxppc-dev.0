Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY9VZ0jXDzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 01:43:49 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HFesse107551
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 11:43:47 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cdbx38ymf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 11:43:46 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 18 Aug 2017 01:43:41 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7HFhcYa40173608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 01:43:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7HFhSBw028071
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 01:43:29 +1000
Subject: Re: [PATCH v4 7/7] ima: Support module-style appended signatures
 for appraisal
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
Date: Thu, 17 Aug 2017 11:43:30 -0400
In-Reply-To: <20170804220330.30026-8-bauerman@linux.vnet.ibm.com>
References: <20170804220330.30026-1-bauerman@linux.vnet.ibm.com>
 <20170804220330.30026-8-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1502984610.3172.41.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 87d2b601cf8e..5a244ebc61d9 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -190,6 +190,64 @@ int ima_read_xattr(struct dentry *dentry,
>  	return ret;
>  }
> 
> +static void process_xattr_error(int rc, struct integrity_iint_cache *iint,
> +				int opened, char const **cause,
> +				enum integrity_status *status)
> +{
> +	if (rc && rc != -ENODATA)
> +		return;
> +
> +	*cause = iint->flags & IMA_DIGSIG_REQUIRED ?
> +		"IMA-signature-required" : "missing-hash";
> +	*status = INTEGRITY_NOLABEL;
> +
> +	if (opened & FILE_CREATED)
> +		iint->flags |= IMA_NEW_FILE;
> +
> +	if ((iint->flags & IMA_NEW_FILE) &&
> +	    !(iint->flags & IMA_DIGSIG_REQUIRED))
> +		*status = INTEGRITY_PASS;
> +}
> +
> +static int appraise_modsig(struct integrity_iint_cache *iint,
> +			   struct evm_ima_xattr_data *xattr_value,
> +			   int xattr_len)
> +{
> +	enum hash_algo algo;
> +	const void *digest;
> +	void *buf;
> +	int rc, len;
> +	u8 dig_len;
> +
> +	rc = ima_modsig_verify(INTEGRITY_KEYRING_IMA, xattr_value);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * The signature is good. Now let's put the sig hash
> +	 * into the iint cache so that it gets stored in the
> +	 * measurement list.
> +	 */
> +
> +	rc = ima_get_modsig_hash(xattr_value, &algo, &digest, &dig_len);
> +	if (rc)
> +		return rc;
> +
> +	len = sizeof(iint->ima_hash) + dig_len;
> +	buf = krealloc(iint->ima_hash, len, GFP_NOFS);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	iint->ima_hash = buf;
> +	iint->flags |= IMA_DIGSIG;
> +	iint->ima_hash->algo = algo;
> +	iint->ima_hash->length = dig_len;
> +
> +	memcpy(iint->ima_hash->digest, digest, dig_len);
> +
> +	return 0;
> +}

Depending on the IMA policy, the file could already have been
measured.  That measurement list entry might include the file
signature, as stored in the xattr, in the ima-sig template data.

I think even if a measurement list entry exists, we would want an
additional measurement list entry, which includes the appended
signature in the ima-sig template data.

Mimi
