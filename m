Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E67C433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 23:52:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7116613B9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 23:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7116613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFPTl2bkHz301J
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=DoH08R29;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=shorne@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=DoH08R29; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFPTF2Dlzz2yYn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Apr 2021 09:52:16 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id
 f2-20020a17090a4a82b02900c67bf8dc69so303747pjh.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Apr 2021 16:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=r0Ha/Gv3pAkjmgqqsKcPiH9tlZnqWzms79uqmOiSHMs=;
 b=DoH08R29BGwmuj6eSbyG3BUk0CMYUOgrE7l1ib0WohqefmBPVt3sY22jJOdDf2ba3M
 OraAYZNzGMrAjzLBt/oLKxSGP5xVkpQwVYlEyQ+FCAxk1AucZMSXaKaX4yes8IpuX9bx
 k/PK2mwZ7S6C7V1Otv/hHIYsXqEQzWVrSgtZ7Smoc3vdWQK5bfkyy5fWevoxUBoneWfM
 UlLNvmrFvT/LKV17m0n35Iq2WXwO1WQ94cKquKeKdq4Eo0jQbOkxVxjhAnmnUDMrZ/jw
 sjVzOf22KCT3mTqKrrakDQ7hCLtkS68PqKVrr3avChCGt1YUrsIst96sJ5oXc8I6D0zL
 +AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r0Ha/Gv3pAkjmgqqsKcPiH9tlZnqWzms79uqmOiSHMs=;
 b=tjFtZlKNaOp0+2xvr4Cv4RbKOfmQA6sM3O255tUk7nwRMciv29JFIZTNxQRZMxTq+k
 mbA78SC2+hOwq+Z+/fGwoI/cC8sOP/XIs1/iu8A4qODGMNVMwm3yC2ECTPe366FGOf/I
 HqwuB+pgtWIapDE5EYoRXJOILXmLc5mBXdvofj0O1/oeR/f+ixhzVhnIGPuFwi1NpO22
 m3OWvS0scbvpplk2b0UI5/B7x/+CV6gaSWrggvjs281ut5SKISO+66onpxh1cBrBBgo3
 oSCS6FvSfBFUAYfYPHTKiLLpugpcgxZbY/wjFfVnHvCDzJhWt+JJZkG9sek9W5AiZK5H
 Ohog==
X-Gm-Message-State: AOAM532F+/rWHm1uSecvXee1q7XGWHQ2oM8IRJtO61B7LH1aSTFJKG40
 ZhtBGtGUor9XuQ69UkOmk2E=
X-Google-Smtp-Source: ABdhPJxtumeckyy0f77HdPuOn8G6N6f+xOhLUrB9QPIL+nP1d3kOEbilw2AHpr0vnTb2lu4tnB14Mw==
X-Received: by 2002:a17:90a:6385:: with SMTP id
 f5mr590598pjj.212.1617753131320; 
 Tue, 06 Apr 2021 16:52:11 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
 by smtp.gmail.com with ESMTPSA id
 k21sm19587938pfi.28.2021.04.06.16.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Apr 2021 16:52:10 -0700 (PDT)
Date: Wed, 7 Apr 2021 08:52:08 +0900
From: Stafford Horne <shorne@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <20210406235208.GG3288043@lianli.shorne-pla.net>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyRrBjomDCPOBUd@boqun-archlinux>
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Guo Ren <guoren@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, Anup Patel <anup@brainfault.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, openrisc@lists.librecores.org, guoren@kernel.org,
 sparclinux@vger.kernel.org, Waiman Long <longman@redhat.com>,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 Ingo Molnar <mingo@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 07, 2021 at 12:51:56AM +0800, Boqun Feng wrote:
> Hi,
> 
> On Wed, Mar 31, 2021 at 02:30:32PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > Some architectures don't have sub-word swap atomic instruction,
> > they only have the full word's one.
> > 
> > The sub-word swap only improve the performance when:
> > NR_CPUS < 16K
> >  *  0- 7: locked byte
> >  *     8: pending
> >  *  9-15: not used
> >  * 16-17: tail index
> >  * 18-31: tail cpu (+1)
> > 
> > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> > 
> > Please let architecture select xchg16/xchg32 to implement
> > xchg_tail.
> > 
> 
> If the architecture doesn't have sub-word swap atomic, won't it generate
> the same/similar code no matter which version xchg_tail() is used? That
> is even CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, xchg_tail() acts
> similar to an xchg16() implemented by cmpxchg(), which means we still
> don't have forward progress guarantee. So this configuration doesn't
> solve the problem.
> 
> I think it's OK to introduce this config and don't provide xchg16() for
> risc-v. But I don't see the point of converting other architectures to
> use it.

Hello,

For OpenRISC I did ack the patch to convert to
CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y.  But I think you are right, the
generic code in xchg_tail and the xchg16 emulation code in produced by OpenRISC
using xchg32 would produce very similar code.  I have not compared instructions,
but it does seem like duplicate functionality.

Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
xchg16/xchg8 emulation code?

-Stafford
