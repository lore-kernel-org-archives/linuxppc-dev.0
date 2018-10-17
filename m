Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D2ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 13:05:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B973D21470
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 13:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oi/uG5Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B973D21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zsq014jKzF3ZW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 00:05:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oi/uG5Y/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oi/uG5Y/"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZshD5JSpzF3VM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 23:59:24 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id f18-v6so12675670plr.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uz45d3VsNy7VQtcXK64lVjOwo9NcbqUTCfX5UcI3TVU=;
 b=oi/uG5Y/qDsFdgy9JFxVe3BFrNnB0EgZGgzKP+xePBodAXcV6GPhBF9A11CJYIkM7B
 jyx91FwElGdMjRyLdLd9pW6RGvCniTN+9Q9aflaWvqAR7sNgcD8I5Pzu74y1p4njt3G2
 w121P6RRu8hq5KtgDjtqpBLRZNIcDFTHOz1NSJoXQqTAHvu88YABHbJehXPxQrvJWy/2
 dBn+KUttZI2mpwhfl0Z34/BH4j5/luZDcVHoFBFfZZ2Tj+tqyhew2Lvr6BLwPvNpRtQu
 gO1wTAADCvpO1w9tHInSuyGrZVmgdtYapjXEMvVezkoCGdUEFZfjJnst2LrTlTjSiE4o
 8nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uz45d3VsNy7VQtcXK64lVjOwo9NcbqUTCfX5UcI3TVU=;
 b=kYbgP1BHizJYPr7BmBWXorXdqETY1qxoaIHvmDY170PVExg18fbWJqtqsBv9Pr7enG
 3QUW+jjbVa5t7MpNs3Q9mJjErEuujXTu/+1coVORFZzVkRGyD4nhaePdiQE/4uN7iHFM
 4EnvxBG7F9HzfRHnGxrW3HXMZhjVR8SAqGjwA0NFQ/XqVHZkjSFI2RjgmRJ1ki4smZb8
 HyyCxH3j6fckoYJ7+IYdlBZS3cWKBA4UMU+Hw1pKozwnKtT8oNtlR6XnIzZG/bnX16lo
 ldPXioYNEiNXOQz6dIT5Z4rjSl6E7IEJGwlBy1PYhSXniZFL5zFrqDnr3zer9oEMTMa1
 /HOw==
X-Gm-Message-State: ABuFfoi/+jg8hhk1Hl1RmRs1Ez730Xhki7bNlXm8rWx8x9cgLm/VBqIH
 A86y62S0RHSW5yy/cNzQn1KfsG3i
X-Google-Smtp-Source: ACcGV61ZpnbSsD0W3qX6qtGY4qGuj1ru4ybFh+w1DlWGsj2NRxId9CvyrSNPsGOyh7W5bLo6ctYCkg==
X-Received: by 2002:a17:902:6907:: with SMTP id
 j7-v6mr25852246plk.232.1539781162723; 
 Wed, 17 Oct 2018 05:59:22 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (14-202-199-226.tpgi.com.au.
 [14.202.199.226])
 by smtp.gmail.com with ESMTPSA id m15-v6sm27378324pgt.28.2018.10.17.05.59.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Oct 2018 05:59:21 -0700 (PDT)
Date: Wed, 17 Oct 2018 22:59:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH 1/5] powerpc/64s: Kernel Hypervisor Restricted Access
 Prevention
Message-ID: <20181017225913.6026e6f4@roar.ozlabs.ibm.com>
In-Reply-To: <20181017064422.26119-1-ruscur@russell.cc>
References: <20181017064422.26119-1-ruscur@russell.cc>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 17 Oct 2018 17:44:19 +1100
Russell Currey <ruscur@russell.cc> wrote:

> Kernel Hypervisor Restricted Access Prevention (KHRAP) utilises a feature
> of the Radix MMU which disallows read and write access to userspace
> addresses.  By utilising this, the kernel is prevented from accessing
> user data from outside of trusted paths that perform proper safety checks,
> such as copy_{to/from}_user() and friends.
> 
> Userspace access is disabled from early boot and is only enabled when:
> 
> 	- exiting the kernel and entering userspace
> 	- performing an operation like copy_{to/from}_user()
> 	- context switching to a process that has access enabled
> 
> and similarly, access is disabled again when exiting userspace and entering
> the kernel.
> 
> This feature has a slight performance impact which I roughly measured to be
> 4% slower (performing 1GB of 1 byte read()/write() syscalls), and is gated
> behind the CONFIG_PPC_RADIX_KHRAP option for performance-critical builds.
> 
> This feature can be tested by using the lkdtm driver (CONFIG_LKDTM=y) and
> performing the following:
> 
> 	echo ACCESS_USERSPACE > [debugfs]/provoke-crash/DIRECT
> 
> if enabled, this should send SIGSEGV to the thread.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
> More detailed benchmarks soon, there's more optimisations here as well.

Nice, this turned out to be a lot neater than I feared! Good stuff.

> @@ -240,6 +240,22 @@ BEGIN_FTR_SECTION_NESTED(941)						\
>  	mtspr	SPRN_PPR,ra;						\
>  END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
>  
> +#define LOCK_AMR(reg)							\
> +BEGIN_MMU_FTR_SECTION_NESTED(69)						\
> +	LOAD_REG_IMMEDIATE(reg,AMR_LOCKED);				\
> +	isync;				    				\
> +	mtspr	SPRN_AMR,reg;						\
> +	isync;								\
> +END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KHRAP,MMU_FTR_RADIX_KHRAP,69)
> +
> +#define UNLOCK_AMR(reg)							\
> +BEGIN_MMU_FTR_SECTION_NESTED(420)						\
> +	li	reg,0;							\
> +	isync;				    				\
> +	mtspr	SPRN_AMR,reg;						\
> +	isync;								\
> +END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_KHRAP,MMU_FTR_RADIX_KHRAP,420)

I wonder if you can skip the first isync on the way in and the second
isync on the way out because the interrupt and return should be context
synchronizing. Might not make a difference though.

What do you think about making the name match the C code a bit more.
Like AMR_LOCK_USER_ACCESS()?

Thanks,
Nick
