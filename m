Date: Wed, 20 Oct 1999 09:33:32 +0200 (MET DST)
From: Raphael Massin <massin@col.bsf.alcatel.fr>
Message-Id: <199910200733.JAA28746@cu5s33.clb>
To: jeff@wa1hco.mv.com
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
Cc: linuxppc-embedded@lists.linuxppc.org, dmalek@jlc.net, massin@cu5s33
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 
> 
> I've also been thinking about this...
> 
> If the boot process goes bad, then the interrupt driven watchdog will
> keep getting reset and prevent the watchdog from firing...leading to a
> unrecoverable hang.  So, what's the likely hood of the boot process
> going bad?
> 
> Our application requires downloading new kernels and applications and this
> may
> increase the likely hood that a kernel fails to complete the boot process.
> 
> This idea has a window of vunerability but how much and how likely???
> 
> Maybe the timer can be set longer than the longest bootup time or at least
> until the first daemon gets going?
> 
> jeff
> 

Hello,

I'm using the watchdog timer on a custom board since several months. To
prevent a CPU reset during the kernel is uncompressing, i prorammed it
to generate a Non Maskable Interrupt instead of system reset. Those NMIs
are handled by a special function in the Linux kernel. This function
can reset the board, using a specific I/O, when too many NMIs occurred
without any watchdog timer (SWSR) servicing.

Today, i refresh the timer in my real time application that is launched
immediately after the kernel init. This scheme must work for any board
launching an appli/real time module after kernel init. For other configurations,
Dan's idea seems perfect.

	Raphael

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
