Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1518CCA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 15:51:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4DD206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 15:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OPNp118P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4DD206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4707rK725gzDqrV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 02:51:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4707nS1QjgzDqq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2019 02:48:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.b="OPNp118P"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4707nR6jVzz8tG8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2019 02:48:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4707nR5r3Nz9sPf; Sat, 26 Oct 2019 02:48:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.b="OPNp118P"; dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by ozlabs.org (Postfix) with ESMTP id 4707nQ67Trz9sPZ;
 Sat, 26 Oct 2019 02:48:42 +1100 (AEDT)
Received: from [10.137.112.108] (unknown [131.107.174.108])
 by linux.microsoft.com (Postfix) with ESMTPSA id B10032010AC4;
 Fri, 25 Oct 2019 08:48:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B10032010AC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1572018520;
 bh=VqpwUPOPMcK+Zifw/xr8/Sr04QZ7T6h/gmJp30tzyqQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OPNp118PxVVoYe9hxq8LDH2b5gGiYI3BrcLqcP5ow+qfbj84HwK8kQHca0Q0qmLGa
 7FUDodUbpcpbEDMYUvdQFvZoYoCQPYV/9Az8TJGuNT1rrgmr+SGjZZdi56xFsuAPE1
 VteNvsPaXnA0WBZGAWcyEXbVzX0GCwBOTIrdSzxM=
Subject: Re: [PATCH v5 1/4] powerpc/powernv: Add OPAL API interface to access
 secure variable
To: Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20191025004729.4452-1-nayna@linux.ibm.com>
 <20191025004729.4452-2-nayna@linux.ibm.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6ccea081-12a5-302f-331b-29ac06f3b228@linux.microsoft.com>
Date: Fri, 25 Oct 2019 08:48:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025004729.4452-2-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 Elaine Palmer <erpalmer@us.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/24/19 5:47 PM, Nayna Jain wrote:

> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 378e3997845a..c1f25a760eb1 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -211,7 +211,10 @@
>   #define OPAL_MPIPL_UPDATE			173
>   #define OPAL_MPIPL_REGISTER_TAG			174
>   #define OPAL_MPIPL_QUERY_TAG			175
> -#define OPAL_LAST				175
> +#define OPAL_SECVAR_GET				176
> +#define OPAL_SECVAR_GET_NEXT			177
> +#define OPAL_SECVAR_ENQUEUE_UPDATE		178
> +#define OPAL_LAST				178

Adjust indentation in the above #defines.

> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index a0cf8fba4d12..9986ac34b8e2 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -298,6 +298,13 @@ int opal_sensor_group_clear(u32 group_hndl, int token);
>   int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
>   int opal_nx_coproc_init(uint32_t chip_id, uint32_t ct);
>   
> +int opal_secvar_get(const char *key, uint64_t key_len, u8 *data,
> +		    uint64_t *data_size);
> +int opal_secvar_get_next(const char *key, uint64_t *key_len,
> +			 uint64_t key_buf_size);
> +int opal_secvar_enqueue_update(const char *key, uint64_t key_len, u8 *data,
> +			       uint64_t data_size);
> +
Fix alignment of the parameters in the 2nd line.
Same comment in a few other files in this change set.


> +
> +static int opal_get_variable(const char *key, uint64_t ksize,
> +			     u8 *data, uint64_t *dsize)
> +{
> +	int rc;
> +
> +	if (!key || !dsize)
> +		return -EINVAL;
> +
> +	*dsize = cpu_to_be64(*dsize);
> +
> +	rc = opal_secvar_get(key, ksize, data, dsize);
> +
> +	*dsize = be64_to_cpu(*dsize);

Is it ok to update dsize even if return code (rc) from opal_secvar_get 
is an error? Just wanted to confirm.

> +
> +	*keylen = cpu_to_be64(*keylen);
> +
> +	rc = opal_secvar_get_next(key, keylen, keybufsize);
> +
> +	*keylen = be64_to_cpu(*keylen);
Same comment as above.

> +
> +	set_secvar_ops(&opal_secvar_ops);
Does this set function return status?

> +
> +	return 0;
> +}
