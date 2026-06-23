Return-Path: <linuxppc-dev+bounces-22952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80787CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 02:25:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glQlS02Kmz2yY1;
	Wed, 24 Jun 2026 12:25:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1042"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782209450;
	cv=none; b=XCVxYSOC5Aw6j3wrR7lZQ+1p4tsF3iWxLnFlGYlfoV9YHl20h+B24WY7DpjZJQTKcdlPow/Z4cJJmrvCS7Qm50pSt/1SIlqFdrdM5H1yedgcdbnXu/xQNwlMDAtNJ4/U2BP/tpQ2VSQsIOttacn0gVNW1wDDQXAGKhD4pTv1t8t8JgsZ5fFqYxrwqka/GUHNhMGPY0qTqujJYzo6xprCORgNAcWoWWv5G4Jovh+a6iea9Oo+18GbyKPA4NUW2KwHcBSIoT7s6F+/Uhpeka8mKJyCsZ85qTq6asaZvPXpAVQwwzHvXNBkihOixYXEAK9Ck7uacfw++C56qriFXPs0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782209450; c=relaxed/relaxed;
	bh=q9xRyN5mmtNm+QB3YIDVLwBheiPW9GTxijNSPRoIWhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXVcpM4qrPgKv5kM/3JL9zOI5kp88bRY10zdKMe7GHDBzu62n9XrKpo+KZCg6N817ncJII6r7YGxKoKhQ7G1cyWW/ZQvXxBNkZ9nIQottX7sFb6Mj80DWR//0+Iw2YwNq7vjSu2/esCQxV5dsTwY5Ngtj6vlwpxto50208ltPQTVhFIP1LtDwk1xNL6EHot+BMciRO2HhltrGVEoqYyqAh0UMb+AqVvDiZ2u0IApREeO3UGlogDf6jNK5VmGoH53fBcR+0rBD00uo8AHfC4TkWkmyIOBSNE/kNz8zQbJNrkcry2sFokciU+mrePVEBWcCd4sZ9bWE8O6V/Gasi62aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VlfDe0Xd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=zhanghongru06@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VlfDe0Xd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=zhanghongru06@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl16c4qctz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 20:10:47 +1000 (AEST)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-37d700363fdso1184301a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782209444; x=1782814244; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9xRyN5mmtNm+QB3YIDVLwBheiPW9GTxijNSPRoIWhA=;
        b=VlfDe0XdNzPn3QxTkcLlk4viGurL9i6YsHigrMHXldsPn2e2hRddt4eJ9TxBiSbgM4
         LOJoqmLgrWzu5W9Us3pFH/sopeeAIE05NklIrcvxXlN4VJiG9eGlFHyae09dGBcAF/Xt
         wG//ulwACpsmxHyYyTa36C5KrJqd5DHeM/gaz4ncvMhALZ8Z/roE96PDkeKWKbQsIyxp
         NBdVYPz0qCaW+DiIgf8F3l+ix6W7XBEXpA4md6W/tabcqIlvlABGqWznHctVuBxgcYVO
         0+qCENQpZEB2QC4cD05DmmjD2flqMrWJKSt+KoZ5KB1mNfq08OcVDGL5hZOrTwnOkPti
         vacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209444; x=1782814244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9xRyN5mmtNm+QB3YIDVLwBheiPW9GTxijNSPRoIWhA=;
        b=VkaRPJa3WR3xMPB8265vCru1WoARo7qQbfKvYr4tL2zTr1J9A2U2UOlr1sia+RWJBT
         oM+XYbw0/KpR5YzHWdGZNapgsDxdwtiS328rUWmde7dPPfHM7e8grZad0eDJbXU4i+Da
         DbiKiEAK0m8QjKCkWooloivDK4DywnE1YwY7hsaAewZDStp/7nsV8c7aH+RZC9gTJnGC
         Dp90pzu3ARttURX6FpIB3RM0VB2J+L0GRDbW3azoKpYBUruMEcf7igCyLBtmD5odq5cM
         Hibxptp+z3IDDJ25ynxpQRBE6OXCtUdTp6M+FPUn6Wgy4l/GkyxMPl+OpHMoREwplZsm
         l/kA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9x/m5fDCyr3pZWAaRNsZAuAhSTUp/7Xq1Hh4uxDB8epBAQj2+7KzG3bhBXX7xE+WS3zKPKSDdJsfb5kI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqvezmJyFV9YNCXDkCatWaz/AAfN3z4YZ3PjLcZbogBn6h4GVh
	HzZvnGmMc/jdzowVB1mOvwZQhZS60Gw/JBIn26bC3//39tMK4N5Td5ZU
X-Gm-Gg: AfdE7ck2R35NKZHJWjUCbl4vHTAHHxLfqpgNuKEV68xSgfc5gLwPejTLSI8D3kiiuYF
	HXN01wXqvi/JZRMp+ga90E3mgqgCNTMEKmEmOmaeSn6v2HOJU02Q9YeOotYg2dgsWt7R61mmH/f
	rEk66XTwI360c8O60HI+elXibVRC6PqadaizN5s22EEZ/KLtnSx5is78epK/yRDqLsWmaYFoCPY
	lvKY6Hrx7tgtR1FDgjGAp1G/3aV8mhzWFDamql2G2u85Y+if5yHrCpXC6vxuf2+prfKlZXPIcnf
	btk5slfNiXuPHkYA5W00GH+3eQOu7EKxRk1k+Fh32Vw+A87XffvOkQo/uJjYre60cGkwcHVMigk
	8ZlXeSDehCQ+510dRYdMf/QLYy7ZUsObNuC6ZCqxkoIWPcyK+Prho6AkXlFn+/VWWt7fPkBsJa1
	QGEn/fYneDyPFvYqLoAGiJD18Cy5HnVn1di6RRr8yx
X-Received: by 2002:a17:902:ec8f:b0:2c0:e5ee:f56c with SMTP id d9443c01a7336-2c7c99def24mr17988445ad.20.1782209444473;
        Tue, 23 Jun 2026 03:10:44 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([2408:8607:1b00:8:ede9:3e72:37cf:55a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f7e0asm118059125ad.30.2026.06.23.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:10:44 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	bhe@redhat.com,
	chentao@kylinos.cn,
	chrisl@kernel.org,
	jack@suse.cz,
	kasong@tencent.com,
	kunwu.chan@gmail.com,
	liam@infradead.org,
	lianux.mm@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	liyangouwen1@oppo.com,
	ljs@kernel.org,
	loongarch@lists.linux.dev,
	mhocko@suse.com,
	nphamcs@gmail.com,
	nzzhao@126.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	vbabka@kernel.org,
	wanglian@kylinos.cn,
	willy@infradead.org,
	youngjun.park@lge.com,
	zhanghongru06@gmail.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page fault performance
Date: Tue, 23 Jun 2026 18:10:09 +0800
Message-ID: <20260623101009.522775-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d04f745d-eb3e-4d2c-8ea2-5fdcf2cf27b8@kernel.org>
References: <d04f745d-eb3e-4d2c-8ea2-5fdcf2cf27b8@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

On 6/23/26 10:02, David Hildenbrand wrote:=0D
> I know that especially browser usually use fork servers: a tiny=0D
> (single-threaded) process just to create new child processes. Any informa=
tion=0D
> regarding the apps above that use fork() on small vs. large processes?=0D
=0D
I wrote a second BPF tool (fork_info) that captures nr_threads and=0D
map_count (VMA count) from the calling process at the exact moment=0D
fork() is triggered. Results from 3 representative apps:=0D
=0D
  App (category)          Fork caller        Threads   VMAs=0D
  -----------------------------------------------------------=0D
  Taobao (shopping)       DaemonThread-6        526    8,987=0D
  Amap (navigation)       DaemonThread-6        289    7,120=0D
  UC Browser (browser)    OneNativeThread       350    8,144=0D
=0D
These are all heavyweight multi-threaded processes (hundreds of threads,=0D
7,000-9,000 VMAs), not fork servers.=0D
=0D
> Above you write "some call fork() from multiple threads". Any further=0D
> information on that?=0D
=0D
Xiaohongshu (com.xingin.xhs, social media) is a clear example. In just=0D
tens of seconds of normal usage, fork() was called 22 times from 4=0D
different threads:=0D
=0D
  PID     COMM            THREADS    VMAS=0D
  4206    com.xingin.xhs       85    4,140=0D
  4216    Thread-2208          85    4,157=0D
  4208    Thread-2208          90    4,211=0D
  5200    Thread-3200         337    6,519=0D
  5200    Thread-3200         343    6,563=0D
  5200    Thread-3200         361    6,769=0D
  5200    Thread-3200         453    7,793=0D
  5200    Thread-3200         450    7,779=0D
  5202    Thread-2219         459    7,846=0D
  5202    Thread-2219         462    7,875=0D
  5202    Thread-2219         465    7,899=0D
  4219    Thread-2219         465    7,903=0D
  4219    Thread-2219         468    7,922=0D
  5202    Thread-2219         467    7,917=0D
  4219    Thread-2219         467    7,921=0D
  4219    Thread-2219         468    7,929=0D
  5202    Thread-2219         464    7,909=0D
  5202    Thread-2219         460    7,889=0D
  5202    Thread-2219         459    7,884=0D
  4219    Thread-2219         433    7,771=0D
  4219    Thread-2219         433    7,771=0D
  4219    Thread-2219         434    7,778=0D
=0D
The process grew from 85 threads / 4,140 VMAs at first fork to=0D
434 threads / 7,778 VMAs at last fork, showing these are long-lived=0D
heavyweight processes that fork repeatedly throughout their lifecycle.=0D
=0D
Tracing tool:=0D
  https://gist.github.com/zhr250/ba7725d0ea55594bcafd3cd4806eed98=0D
=0D
Hongru=0D

