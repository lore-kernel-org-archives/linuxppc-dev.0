Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3EA5DDD01
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 18:38:33 +1100 (EST)
Message-Id: <2F57AC6E-EE1B-4B8D-8AB5-AAF5B2DC4C06@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <474B2A7F.5090607@anagramm.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: 85xx software reset problems from paulus.git
Date: Tue, 27 Nov 2007 01:38:21 -0600
References: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>	<473DB6DF.9010804@anagramm.de>	<f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>	<f87675ee0711161328u3127de3bjdd6341cdf11cd626@mail.gmail.com>	<0B4C1069-9D89-44E8-89F7-9E7CE07B03DF@kernel.crashing.org>	<f87675ee0711161401k600b658ao3d6ae572fb367c47@mail.gmail.com>	<7C2ED552-6644-4FB3-A97B-05FC3E2141FF@kernel.crashing.org>
	<f87675ee0711260941w25e5ed81v7322be1500fd5611@mail.gmail.com>
	<474B2A7F.5090607@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> Yes. The symptoms in 2.6.24RC2 are that during a kernel panic or when
>> calling 'reboot' in the shell, it just hangs. Using the same dts and
>> resets in 2.6.23.1 reboots fine. I don't have a cds reference, but
>> someone who does should be able to confirm whether the issue exists  
>> or
>> not by just attempting to reboot via bash.

Can someone do a git-bisect and find the patch that breaks things?

>> ACK. Exactly the same over here (mpc8540ads compatible).
> I added the global-utilities today as well, but reboot fails.

if you are on a 8540 GUTS doesn't support hreset_req (8548 or newer).

> Why is the guts stuff missing i.e. in most of the shipped
> mpc85xx*.dts? Does it depend on some hardware connections
> external to the CPU?

Only the 8548 or newer CPUs have the GUTS HRESET_REQ ability that we  
use to reset. (8540, 8560, 8541, 8555 do not).

- k
