Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C28C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 21:04:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5C020868
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 21:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5C020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435VPX5JznzDrRL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 08:04:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=zohar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435VJY2JxYzDrQh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 07:59:37 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wATKwnbG105773
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 15:59:35 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p2p55kyf9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 15:59:34 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.ibm.com>;
 Thu, 29 Nov 2018 20:59:32 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 29 Nov 2018 20:59:26 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wATKxPsF8520020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Nov 2018 20:59:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D557FA405B;
 Thu, 29 Nov 2018 20:59:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA5B0A405F;
 Thu, 29 Nov 2018 20:59:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.103.235])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 29 Nov 2018 20:59:23 +0000 (GMT)
Subject: Re: [PATCH v8 04/14] integrity: Introduce struct evm_xattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 linux-integrity@vger.kernel.org
Date: Thu, 29 Nov 2018 15:59:12 -0500
In-Reply-To: <20181116200712.14154-5-bauerman@linux.ibm.com>
References: <20181116200712.14154-1-bauerman@linux.ibm.com>
 <20181116200712.14154-5-bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112920-0028-0000-0000-000003238C40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112920-0029-0000-0000-000023DF9E7F
Message-Id: <1543525152.3902.411.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-29_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290175
X-Mailman-Approved-At: Fri, 30 Nov 2018 08:02:09 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-doc@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
 David Howells <dhowells@redhat.com>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-11-16 at 18:07 -0200, Thiago Jung Bauermann wrote:
> Even though struct evm_ima_xattr_data includes a fixed-size array to hold a
> SHA1 digest, most of the code ignores the array and uses the struct to mean
> "type indicator followed by data of unspecified size" and tracks the real
> size of what the struct represents in a separate length variable.
> 
> The only exception to that is the EVM code, which correctly uses the
> definition of struct evm_ima_xattr_data.
> 
> So make this explicit in the code by removing the length specification from
> the array in struct evm_ima_xattr_data. Also, change the name of the
> element from digest to data since in most places the array doesn't hold a
> digest.
> 
> A separate struct evm_xattr is introduced, with the original definition of
> evm_ima_xattr_data to be used in the places that actually expect that
> definition.

, specifically the EVM HMAC code.

> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Other than commenting the evm_xattr usage is limited to HMAC before
the structure definition, this looks good.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/integrity/evm/evm_main.c     | 8 ++++----
>  security/integrity/ima/ima_appraise.c | 7 ++++---
>  security/integrity/integrity.h        | 5 +++++
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 7f3f54d89a6e..a1b42d10efc7 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -169,7 +169,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  	/* check value type */
>  	switch (xattr_data->type) {
>  	case EVM_XATTR_HMAC:
> -		if (xattr_len != sizeof(struct evm_ima_xattr_data)) {
> +		if (xattr_len != sizeof(struct evm_xattr)) {
>  			evm_status = INTEGRITY_FAIL;
>  			goto out;
>  		}
> @@ -179,7 +179,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  				   xattr_value_len, &digest);
>  		if (rc)
>  			break;
> -		rc = crypto_memneq(xattr_data->digest, digest.digest,
> +		rc = crypto_memneq(xattr_data->data, digest.digest,
>  				   SHA1_DIGEST_SIZE);
>  		if (rc)
>  			rc = -EINVAL;
> @@ -523,7 +523,7 @@ int evm_inode_init_security(struct inode *inode,
>  				 const struct xattr *lsm_xattr,
>  				 struct xattr *evm_xattr)
>  {
> -	struct evm_ima_xattr_data *xattr_data;
> +	struct evm_xattr *xattr_data;
>  	int rc;
>  
>  	if (!evm_key_loaded() || !evm_protected_xattr(lsm_xattr->name))
> @@ -533,7 +533,7 @@ int evm_inode_init_security(struct inode *inode,
>  	if (!xattr_data)
>  		return -ENOMEM;
>  
> -	xattr_data->type = EVM_XATTR_HMAC;
> +	xattr_data->data.type = EVM_XATTR_HMAC;
>  	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
>  	if (rc < 0)
>  		goto out;
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index deec1804a00a..8bcef90939f8 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -167,7 +167,8 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
>  		return sig->hash_algo;
>  		break;
>  	case IMA_XATTR_DIGEST_NG:
> -		ret = xattr_value->digest[0];
> +		/* first byte contains algorithm id */
> +		ret = xattr_value->data[0];
>  		if (ret < HASH_ALGO__LAST)
>  			return ret;
>  		break;
> @@ -175,7 +176,7 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
>  		/* this is for backward compatibility */
>  		if (xattr_len == 21) {
>  			unsigned int zero = 0;
> -			if (!memcmp(&xattr_value->digest[16], &zero, 4))
> +			if (!memcmp(&xattr_value->data[16], &zero, 4))
>  				return HASH_ALGO_MD5;
>  			else
>  				return HASH_ALGO_SHA1;
> @@ -274,7 +275,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  			/* xattr length may be longer. md5 hash in previous
>  			   version occupied 20 bytes in xattr, instead of 16
>  			 */
> -			rc = memcmp(&xattr_value->digest[hash_start],
> +			rc = memcmp(&xattr_value->data[hash_start],
>  				    iint->ima_hash->digest,
>  				    iint->ima_hash->length);
>  		else
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index e60473b13a8d..20ac02bf1b84 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -79,6 +79,11 @@ enum evm_ima_xattr_type {
>  
>  struct evm_ima_xattr_data {
>  	u8 type;
> +	u8 data[];
> +} __packed;
> +

Please add a comment here saying that evm_xattr is limited to HMAC.

> +struct evm_xattr {
> +	struct evm_ima_xattr_data data;
>  	u8 digest[SHA1_DIGEST_SIZE];
>  } __packed;
>  

