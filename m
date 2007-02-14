Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 05F74DDE27
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 07:32:08 +1100 (EST)
Message-ID: <45D371C0.80805@freescale.com>
Date: Wed, 14 Feb 2007 14:32:00 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
	<Pine.LNX.4.60.0702142118200.8621@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0702142118200.8621@poirot.grange>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, Stuart Yoder <stuart.yoder@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:

> Is that dts also for u-boot? maybe they have another bootloader? I know 
> u-boot creates "chosen" itself, but not all possible bootloaders?

Well, that's what I'm trying to figure out.  I don't see any evidence to suggest 
that the 8276 is different from any other 8xxx board, with respect to U-Boot, 
and none of the other 8xxx DTS files have a 'chosen' section.  Then there's the 
fact that the 8276's 'chosen' section is in the *middle* of the DTS, and not at 
the end where everyone else puts it, leads me to believe that its presence is an 
oversight.

So far, no one who has chimed in on this particular subject has answered this 
question: what's so special about the 8276 that its DTS should have a 'chosen' 
section when none of the others do?

> (as a matter of fact, the more I think about those .dts's, the more it 
> seems to me like they belong to bootloaders, not in the kernel... Just 
> one word - information duplication...)

Well, that's a completely separate issue altogether.  I believe that they are 
kept with the kernel as a convenience, so that we all have more control over 
their contents.

> Another thing, Timur, if you respin your patch, could you do it against 
> the current powerpc.git? There's at least one more .dts there that also 
> would need boot-cpu removed - kuroboxHD.dts.

My patch already removes linux,boot-cpu from kuroboxHD.dts:

diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts 
b/arch/powerpc/boot/dts/kuroboxHG.dts
index d06b0b0..7531027 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -35,7 +35,6 @@ build with: "dtc -f -I dts -O dtb -o kur

  		PowerPC,603e { /* Really 8241 */
  			linux,phandle = <2100>;
-			linux,boot-cpu;
  			device_type = "cpu";
  			reg = <0>;
  			clock-frequency = <fdad680>;	/* Fixed by bootwrapper */

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
