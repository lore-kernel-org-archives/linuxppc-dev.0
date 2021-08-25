Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED0C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 03:50:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344B0613D2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 03:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 344B0613D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvX7R2nM3z2yWL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 13:50:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=SNHYHGi1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=dabbelt.com (client-ip=2607:f8b0:4864:20::62e;
 helo=mail-pl1-x62e.google.com; envelope-from=palmer@dabbelt.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=dabbelt-com.20150623.gappssmtp.com
 header.i=@dabbelt-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=SNHYHGi1; dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvX6b6wyPz2xrT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Aug 2021 13:49:42 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id m17so6475716plc.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=9sHfdiClg+ir79cDPtKTL0W793DnT07IRwQSqAPFHp4=;
 b=SNHYHGi1ywjzqrjN4Vr5b6iNJuFzuwLqCq5u/T+Vfl6bT/nVDfak3HIZ/5zzUaXBLx
 qHXc5HMhjunz5Tcci8T3BtPjccUPo9lQag2yq3MXOA8dzmHpPURkp4Phyb+NMOiA8uHu
 mAk3iNIjgmeySpy814cH9pbwf2U7WobmCunvxbey2Y5JK954SHN6j+FOB7BhcUUV6fy6
 b2YKJhK2R6UhdDgyj6KV0/AwH80guc1lwrwNI99/pqR9LOlSlx+tvHE2KYpVFMgq+70x
 D/65PWFVp2fnw4Ly+nACy81jTlmetYbczposURZHXwCv83wJ8N9j9QIOFTbcm721nckF
 YnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=9sHfdiClg+ir79cDPtKTL0W793DnT07IRwQSqAPFHp4=;
 b=TdztUFKEyFNEcBn/xAKWQs4BYuxMgFjyrmD2GS8UMVrTJTQHb9gtwozTo+btnnodRZ
 Wz2dX/gDI0gCBYsZVCbDbG5lkyDEcwkDVEgt5x5bDfl9lZqiz3OwTpKmzg62DuYnmmuR
 0LnacRRidm1LWSzbCf1aWLhN1TND44gz63ysTHy2hZS6Tw7D4X2H64LSu4BqfljQlIaY
 QsAD/MVcqVnxwzW+/QB4Lvg917L1CFB7BTajMgU2MsE01m9wdZTgGDFAaSDXYM00/iQ+
 9ddaWZJhUz6jvL3l1F6gPu/2ATYDRjebcLxx4oWY5ccKh/dAG/sCS9LnQNwN61TS1bn+
 tXNQ==
X-Gm-Message-State: AOAM532rcEjiDvNCHRxtCglV+B34T+L/Dqsk+WgmIkXHM8vbeIY/YVgt
 mfdYN9lQViETE/raZS38uUhqYQ==
X-Google-Smtp-Source: ABdhPJxItrgE+EVFUgM4xk5y1cyovfSflBdGl/ZTQWYSibONNZyb8WQmjv4eJYMsWeIsNWXL/FrN5w==
X-Received: by 2002:a17:902:9008:b0:12d:8258:e07c with SMTP id
 a8-20020a170902900800b0012d8258e07cmr36851163plp.42.1629863379987; 
 Tue, 24 Aug 2021 20:49:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id x26sm20744756pfm.77.2021.08.24.20.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 20:49:39 -0700 (PDT)
Date: Tue, 24 Aug 2021 20:49:39 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Aug 2021 20:43:54 PDT (-0700)
Subject: Re: [PATCH] arch: vdso: remove if-conditionals of $(c-gettimeofday-y)
In-Reply-To: <20210731055733.12332-1-masahiroy@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: masahiroy@kernel.org
Message-ID: <mhng-2a609a54-0d13-4fb3-9966-086357936773@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: tsbogend@alpha.franken.de, masahiroy@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, paulus@samba.org, luto@kernel.org,
 catalin.marinas@arm.com, linux@armlinux.org.uk, tglx@linutronix.de,
 vincenzo.frascino@arm.com, will@kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 30 Jul 2021 22:57:33 PDT (-0700), masahiroy@kernel.org wrote:
> arm, arm64, mips, powerpc always select GENERIC_GETTIMEOFDAY, hence
> $(gettimeofday-y) never becomes empty.
>
> riscv conditionally selects GENERIC_GETTIMEOFDAY when MMU=y && 64BIT=y,
> but arch/riscv/kernel/vdso/vgettimeofday.o is built only under that
> condition. So, you can always define CFLAGS_vgettimeofday.o
>
> Remove all the meaningless conditionals.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/kernel/vdso/Makefile     |  5 +----

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
