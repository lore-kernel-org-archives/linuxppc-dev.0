Return-Path: <linuxppc-dev+bounces-23719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C852C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:09:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvmPc2RW4z2xnp;
	Wed, 08 Jul 2026 02:09:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:a60:0:28:0:1:25:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783440548;
	cv=none; b=GZrIg3AtyEx35zdUHRyVIw15//miyr0siduF7rRHvdbyPdF2flK4FycK1YuQfYTvRPVfU+koV3FYmkus9qzUHurX9l/A2cA5eEoxj2pJSSiKgvBSKvq6NJsCPUog+1muJIKmVAqMhTpREymq2PMoS2/4yOukbIrJKU7MoyRIYoY2QrB4owagKtu4CYe6zy7qhq6WZZfDBhuhQFKNibnLllZaREzgArIqav4QvBDDFVu4L8djFJzo0ziP+bXsIxd8NqE4Eu0M101GQrjcT8/+s/ZWSeY3pys0IwE/QWbL/QJpTvITxooiezSAdckhDlY4MjfGQZbyip9d+E5D/MeMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783440548; c=relaxed/relaxed;
	bh=U56NC3mNT7lbjK7Ig0U8DtYWnF2cWtCDdN0TNK2mjnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGEuLuT7VO4tilzO6tyfi6BJLy8t2vheIAcr/yHaOjVbvnSJ4n5592+OhBYv6HcqZDoDNyLsWPS2Dr1D4qiS5u3iqpxyuHFg3exwdZcAwSFr8EFDFbKooTAEGAoO2sGknxYreBtAGHHbRsI73dknVax4LrLST9UvQWYxPPKoiLfzJ0vd0n45DpcHmLsuCvrpgHrJSAHoQ9QqggS6Rn8CyMUXI7ZfVKzaApW95X/6rcv3zs65RDb7dSNW7BOX3VqLf3xU1mFOHcg9kwknds3F4xGfu3JHCbkGH6ahgENLv0AkmoI/I7XUwG8plyQ1aQ0SJxV9b+qkqnGf8sdUMhxMeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=2001:a60:0:28:0:1:25:1; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=2001:a60:0:28:0:1:25:1; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvmPb0nnkz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 02:09:05 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gvmPS2rXJz1sGfL;
	Tue,  7 Jul 2026 18:09:00 +0200 (CEST)
Received: from frontend04.mail.m-online.net (unknown [192.168.6.183])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gvmPC6BSXz1sGXG;
	Tue,  7 Jul 2026 18:08:47 +0200 (CEST)
Received: from localhost (dynscan4.mnet-online.de [192.168.6.88])
	by mail.m-online.net (Postfix) with ESMTP id 4gvmPC2J8Dz1qqlR;
	Tue,  7 Jul 2026 18:08:47 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan4.mail.m-online.net [192.168.6.88]) (amavis, port 10024)
 with ESMTP id jsNNAtYIPpak; Tue,  7 Jul 2026 18:08:43 +0200 (CEST)
X-Auth-Info: j+uDViKe2COeGWpviY372vOshaFOepNoNIfiRp/Dn0r/1U7FrM6TTd+bOiD5m4vw
Received: from igel.home (aftr-62-216-202-200.dynamic.mnet-online.de [62.216.202.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue,  7 Jul 2026 18:08:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id D87002C0AF2; Tue, 07 Jul 2026 18:08:42 +0200 (CEST)
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
In-Reply-To: <18acdffe-a06b-4bfa-bbf6-e38274700b04@linux.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
	<87wlvazrdy.fsf@igel.home>
	<1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
	<877bn9vfd4.fsf@igel.home>
	<18acdffe-a06b-4bfa-bbf6-e38274700b04@linux.ibm.com>
Date: Tue, 07 Jul 2026 18:08:42 +0200
Message-ID: <87a4s2u6id.fsf@igel.home>
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

On Jul 07 2026, Shrikanth Hegde wrote:

> Can you try "powersave=off" commandline to disable idlestate and
> see if it boots?

Yes, that allows it to boot normally.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

