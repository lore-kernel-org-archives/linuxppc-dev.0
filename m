Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A13CC32789
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:23:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA3220827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtS8tBJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA3220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qRw46D2zzF3DW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 11:23:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtS8tBJ7";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qRsV24zPzF3Cx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 11:21:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtS8tBJ7"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42qRsV0JLKz8svw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 11:21:02 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42qRsT6xgvz9sDN; Wed,  7 Nov 2018 11:21:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtS8tBJ7"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42qRsT2PPnz9sDC
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2018 11:21:00 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id t6-v6so7003804plo.9
 for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2018 16:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ah7xgf7wNxYiBkO/e1AYVzwUkpyP+RdbnFSYQKBy6UQ=;
 b=RtS8tBJ7k2IsWDTsxuFg5dtGxII9vIf3VbASZ5ydbDN4uBk1uJVtnoVtVZdyKkQKtn
 E19ERFeoVu3aQufTT4l38D2pxo/rWf5H5Y0ao+BFulaaNt2MTtDaYi0wMSXEXA07JxZr
 d/OL8gxnWPPkVPlPG9loILz2bVnqOk2FpEdrrnRQuAyfrZB8mrkVsb1PdFqcGIyrEWSR
 AkuwfOyjM2R0JlFc3IF9Don520xqg0WiKpNEXQzk6mPfs+d2LV76VsW8oxOkeogPJA8r
 nxo8ZvSlcuhqGrRHzK04UurKi6mjjh25AQwE670NHI22UdiE+bXjHeLLtBPYKwYpq2aB
 KBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ah7xgf7wNxYiBkO/e1AYVzwUkpyP+RdbnFSYQKBy6UQ=;
 b=hFjSAZDl4dSGx3RGqheOs0oTAtcnYiky2cMAobN+lSRnLaQN3tuXPY5SKlUX4rt3+K
 mWCZbo1ewOEqu4m9pcXt4bST0aT8Z/hyiOfw+dA5OBXcNKktQXYPNHpaTqJLrHkzwg8p
 VIx9b+2p9/fjM9aZBifsQni3zVXegjqJe+BeGPZlSrN8sHlkbJGqyx7n1oXURyA+auii
 PXXcSuLxtL90NS+QuYMrSgoYGOgwT9ZP6WoIgdkoevo9t0Txgfb92eUbGNq5wo4J3bmb
 isPzhMrMNBE1YGJWBs/sTXiJZZIxJci+OgrlKxiuUYDnHS7tKECEn8eDMsr8MuCWKSo8
 fCPA==
X-Gm-Message-State: AGRZ1gJO7nNnayKUswgjyvwx9HylFnsynmxtHSOoAO+dfqxQC8N8pOCY
 zc4eD3KZ1Ctlxcp8pOfg3CeV9E0G
X-Google-Smtp-Source: AJdET5eRKiT7f9CiGMGVeNmm6FoVy8YEVEgQeu1akxOnIz+VRuDohjPLUwiywZeTaklzP0YIQhcScA==
X-Received: by 2002:a17:902:16a4:: with SMTP id
 h33-v6mr28279791plh.141.1541550059390; 
 Tue, 06 Nov 2018 16:20:59 -0800 (PST)
Received: from roar.ozlabs.ibm.com
 (148.36.194.203.dial.dynamic.acc01-tull-pth.comindico.com.au.
 [203.194.36.148])
 by smtp.gmail.com with ESMTPSA id i189-v6sm39807858pfg.156.2018.11.06.16.20.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 06 Nov 2018 16:20:58 -0800 (PST)
Date: Wed, 7 Nov 2018 10:20:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/mm/64s: Only use slbfee on CPUs that
 support it
Message-ID: <20181107102046.204dbd8f@roar.ozlabs.ibm.com>
In-Reply-To: <20181106123709.940-3-mpe@ellerman.id.au>
References: <20181106123709.940-1-mpe@ellerman.id.au>
 <20181106123709.940-3-mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue,  6 Nov 2018 23:37:09 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> The slbfee instruction was only added in ISA 2.05 (Power6), it's not
> supported on older CPUs. We don't have a CPU feature for that ISA
> version though, so just use the ISA 2.06 feature flag.
> 
> Fixes: e15a4fea4dee ("powerpc/64s/hash: Add some SLB debugging tests")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Ugh, thank for fixing all that up. Looks good.

Thanks,
Nick

> ---
>  arch/powerpc/mm/slb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 457fd29448b1..b663a36f9ada 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -66,6 +66,9 @@ static void assert_slb_presence(bool present, unsigned long ea)
>  
>  	WARN_ON_ONCE(mfmsr() & MSR_EE);
>  
> +	if (!cpu_has_feature(CPU_FTR_ARCH_206))
> +		return;
> +
>  	asm volatile(__PPC_SLBFEE_DOT(%0, %1) : "=r"(tmp) : "r"(ea) : "cr0");
>  
>  	WARN_ON(present == (tmp == 0));
> -- 
> 2.17.2
> 

