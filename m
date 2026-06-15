Return-Path: <linuxppc-dev+bounces-22656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AECDCD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 18:12:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfJBG1QnRz3btj;
	Tue, 16 Jun 2026 04:12:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781547158;
	cv=none; b=IxSB8NN8e2d/OWc/dodvDFlsgFnFgikVq7ZOqHn47kBpwv/lpSJ6n9SNKRG+0iP9DC6pFSDFY4ukUYHiE1WY00poHAlfdsH3gGCov/UPHIxFr4yIPmRcEoeglwmFFDhOUMjFWIgKQD4pdoUTy96nVSEcGWLr/s1n4BNx+/NqewvHIy1WX7mXvP2k663GFoyqqcIzyaxN8jr4wimGEVOjTS6SdYYRjcTL/eyoxsj4fHgOjx7V3ns5AdaPha1xgovQrmb0xswWKZhMzwo21i9oX5lUBkV1cN1V+rVTGEg6ABksFzsDv9RHxeTp6Lx1MnGyf8xtWgf0mEYXk+WYIQGgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781547158; c=relaxed/relaxed;
	bh=hJKKgSIwhLcdPsONVTi2CDly+Ayva6tOzhT1hkqtAZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+G50E5CZ7EMNjC4adsuX3Wz/bROvePNiKbylmGlgTK8YhUb+sPlW2TwlRo4ERGvrJoPRG0MNgNr6nWJrACRcKI4AhkWM1FFP7m8j1m4wYdf0usIGV8l1mL35l88jdEe0/fvTx3OuB6KkJ6JBHY6IY622PFUMt/2d+rIEx6gifdMqFKLokMDFrDdDwr+5uWmJAEyCAMghUs29zjn3547ssa3G89Q54jlNFNGwYwyH1iYhrKEw5MwnmPN/PjW9U+MKOlU13Y4X3EK3r5zUF2pz8WYBPIvhBxGr4e74+LI4DGW2Zcm4ydjPGixEIgO28VJXo/+yBkS3wOvT4AjfPW49g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNy2fXXk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNy2fXXk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfJBF1x0Pz3btc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 04:12:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B0D2743712;
	Mon, 15 Jun 2026 18:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFD61F000E9;
	Mon, 15 Jun 2026 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547154;
	bh=hJKKgSIwhLcdPsONVTi2CDly+Ayva6tOzhT1hkqtAZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eNy2fXXkfz6Lioz/0ZKkxH7VH5kesO9N6rJkGwhtcdqA8YUZkeeyEKV6Q4MOVcH1B
	 2ViIbTIZvzJHXg2uItiX3uS7TBpgnAzN+vNn+tZlwJDIwJHlqQWdOd3n4c3W5LtYUv
	 CgyMVe5HwSVjVXWJ0KfNnv+H7c1Chk6MPOKSdREr/R6T7MXVRlKCas+M62BmqMq4TH
	 lOYEPIntyPO3NUnz29dlhc2WQWqSO5rHohS8wc4HDI0ifeh+Xq8ok5jJ3nvtEN9YZg
	 MXm0olRPX6nIP+vYzlHDYR8VKOK+RqUm9m3nX51hgJzBwKu5vbGEh5hrovmRhBXS+Q
	 4Ne88RoQ6toZw==
Message-ID: <2d037b7b-6bdf-4aaa-9e2d-d26530d668d8@kernel.org>
Date: Mon, 15 Jun 2026 20:12:31 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: Does kvm_pr work on G5 mac with host kernel 6.12.xx ?
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
References: <CA+rFky7UDpHYFXvEiq91dpnfLuKCiaONctmW-q2jONmNG25Wow@mail.gmail.com>
 <418f045e-7aaf-c48b-4f08-018625b2c3e6@eik.bme.hu>
 <CA+rFky73KGYwJRBuEBqFA1dKkDk0_W+u4VQL9bg2n1_AkeOU3g@mail.gmail.com>
 <fb610033-efd3-6fa6-bd80-c5dccc9296eb@eik.bme.hu>
 <CA+rFky4nea6VPhYuVhH2SwSAgP0QC5LMrHqfWAwKNMNHpQ7aYg@mail.gmail.com>
 <8f2fb26e-f406-261a-f9b7-8a1a032bf4df@eik.bme.hu>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <8f2fb26e-f406-261a-f9b7-8a1a032bf4df@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/06/2026 à 15:33, BALATON Zoltan a écrit :
> On Mon, 15 Jun 2026, Andrew Randrianasulu wrote:
>> I also tried to see "info registers" as you showed in another email from
>> 2021 where you tried to use kvm-pr on qemu-emulated G5 and it showed
>>
>> info registers
>>                NIP 0000000000000700   LR 0000000000000000 CTR
>> 0000000000000000 XER 0000000000000000 CPU#0
>> MSR 8000000000000000 HID0 0000000060000000  HF 8000000000000000 iidx 3 
>> didx
>> 3                      TB 00000000 00000000 DECR 0
>>                                              GPR00 0000000000000000
>> 0000000000000000 0000000000000000 0000000000000000
>> GPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>                        GPR08 0000000000000000 0000000000000000
>> 0000000000000000 0000000000000000                          GPR12
>> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> GPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>                        GPR20 0000000000000000 0000000000000000
>> 0000000000000000 0000000000000000                          GPR24
>> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>                  GPR28 0000000000000000 0000000000000000 0000000000000000
>> 0000000000000000
>> CR 00000000  [ -  -  -  -  -  -  -  -  ]             RES ffffffffffffffff
>>                        FPR00 0000000000000000 0000000000000000
>> 0000000000000000 0000000000000000                          FPR04
>> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>                  FPR08 0000000000000000 0000000000000000 0000000000000000
>> 0000000000000000
>> FPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>                        FPR16 0000000000000000 0000000000000000
>> 0000000000000000 0000000000000000                          FPR20
>> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>                  FPR24 0000000000000000 0000000000000000 0000000000000000
>> 0000000000000000                          FPR28 0000000000000000
>> 0000000000000000 0000000000000000 0000000000000000
>> FPSCR 0000000000000000
>>                        SRR0 0000000000000100  SRR1 8000000000080000    
>> PVR
>> 00000000003c0301 VRSAVE 0000000000000000      SPRG0 0000000000000000 
>> SPRG1
>> 0000000000000000  SPRG2 0000000000000000  SPRG3 0000000000000000      
>> SPRG4
>> 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SPRG7
>> 0000000000000000
>> SDR1 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000
>>
>> (qemu) q
>>
>> not sure if instruction pointer moved or not ...
>>
>> looking at some scroll buffer in Termux (I ssh into powermac ) it was at
>> 700 all 3 times I typed "info registers" into qemu monitor.
>>
>> but this debug msg
>>
>> [154992.595845] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
>> [154992.595859] kvmppc_exit_pr_progint: emulation at 100 failed 
>> (00000000)
>>
>>
>> fills logs FAST!
> 
> NIP=0x700 is illegal instruction exception due to trying to execute 0 
> opcode at 0x100 which is the reset vector but shouldn't it try to start 
> at 0xfff00100? Maybe there's some issue with setting up KVM correctly?

On powerpc32 it is 0x100 or 0xfff00100 based on whether bit IP 
(Interrupt Prefix) is 0 or 1 in MSR register.

On powerpc64 MSR[IP] doesn't exist.

Christophe

> You can trace what is executed in TCG with -d in_asm but that does not 
> work for KVM as it's a TCG debug option. I don't know how to trace 
> execution with KVM but probably there are some trace points for that. 
> Maybe you get some info with -trace enable="kvm*" but I don't know how 
> to understand that output.
> 
> Regards,
> BALATON Zoltan
> 


