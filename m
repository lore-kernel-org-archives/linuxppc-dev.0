Message-ID: <3A4CD374.40754688@mvista.com>
Date: Fri, 29 Dec 2000 13:09:56 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tim Montgomery <tjmontgo@mailbag.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 64 bit memory access
References: <3A4CC527.BF9431A7@mailbag.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim Montgomery wrote:

> I need to:
> 1.) figure out a way to perform a 64bit write via other means

Cache the location.  When you access the space the processor will
do a 64-bit read.  You will have to run in copyback mode then when
done updating the location push the cache line to the device.

> Any suggestions/insight would be appreciated.

Using 64-bit only I/O, and FP registers on a 32-bit processor is
an interesting hardware/software hack, but not a very good system
design.

I guess we could write some kernel 64-bit I/O functions that use
an FP register.  This would require disabling interrupts, enabling
the FPU in the kernel, saving a register, doing the I/O, restoring the
register, disabling the FPU, and enabling interrupts.  Not very efficient
when a proper 60x bus implementation that allowed sizing would have
been really fast.........


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
