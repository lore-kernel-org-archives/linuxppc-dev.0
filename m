Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E7A31007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Nov 2009 08:34:55 +1100 (EST)
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B100BF4.5080209@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<8E6E11A2-25F1-4AB8-B42E-58C269018CD2@kernel.crashing.org>
	<4B0D65C5.8090304@yahoo.es>
	<7556BF73-5D6D-4817-A02F-3DFA05E9AC58@kernel.crashing.org>
	<4B0EFBB2.9090206@yahoo.es>
	<9741644C-BED3-45D9-B405-4C4FC2184DC7@kernel.crashing.org>
	<786BBFA3-39AF-4100-8406-6B32258D3174@kernel.crashing.org>
	<4B100BF4.5080209@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 28 Nov 2009 08:34:33 +1100
Message-ID: <1259357673.2076.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-11-27 at 18:27 +0100, Albert Herranz wrote:
> 
> I checked it too on the Nintendo GameCube making the ack a no-op.
> 
> It turns out that we _need_ to ack the RSW (Reset Switch) interrupt.
> The other interrupt sources checked (EXI, VI, DI, AI, DSP/ARAM) need
> no explicit ack.

That would probably mean that the reset switch interrupt is an edge
interrupt. Which means that you also use the wrong flow handler btw :-)
No biggie here tho, if it's acked before the handler is called, which
should be the case, and if masking it doesn't prevent the edge detector
from latching, then it should be allright.

But you may want to make sure you don't have another edge irq somewhere
in there...

Cheers,
Ben.
