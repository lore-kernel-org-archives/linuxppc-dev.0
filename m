Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.203])
	by ozlabs.org (Postfix) with ESMTP id C17782BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Oct 2004 05:27:47 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so134255rnk
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 09 Oct 2004 12:27:15 -0700 (PDT)
Message-ID: <35fb2e59041009122710ab6d53@mail.gmail.com>
Date: Sat, 9 Oct 2004 20:27:15 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Tony Lee <tony.p.lee@gmail.com>
In-Reply-To: <470b6397041007195371655afb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <000001c4aace$245a5060$6500a8c0@PortatileLG>
	<35fb2e5904100508157a393ee2@mail.gmail.com>
	<4162C649.6060900@ru.mvista.com>
	<35fb2e590410051507367017a@mail.gmail.com>
	<41641222.6080405@ru.mvista.com>
	<470b63970410071534422f6617@mail.gmail.com>
	<4165DB83.8080001@jonmasters.org>
	<470b6397041007195371655afb@mail.gmail.com>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>,
	Luca Giuliani <l.giuliani@tiscali.it>, linuxppc-embedded@ozlabs.org
Subject: Re: Linux on Memec Virtex II Pro V4P7 Rev. 3
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 7 Oct 2004 19:53:52 -0700, Tony Lee <tony.p.lee@gmail.com> wrote:

> The problem I saw was that I can't turn off the interrupt at all.

On the Memec board? really?

> Once I start one write command, the ISR keep coming in.

Ouch.

> I review the verilog code and schematic multiple times with the
> HW group but can't figure out what went wrong.

We had to move one of the sysace lines to a different bank on the v2p
but that was because we were cunningly running out of particular IO
lines (the v2p does different signalling and voltages on different
banks - I didn't make the modification as I don't work on the hardware
directly, just mess with Xilinx hardware stuff in my spare time and
software for them when at work :-) ).

> My best guess was the BUFRDY line is mix up with the ISR line

Perhaps. But that's down to your hardware guys to check the error
output from your synthesis tool to see if this weirdly has happened.
Our board doesn't have lines hard tied together, if that was the
notion you were offering.

> I try turn off the ISR on write with SYSACE register and
> the ppc interrupt control register.  None of them worked.

Did you do it as per my patch, or what?

> Do you think if we add a small DMA engine would help
> the performance or the performance problem is caused
> by the sysace firmware + the CF disk?

Perhaps. I'll have a think about that - I'm certainly not going to get
paid to do that, and until I can buy a v2p board for home or have some
spare time in the office, it'll have to wait for an implementation.
Kind of like porting to 2.6 and a whole bunch of other non-comercially
useful things I want to do with this thing :-).

> The sysace controller IS VERY fast on loading the bitstream
> and linux boot image.

Yes. We come up in 8 seconds to my firmware, and total boot time is
around 20 seconds, without any effort to make it less. That includes
cunning DHCP+ZeroConf scripts I wrote.

Jon.
