Date: Thu, 5 Dec 2002 12:50:58 -0700
From: Matt Porter <porter@cox.net>
To: Linux on PowerPC Developers Mail List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: questions about porting an 8240 arch to linux
Message-ID: <20021205125058.B14807@home.com>
References: <20021205161437.A16705@crystal.2d3d.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021205161437.A16705@crystal.2d3d.co.za>; from abraham@2d3d.co.za on Thu, Dec 05, 2002 at 04:14:37PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 05, 2002 at 04:14:37PM +0200, Abraham vd Merwe wrote:
> * Board based on Motorola MPC8240 processor (based on 603e core)
> * 32M sdram
> * 250mhz processor
> * board is based on PowerPC microprocessor command hardware reference
> platform (CHRP).
>
> !!! Here's what I figured out/did so far. Please correct me if I did
> something wrong.
>
> 1. used 2.4.18 w/ 2.4.18-ppc patch applied (got it from ftp.kernel.org)
> 2. added my arch to arch/ppc/config.in
> 3. added a embed_config() section to arch/ppc/boot/simple/embed_config.c for
> my arch with the following hardcoded parameters:

This is wrong.  You don't need this if you use misc-simple.c

> 4. add an include for my arch header in include/asm-ppc/mpc8xx.h

You are an 8240/603e core.  don't touch.

> 5. defined the following bd_t structure in my arch header:

Not needed.

> 6. defined IMAP_ADDR, IMAP_SIZE, NR_8259_INTS in my arch header

Not needed.

> 2. what uart should I use? the user manual claims the board has a 8250
> compatible uart, but if I compile in the standard linux 16550 uart support,
> it exports the same symbols as those in arch/ppc/boot/simple/m8xx_tty.c
> which is compiled when I select M8XX support. I disabled the 16550 support
> for now and defined NR_8259_INTS to 16 (what should this be?) for now just
> to get it to compile.

As benh said, select 6xx/7xx/74xx/... (classic ppc)

> 3. do I need to setup any registers before branching to the kernel?

No, the simple bootloader takes care of it for you.

See platforms/* for examples to make your life easy.

menf1_setup.c:menf1_find_end_of_memory(): get memory size using standard
mpc10x lib.
menf1_setup.c:menf1_platform_init(): setup todc_* to use rtc to handle bus
freqs.
If no RTC on system then see:
zx4500_setup.c:zx4500_calibrate_decr(): setup jiffies.

Take a good look at mpc10x_common.c.

Good luck.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
