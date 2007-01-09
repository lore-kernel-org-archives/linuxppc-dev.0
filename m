Return-Path: <tnt@246tNt.com>
Received: from outmx027.isp.belgacom.be (outmx027.isp.belgacom.be
	[195.238.4.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6797CDDE05
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 18:17:10 +1100 (EST)
Received: from outmx027.isp.belgacom.be (localhost [127.0.0.1])
	by outmx027.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l097Gq05018650
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 08:16:55 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A340E4.5030702@246tNt.com>
Date: Tue, 09 Jan 2007 08:14:44 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>	
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>	
	<1168303139.22458.246.camel@localhost.localdomain>	
	<20070109005624.GA598@suse.de>
	<1168308323.22458.254.camel@localhost.localdomain>
In-Reply-To: <1168308323.22458.254.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2007-01-08 at 16:56 -0800, Greg KH wrote:
>> On Tue, Jan 09, 2007 at 11:38:59AM +1100, Benjamin Herrenschmidt wrote:
>>> On Mon, 2007-01-08 at 15:58 +0100, Sylvain Munaut wrote:
>>>> Don't build ohci as module for now.
>>>> A fix for that is already in gregkh usb tree for 2.6.21
>>> Do you mean that as-is, powerpc defconfigs cannot build USB as a module
>>> in 2.6.20 ? That is unacceptable as a regression. We need a fix in
>>> 2.6.20.
>>>
>>> Greg, what is the status there ?
>> Hm, for some reason I thought your patches were not needed until 2.6.21.
>
> My endian patches aren't, but Sylvain' are based on mines so ... Maybe
> if Sylvain rebases his ?

FWIW, the patch does apply fine (at least the first one, which is needed) :

tnt@hitomi linux-2.6-mpc52xx-new $ patch -p1 --dry-run <
ohci-rework-bus-glue-integration-to-allow-several-at-once.patch
patching file drivers/usb/host/ohci-at91.c
patching file drivers/usb/host/ohci-au1xxx.c
patching file drivers/usb/host/ohci-ep93xx.c
patching file drivers/usb/host/ohci-hcd.c
patching file drivers/usb/host/ohci-lh7a404.c
patching file drivers/usb/host/ohci-omap.c
patching file drivers/usb/host/ohci-pci.c
Hunk #1 succeeded at 238 (offset -73 lines).
patching file drivers/usb/host/ohci-pnx4008.c
patching file drivers/usb/host/ohci-pnx8550.c
patching file drivers/usb/host/ohci-ppc-soc.c
patching file drivers/usb/host/ohci-pxa27x.c
patching file drivers/usb/host/ohci-s3c2410.c
patching file drivers/usb/host/ohci-sa1111.c

The offset in ohci-pci.c is harmless.

But maybe the question we should ask is why would it build
drivers/usb/host/ohci-ppc-soc.c for an iMac G3 ... Because that problem
(ohci multiple glue in module) is there since a long time, just never
spotted before.

arch/powerpc/KConfig :

config PPC_EFIKA
        bool "bPlan Efika 5k2. MPC5200B based computer"
        depends on PPC_MULTIPLATFORM && PPC32
        select PPC_RTAS
        select RTAS_PROC
        select PPC_MPC52xx
        select PPC_NATIVE
        default y
               ^^^

This was added by commit
c37858d333a50815c74349396e31a535f4128e0b on Nov5.

and a patch to correct that has been submitted recently :
http://patchwork.ozlabs.org/linuxppc/patch?id=8848


    Sylvain
