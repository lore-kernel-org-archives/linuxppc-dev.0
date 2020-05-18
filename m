Return-Path: <SRS0=1bSx=7A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD493C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 22:58:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E29207F9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 22:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jXg2wpaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E29207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49QvZQ5nyfzDqly
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 08:58:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jXg2wpaX; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49QvXT6DDQzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2020 08:56:57 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id x15so5654011pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2020 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0xdAxuqwLSAR4wU4rxIu2ac9SKwG/LSGWIocJ0QtT6w=;
 b=jXg2wpaX0CwdrQaS00pYNMaIEh7CEHl6tslWLzd+iibMUU5UvqbxUyYj7ffChZY0GG
 YPb3Xi6zizo+p5J8WbYJSzHS5vb5CRReaQbq96YarkGjGc4CIWFgQv6lHDJW0Jg0GT1/
 9qIMvrY3ACO9C9XGbr/hZOfQqV7NmF2J6mWH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0xdAxuqwLSAR4wU4rxIu2ac9SKwG/LSGWIocJ0QtT6w=;
 b=PI/tfo/78HccIg3qjy9rRTwc7cYSULob/QLZXFvwP3pRtxdpt3f7cllpBUfKEmBIT0
 DyieVu2EK17AHA2zzhAu81HRdRfs7hDYZkQ7KqvlnExSmYBUUbpPYG62b4d1CaFLPE60
 nDeLiUig0juNqnYB2JL+O/jvNUR1iFwP7+QEwd1GkqNlXjcBJ759ynx59DwsmXLhDu7i
 kvYM+gaQZ+SSMtE4+DWKdlXz+dyzJZtLBS8hibPYdf3jmUl92bjKqJSwetIVhl7ie2yZ
 drFaVGsuWZYjMIeZkObG2wyUiQlFNpn7CjnB0/fHxlORGRDZVG8gOnCQkrgpR0uyNFyP
 ZZxQ==
X-Gm-Message-State: AOAM530KdFIFnEFCIblXtwL/a2IB+VbPJoUn3HgIMMNGAuyG5vT8Wf28
 3R0AJ91r2XzO4P6AJ4+4N8ttMg==
X-Google-Smtp-Source: ABdhPJyKF51sCRODFCXTmnA674qG1KM8BNV3JMUFs5tmiJRRPukmQtLiPYLhoGwBRe+S+Lctt3Azbw==
X-Received: by 2002:a63:3545:: with SMTP id c66mr2903262pga.82.1589842613663; 
 Mon, 18 May 2020 15:56:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id p62sm9602982pfb.93.2020.05.18.15.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 15:56:52 -0700 (PDT)
Date: Mon, 18 May 2020 15:56:51 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] soc: fsl: qe: Replace one-element array and use
 struct_size() helper
Message-ID: <202005181529.C0CB448FBB@keescook>
References: <20200518221904.GA22274@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518221904.GA22274@embeddedor>
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 18, 2020 at 05:19:04PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of one-element arrays in the following
> form:
> 
> struct something {
>     int length;
>     u8 data[1];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
> 
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
> 
> Also, make use of the new struct_size() helper to properly calculate the
> size of struct qe_firmware.
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> _manually_.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/soc/fsl/qe/qe.c | 4 ++--
>  include/soc/fsl/qe/qe.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 447146861c2c1..2df20d6f85fa4 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -448,7 +448,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
>  	unsigned int i;
>  	unsigned int j;
>  	u32 crc;
> -	size_t calc_size = sizeof(struct qe_firmware);
> +	size_t calc_size;
>  	size_t length;
>  	const struct qe_header *hdr;
>  
> @@ -480,7 +480,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
>  	}
>  
>  	/* Validate the length and check if there's a CRC */
> -	calc_size += (firmware->count - 1) * sizeof(struct qe_microcode);
> +	calc_size = struct_size(firmware, microcode, firmware->count);
>  
>  	for (i = 0; i < firmware->count; i++)
>  		/*
> diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> index e282ac01ec081..3feddfec9f87d 100644
> --- a/include/soc/fsl/qe/qe.h
> +++ b/include/soc/fsl/qe/qe.h
> @@ -307,7 +307,7 @@ struct qe_firmware {
>  		u8 revision;		/* The microcode version revision */
>  		u8 padding;		/* Reserved, for alignment */
>  		u8 reserved[4];		/* Reserved, for future expansion */
> -	} __attribute__ ((packed)) microcode[1];
> +	} __packed microcode[];
>  	/* All microcode binaries should be located here */
>  	/* CRC32 should be located here, after the microcode binaries */
>  } __attribute__ ((packed));
> -- 
> 2.26.2
> 

Hm, looking at this code, I see a few other things that need to be
fixed:

1) drivers/tty/serial/ucc_uart.c does not do a be32_to_cpu() conversion
   on the length test (understandably, a little-endian system has never run
   this code since it's ppc specific), but it's still wrong:

	if (firmware->header.length != fw->size) {

   compare to the firmware loader:

	length = be32_to_cpu(hdr->length);

2) drivers/soc/fsl/qe/qe.c does not perform bounds checking on the
   per-microcode offsets, so the uploader might send data outside the
   firmware buffer. Perhaps:


diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 447146861c2c..c4e0bc452f03 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -451,6 +451,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	size_t calc_size = sizeof(struct qe_firmware);
 	size_t length;
 	const struct qe_header *hdr;
+	void *firmware_end;
 
 	if (!firmware) {
 		printk(KERN_ERR "qe-firmware: invalid pointer\n");
@@ -491,19 +492,39 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 		calc_size += sizeof(__be32) *
 			be32_to_cpu(firmware->microcode[i].count);
 
-	/* Validate the length */
+	/* Validate total length */
 	if (length != calc_size + sizeof(__be32)) {
 		printk(KERN_ERR "qe-firmware: invalid length\n");
 		return -EPERM;
 	}
 
 	/* Validate the CRC */
-	crc = be32_to_cpu(*(__be32 *)((void *)firmware + calc_size));
+	firmware_end = (void *)firmware + calc_size;
+	crc = be32_to_cpu(*(__be32 *)firmware_end);
 	if (crc != crc32(0, firmware, calc_size)) {
 		printk(KERN_ERR "qe-firmware: firmware CRC is invalid\n");
 		return -EIO;
 	}
 
+	/* Validate ucode lengths and offsets */
+	for (i = 0; i < firmware->count; i++) {
+		const struct qe_microcode *ucode = &firmware->microcode[i];
+		__be32 *code;
+		size_t count;
+
+		if (!ucode->code_offset)
+			continue;
+
+		code = (void *)firmware + be32_to_cpu(ucode->code_offset);
+		count = be32_to_cpu(ucode->count) * sizeof(*code);
+
+		if (code < firmware || code >= firmware_end ||
+		    code + count < firmware || code + count >= firmware_end) {
+			printk(KERN_ERR "qe-firmware: invalid ucode offset\n");
+			return -EIO;
+		}
+	}
+
 	/*
 	 * If the microcode calls for it, split the I-RAM.
 	 */


I haven't tested this.


-- 
Kees Cook
