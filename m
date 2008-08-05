Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA028DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 02:48:36 +1000 (EST)
In-Reply-To: <3d6dc055c5b18a641a5467b7331d935ede87efb2.1217943634.git.michael@ellerman.id.au>
References: <3d6dc055c5b18a641a5467b7331d935ede87efb2.1217943634.git.michael@ellerman.id.au>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <02B3273A-55F2-42A3-AB17-8B90FCE27961@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: EOI spurious irqs during boot so they can be
	reenabled later
Date: Tue, 5 Aug 2008 18:48:00 +0200
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> So when we receive a spurious irq, EOI it, and then mask it.

What happens when a new IRQ arrives on the interrupt controller
between these EOI and mask calls?  Should you instead first mask
it, and only then EOI it?  Or doesn't that work on XICS?


Segher
