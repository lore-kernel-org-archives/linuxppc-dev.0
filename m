Return-Path: <linuxppc-dev+bounces-21618-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9AFCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 07:21:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQybL39Czz2xJT;
	Thu, 28 May 2026 17:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779952894;
	cv=none; b=cngDqhhLVVt96UcsDdsSivniT4l1N0P226ANgT2zfruSyr+KfwSNUMT4vsfHDixkatFS3m/lKuYCMDs2HMPDHc1CZAqTgmmGGDsu4/mT2DYbj/lPc61eeB/So7yWnvYbAd65PeUUp3fhpaK3k8aEyb7Jlhiwe1FFxMWOlRaPwkXvBoR86oI8d7l4D4SGKalyTwoL1JpqTWmNDapqxqijJCSiNs6hCvq11nPRHMrbl38/AiZmbXRf3MhexwBc+5vF4o7QNpP15+w8LRZFHmYEbxXN+tKE5ca5w9DS3e4hTWMO0cH+FiG1OXNI0G0mTDy2/S4YqRB6/41+Qng3STCUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779952894; c=relaxed/relaxed;
	bh=EAI9IZj0O7jAgpPnvIYkrsUUqoq6FsOm5c5MOgk8/o8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=AQmszyx1rdjijEZFUZHqVEPIXgoyziZiICTqQNxuXoymt+PqOz/jd1drweAjvQHxcwNq4PF8PUm//ArXNthnaDVDCi0VBA6DVHfUoftqba/4QF7mZKz0dM8dahkL4abvGaKHfMI8ckQpgitbWqs9HfqSqWnmX9RvIFGUhW7twYsKTvC5EHSGiRn+VHduCT32kqgwxRYbRUxZVugmoV9sRc/7cIiXyqQP3Li0DqAdzE26/DJ1r4xFGpB2BPRf3spm46fgSNkPh2TRZj9o9AU8g7jmG/+mRKC86DLvikIjSC+eUbbe0v7ZNnq81DuDKMifxEjgYUaSFDc/mtRW0NBhLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ce6moVS8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ce6moVS8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQybJ3wZ1z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 17:21:31 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b4650d5f5cso52735265ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 00:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779952890; x=1780557690; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAI9IZj0O7jAgpPnvIYkrsUUqoq6FsOm5c5MOgk8/o8=;
        b=ce6moVS8E9LzpJe89aLeNpvcRtlJR6BKXmlLuC/fxkW04jqJS927o+t+9pkdU1wq0o
         D5uG4ZjldVVzkWNzmg5s5UgympkSbqxG/Wnw0deYx7XX/JMYUIuyPg/VYifZfAJYg6Mc
         Mr+NlZKQ0p81donV2ucaldpAENzCgp4ZGBCrVEZwXwfVU+cX6dloIUe/Qd/qLV418YPi
         hOvq/iB3bjkEHdT/CKeGELvNdSLBp7LElSvHkG+hcD+LbhNT5/UpF9bz8qUkJdCuXvfU
         of0FC3S8izzMEvSxnvhfsn85qXAplGjwWll9CbHZv+aI1yqnYewFZ2w/vfWol1Lr7y0N
         OOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779952890; x=1780557690;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EAI9IZj0O7jAgpPnvIYkrsUUqoq6FsOm5c5MOgk8/o8=;
        b=QE97yrTgHsABEVpsUe5FdCe1a4EdKyC5RxwwdxMQyu0xFscqowoseBxgmcv6Ck+mbr
         O1r4vgs10QgmAknSfGCiAXMgC/Idizc4riNR2v3XmRHF1J9LjkhOJrVIhfmnquWhFT+R
         nJuXf2BjQqetCorodRv71JigsQa+RQv8NKjjcEnOguI54owZDysamjmplc4C1kioiCd/
         U7zdexA/xhIw7RNkhrBGgo6QwDdYoBLW3g4jLRmK2yJxnvGt/P8B56fmfAkey464//Pd
         dSPQvKth7SRWRBkfHr3CVy4/ZshfXCoHBktWg8LBOrApNZjG08ZBkH/zPd+zz4MAiIzG
         tTXw==
X-Forwarded-Encrypted: i=1; AFNElJ9y5vXBTvuAQ8D+2EVvpqTKQ+IbeDSCdX3cJtHTvHCD4TZcfpyGL16beLf9i/C7SC3Km1M+WWA52+y2Zxs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpBIxOl3NBpsi3zR2mIy6iq5VNyvNs9lAYpvqcm8FTOsTdV8XV
	ncjvVrWMMTwLjc8baUGIarWPIBuOadc3luzspYvAYTrxJANu4Lxt/e+I
X-Gm-Gg: Acq92OGVXh1rSQ06u4Qklv8l2b78iIUVGi9rLZuquo5wGPgu38MpqTaS3WGJuEooRE2
	NwwYO1nh0hIBJYAK0fdDUnD7+5DFMockUqzUEazqIiaB+WlM3vhm3oALaTE5MuM1ex3Sy6JL69C
	oFPnHip/4WRMSFo53Vsq1FcG9ipkm9aOhvHpgvAOVAmkRQwxvgeAkxq5DqGO+NVg2PRd2utBOEE
	6YW9vI9NAKHfp7oyysNa/AugbS2gxidtu5oFGX2UD1jikwFcWuVzaL3aLDiMeX5ldd5ze2Rifmu
	yaYAN1o6C/CfH2p/4zcyvVDkPhBnlnaA5i2T0E74H+7CvscrUqA7JKbWhcLZ7lN8wxt1UIrqBO/
	ap5pAtGLqn208Kpl3nIY821xuD5IE5Rd2yJljHdyfN/gb0e+JCu99lESMGAMimZLS400TGV5mag
	+PQX8wb9jFQ0gqMpS2jxEus4Gr6bhJRfu5
X-Received: by 2002:a17:902:ce84:b0:2b0:917c:bc4 with SMTP id d9443c01a7336-2beb03661a2mr279765075ad.4.1779952889777;
        Thu, 28 May 2026 00:21:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695b3csm168527935ad.3.2026.05.28.00.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 00:21:29 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, "Chen, Yu C" <yu.c.chen@intel.com>, tim.c.chen@linux.intel.com
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sched@vger.kernel.org
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask dereference in build_sched_domains on POWER9
In-Reply-To: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
Date: Thu, 28 May 2026 12:24:39 +0530
Message-ID: <o6i06n2o.ritesh.list@gmail.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:

> Greetings!!!
>
> I am seeing an early boot kernel panic due to NULL pointer dereference 
> on a POWER9 (pSeries) system when testing linux-next (next-20260522).
>
>
> [    0.039029] NIP [c000000000e58504] _find_first_bit+0x44/0x130
> [    0.039043] LR [c000000000e58500] _find_first_bit+0x40/0x130
> [    0.039054] Call Trace:
> [    0.039060] [c0000000090e7b80] [c00000000416af20] 
> schedutil_gov+0x0/0xa0 (unreliable)
> [    0.039076] [c0000000090e7bc0] [c00000000038b3b8] 
> build_sched_domains+0xad8/0xe50
> [    0.039089] [c0000000090e7ce0] [c000000003045d78] 
> sched_init_smp+0xa8/0x164
> [    0.039102] [c0000000090e7d30] [c00000000300f374] 
> kernel_init_freeable+0x250/0x370
> [    0.039117] [c0000000090e7de0] [c000000000011f90] kernel_init+0x34/0x1e4
> [    0.039129] [c0000000090e7e50] [c00000000000debc] 
> ret_from_kernel_user_thread+0x14/0x1c
> [    0.039142] ---- interrupt: 0 at 0x0
> [    0.039150] Code: 41820090 7c0802a6 393cffff fbe10038 7c7f1b78 
> fba10028 fbc10030 3bc00000 793dd7e2 f8010050 4bae6e9d 60000000 
> <e93f0000> 2c290000 408200bc 283c0040
> [    0.039196] ---[ end trace 0000000000000000 ]---
>
>

Well, I am hitting this on 7.1.0-rc5-next-20260526-00010-gbfac43765a97
with Qemu Pseries TCG power10/11.

[    0.342868][    T1] smp: Bringing up secondary CPUs ...
[    0.342868][    T1] smp: Bringing up secondary CPUs ...
[    0.525419][    T1] smp: Brought up 1 node, 4 CPUs
[    0.525419][    T1] smp: Brought up 1 node, 4 CPUs
[    0.527992][    T1] numa: Node 0 CPUs: 0-3
[    0.527992][    T1] numa: Node 0 CPUs: 0-3
[    0.552787][    T1] BUG: Kernel NULL pointer dereference on read at 0x00000000
[    0.552787][    T1] BUG: Kernel NULL pointer dereference on read at 0x00000000
[    0.557446][    T1] Faulting instruction address: 0xc000000000fe3f1c
[    0.557446][    T1] Faulting instruction address: 0xc000000000fe3f1c
cpu 0x0: Vector: 300 (Data Access) at [c000000006607800]
    pc: c000000000fe3f1c: _find_first_bit+0xc/0xc0
    lr: c00000000027b7d8: build_sched_domains+0xbb4/0x1938
    sp: c000000006607ac0
   msr: 8000000002009033
   dar: 0
 dsisr: 80000
  current = 0xc000000006f9fb00
  paca    = 0xc000000005670000   irqmask: 0x03   irq_happened: 0x09
    pid   = 1, comm = swapper/0
Linux version 7.1.0-rc5-next-20260526-00010-gbfac43765a97-dirty (powerpc64le-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #19 SMP PREEMPT Thu May 28 12:29:51 IST 2026
enter ? for help
[link register   ] c00000000027b7d8 build_sched_domains+0xbb4/0x1938
[c000000006607ac0] c00000000027b0a8 build_sched_domains+0x484/0x1938 (unreliable)
[c000000006607c20] c000000004053180 sched_init_domains+0x114/0x1cc
[c000000006607c70] c0000000040515e0 sched_init_smp+0x5c/0x17c
[c000000006607cc0] c000000004012888 kernel_init_freeable+0x258/0x790
[c000000006607dc0] c000000000011f3c kernel_init+0x34/0x268
[c000000006607e30] c00000000000debc ret_from_kernel_user_thread+0x14/0x1c
---- Exception: 0  at 0000000000000000



-ritesh

