Return-Path: <bwarren@qstreams.com>
Received: from web303.biz.mail.mud.yahoo.com (web303.biz.mail.mud.yahoo.com
	[68.142.199.179]) by ozlabs.org (Postfix) with SMTP id 63858DDEF4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 12:31:05 +1000 (EST)
Date: Mon, 9 Apr 2007 19:31:03 -0700 (PDT)
From: Ben Warren <bwarren@qstreams.com>
Subject: RE: Unable to Boot 2.6.19.2 from ELDK 4.1 on MPC8349E MDS
To: Gary Kenaley <gkenaley@echelon.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <DDBD7B17DB2ECE48BCD94C593F7255B4046E9F23@monk.echelon.echcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <871602.42517.qm@web303.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gary,

--- Gary Kenaley <gkenaley@echelon.com> wrote:

> I have been evaluating Freescale 2.6.11, Wind River
> 2.6.14, and am now
> attempting Denx 2.6.19 (from ELDK 4.1) - running on
> the Rev 1.0 MPC8349E
> MDS (V1.1 CPU). I boot 2.6.19.2 using the factory
> u-boot 1.1.3 and the
> kernel immediately hangs:
> Uncompressing Kernel Image ... OK {hangs forever}

This version of U-boot is very old.  It is too old to 
boot a Linux kernel that was built using ARCH=powerpc.
 
On to your questions...  
<snip>

> Questions, please:
> ------------------
> 1. Should I expect this kernel to boot on the
> MPC8349E MDS, or do I need
> to find and apply a variety of patches?
> 
This kernel will boot on this board (I have the same
board), but you need to do a few things:

1. Get the latest U-boot.  It's available via git
from:
git://www.denx.de/git/u-boot.git.
2. Get 'dtc', the device tree compiler.  It's
available at www.jdl.com
3. Compile the device tree file for your board, which
is in /arch/powerpc/boot/dts/mpc8349emds.dtc of the
Linux source.
4. From U-boot, load the .dtb file that was generated
in step 3 either into memory or flash.
5. Modify whatever U-boot command you're using to boot
Linux to call 'bootm <kernel address> - <dtb address>
6. Try to not get frustrated about this device tree
stuff.  It's not very well documented, but several
people recognize this and are working to remedy it.

> 2. Any idea why I have problems doing the "ELDK 4.1
> full source rebuild
> from scratch"?
> 
Can't comment.  I'm still on ELDK 4.0.
> 3. Do you see anything else important that I should
> change in my
> process?
> 
> Since I am a bit of a newbie, I'll be grateful to
> get a lot of specific
> advice.
> 
> Thanks, Gary

Feel free to ping the U-boot list if you need help. 
It's very possible that I missed something here or
wrote something incorrectly.  Please ask again if you
still have difficulty.

regards,
Ben
