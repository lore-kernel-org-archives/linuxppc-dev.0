Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED743C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:53:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376852083F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5zdiDki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376852083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PJyd1GQNzF3DW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 09:53:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5zdiDki";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5zdiDki"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PJw52mPTzF39y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 09:51:33 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id s5-v6so102471pfj.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 16:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gplaKC6UEz0A+Uvp0v0Qlnbl2RdlNAz4fdwm9o7AFfc=;
 b=c5zdiDkimz9IRvquk4YGddgRM0jjskHkNMk4Z+mkFxCwErP73SjSvxEU8l5qKcfA1W
 30bfSIoz4Rs14hJJ/M2SAodvL/60T5DLKyNqvPtAz6BKn5x9yhH/Q39ctIgcjA/ZaKFt
 2qQ/c5PS2ClshOQwnIujgXbRjdTICclPdyjEqQ5Vfwm2KQ3gm+Hpf7CDtmMIvKbPdKbM
 pP4zRWvvn+YPu9EL9m0qpLMN1yivR110z3RaZS+6q9GQuxdZF9otP+SPLS29ZHEglN3O
 0wKl5pepvcVxid01rPGYGDHH7WfcM1J/gggkFjfSqEeZTMo/sggxVNJyDxV4LDwc94Jx
 FmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gplaKC6UEz0A+Uvp0v0Qlnbl2RdlNAz4fdwm9o7AFfc=;
 b=r2DbMU0qufsUNgPmStPTu3H9ZbzDhixt2EHbJawHaYtjhfOCXds6LuLux6+PrRmxPg
 BCZaUMfOAzhdbD3iNedOkoeMYgqz56qjuqU09yiCd9L/TETsLoCosXAyTuFROEgvGeUY
 4a1H8PLkrzFjasFwz+/c3uErSvUPIRJSPcMl2tiFVf7uX5icPFaSCjpLqpcds/PJ4P+H
 g8hRYwGNBRxAtC5Oq6gF2ECZzJYMx/TKl3yTFKcscviigZrsZN9ws3G3VSgJt0FUiQgw
 fFo/RylZLcftT/oBio4x/y202lL7WCcVTP1zpfj8+EQeGUKiCkrRoQGVesrud7nTTlxJ
 Jp4Q==
X-Gm-Message-State: ABuFfoh5dUltWiDOiSrRhhT43LwNqwP77temwWzkgVEblQLkdmSxOPXi
 K/wp5OFvCMtK7Tu4OSAuVGk=
X-Google-Smtp-Source: ACcGV60RY0EEwZ8PnLMWS7bZ6KBLp9mbnKRO8v1ARfAyC3+Q3G55MVZhvQuVn9gDXL2N5UvpEQi4pA==
X-Received: by 2002:a62:c08b:: with SMTP id
 g11-v6mr13722746pfk.72.1538437891115; 
 Mon, 01 Oct 2018 16:51:31 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id b81-v6sm34559027pfm.96.2018.10.01.16.51.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 01 Oct 2018 16:51:30 -0700 (PDT)
Date: Tue, 2 Oct 2018 09:51:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] powerpc: remove leftover code of old GCC version checks
Message-ID: <20181002095121.3f0326f7@roar.ozlabs.ibm.com>
In-Reply-To: <1538374224-3742-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538374224-3742-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon,  1 Oct 2018 15:10:24 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Clean up the leftover of commit f2910f0e6835 ("powerpc: remove old
> GCC version checks").
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> My patch had been sent earlier, with more clean-ups:
> https://lore.kernel.org/patchwork/patch/977805/

Sorry, I missed or forgot about your patch :(

Thanks for tidying up my mess!

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Anyway, this cleans up the left-over of the Nicholas' one.
> 
> 
>  arch/powerpc/Makefile | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 2ecd0976..b094375 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -400,10 +400,6 @@ archclean:
>  
>  archprepare: checkbin
>  
> -# Use the file '.tmp_gas_check' for binutils tests, as gas won't output
> -# to stdout and these checks are run even on install targets.
> -TOUT	:= .tmp_gas_check
> -
>  # Check toolchain versions:
>  # - gcc-4.6 is the minimum kernel-wide version so nothing required.
>  checkbin:
> @@ -414,7 +410,3 @@ checkbin:
>  		echo -n '*** Please use a different binutils version.' ; \
>  		false ; \
>  	fi
> -
> -
> -CLEAN_FILES += $(TOUT)
> -
> -- 
> 2.7.4
> 

