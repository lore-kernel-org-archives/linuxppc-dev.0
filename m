Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id B54F167A75
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 08:50:17 +1100 (EST)
To: srinivas.surabhi@wipro.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Feb 2005 19:55:35 +0530."
	<EF9B29C78F41FA488927FCBC7750AF0E011DA5A1@hyd-mdp-msg.wipro.com>
Date: Mon, 14 Feb 2005 22:49:59 +0100
Sender: wd@denx.de
Message-Id: <20050214215004.5C72AC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <EF9B29C78F41FA488927FCBC7750AF0E011DA5A1@hyd-mdp-msg.wipro.com> you wrote:
> 
> Our target is somewhat like this. It has PPC8270, Flash and SDRAM. We
> are using the uboot for booting. Successfully built the linux kernel and
> Ramdisk images using devrocket. The problem is that the kernel and

Are you sure that your Linux kernel is configured to be booted by U-Boot?

> Ramdisk images although getting extracted successfully to 0M location of
> SDRAM from Flash with the help of uboot, the serial console says nothing
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

> 3. Is there any documentation which gives the detailed debugging of the
> linux kernel from the loading of kernel?

This is partially covered in the DULG, see
http://www.denx.de/twiki/bin/view/DULG/Manual

Best regards,

Wolfgang Denk

-- 
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Cogito cogito ergo cogito sum - "I think that I  think,  therefore  I
think that I am."          - Ambrose Bierce, "The Devil's Dictionary"
