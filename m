Return-Path: <linuxppc-dev+bounces-23568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632A1C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 11:35:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtQQx48Z5z2yXj;
	Sun, 05 Jul 2026 21:35:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.18.0.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783251337;
	cv=none; b=jqcdA3ywYpIGTWQfqIr3kC8g8XQBgfEw2YZbNyFiZ/0Uc8A88VGiQj6QGW+tmKn6rSX6ldD2fQFJ47XFrkcQ7VIAfgNg+oxyEd0F1unHMJDw/86MYmLc9cgqKovqUppfWGNPh2Rv3ka++dyYpfYNEyZWGOR3Iq8d2Uxtid7iSsWYaKHPlC5+MnCEZd3XMcIgnmWyryggh3fo/JFcWZny1FABrgU2ok1f33EWvMBUXbr1QjCWsmAhTdM5Ggd2PqUNNyQ4nlTF1P2casIB0IBc0YIYWF6nWckmn9xDBmKb4ZptRDJMPXa0ODQqbRMeL5zczv1eYdaX9P/AFuT8uRb6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783251337; c=relaxed/relaxed;
	bh=hEp4hkXnZJqqgHj1cbX6prSWUq/sWPwGNo6KywR0pd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S8Qm9fcxkJhoVShYV/JtRi6cpH+6vrk4K5dNVkk5y1sgc2PT63bHtvczN7XrqBzTX2L98R+vIcTJe3YMvlA5r0SfIFPM8xQYKLPF8nhcPVN87kHnR7IPL9tPhJvPZLOXtIt+EIkqvTnTr83RbrJEwazcqH2o1Ok5bdgj+yNxRQvL22/NiE/LGf9VlimdjF7I2sFwMQ2HdaZpBqPZJzHwJEfxV3APwgeCvd9yPXhTaE0/gsy0K6f+5VXMz3zzjD0zWg5/jbXc/5BRIN8tPmGDuDyBHEnhERDK8P1ILG/h1JgmEDo7WUsr1X8lh5F8g/BrWEFIT9IOLKpqhMLpEJ0O1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=212.18.0.9; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=212.18.0.9; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtQQv6427z2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 21:35:34 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gtQQp3gddz1r5ST;
	Sun,  5 Jul 2026 13:35:30 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gtQQj391Lz1r5SR;
	Sun,  5 Jul 2026 13:35:25 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4gtQQh4vnnz1qqlR;
	Sun,  5 Jul 2026 13:35:24 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id eqXnZcOzeJq0; Sun,  5 Jul 2026 13:35:20 +0200 (CEST)
X-Auth-Info: rL0Tgy9moVwB6CCQCSaA+F48ujYxdVsV0p4gppaTiwTnO5NOHncg3Q4G9ZyKTDzO
Received: from igel.home (aftr-62-216-202-245.dynamic.mnet-online.de [62.216.202.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun,  5 Jul 2026 13:35:20 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 093BE2C0B17; Sun, 05 Jul 2026 13:35:20 +0200 (CEST)
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
  kan.liang@linux.intel.com,  linuxppc-dev@lists.ozlabs.org,
  linux-kernel@vger.kernel.org,  kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
In-Reply-To: <1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
References: <20260427122742.210074-1-mkchauras@gmail.com>
	<87wlvazrdy.fsf@igel.home>
	<1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
Date: Sun, 05 Jul 2026 13:35:19 +0200
Message-ID: <877bn9vfd4.fsf@igel.home>
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

On Jul 05 2026, Christophe Leroy (CS GROUP) wrote:

> Le 04/07/2026 à 17:49, Andreas Schwab a écrit :
>> This breaks booting on the PowerMac G5 (PowerMac7,3), there is a panic
>> somwhere in an irq.
>> 
>
> Do you have more details ? Like at least the dump of the panic Oops ?

NIP .power4_idle_nap+0x30/0x34
LR .power4_idle+0x64/0x70
--- interrupt: 900

.arch_spu_idle+0x88/0x100
.default_idle_call+0x3c/0x5c
.do_idle+0x194/0x2b4
.cpu_startup_entry+0x3c/0x40
.start_secondary+0x6b0/0x820
start_secondary_prolog+0x10/0x14

> Can it be reproduced on QEMU ?

No, qemu does not support SMP.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

