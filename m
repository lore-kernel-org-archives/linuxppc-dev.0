Date: Sat, 24 Nov 2001 22:57:41 -0700
From: Matt Porter <mporter@mvista.com>
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel/head.S start_here
Message-ID: <20011124225741.A9197@beef.az.mvista.com>
References: <35C119252057D511BB9F0003476BF8A208E65F@freexc01.smartm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35C119252057D511BB9F0003476BF8A208E65F@freexc01.smartm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 15, 2001 at 12:18:55PM -0800, Prasad, Siva wrote:
> Thanks a lot for the reply Matt. I understood how virtual memory is enabled
> with SRR0 and SRR1. Thanks for the help.
>
> >Inserting the card is probably exposing a bug in your PCI enumeration
> >software or the board port's handling of PCI host bridge setup.
>
> I don't think it is going until PCI enumeration software. Last thing it
> prints is "Now booting kernel". After that it stops, if I put the PMC card.

The last thing you see is from the bootloader, so based on that it
could be anywhere before console_init() (or after if your serial
output code doesn't work).

> Based on my preliminary investigation, I think code hangs some where around
> the following instructions.

What method did you use to determine you are in this code?

> ~~~~~~~~~~~~~~~
> start_here:
> #ifndef CONFIG_PPC64BRIDGE
> 	bl	enable_caches
> #endif
>
> 	/* ptr to current */
> 	lis	r2,init_task_union@h
> 	ori	r2,r2,init_task_union@l
> 	/* Set up for using our exception vectors */
> 	/* ptr to phys current thread */
> 	tophys(r4,r2)
> 	addi	r4,r4,THREAD	/* init task's THREAD */
> 	CLR_TOP32(r4)
> 	mtspr	SPRG3,r4
> 	li	r3,0
> 	mtspr	SPRG2,r3	/* 0 => r1 has kernel sp */
>
> 	/* stack */
> 	addi	r1,r2,TASK_UNION_SIZE
> 	li	r0,0
> 	stwu	r0,-STACK_FRAME_OVERHEAD(r1)
> ~~~~~~~~~~~~~~~~
>
> What I don't understand is, how come this part of code is creating problem
> with Linux booting if I plug in the other PMC card. How is this related to
> PCI?.

No idea.

> Is there any way to debug where it hangs when virtual memory is ON. It hangs
> if I call a C routine to printk in the middle of this code.

The efficient way is to use a BDI2000 or similarly capable (if there
are any) JTAG COP debugger.

Alternatively, cover your UART with a BAT and drop progress characters
out the port.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
