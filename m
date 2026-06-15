Return-Path: <linuxppc-dev+bounces-22655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAFBCD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 18:10:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfJ7k06W7z3btc;
	Tue, 16 Jun 2026 04:10:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781547025;
	cv=none; b=anHT+hW12Ppx1+EHWsJouHD9wBALcYoXWnIc7kmDeAgw3WSBDk8FVqbLk74+zg5klP7a+cklGDDMTRPmjHiFtBCl5lZqU3ltXv7Wfk/rlKAp5BlqQmyg0gJ1fWdDz+3dhNKw0GFJN3G8bj15OGilGkMGvazGm6QUKYzf0oePXoK2BLSUugjdxRKDpSH6undewAZg45QyY/i71NUDXjrPTcW1sT3sMyy5wV5FZAwQS9GucjD7MuXpqNH354hpUCfZbuVJ2a3HqGhKlKR95epV4wGLHajlF+1Uw254yoEJMIHXNrgEfQ103i+gYKeJDIHlAOQtMRPr9KBf2loFF92Rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781547025; c=relaxed/relaxed;
	bh=trbfjLfnTLiXj5O8MchOok/FSLe3kEJwF1nBNpWpkfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPRe6UAiZVEHqtWyGTZIlrfWVd2U62BM5fDEahUBEQuc3R63VB9otf35kTJJ3Lu53wEk0RyTEf7365gyhawdDzE40o4ZnKkFnjvJya8qlWjET3xuxRtLb9KvqzGHtAzfPG3s29v4aRrcd3ivk3H57nuJO2pGugVx5H3VbyuJWLU5jXRfXHaj0bEGwOlaY9y181skZdeeGNc+Fqtayt/ojFH0lwtIrqZmsxsnDu4zaANQZhF4Zpsy8p15yo/Zgh2ZNSxRuFJ0aTvgV7NBN7A86niU3c4KIdbJI1IEX0MFwn68RqWn/9W3lRmZbeiPnQfuurLeeI/1OxpYV37cvhOvfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgTlXsir; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgTlXsir;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfJ7h2Rd2z3btT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 04:10:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 96991600AB;
	Mon, 15 Jun 2026 18:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242541F000E9;
	Mon, 15 Jun 2026 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547021;
	bh=trbfjLfnTLiXj5O8MchOok/FSLe3kEJwF1nBNpWpkfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QgTlXsirazc4DRHEl8g72PVM0tL5WJAqxTv6nhBjp3s4QWmIFVb2GhrihL44ozbQN
	 n9UjJIRiM2LeCmpXDMooIXiO9rndkOJyKScvKmal2PYlKxKJNA3i8lHvd3Gv5RA1FN
	 L3CSYsgF80VrB1ULmbo+fLIdkLv+Nh2cALk3I+GtRdwkdJJX/6MVFd9wvQhwof1raR
	 z15w5tjeGFqZYKBA0mhBGert8dSWd1vL7oYtQlq0bcw8b5C4SljaevBvZxn8FNON77
	 xAya6mBbseVvmWjohHSGjJ8mq4IzZDUq967hM4PsRKFSn51DAwVCdjd4zpXMq6KqL0
	 HQTKUNx99kJeQ==
Message-ID: <e50782eb-aaa5-47c9-b933-06edd0a12df1@kernel.org>
Date: Mon, 15 Jun 2026 20:10:17 +0200
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
To: Andrew Randrianasulu <randrianasulu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
References: <CA+rFky7UDpHYFXvEiq91dpnfLuKCiaONctmW-q2jONmNG25Wow@mail.gmail.com>
 <418f045e-7aaf-c48b-4f08-018625b2c3e6@eik.bme.hu>
 <CA+rFky73KGYwJRBuEBqFA1dKkDk0_W+u4VQL9bg2n1_AkeOU3g@mail.gmail.com>
 <fb610033-efd3-6fa6-bd80-c5dccc9296eb@eik.bme.hu>
 <CA+rFky4nea6VPhYuVhH2SwSAgP0QC5LMrHqfWAwKNMNHpQ7aYg@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CA+rFky4nea6VPhYuVhH2SwSAgP0QC5LMrHqfWAwKNMNHpQ7aYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/06/2026 à 11:26, Andrew Randrianasulu a écrit :
> 
> 
> вс, 14 июн. 2026 г., 23:35 BALATON Zoltan <balaton@eik.bme.hu 
> <mailto:balaton@eik.bme.hu>>:

[...]

> 
>     But that's BookE e500 not the BookS POWER4 variant G5 you have so
>     KVM may
>     work differently on that and maybe it even has HV which probably works
>     better than PR. 
> 
> 
> oh yes, I noticed another "hidden" option in Kconfig about kvm pr on 
> E5500/E6500
> 
> It was hidden because I did not select such machine in config, I guess.
> 
> 
>     I think KVM was used on G4, e500 and newer POWER mostly
>     with HV but I'm not sure if KVM PR on G5 was ever well supported.
>     Did you
>     try running the same Linux version that you have on your host under
>     KVM PR
>     first to verify that at least that works? I think that's where
>     everybody
>     should start with KVM before trying to boot other guest OSes.
> 
>      >> So considering the above, what may work is if you run a 32 bit
>     ppc kernel
>      >> (G4 version) on your G5 for the host not using it as 64 bit
>     instead of
>      >> ppc64 kernel and try a guest kernel that detects G5 CPU and
>     knows how to
>      >> handle the different cache line size.
>      >
>      >
>      > Are you saying 32bit *Linux* ppc kvm as host can handle 64bit
>     guest kernel ?
> 
>     No I meant trying a 32 bit host with 32 bit guest but the cache line
>     size
>     issue may still get in the way so maybe this does not help but for
>     debugging may worth a try.
> 
>      > I am not ever sure firmware here can load 32bit ppc Linux .. I'll
>     try of
>      > course.
> 
>     Since G5 is backwards compatible with PPC32 maybe it should work but I
>     know nothing about real PowerPC machines.
> 
>      > Or find and fix the emulation of
>      >> different instructions on ppc64 in Linux KVM when running 32 bit
>     ppc code
>      >> on 64 but host. There supposed to be some support for that but
>     maybe it's
>      >> broken or never finished.
> 
> 
> I found this email msg today:
> 
> 
> https://lkml.iu.edu/1605.1/03841.html <https:// 
> eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Flkml.iu.edu%2F1605.1%2F03841.html&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C5e49653ba80147cc12e808decac03273%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639171124039051598%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=7gxjETKFSAMFjcnBQUuYcFHR2OE7b3W%2FGMRdHWF9X0Q%3D&reserved=0>
> 
> checked
> 
> linux-6.12.92/arch/powerpc/kvm/emulate.c and there seems to be ifdef 
> only for
> 
> #ifdef CONFIG_PPC_BOOK3S                                                
>                             kvmppc_core_queue_program(vcpu, SRR1_PROGTRAP);
> #else                                                                    
>                            kvmppc_core_queue_program(vcpu,              
>                                arch.shared->esr | ESR_PTR);
> #endif
> 
> 
> may be this ifdef should include CONFIG_PPC_BOOK3S_64 as well ?

I don't understand what you mean.

CONFIG_PPC_BOOK3S is defined as:

config PPC_BOOK3S
	def_bool y
	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64

Christophe

