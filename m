Return-Path: <linuxppc-dev+bounces-27146-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528DBC88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 18:02:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhMpJ4hfpz2xpv;
	Sat, 12 Sep 2026 04:02:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789149768;
	cv=none; b=IIVeGCB5Ce+6b8WtcdoKVY03PAZaiYEPpQOhY5sK8h6y33yGMcOEknEkezc3/0q3DReME1Cu9ala9M4z6tW2/97Zu7ZVYjbk/+gxtHpxujLTTWXoAni1GYygPxZrm39CWwWBKFiOuDdH/N/e5qJD6c3Wv76OXaDX99kdyaHKkfjuc0zT8tOsXhgoMpaAY8kqHJWQpulB8gHkSd+8Hqe2KSEz6SyQXMM7+6DxJz/gaatPYnFkeIr5pwURUgBW8wmaio8J4V/J/s4qS8qjk+LWV3ZqGQ3Nc/b5rWCMmWRannDI9dTH0U1Z3eMyTVrPjun4Hm3bDSloqF2t+zdf6QCu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789149768; c=relaxed/relaxed;
	bh=tEg6c7bZ7wxXKsRmp0OjaJyQp7uwB9ezm8J/nXNrwM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZY9mv65oTZRXNQPvEAaNofflnZz3oI2zsgL254z0dYYakDFJBMtuj2TZHbsq20foUXytpiwoSJAAS0oz9ScohI0rVlHkhpMGYMkahWvzUYxl04SvfjRiJrOJcmh7usFw+W80crMjARLF7k8VIX9sTVKKWJiCHvxtdv/1oRE4AtKTBNpCJHJPAplUY+iw6XDoZnsASOFYPaCxuW4K12+s1n+5hW1+1k6Vt0F5uPg3uM45DhiGKonRSHqRZvEqyq7yXBQc8udjiiI/e60sbLI/h9Gg6FRabMZjZ03jJMkADWQDttnbOPmD1oFCpgNL6XxgtRgvdrMitMpxVPyCuDVHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=foNCvvwI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=foNCvvwI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhMpH5C2Fz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 04:02:47 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso277543a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789149765; x=1789754565; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tEg6c7bZ7wxXKsRmp0OjaJyQp7uwB9ezm8J/nXNrwM4=;
        b=foNCvvwIDZICbCrP1Qe6g/mv2EaSyoH8GNqi6FjACajsLMui4uqvmteju2YMrl1ueG
         B4aGiYiLfANERTXzfBI11TRfsatEapV2drpsOyASuCOX1IHcezvEf3/vOFiMRF8VWvgN
         gJa/RB+hBXIk3u1/Xa1wkmm6jM2cBDr+CnipV9IiTZJc1Sk+iIQinFpYWAE4weAkogmc
         7+OQqewPH9sanL74aGZZdIJSZ747bN/WUztwHja1GnP/TQVMvWwoS+RgrWDO91vL5UZ1
         LvhWPC6hdyKKbZ9hZy7Vm0meMGOyN+W6Y/vvUhO6N+RMvRxx8PfOUp4dmmDFqpTRQMVY
         XnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149765; x=1789754565;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEg6c7bZ7wxXKsRmp0OjaJyQp7uwB9ezm8J/nXNrwM4=;
        b=s4IMTy35aH4Hu/z4dLwka6zIEPrNSIyHRGz37tj+eZKjJt0gbKhzAJSp2UMblYO+oJ
         11J/HjESydeKU6YSlFVHCuuQqYyMPDh5j9Y0hvy3cmilCaHNfujJ2gZb3SLsAf151gfZ
         now0khAZpzQlIwhobP+vcddtTBKNy+lmIAzttL5FkHSDfHlpeIqt723jeorpPsfq+dwt
         l04plW/F25MepZARtkYPRYG3DKkAwkl53T5qT3po9hMpWPjLOqvWeogoOeuL0I+iG5D4
         jnkAjFaF+I4UQKyLKf7sY4jhZnAYPIxZeUCQxA0TL27ujwELgAMRX37hcBPaX5REv68v
         gKxA==
X-Forwarded-Encrypted: i=1; AKwUvBwO4uiv0T7A73bnhovCXZhLbsxn0Ju1wElSUX+wDK3U5aMS8KSucIDuTtTfySfiOqJj7JJ8LkItCeQRcRs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lnaGQqO76TA7R0nV8uUXtCbTdNPe87xiA6d5UnYRiYN/Vf6zR9
	QzKlMA9WX3uEMS8Aec2TBn9ZJZkbC02H15gBoVdAxDzD5URY++Ppvz2X
X-Gm-Gg: AYBFou2i4IAoG0zKUdjCHLtFMEIBgLOmrkqngT6QN2qD/oEBGW2SjsrdbYx+72CeHey
	x3iU7Nh7AOTvM/Wtf+QnikO/zSkOszyCc2Z0uq22v94Iou0I8W9BRhgCM2a/V7+J6YtkrTYrMAr
	3digm+j2KUW2cePcrV+jTxD/NCVHhVEH7zR6IfibvY2K042Im8MQJdjG1qzsWVCJX0t5uNtr9Ex
	sq/2d7WMvQjqIYwHH4xPpHz+zoLzxGZrRyDY4+BmBM6o8GnBUTfZKG0xZFmCORuUt5IAv8+BOHE
	SGoefnbKTGJ5lhE8Nk7BK1vpEP/ZUzJZ2GTIImQ9Yml98BNJ/oZkKbmHSwizOmyw0zhLfIuaJ3x
	J5TkbBaL1GdmZACH/cy5hMlG6sYbw2HCXz5Zr8cr4rC5vCEuwgDbxp0yRT+TmXlXUF7HGb0Axb3
	S/Cuy8Z6SS+QWPBPh9QXwJEJL9NkATqr1R8PvdMsgYyXu+1sIbwnLj7mK6IK87EHEUCbG0nt/1t
	n3Gcrnzbb4m/AlyGnkMO7/n/4Kx0y/PFKOKG/rBWJ6Z2A==
X-Received: by 2002:a17:90b:5246:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39d9bc67660mr9487469a91.1.1789149764717;
        Fri, 11 Sep 2026 11:02:44 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98a58d23sm6962244a91.2.2026.09.11.11.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:02:44 -0700 (PDT)
Date: Fri, 11 Sep 2026 23:32:28 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Jirka Hladky <jhladky@redhat.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com, sshegde@linux.ibm.com, 
	thuth@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org, 
	macro@orcam.me.uk, ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, 
	kevin.brodsky@arm.com, ritesh.list@gmail.com, yeoreum.yun@arm.com, 
	agordeev@linux.ibm.com, segher@kernel.crashing.org, mark.rutland@arm.com, 
	ryan.roberts@arm.com, pmladek@suse.com, feng.tang@linux.alibaba.com, 
	peterz@infradead.org, kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Message-ID: <aqRB8aSzbeQ-UcYY@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
 <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>
 <aqAMpawvpB7g1XdK@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGBCmA0+28G=V_Qs37cR2GKYDUTGQWW_uRe0qvEp5io3qQ@mail.gmail.com>
 <CAE4VaGCp7A7NuBC9Hwgzs5xg3bGBuRiDC8PRCu+yXnUZEXmt-g@mail.gmail.com>
 <CAE4VaGATCET9F4XXS2oj47aNEZx3HN__Zp1CH4+ASec6BjhjGA@mail.gmail.com>
 <aqONPHH8B_z_GpT2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGDJy-EzD_iHeb+AQOYi9LZN1dB9OXjf7FtVWM=LWrWVTg@mail.gmail.com>
 <CAE4VaGAq1PugOAomUnJ4vEtmHzKPt5m6VJ21wErdOf19G8UPWw@mail.gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE4VaGAq1PugOAomUnJ4vEtmHzKPt5m6VJ21wErdOf19G8UPWw@mail.gmail.com>

On Fri, Sep 11, 2026 at 02:24:44PM +0200, Jirka Hladky wrote:
> Hi Mukesh,
> 
> I built 7.2-rc4 from source with your proposed rcu_ct_kernel_exit_qs()
> patch and re-ran the same sweep - it shows minor improvements vs. stock
> 7.2-rc4
> 
> Full results, median bogo-ops/sec over 15 runs each:
> 
>   Mode          7.1        7.2-rc4     7.2-rc4+patch
>   Enforcing     68,275     70,154      71,585
>   Permissive    68,082     67,166      68,705
>   Disabled      99,654     100,510     101,016
> 
> The patch vs. stock 7.2-rc4 differences (+4.8%/+0.9%/+1.3%) are hard
> to distinquish
> from run-to-run noise we've been seeing on this hardware, but they are
> consistent.
> 
> I think it's a useful efficiency improvement on its own merits, as it
> does avoid the unconditional rcu_preempt_deferred_qs() call on the common
> fast path. Even with only small performance gains, the change looks correct
> and low-risk to me, and I'd like to see it land in mainline. Let me
> know if there's
> anything else you'd like me to test before you post it, or if it's
> already queued up
> separately from this thread.
> 
> Thank you!
> Jirka
> 
Hey Jirka,

Thanks for the verification. I think that's all i wanted. I would send
out a patch for this soon. Thanks for all the support.

Regards,
Mukesh
[...]

