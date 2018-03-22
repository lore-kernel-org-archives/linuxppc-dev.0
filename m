Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406j575QCLzF1rZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 10:08:11 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MN5Tx8011714
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 19:08:09 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gvhp71psp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 19:08:08 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 23:08:06 -0000
Subject: Re: [PATCH v6 03/12] PKCS#7: Introduce pkcs7_get_digest()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 David Howells <dhowells@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Thu, 22 Mar 2018 19:07:58 -0400
In-Reply-To: <20180316203837.10174-4-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
 <20180316203837.10174-4-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521760078.3848.301.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-16 at 17:38 -0300, Thiago Jung Bauermann wrote:
> IMA will need to access the digest of the PKCS7 message (as calculated by
> the kernel) before the signature is verified, so introduce
> pkcs7_get_digest() for that purpose.
> 
> Also, modify pkcs7_digest() to detect when the digest was already
> calculated so that it doesn't have to do redundant work. Verifying that
> sinfo->sig->digest isn't NULL is sufficient because both places which
> allocate sinfo->sig (pkcs7_parse_message() and pkcs7_note_signed_info())
> use kzalloc() so sig->digest is always initialized to zero.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>

Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  crypto/asymmetric_keys/pkcs7_verify.c | 25 +++++++++++++++++++++++++
>  include/crypto/pkcs7.h                |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
> index 39e6de0c2761..bd02360f8be5 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -33,6 +33,10 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
> 
>  	kenter(",%u,%s", sinfo->index, sinfo->sig->hash_algo);
> 
> +	/* The digest was calculated already. */
> +	if (sig->digest)
> +		return 0;
> +
>  	if (!sinfo->sig->hash_algo)
>  		return -ENOPKG;
> 
> @@ -122,6 +126,27 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
>  	return ret;
>  }
> 
> +int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u8 *len)
> +{
> +	struct pkcs7_signed_info *sinfo = pkcs7->signed_infos;
> +	int ret;
> +
> +	/*
> +	 * This function doesn't support messages with more than one signature.
> +	 */
> +	if (sinfo == NULL || sinfo->next != NULL)
> +		return -EBADMSG;
> +
> +	ret = pkcs7_digest(pkcs7, sinfo);
> +	if (ret)
> +		return ret;
> +
> +	*buf = sinfo->sig->digest;
> +	*len = sinfo->sig->digest_size;
> +
> +	return 0;
> +}
> +
>  /*
>   * Find the key (X.509 certificate) to use to verify a PKCS#7 message.  PKCS#7
>   * uses the issuer's name and the issuing certificate serial number for
> diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
> index 6f51d0cb6d12..cfaea9c37f4a 100644
> --- a/include/crypto/pkcs7.h
> +++ b/include/crypto/pkcs7.h
> @@ -46,4 +46,7 @@ extern int pkcs7_verify(struct pkcs7_message *pkcs7,
>  extern int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
>  				      const void *data, size_t datalen);
> 
> +extern int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf,
> +			    u8 *len);
> +
>  #endif /* _CRYPTO_PKCS7_H */
> 
