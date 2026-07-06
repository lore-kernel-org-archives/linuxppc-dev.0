Return-Path: <linuxppc-dev+bounces-23639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AB5C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 15:27:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv7Wl4qhSz3bby;
	Tue, 07 Jul 2026 01:27:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.18.0.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783351635;
	cv=none; b=CJJr8sNbP9YC8U+y2SaEi2iBjyWNVRTzR/X+s9tlN5tvmDMgO7j3JOPvz2vCWEzYZrVSVnMNq7n5DT8WUiYEtG+UzDEgMrEQa0pOdchfkGEG+ZV1jt0lO10kSy3a2muBSG+iOXNxawYjslKGsYX10ZxywkUP0gX42k05Aa+0GEiNYzDy/jO4Rojd65yOY1pHkpPXkVMujcFi8R+h8qHdcUdbPnOlucY9vDQ8cgL/2sRnC2cyuvt4kA1aau9OnshNl8eMBlk+1vDFs25VS4+TQS6FHoV9SlV9f+Bp1msMD1wkE27BiZbku2P4DP0tXfUMxvcTyDM2+tMoMtdNfi3d0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783351635; c=relaxed/relaxed;
	bh=wYOCgqzMGWWErCZz9ovcrMp+CddUSBdOxY7FI+8PcsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EqHdOoYilTtN0tVcDi0km0qMWAc8fBEaVNytm5+Hl1GxTYCpOhtPY0yv1oOfYnBspGa0BtWXyu1363tgDdAZJ4l6AkoADrXO21KdcpMz9g2PcKr3RIQZsg93BsNeKp96QuNlTSZBZDToj8XCvR8ALwjK8E5SfnlQaX3Zbck2qWfrnT6EGj/EHMjxVKr5h5uKX8Xr3dOnyM5iZ3z1o/qzfrx+420Mn2PaQaO45KuNZEJ6dDKcO0BdKM3Y+g8BGpz9ZtTb7Fh1qyZZdI1yh7KFl5mg2XbBGR9U9+GOtvkBMg9hJMQh/lIW7/ImnM164zAcDAf0Gx+X63q/5Fm2iRWubg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=212.18.0.10; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=212.18.0.10; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv7Wk0PDzz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 01:27:12 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gv7Wc2XRFz1sHQ1;
	Mon,  6 Jul 2026 17:27:08 +0200 (CEST)
Received: from frontend04.mail.m-online.net (unknown [192.168.6.183])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gv7WR53g2z1sHPP;
	Mon,  6 Jul 2026 17:26:59 +0200 (CEST)
Received: from localhost (dynscan4.mnet-online.de [192.168.6.88])
	by mail.m-online.net (Postfix) with ESMTP id 4gv7WR19jFz1qqlR;
	Mon,  6 Jul 2026 17:26:59 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan4.mail.m-online.net [192.168.6.88]) (amavis, port 10024)
 with ESMTP id MJWgF5bi-jD9; Mon,  6 Jul 2026 17:26:54 +0200 (CEST)
X-Auth-Info: TNc3sp1ivTnsjHBGV3mZNpzmLz97A1EGuaNuvlZwLZpSdf55Cp25/eG5esZlAOVm
Received: from igel.home (aftr-62-216-202-81.dynamic.mnet-online.de [62.216.202.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon,  6 Jul 2026 17:26:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 1FA5F2C0AF6; Mon, 06 Jul 2026 17:26:54 +0200 (CEST)
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
Date: Mon, 06 Jul 2026 17:26:54 +0200
Message-ID: <87y0fo9m0x.fsf@igel.home>
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

On Jul 06 2026, Shrikanth Hegde wrote:

> Hi Andreas.
>
> On 7/5/26 5:32 PM, Andreas Schwab wrote:
>> BUG: Unable to handle kernel data access at 0x30af548c0000028
>> Faulting instruction address: 0xc0000000000af47c
>> c0000000000aee6c <.sched_balance_find_src_group>:
>> c0000000000af474:       e9 3f 00 18     ld      r9,24(r31)
>> c0000000000af478:       e9 29 0d 48     ld      r9,3400(r9)
>> c0000000000af47c:       89 49 00 28     lbz     r10,40(r9)
>> c0000000000af480:       7c 0a e0 40     cmplw   r10,r28
>> 
>
> Does the stack-trace change every time?

Most of the time I get nothing, and when I get something it is mostly
scrolled out already (there is only so much you can put in 80x25).  I
had to hack the kernel to reduce the output to the bare minimum.

> There were couple more fixes on top of it. Is it included in your kernel already?
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=334f3f6d7a1660fd65597bad9960bfa33a716d35
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=4e1187e12de40b5301977b2476d21b569358dafb

They are all in 7.2-rc1 already.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

