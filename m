Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx3.wipro.com (wip-ectls-mx3.wipro.com
	[203.101.113.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx3.wipro.com",
	Issuer "certserv.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B9A1E67A85
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 21:33:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 15 Feb 2005 16:02:48 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA5C5@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

Today somehow after removing many options I build the kernel and able to
succeed till the VFS: "Mounted root (cramfs filesystem) readonly." But
then I am seeming "kernel panic". Actually what option has to be given
for init. We have given init=3D/bin/sh but no luck.

Please pull me out.

One more observation is that the U-boot bootargs are overwriting the
Kernel boot arguments given at the time of build. Even though using
setenv I removed the bootargs but still the kernel arguments given at
the time of build using devrocket are not still active.


The end part on the hyperterminal is given below

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 2640k freed
VFS: Mounted root (cramfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 60k init
Warning: unable to open an initial console.
Error -3 while decompressing!
0015fd20(1928974736)->00141000(4096)
Kernel panic: No init found.  Try passing init=3D option to kernel.
 <0>Rebooting in 180 seconds..


Thanks & Regards
Surabhi Srinivas

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]=0D
Sent: Tuesday, February 15, 2005 3:20 AM
To: Srinivas Surabhi (WT01 - EMBEDDED & PRODUCT ENGINEERING SOLUTIONS)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console=0D

In message
<EF9B29C78F41FA488927FCBC7750AF0E011DA5A1@hyd-mdp-msg.wipro.com> you
wrote:
>=0D
> Our target is somewhat like this. It has PPC8270, Flash and SDRAM. We
> are using the uboot for booting. Successfully built the linux kernel
and
> Ramdisk images using devrocket. The problem is that the kernel and

Are you sure that your Linux kernel is configured to be booted by
U-Boot?

> Ramdisk images although getting extracted successfully to 0M location
of
> SDRAM from Flash with the help of uboot, the serial console says
nothing
> except "uboot ist nicht tot..."

Funny. This message is neiter part of the standard U-Boot code nor of
the standard Linux kernel. Try to find out where this code is  coming
from.

> 1. How do I know that the control was given to linux kernel?

Set a breakpoint at a low address like 0x000C. If the debugger  stops
there you are executing Linux kernel code.

Alternatively, enable DEBUG when building your U-Boot image (at least
when compiling file "common/cmd_bootm.c").

> 2. Is it that the linux kernel got the control but unable to put the
> prompt on the serial line? FYI.  I modified the inittab to reflect the
> console to come on the serial line.

Inittab has nothing to do with the kernel's startup messages. Is your
kernel configured correctly for using a serial console?

> 3. Is there any documentation which gives the detailed debugging of
the
> linux kernel from the loading of kernel?

This is partially covered in the DULG, see
http://www.denx.de/twiki/bin/view/DULG/Manual

Best regards,

Wolfgang Denk

--=0D
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Cogito cogito ergo cogito sum - "I think that I  think,  therefore  I
think that I am."          - Ambrose Bierce, "The Devil's Dictionary"



Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
