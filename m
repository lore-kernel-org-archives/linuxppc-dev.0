Return-Path: <linuxppc-dev+bounces-23569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7702C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 12:03:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtR2W1FVnz2yXj;
	Sun, 05 Jul 2026 22:02:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:a60:0:28:0:1:25:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783252979;
	cv=none; b=XUKpik7t2znDZ46k0Lnth+yl4RemXdAykLxK1TWEKGHw3Xnh5sqmopX2bGclw0yHfIFyaJw/u31KDXgOicCj6lm/Y7mf303G1VfJqYke2/xlPskN69YIEi7OO4yd3ZlmKoqkbTl014dnv0x+JqK9QHH9ndufg8Ayiclh+27QG1N67CFeDtLi/+ZPJZ6Wrf6Wlds+5aasCZzI1vpXeoxQwjcIQJdCxX5ZhwdsDJPfVZaDA4h9ZeUC5jNmdlUcRhHwbcW8yarUlvZuho/st/vmLxQGfSneZPoIwJ+o3rfmxL9toQ9MFrwYvaEMEmqhs+FXM9FhghLcR6s78zdyrWHz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783252979; c=relaxed/relaxed;
	bh=Sji5Ah8stAlV4Q0B2WHTEDyQ0tlhX/MxLrEtBI4Pggs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jEKGFQRLz3gkgJM2huNDbyKTbW1L1fnT4LQnQ1UJRbpbfr1ZnVXriR7M+O+q5imddCrfPFwY83ZMk5QAmhrmB3rJEn+PxQumVDzTTS/RrXm43iRkSi1Z+8jaV6Zjdg6wmOpq60BUXRkTBo1Jayu7rt4SaFsp8sr8SL5SSo5lXxm2FChtZgzbdGhrdxss+lwD4CwPcVFgNqLBC6K1fcwP4zAcGxByd10KQXTJLczo3v/hQiRy71+f2TKOi4loTx+5ZNiWOg9KGv4FIXw6HEgsIcLgf/rMaqw+TLyfLkgQ48T905tvn3M7c3bL6+HkOzgcVy7FIlgxTyjs/umnJlKjAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=2001:a60:0:28:0:1:25:1; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=2001:a60:0:28:0:1:25:1; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 72768 seconds by postgrey-1.37 at boromir; Sun, 05 Jul 2026 22:02:58 AEST
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtR2V0rfHz2yRC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 22:02:57 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gtR2P3sBQz1sGWl;
	Sun,  5 Jul 2026 14:02:53 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gtR2H2N3zz1sGWg;
	Sun,  5 Jul 2026 14:02:47 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4gtR2G5KXFz1qqlR;
	Sun,  5 Jul 2026 14:02:46 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id sBBVFTrCTAec; Sun,  5 Jul 2026 14:02:42 +0200 (CEST)
X-Auth-Info: GjGVZKdk11T2Q/lJmy5m6Z08B4R22gBnYRTgOUdbDTI6PnfTLnyKcwoAO+YSoz4S
Received: from igel.home (aftr-62-216-202-245.dynamic.mnet-online.de [62.216.202.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun,  5 Jul 2026 14:02:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 4A4D52C0B17; Sun, 05 Jul 2026 14:02:42 +0200 (CEST)
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
Date: Sun, 05 Jul 2026 14:02:42 +0200
Message-ID: <8733xxve3h.fsf@igel.home>
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

BUG: Unable to handle kernel data access at 0x30af548c0000028
Faulting instruction address: 0xc0000000000af47c

c0000000000aee6c <.sched_balance_find_src_group>:

c0000000000af474:       e9 3f 00 18     ld      r9,24(r31)
c0000000000af478:       e9 29 0d 48     ld      r9,3400(r9)
c0000000000af47c:       89 49 00 28     lbz     r10,40(r9)
c0000000000af480:       7c 0a e0 40     cmplw   r10,r28

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

