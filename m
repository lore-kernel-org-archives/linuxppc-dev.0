To: zjzhou@newrocktech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: reboot by software 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Dec 2003 17:38:46 +0800."
             <000101c3c3b8$68333110$b702a8c0@newrock2>
Date: Tue, 16 Dec 2003 11:24:51 +0100
Message-Id: <20031216102456.E79DEC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear John,

in message <000101c3c3b8$68333110$b702a8c0@newrock2> you wrote:
>
> I have a linux running on my mpc8260 board( power on reset at
> 0xfff00100, I use 32 bit flash, and directly maping 0xF0000000 ~
> 0xFFFFFFF in kernel).
>
> Now, I want to reboot system by software. But, when I jump to
> 0xfff00100 in kernel mode, it's going dead. Can anybody help me?

Jumping to some address does not cause a reboot of the system.  After
a   reset,  the  CPU  state  (especially  the  state  of  the  memory
controller) is somewhat special. The safest  way  to  cause  a  clean
reboot of the whole system is to actually go through a reset.

Try something like this:

void
m8260_restart(char *cmd)
{
	__volatile__	unsigned char	dummy;
	__volatile__	unsigned int	msr;
	uint		bad_addr;

	/* Get base address mapped by BR0/OR0 */
	bad_addr = ((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 & 0xFFFF8000;
	cli();

	/* Enable CheckStop Reset */
	((immap_t *)IMAP_ADDR)->im_clkrst.car_rmr |= 0x00000001;

	/* Invalidate BR0 mapping */
	((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 = 0;

	/* Set MSR and cause reset */
	__asm__("mfmsr %0" : "=r" (msr) );
	msr &= ~0x1000;
	__asm__("mtmsr %0" : "=r" (msr) );
	dummy = * (unsigned char *) bad_addr;
	printk("Restart failed\n");
	while(1);
}

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bankers do it with interest (penalty for early withdrawal).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
