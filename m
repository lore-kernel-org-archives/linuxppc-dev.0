Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C11C004D2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 23:29:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7769F206B2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 23:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENxpLTga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7769F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NhTT5ZtWzF371
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 09:29:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ENxpLTga";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ENxpLTga"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NhQy4gVLzF35X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 09:27:38 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id r9-v6so4246357pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 16:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i4MfeCx7ARZqeH+V+F3kwmOir8Bp/vkjK3Vr95FLQAI=;
 b=ENxpLTgaujHJ2Pf+QHdJiPhTdwP8+OLgra9e1AqsiFGEZXibQNrwhIRxWw5d+YwV2l
 rxWGk+wwcqtg0+QGa/JV9GxW3pCdHzGDSqAqjl1s6uvf+pXQQx/za2E6b0sYgOtp1l86
 a6+RgAn+49B9lyLF5IJLP71OVhXeu7KlavPiJZB4nH544nhNQvXXZ1qczkGYiNSbQGwQ
 GibPVVBZKrQpdiGxDvK/FRU8445ZT7X7BcacgOImWm46xbrEiA/VycJYf1UM+7GJqqaw
 w8pv/65Lc6+cvfLLPoIHzmxrzTSiHxUQbycMawO5r11+pfm50uubKPx+x/H/F56e0jcB
 IwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i4MfeCx7ARZqeH+V+F3kwmOir8Bp/vkjK3Vr95FLQAI=;
 b=t0uBlGrc/HgZHei40zEe5kkk3PC8c3mW6Vq5o2kUyC+T44iCXyPvnP3DOzorjZXGAm
 MpSE8YgqDCaaYnqxT9cIXo5sVsovZvFWQBANU7PsLTG2X2QhaRHZhoYqOcxxDYUi/qom
 umRsuMR9RSFde3UZraIDWzEapmWs+3X7ScwM3DnR9QFjZ4QuDZaLU5IgEWmnGDF38pb/
 lyTOabyCCNLN7miaOLCdsCSCSIhL7wGzVTFeAnGTEG0j6zqWcDDUwwT4HlUX8rlfVzke
 8a5JkNdc6AGmUnkSGJNIaKmjETOwE0CHPOigRkL8Oycw5K6HbFBAnHCNdjcjkbVYMZrF
 rVNw==
X-Gm-Message-State: ABuFfogYlxpzOivPTpqapI+CdQssSLc+AptczV3PiKhqcteUGSYavrrz
 yjRCv7lYvmaWfy6ozSLc/rI=
X-Google-Smtp-Source: ACcGV61pU9tEnwCRq2bn6HfsrFR/cfqxDZFGFwVtKpCI3KVwOn4HnMSwR0eh+uslC+ZcGo1aPvS5rQ==
X-Received: by 2002:a63:aa48:: with SMTP id x8-v6mr7790613pgo.87.1538350056505; 
 Sun, 30 Sep 2018 16:27:36 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p7-v6sm17551764pfb.101.2018.09.30.16.27.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 30 Sep 2018 16:27:35 -0700 (PDT)
Date: Mon, 1 Oct 2018 09:27:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit
 kernel to 512 bytes
Message-ID: <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
In-Reply-To: <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 29 Sep 2018 23:25:20 -0700
Bin Meng <bmeng.cn@gmail.com> wrote:

> commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
> userspace to 512 bytes") only changes stack userspace redzone size.
> We need increase the kernel one to 512 bytes too per ABIv2 spec.

You're right we need 512 to be compatible with ABIv2, but as the
comment says, gcc limits this to 288 bytes so that's what is used
to save stack space. We can use a compiler version test to change
this if llvm or a new version of gcc does something different.

Thanks,
Nick

> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> 
>  arch/powerpc/include/asm/ptrace.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 447cbd1..817be3f 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -30,16 +30,12 @@
>  #ifdef __powerpc64__
>  
>  /*
> - * Size of redzone that userspace is allowed to use below the stack
> + * Size of redzone that kernel/userspace is allowed to use below the stack
>   * pointer.  This is 288 in the 64-bit big-endian ELF ABI, and 512 in
>   * the new ELFv2 little-endian ABI, so we allow the larger amount.
> - *
> - * For kernel code we allow a 288-byte redzone, in order to conserve
> - * kernel stack space; gcc currently only uses 288 bytes, and will
> - * hopefully allow explicit control of the redzone size in future.
>   */
>  #define USER_REDZONE_SIZE	512
> -#define KERNEL_REDZONE_SIZE	288
> +#define KERNEL_REDZONE_SIZE	512
>  
>  #define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
>  #define STACK_FRAME_LR_SAVE	2	/* Location of LR in stack frame */
> -- 
> 2.7.4
> 

