Message-Id: <200008211325.PAA14539@denx.local.net>
To: Jerry Van Baren <vanbaren_gerald@si.com>
cc: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot memory mapping problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 21 Aug 2000 07:24:18 EDT."
             <4.3.2.20000821065652.00b573b0@falcon.si.com>
Date: Mon, 21 Aug 2000 15:25:40 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Maybe we should keep PPCBoot related discussion  out  of  this  list?
IMHO  it  belongs  to the ppcboot-users@lists.sourceforge.net mailing
list.

In message <4.3.2.20000821065652.00b573b0@falcon.si.com> you wrote:
>
> One thing that leaps out at me which could be a problem, depending on
> conditions and code, is the IMMR address.  We found it much easier to
> just set the IMMR to 0xF0000000 rather than fight the code to put it
> elsewhere.  Theoretically, it can be anywhere above the virtual address

Then change it. It's just a #define in the PPCBoot config file!

If you port PPCBoot for a EST8260 system, it makes sense to adapt the
settings from the Linux include/asm-ppc/est8260.h  file.  I  will  be
happy  to  include your config_EST8260.h file into the PPCBoot source
tree. Just send it to me...

> of RAM (0xC0000000).  You also have to be _very_ careful in your IMMR
> remap code that it only is executed _once_.  If you execute it a second
> time or try to remap it but don't have the correct current IMMR address
> (you need the current IMMR address in order to set it to the new
> address), you will (probably) cause a bus fault and Bad Things Will Happen.

I can't see any relation of this statement to current PPCBoot code.

> It shouldn't be a problem, but I would strongly urge you to _not_ set
> the IMMR to 0xFFF00000 because that is the magic boot address.  It will

Depends on your setup. My MPC8xx systems all start execution at 0x100 :-)

> be very confusing for everybody who follows in your footsteps as to why
> you appear to be overwriting your boot code when you do IMMR I/O.  I
> would recommend you use one of the power up selectable IMMR addresses
> (0xF0000000 is the only one that is above 0xC0000000) and it is easier
> if you set your boot configuration to set the IMMR to 0xF0000000 on
> bootup to make it match the linux expectations.

You can do so if you like - it's just a single #define in the PPCBoot
configuration file. What are you complaining about?

> Another possibility is your flash addresses.  The kernel makes
> assumptions that the addresses of I/O is higher than the end of virtual
> RAM: if your kernel is using the flash[01], it may be getting confused.

I've been using Linux with these mapping for a  _long_  time,  and  I
never  had  any  problems.  Our  flash  driver  works fine with these
addresses. Can you please explain where you see problems?

If there are really any problems it's trivial to change.

>          Initial conditions:
>          -------------------
>
>          Tasks that need to be perform by the boot ROM before control is
>          transferred to zImage (compressed Linux kernel):

Please note that PPCBoot does not need all the bootstrap code you get
with a zImage - all the initialization and uncompressing is  doen  by
PPCBoot,  so you just need the compressed kernel image: all the stuff
in arch/ppc/mbxboot is obsolete when you're using PPCBoot.


>          - Define the IMMR to 0xf0000000

OK, so use this value when you write the config_EST8260.h file.

>          - Initialize the memory controller so that RAM is available at
>            physical address 0x00000000.  On the SBC8260 is this 16M (64M)
>            SDRAM.

OK.

>          - Build the board information structure (see
>            include/asm-ppc/est8260.h for its definition)

OK.

>          - The compressed Linux kernel (zImage) contains a bootstrap
> loader
>            that is position independent; you can load it into any RAM,
>            ROM or FLASH memory address >= 0x00200000 (above 2 MB).

This is NOT NEEDED with PPCBoot. Don't waste flash memory for
duplicate code!

>          - Load R3 with the address of the board information structure

This is NOT enough. The Linux kernel parameters are:

	r3: ptr to board info data
	r4: initrd_start or 0 if no initrd
	r5: initrd_end - unused if r4 is 0
	r6: Start of command line string
	r7: End   of command line string

>          - The Linux console port is SMC1, and the baud rate is controlled
>            from the bi_baudrate field of the board information structure.

This is configurable with PPCBoot, and with all Linux kernels we are
using. We like to have the console on SMC2 on some boards...

>            On thing to keep in mind when picking the baud rate, is that
>            there is no flow control on the SMC ports.  I would stick
>            with something safe and standard like 19200.

Speeds up to 115200 work fine for me.


Again: may we please move this discussion to the ppcboot-users list?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A complex system that works is invariably found to have evolved from
a simple system that worked."             - John Gall, _Systemantics_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
