MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: reboot by software
Date: Tue, 16 Dec 2003 06:16:33 -0700
Message-ID: <8039970AF146314597457D3B51A68B382E044E@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem with jumping to 0xFFF00100 is that the hardware (processor internal as well as external bits) is not reset and it messes up the start up sequence.  The easiest solution is to force a checkstop reset (via a machine check), which performs a hardware reset and gets the 8260 (and your external hardware if your hardware supports the reset properly) back into the reset state.

The easiest way to do this is to unmap the memory that is being used to execute code (including the vector area) and then force a machine check

For an example, see U-Boot reset: it may need to be adapted to your purposes, but is a very nice example.  U-Boot can be found on sourceforge.net.  It is maintained and supported by Wolfgang Denk and his merry band (the snippet below is from .../cpu/mpc8260/cpu.c and is copyright Wolfgang Denk with a GPL license).  For more information, see sourceforge and www.denx.de

gvb


int
do_reset(cmd_tbl_t *cmdtp, bd_t *bd, int flag, int argc, char *argv[])
{
	ulong msr, addr;

	volatile immap_t *immap = (immap_t *)CFG_IMMR;

	immap->im_clkrst.car_rmr = RMR_CSRE; /* Checkstop Reset enable */

	/* Interrupts and MMU off */
	__asm__ __volatile__ ("mfmsr    %0" : "=r"(msr) : );
	msr &= ~(MSR_ME|MSR_EE|MSR_IR|MSR_DR);
	__asm__ __volatile__ ("mtmsr    %0" : : "r"(msr) );

	/*
	 * Trying to execute the next instruction at a non-existing address
	 * should cause a machine check, resulting in reset
	 */
#ifdef CFG_RESET_ADDRESS
	addr = CFG_RESET_ADDRESS;
#else
	/*
	 * note: when CFG_MONITOR_BASE points to a RAM address, CFG_MONITOR_BASE
	 * - sizeof (ulong) is usually a valid address. Better pick an address
	 * known to be invalid on your system and assign it to CFG_RESET_ADDRESS.
	 */
	addr = CFG_MONITOR_BASE - sizeof (ulong);
#endif
	((void (*)(void ))addr)();
	return 1;

}


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of John
> Zhou
> Sent: Tuesday, December 16, 2003 4:39 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: reboot by software
>
>
>
> Hello!
>
> I have a linux running on my mpc8260 board( power on reset at
> 0xfff00100, I use 32 bit flash, and directly maping
> 0xF0000000 ~ 0xFFFFFFF in kernel).
>
> Now, I want to reboot system by software. But, when I jump to
> 0xfff00100 in kernel mode, it's going dead. Can anybody help me?
>
> Thanks.
>
> John
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
