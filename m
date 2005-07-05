Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 4E1A967C3C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 18:31:11 +1000 (EST)
To: Rober Hsu <rober@opnet.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Jul 2005 15:16:38 +0800."
	<1120547797.16541.24.camel@localhost.localdomain>
Date: Tue, 05 Jul 2005 10:28:40 +0200
Sender: wd@denx.de
Message-Id: <20050705082840.A140C353A4A@atlas.denx.de>
Cc: LinuxPPC <linuxppc-embedded@ozlabs.org>
Subject: Re: How to porting U-Boot to MPC852T 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1120547797.16541.24.camel@localhost.localdomain> you wrote:
> 
>    I can run ppcboot 1.1.6 at my MPC852T very well,
> but when i change to 1.2.0 or above, it has many trouble
> to me.I found 1.1.6 can work at 100MHZ, but else fail.

This is off topic on a Linux mailing list.

>    Somebody know how to use u-boot or ppcboot 1.2.0 at MPC852T at 100MHZ
> and Enable Fast  Ethernet, i just can run at ppcboot 1.1.6, else
> fail.I've try all version from ppcboot 1.2.0 to u-boot 1.2.0.I think i
> can run 852T at 100Mhz and enable fast ethernet,so my hardware is no
> problem.But ppcboot 1.2.0  change too much source code, it makse me very
> confuse,i don't know how to quickly debug it.

You did not mention which board you are using. If it is  one  of  the
boards in the public source tree than all current versions of U-Boot,
especially  top-of-tree  in  CVS. should just work fine. We use it on
several MPC852 based boards.

> #Running at 50MHz is stable than 100MHZ but fec is stil not work
> 
> PPCBoot 1.2.0 (Jul  5 2005 - 10:04:03)
>  
> CPU:   MPC852T (0x08010004) at 50 MHz: 4 kB I-Cache 4 kB D-Cache FEC
> present
> DRAM:  16 MB
> Not load linux now? (enter anykey):
^^^^^^^^^^^^^^^^^^^^

This does not look like a standard port of PPCBoot /  U-Boot.  Heaven
knows which modifications and/or bugs it may contain.

> => tftp 0 ppcboot.bin
> NIP: 00000000 XER: A0000000 LR: 00FE3F0C REGS: 00fafb48 TRAP: 1000 DAR:
> A0000000
> MSR: 00009002 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00
>  
> GPR00: 00000000 00FAFC38 00000000 FFFFFFFF 00FAFDD1 00000075 00FAFEC0
> 00000000
> GPR08: 00FF9818 FFFFFFFF 00FF7DA0 00001E00 59005035 00000000 00FF8B00
> C0FD0000
> GPR16: 00000000 00000000 00000000 00000000 39000004 00000001 FFFFFFFC
> 00001000
> GPR24: 00000001 00000000 00FAFFC4 00000003 00000003 00FAFF94 00FF90F0
> 00FF7F70
> Call backtrace:
> 00000160 00FE1744 00FEC8C4 00FEC64C 00FE48DC 00FE40D4 00FE15CC
> 00FD23B0 30343A30
> Software Emulation Exception

User error. You just overwrote the exception vectors.  You  just  got
what you asked for.

> #100MHZ halt at System init
> 
> PPCBoot 1.2.0 (Jul  5 2005 - 15:00:32)
>  
> CPU:   MPC852T (0x08010004) at 100 MHz: 4 kB I-Cache 4 kB D-Cache FEC
> present
> DRAM:  16 MB   <--- System Halt at here

Probably a some errors in your SDRAM init  code.  Are  you  sure  you
adjusted  it  correctly  for  the  new clock? [One more reason to use
current code instead.]

> #define CONFIG_8xx_GCLK_FREQ    100000000
> #define CONFIG_MPC860			1 /* This is a MPC860 CPU		*/
> #define CONFIG_TQM860L			1 /* ...on a TQM8xxL module	*/


Arghhh!!!! You CANNOT, I repeat *CANNOT* just  take  a  configuration
from  one  board  and  use  it on completely different hardware. This
config file is for a TQM860L board, and it will definitely  NOT  work
correctly on your MPC852 based system.


Sorry, but you obviously failed to read  the  documentation  (README,
FAQ, Manual). Go back to square 0.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Perl already has an IDE.  It's called Unix.
                      -- Tom Christiansen in 375bd509@cs.colorado.edu
