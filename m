Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4283687DE
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2005 13:58:20 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17290.26688.710369.613144@cargo.ozlabs.ibm.com>
References: <20051126113805.709ee538.pochini@shiny.it>
	<17290.26688.710369.613144@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 13:52:48 +1100
Message-Id: <1133146369.7768.170.camel@gaston>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: CPU off power consumption
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-28 at 13:15 +1100, Paul Mackerras wrote:
> Giuliano Pochini writes:
> 
> > Out of curiosity, what's the difference between a cpu that has never been
> > enabled and one that has been disabled with echo 0>/sys/.../online ? It
> > happens that when I boot with maxcpus=0 the temperature always stays low
> > enoung that the fan never spins up. If I enable and then I immediately
> > disable the 2nd cpu, the temperature goes a few degrees up. I have a dual
> > G4-MDD.
> 
> Interesting.  A cpu that has been disabled will be in sleep mode with
> interrupts disabled and its caches flushed.  One that has never been
> started may possibly be held in the reset state.  The way to check
> would be to check the state of the GPIO register that controls the
> soft reset line of the second CPU.

No, I think CPUs that have not been started are held in a similar sleep
loop in ROM. I don't see right away why there would be any power
consumption difference unless some bug causing us to never actually call
the sleep loop ....

Ben.
