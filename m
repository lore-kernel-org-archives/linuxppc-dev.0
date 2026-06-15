Return-Path: <linuxppc-dev+bounces-22648-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82C1CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 15:35:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfDhr52rLz3bxC;
	Tue, 16 Jun 2026 01:35:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=152.66.115.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781530400;
	cv=none; b=a2LMo8dp409LUL6Q5fAERHmrx4t8LUBh2n+ivPEH8oorK9Z5L1gaZlExLIFgKnWsnyaYKpFpymCGd6GpShx6/ATTj7DAUCxtSN6mBr5b3Febsxn655KugrKL4tnd3QTbPYVZd8npGzX6TrkyJzMP/tvY9NN8Vh5oQs6r8wJ4a42beXw2lgXvfB0rhUwmQzQPayG3KVt3RpR4xPveclTLLeJqXRcBe/WOudKD6RoHdG476bx3UjRuinjSDX7JyXus/SfvozLs4Nrhp8gLmgbBPBirKUakjawTdRKnZEdAlGviObZWqTCD3STN8XisSfzis4GSmBXRtHK51JqOO8lH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781530400; c=relaxed/relaxed;
	bh=GOcv6OMpsa614rwCuNxT3/MnZDQ2l3laubE8o58STho=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S+y5f3JIfhXmR69lIlQY4v5pysYEq3tOPPjb8SmulZOECtlWhpJp5vmfHs/XW2VS6JGSM37GWrAv00izVeJIpVnWDdxH6ZRuhOp/dl9sIgVl79OaRUNJ1PE0YlsGgndW3DmAjV0oyyjw8Ii263ATc3TpucWwNCjTzpUgSJArDvQhSLJPU7Wxxl5RnGRWFnbkogNJ/G1VM0hAyFXxnM8mu0+t02EvbOq/8DPRQs3lMl2bBH+MLXHw/5nKDmIh+FULh+H1f3L9iXmuVF0ipounYKDxepvoITOl+WfSCQiXMQ9nh7vVg8rXohpi3kiR502H9IAd5lwS6g2z+kEc41wyTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass (client-ip=152.66.115.2; helo=zero.eik.bme.hu; envelope-from=balaton@eik.bme.hu; receiver=lists.ozlabs.org) smtp.mailfrom=eik.bme.hu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=eik.bme.hu (client-ip=152.66.115.2; helo=zero.eik.bme.hu; envelope-from=balaton@eik.bme.hu; receiver=lists.ozlabs.org)
Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf9zy6NLCz3btJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 23:33:17 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 355E8596978;
	Mon, 15 Jun 2026 15:33:13 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wySfAcL1UpVd; Mon, 15 Jun 2026 15:33:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 2E8F8596967; Mon, 15 Jun 2026 15:33:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 2CDAB596948;
	Mon, 15 Jun 2026 15:33:11 +0200 (CEST)
Date: Mon, 15 Jun 2026 15:33:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Does kvm_pr work on G5 mac with host kernel 6.12.xx ?
In-Reply-To: <CA+rFky4nea6VPhYuVhH2SwSAgP0QC5LMrHqfWAwKNMNHpQ7aYg@mail.gmail.com>
Message-ID: <8f2fb26e-f406-261a-f9b7-8a1a032bf4df@eik.bme.hu>
References: <CA+rFky7UDpHYFXvEiq91dpnfLuKCiaONctmW-q2jONmNG25Wow@mail.gmail.com> <418f045e-7aaf-c48b-4f08-018625b2c3e6@eik.bme.hu> <CA+rFky73KGYwJRBuEBqFA1dKkDk0_W+u4VQL9bg2n1_AkeOU3g@mail.gmail.com> <fb610033-efd3-6fa6-bd80-c5dccc9296eb@eik.bme.hu>
 <CA+rFky4nea6VPhYuVhH2SwSAgP0QC5LMrHqfWAwKNMNHpQ7aYg@mail.gmail.com>
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
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 15 Jun 2026, Andrew Randrianasulu wrote:
> I also tried to see "info registers" as you showed in another email from
> 2021 where you tried to use kvm-pr on qemu-emulated G5 and it showed
>
> info registers
>                NIP 0000000000000700   LR 0000000000000000 CTR
> 0000000000000000 XER 0000000000000000 CPU#0
> MSR 8000000000000000 HID0 0000000060000000  HF 8000000000000000 iidx 3 didx
> 3                      TB 00000000 00000000 DECR 0
>                                              GPR00 0000000000000000
> 0000000000000000 0000000000000000 0000000000000000
> GPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                        GPR08 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000                          GPR12
> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                        GPR20 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000                          GPR24
> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                  GPR28 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> CR 00000000  [ -  -  -  -  -  -  -  -  ]             RES ffffffffffffffff
>                        FPR00 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000                          FPR04
> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                  FPR08 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> FPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                        FPR16 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000                          FPR20
> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                  FPR24 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000                          FPR28 0000000000000000
> 0000000000000000 0000000000000000 0000000000000000
> FPSCR 0000000000000000
>                        SRR0 0000000000000100  SRR1 8000000000080000    PVR
> 00000000003c0301 VRSAVE 0000000000000000      SPRG0 0000000000000000 SPRG1
> 0000000000000000  SPRG2 0000000000000000  SPRG3 0000000000000000      SPRG4
> 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SPRG7
> 0000000000000000
> SDR1 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000
>
> (qemu) q
>
> not sure if instruction pointer moved or not ...
>
> looking at some scroll buffer in Termux (I ssh into powermac ) it was at
> 700 all 3 times I typed "info registers" into qemu monitor.
>
> but this debug msg
>
> [154992.595845] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> [154992.595859] kvmppc_exit_pr_progint: emulation at 100 failed (00000000)
>
>
> fills logs FAST!

NIP=0x700 is illegal instruction exception due to trying to execute 0 
opcode at 0x100 which is the reset vector but shouldn't it try to start at 
0xfff00100? Maybe there's some issue with setting up KVM correctly? You 
can trace what is executed in TCG with -d in_asm but that does not work 
for KVM as it's a TCG debug option. I don't know how to trace execution 
with KVM but probably there are some trace points for that. Maybe you get 
some info with -trace enable="kvm*" but I don't know how to understand 
that output.

Regards,
BALATON Zoltan

