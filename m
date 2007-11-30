Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 62C6CDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 02:09:40 +1100 (EST)
Message-ID: <475027B9.4060804@anagramm.de>
Date: Fri, 30 Nov 2007 16:09:45 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: fabien <fabien.fb@gmail.com>
Subject: Re: ppcboot and powerpc branch question
References: <f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>
In-Reply-To: <f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

fabien schrieb:
> hi all,
> 
> After some problem with my custom board and kernel 2.6.19 about the
> init process, i've moved
> on 2.6.23 and that had fixed my problems. (related to this post :
> http://marc.info/?l=linuxppc-embedded&m=119609022221017&w=2)
> Apparently it was a problem with cpm_uart on SMC1.
> (http://lkml.org/lkml/2007/9/23/99)
> the patch have been integrated in 2.6.23. Now i use this kernel and
> busybox works.
> I want to migrated my board in powerpc branch instead of ppc (i plan
> to use xenomai but in 2.6.23
> there is only an adeos patch for piowerpc branch), but i see the use
> of a device tree
> instead of bd_t struct. I'm a bit disappointed because i also see that
> older u-boot (in my case
> ppcboot 1.1.5) aren't capable to pass dts to kernel.
> Is there a way to keep my old bootloader to boot a powerpc branch kernel ?

please read linux/Documentation/powerpc/booting-without-of.txt

To get a cuImage, you
- need to adjust your <platform>.dts and configure your kernel to use it.
- need the latest dtc (device tree compiler),
- need the latest mkimage (from the latest u-boot tree)
- and build your cuImage by building the target zImage (make zImage)
-> your cuImage then rests in i.e. arch/powerpc/boot/cuImage.<platform>

Aside of no good documentation, I ran into the problem that the
embedded device tree doesn't get updated by the bd_t struct properly
(the mac addresses) in the latest versions of the kernel. This might be
a bug or a configuration error on my side. I didn't check yet.
U-Boot with full device tree support will hopfully fix that, when it's
out.

Regards,

-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
