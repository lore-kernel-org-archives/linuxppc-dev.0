Return-Path: <msheahan@networkmodules.com>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [216.148.227.85])
	by ozlabs.org (Postfix) with ESMTP id 4D4762BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 01:29:38 +1100 (EST)
From: "Matt Sheahan" <msheahan@networkmodules.com>
To: "'Howard, Marc'" <Marc.Howard@KLA-Tencor.com>
Date: Wed, 12 Jan 2005 09:24:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050112113708.9E414C108D@atlas.denx.de>
Message-Id: <20050112142938.4D4762BF0E@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Help with PPC440GX + MontaVista + uBoot 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Check ocotea_calibrate_decr.  It is using a hard coded clock value of 25
MHz.  When I ported the Ocotea code to my custom board, used the value
passed from U-Boot (bi_intfreq).

I think the Ocotea code in 2.4.x might have been developed using a rev. B
440GX and there are some differences in how the timers and decrementers
derive their clock on the rev. C parts.

Also, using the bd_info definition in asm/ppcboot.h did not work perfectly
for me.  Be sure to check the conditional compiles that are being set in
U-Boot against Linux for the bd_info structure.  The 440GX structures did
not align properly and I had to tweak them and make sure U-Boot was filing
them in correctly (lib_ppc/board.c).


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Wolfgang Denk
Sent: Wednesday, January 12, 2005 6:37 AM
To: Howard, Marc
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Help with PPC440GX + MontaVista + uBoot 

In message
<91B22F93A880FA48879475E134D6F0BE316B8C@CA1EXCLV02.adcorp.kla-tencor.com>
you wrote:
> 
> PIBS isn't what we want to use long term, we'd rather use uBoot.  I've
> downloaded and built the latest version of uBoot (1.1.2).  I then
> created a multi-file image with mkimage.  I can download it via TFTP but
> when I start to run it strange/bad things happen:
> 
> 	Kernel command line: ip=3Don console=3DttyS0,115200 root=3D/dev/ram
rw
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
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
