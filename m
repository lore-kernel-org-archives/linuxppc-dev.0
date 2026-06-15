Return-Path: <linuxppc-dev+bounces-22666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B017CD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 22:29:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfPtN3lm4z2yRF;
	Tue, 16 Jun 2026 08:29:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=152.66.115.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781549675;
	cv=none; b=M4ozcXI2zqvCs1DyyijAvwp/8ypW8HjuIAItQ73p28nhalsCY7Xaksy76JSuRiYoEWabjodHycxqAA4xQyI8MVqN7HFcvj4ME+gTB61VMKaHJFJUUZvXX2pGVX/yUPMyzz+mOxC8R/vFfjABfYOiWsNy750zwwBN8Ad8FFGCsXL9Hs5AejAujSaq9Pl1Sr/Ep/qgKSjEymOmEb833YuJGvs08NpieBbXpOac7j8LHp23M/PaoaY9wcvTJC/cKJ6EUCyI2PUm5hOgbC2hvLpYnrob7mIXQllk5QHDyRgtwtaTbWzzhhUnCWR6HVmBJhbggylEyUtDTSqSr6aDJA8KUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781549675; c=relaxed/relaxed;
	bh=MGNi23gfG/uNc9HHT2kpC2EmhAUNQhHX6EZpPdGrT3k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cqhrzk9k4VPpOE24N1SVFST3a0ToH6VCdGX0dh/ywLeRWyW6EaDAQLFErYSfqvtXeEGw1Ux3Eb9H8HbgFo3mlViOILN4QAcNKroIIx6/6lSHHXEEMGeb8okm87nmRvrW0TPLG9dSDAB5cVJM03Aa0zIUBcb6xSdAx9oSC21ZqDsxEzE38VuA/nGN0FKRrfGaW08g/4SR1hJi71OylbWIimVHpAGG720/FSl7Ndct+X4K1PhOH6f62VapnF6KeqOY03mQxNzU5pEhfTiZU+1sEp/PEt14SMLiFTD9wqjAqQz0kNAVdCsJYH8oxSln2A2Ca0a6x7gwF9DwE3LNw5O2kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass (client-ip=152.66.115.2; helo=zero.eik.bme.hu; envelope-from=balaton@eik.bme.hu; receiver=lists.ozlabs.org) smtp.mailfrom=eik.bme.hu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=eik.bme.hu (client-ip=152.66.115.2; helo=zero.eik.bme.hu; envelope-from=balaton@eik.bme.hu; receiver=lists.ozlabs.org)
Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfK6f0LPLz2y8h
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 04:54:32 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 7C837596944;
	Mon, 15 Jun 2026 20:54:28 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Sq3z6YurKN-w; Mon, 15 Jun 2026 20:54:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 633DE596941; Mon, 15 Jun 2026 20:54:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 5DB3F596858;
	Mon, 15 Jun 2026 20:54:26 +0200 (CEST)
Date: Mon, 15 Jun 2026 20:54:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
cc: Andrew Randrianasulu <randrianasulu@gmail.com>, qemu-ppc@nongnu.org, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: Does kvm_pr work on G5 mac with host kernel 6.12.xx ?
In-Reply-To: <2d037b7b-6bdf-4aaa-9e2d-d26530d668d8@kernel.org>
Message-ID: <b962164f-1540-d2c1-6478-1f255622f0de@eik.bme.hu>
References: <CA+rFky7UDpHYFXvEiq91dpnfLuKCiaONctmW-q2jONmNG25Wow@mail.gmail.com> <418f045e-7aaf-c48b-4f08-018625b2c3e6@eik.bme.hu> <CA+rFky73KGYwJRBuEBqFA1dKkDk0_W+u4VQL9bg2n1_AkeOU3g@mail.gmail.com> <fb610033-efd3-6fa6-bd80-c5dccc9296eb@eik.bme.hu>
 <CA+rFky4nea6VPhYuVhH2SwSAgP0QC5LMrHqfWAwKNMNHpQ7aYg@mail.gmail.com> <8f2fb26e-f406-261a-f9b7-8a1a032bf4df@eik.bme.hu> <2d037b7b-6bdf-4aaa-9e2d-d26530d668d8@kernel.org>
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

On Mon, 15 Jun 2026, Christophe Leroy (CS GROUP) wrote:
>> NIP=0x700 is illegal instruction exception due to trying to execute 0 
>> opcode at 0x100 which is the reset vector but shouldn't it try to start at 
>> 0xfff00100? Maybe there's some issue with setting up KVM correctly?
>
> On powerpc32 it is 0x100 or 0xfff00100 based on whether bit IP (Interrupt 
> Prefix) is 0 or 1 in MSR register.
>
> On powerpc64 MSR[IP] doesn't exist.

But this is under QEMU which sets in qemu/hw/ppc/mac_newworld.c:

#define PROM_BASE 0xfff00000
[...]
static void ppc_core99_reset(void *opaque)
{
     PowerPCCPU *cpu = opaque;

     cpu_reset(CPU(cpu));
     /* 970 CPUs want to get their initial IP as part of their boot protocol */
     cpu->env.nip = PROM_BASE + 0x100;
}

So the execution should start from 0xfff00100 unconditionally where the 
OpenBIOS is loaded but I haven't seem the QEMU command so I'm only 
guessing this is with qemu-system-ppc -machine mac99,accel=kvm. I'm not 
sure how it got to 0x100 instead but there's no code there to execute on 
reset.

Regards,
BALATON Zoltan

