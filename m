Return-Path: <linuxppc-dev+bounces-23570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B86C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 18:00:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtZzJ30Hdz2yVZ;
	Mon, 06 Jul 2026 04:00:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:a60:0:28:0:1:25:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783274444;
	cv=none; b=e2qOyVN7RX3EdHVfHpAknQmAD2eKGYIRgNRg/D1ZOJm/Bm9NKjEV/Pm+e7WP5lQyY+PISVcWvm/afpb5uTpE2w6o1n+1wnOH3exv5Bg2voo0ONmLlORQZMWwWstpmQqrKBTmEjqPEA694Z7CfdfYJupNWfuWfezEOiKivEqASdnigpBc2uw3ZrG8jEp8EB7qXYBfOMvUh7PbHlsPNVjjtrxbXKmeT06CUbmnCtl4g868SItk1CE1VgXKFGEQQJnEwJeUvHul0QE4ehlvulSFhkf24kyAdh2PB4kF48MZCwWdVzWQYwfo6aABEWRPFSxNbm64Wta3ckjWNX6mDbo+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783274444; c=relaxed/relaxed;
	bh=bR9Jd0D8R3KBwB/QOfP4VeGkZH2drufPVqCSMNmYFxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LrE5Qr08nRzgysraG6BvzocTQxm00VEdhGiY+1MyJQwExrgDWx9bE1wjkOaT0eq5sUZKS6Vl1SCK76/lQFvateAa3qdmUOjEQaofo3Pb/wVW62YzvWfsyDNRewljQO0VD0HtzPo5M0YiLySNeXe7QHr8eYojQpzOroUGRGpWPs3eY5u4dIgrJrJ9tRsL9byRUp+aXuAe8iCY7fcoURsjmTgGn7y+b8XH8BdbNcdPoJi2UcH5RklbgYIBXv6H1jsQ9gItNj707V2Y0SYzDzslOPbsn3hAH/deAQvVohmlzG0AIDnah7S9pbC2u3LyKVc/R/m3lJI+f4NjXqXy32r+JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=2001:a60:0:28:0:1:25:1; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=2001:a60:0:28:0:1:25:1; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtZzH0QsNz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 04:00:41 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gtZz51CXjz1sG7h;
	Sun,  5 Jul 2026 20:00:33 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gtZyz5SkFz1sFNQ;
	Sun,  5 Jul 2026 20:00:27 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4gtZyz1bnyz1qqlS;
	Sun,  5 Jul 2026 20:00:27 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id 1zh_gJquWQx1; Sun,  5 Jul 2026 20:00:22 +0200 (CEST)
X-Auth-Info: Os9fPA2uikgG+HJh+ICgitCam1iDICsN3+vZsQ4MLL04q3yLEw5CCiN1V8QdoNre
Received: from igel.home (aftr-62-216-202-245.dynamic.mnet-online.de [62.216.202.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun,  5 Jul 2026 20:00:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 670202C0B17; Sun, 05 Jul 2026 20:00:21 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
  maddy@linux.ibm.com,  mpe@ellerman.id.au,  npiggin@gmail.com,
  ryabinin.a.a@gmail.com,  glider@google.com,  andreyknvl@gmail.com,
  dvyukov@google.com,  vincenzo.frascino@arm.com,  oleg@redhat.com,
  kees@kernel.org,  luto@amacapital.net,  wad@chromium.org,
  mchauras@linux.ibm.com,  sshegde@linux.ibm.com,  thuth@redhat.com,
  ruanjinjie@huawei.com,  akpm@linux-foundation.org,  macro@orcam.me.uk,
  ldv@strace.io,  charlie@rivosinc.com,  deller@gmx.de,
  kevin.brodsky@arm.com,  ritesh.list@gmail.com,  yeoreum.yun@arm.com,
  agordeev@linux.ibm.com,  segher@kernel.crashing.org,
  mark.rutland@arm.com,  ryan.roberts@arm.com,  pmladek@suse.com,
  feng.tang@linux.alibaba.com,  peterz@infradead.org,
  linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
  kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
In-Reply-To: <1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
References: <20260427122742.210074-1-mkchauras@gmail.com>
	<87wlvazrdy.fsf@igel.home>
	<1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
Date: Sun, 05 Jul 2026 20:00:21 +0200
Message-ID: <87wlv9tiyy.fsf@igel.home>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Most of the time it prints nothing, and when it prints something it is
mostly scrolled out.


.handle_softirqs+0xcc/0x264
.do_softirq_own_stack+0x30/0x38
.__irq_exit_rcu++0x7c/0x120
.timer_interrupt+90x1ß9/0x2c4
decrementer_common_virt+9x214/0x22ß

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

