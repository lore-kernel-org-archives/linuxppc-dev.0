Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 3D1632BF16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 22:37:31 +1100 (EST)
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Jan 2005 18:44:08 PST."
	<91B22F93A880FA48879475E134D6F0BE316B8C@CA1EXCLV02.adcorp.kla-tencor.com>
Date: Wed, 12 Jan 2005 12:37:03 +0100
Sender: wd@denx.de
Message-Id: <20050112113708.9E414C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Help with PPC440GX + MontaVista + uBoot 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <91B22F93A880FA48879475E134D6F0BE316B8C@CA1EXCLV02.adcorp.kla-tencor.com> you wrote:
> 
> PIBS isn't what we want to use long term, we'd rather use uBoot.  I've
> downloaded and built the latest version of uBoot (1.1.2).  I then
> created a multi-file image with mkimage.  I can download it via TFTP but
> when I start to run it strange/bad things happen:
> 
> 	Kernel command line: ip=3Don console=3DttyS0,115200 root=3D/dev/ram rw
> 	Warning: real time clock seems stuck!
> 	Calibrating delay loop... 37.27 BogoMIPS
> 
> ...now the RTC is know to work and the mips calculation is seriously
> off.  Then...

That's a FAQ. Please see the part about "Bad definition of the
bd_info structure" in
http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

> I realize that ocotea.c will have to be modified to grab command line
> options from NVRAM (uBoot) instead of FLASH (PIBS) but that doesn't seem

Wrong. U-Boot (please mind the spelling) does not pass  command  line
options in NVRAM. They get passed in RAM.

> to explain why the internal timer is way off and the ethernet PHYs can't
> be found.

Because you use a wrong definition of bd_info.  Delete  the  existing
definition and include asm/ppcboot.h in your board config file.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Bradley's Bromide: If computers get too  powerful,  we  can  organize
them into a committee - that will do them in.
