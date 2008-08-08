Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 551C9DDF46
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 19:18:40 +1000 (EST)
Subject: Re: Strange tg3 regression with UMP fw. link reporting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <31233EB5-037E-4615-95C9-7C816E510752@kernel.crashing.org>
References: <1218180939.24157.332.camel@pasglop>
	<31233EB5-037E-4615-95C9-7C816E510752@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 19:18:31 +1000
Message-Id: <1218187111.24157.336.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Nathan Lynch <ntl@pobox.com>,
	mcarlson@broadcom.com, Michael Chan <mchan@broadcom.com>,
	netdev <netdev@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-08 at 10:58 +0200, Segher Boessenkool wrote:
> > I don't know yet for sure what happens, but a quick look at the commit
> > seems to show that the driver synchronously spin-waits for up to 2.5ms
> 
> That's what the comment says, but the code says 2.5 _seconds_:
> 
> +       /* Wait for up to 2.5 milliseconds */
> +       for (i = 0; i < 250000; i++) {
> +               if (!(tr32(GRC_RX_CPU_EVENT) & GRC_RX_CPU_DRIVER_EVENT))
> +                       break;
> +               udelay(10);
> +       }
> 
> (not that milliseconds wouldn't be bad already...)

Right, indeed. I think we have a good candidate for the problem :-) I'll
verify that on monday. Now, that leads to two questions:

 - What such a synchronous and potentially horribly slow code is
going in a locked section or a timer interrupts ? Ie, the link
watch should probably move to a workqueue if that is to remain,
or the code turned into a state machine that periodically check for
events, or whatever is more sane than the above.

 - The code should at least display some error and do something sane in
case of timeout such as disabling the new UMP feature instead of
repeatedly looping ...

 - If this is indeed our problem (timing out in the code above), why is
our firmware not emitting the requested event -> maybe the PowerStations
need a tg3 firmware update.

Matt, what's your take on this ?

Cheers,
Ben.
