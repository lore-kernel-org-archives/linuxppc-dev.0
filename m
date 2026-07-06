Return-Path: <linuxppc-dev+bounces-23647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F7FC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:21:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvDkX3KTRz2yVZ;
	Tue, 07 Jul 2026 05:21:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.18.0.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783365716;
	cv=none; b=HfBuS/qNSaO2b/iSja5KNL//SUItkg0qac/YUeJIzBfJKW15+s8Li6otYbVnAnItYTS9593U5zRE62ssp7TOe9MOj1wmQC+EwXeZcdo+PicovxMBZhnhmS/3+QGpNicPUh0LHyyp5eXZ9LLEUWMWRZamOBG1Y/oxSjQWfstLuK/9rIDvgYS5dYQh+X59GvzimC2MPbzYW2z1j6Dxto4aNMDzXp5GgOflTI9Am+53/RHjEfuXrwL89IqcCOeZgvvSY/D0DYG4oXSVp37dOcfKjazOoUVEPyJvXeZPonRpHcLhFXpYUOawpVE7mRZMhcHTuf6z14oblIwdT25RfO3zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783365716; c=relaxed/relaxed;
	bh=p34yEhjT466o4tB0YNIeM6NweEK1RkFu3K9bpxHyC8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TuZX0FxJ/HHfQLPq7UCv/vQJOJ7JOc1B0bW7h8shrkvgmGR1qoSM4nxsCtv+PdsK+b0eskRHkLxz25o5AhijjJEHG19nspX3bcoa8O82ShghoBQy2araapLUNngMu6FksurYlxwRRiLELKwSWcH27tHfgQfwUArQM+JznCQed/qyl/pURq2i6Ly6yBihYE8Wz0z+izPIR66vbnGpkw/qmLRnbOHy+UNLbjdf/WmLZTHpzonKFJWylyGgjwH6f8QevRWpg31sM4D9vaR5EKidTFqMX8NAhzidbjAGQgejf0XaLyklnRXdBp144vaWzc3v8cMBGt1BAPu4KyxbLWt4GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=212.18.0.9; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=212.18.0.9; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvDkV6zzDz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:21:53 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gvDkP2JXqz1r5Sg;
	Mon,  6 Jul 2026 21:21:49 +0200 (CEST)
Received: from frontend04.mail.m-online.net (unknown [192.168.6.183])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gvDkK0404z1r5SZ;
	Mon,  6 Jul 2026 21:21:44 +0200 (CEST)
Received: from localhost (dynscan4.mnet-online.de [192.168.6.88])
	by mail.m-online.net (Postfix) with ESMTP id 4gvDkJ3hSWz1qqlR;
	Mon,  6 Jul 2026 21:21:44 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan4.mail.m-online.net [192.168.6.88]) (amavis, port 10024)
 with ESMTP id gl-AZVGbw1jk; Mon,  6 Jul 2026 21:21:40 +0200 (CEST)
X-Auth-Info: D2O3wWkm2V4gItoSeunzHiB2Cy0C8MSgpOhe6rFXpbumFhFiBXBa9ngkCoUVE50s
Received: from igel.home (aftr-62-216-202-81.dynamic.mnet-online.de [62.216.202.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon,  6 Jul 2026 21:21:40 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 042FB2C0393; Mon, 06 Jul 2026 21:21:40 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  "Mukesh Kumar
 Chaurasiya (IBM)" <mkchauras@gmail.com>,  maddy@linux.ibm.com,
  mpe@ellerman.id.au,  npiggin@gmail.com,  ryabinin.a.a@gmail.com,
  glider@google.com,  andreyknvl@gmail.com,  dvyukov@google.com,
  vincenzo.frascino@arm.com,  oleg@redhat.com,  kees@kernel.org,
  luto@amacapital.net,  wad@chromium.org,  mchauras@linux.ibm.com,
  thuth@redhat.com,  ruanjinjie@huawei.com,  akpm@linux-foundation.org,
  macro@orcam.me.uk,  ldv@strace.io,  charlie@rivosinc.com,  deller@gmx.de,
  kevin.brodsky@arm.com,  ritesh.list@gmail.com,  yeoreum.yun@arm.com,
  agordeev@linux.ibm.com,  segher@kernel.crashing.org,
  mark.rutland@arm.com,  ryan.roberts@arm.com,  pmladek@suse.com,
  feng.tang@linux.alibaba.com,  peterz@infradead.org,
  kan.liang@linux.intel.com,  linuxppc-dev@lists.ozlabs.org,
  linux-kernel@vger.kernel.org,  kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
In-Reply-To: <7f013fb9-c3fb-4c03-8a2b-cd395cc1e113@linux.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
	<87wlvazrdy.fsf@igel.home>
	<1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
	<8733xxve3h.fsf@igel.home>
	<7f013fb9-c3fb-4c03-8a2b-cd395cc1e113@linux.ibm.com>
Date: Mon, 06 Jul 2026 21:21:39 +0200
Message-ID: <87tsqbapq4.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain

Oops: Exception in kernel mode, sig: 4 [#1]

Oops: Kernel access of bad area, sig: 11 [#1]

kernel tried to execute exec-protected page (c0000001bfa8c380) - exploit attempt? (uid: 0)
Faulting instruction address: 0xc0000001bfa8c380
BUG: Unable to handle kernel instruction fetch
Oops: Kernel Access of bad area, sig: 11 [#1]

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

