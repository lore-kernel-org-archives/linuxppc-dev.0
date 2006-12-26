Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 9092EDDE43
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 08:23:13 +1100 (EST)
Date: Tue, 26 Dec 2006 22:23:18 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mark Glines <mark@glines.org>
Subject: Re: kurobox kernel
In-Reply-To: <45918294.3080303@glines.org>
Message-ID: <Pine.LNX.4.60.0612262159180.3245@poirot.grange>
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>
	<459046FE.9030008@glines.org>
	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>
	<45905997.5080403@glines.org>
	<Pine.LNX.4.60.0612260019430.3424@poirot.grange>
	<45918294.3080303@glines.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Dec 2006, Mark Glines wrote:

> Guennadi Liakhovetski wrote:
> > u-boot version. Or just ask me. Or I could even just send you binaries to 
> > start with. Do you have JTag?...
> 
> No, I haven't made any hardware mods yet.

I asked about JTag because the U-boot you'll have to flash to boot an 
arch/powerpc based kernel has only been so far tested on one (mine) 
KuroboxHG. It is (hopefully) the same hardware as yours, but you never 
know...

> Thanks for the offer.  Kernel binaries might actually help, just to make 
> sure the hardware and bootloader are working properly.

Yes, I can send you the kernel, but I think, it is the u-boot that's most 
critical and difficult to build, since what I am running is some checkout 
from a git tree with a modified kurobox patch applied, and you might want 
to start with a precompiled u-boot. The fdt blob and the kernel are no 
longer as critical and much easier to build - just kernel.org kernel with 
the default defconfig, but I can send you those too, if you want.

> The instructions on 
> http://www.linuxnotincluded.pwp.blueyonder.co.uk/linkstation/u-bootinstall.html 
> were a little broken in a few places, but still very helpful.  I've got 
> U-boot 1.1.4 up and running.  It's just booting the old 2.4.17_mvl21 
> >from flash right now... 2.6.20-rc2 fails to boot.

No, those won't help you directly. That U-boot will not be able to boot an 
arch/powerpc based kernel. You have to know: there are currently 2 ways to 
boot a 2.6 kernel on a linkstation/kurobox. 1: which most (everybody 
except me) use - U-boot like what you've built or loader.o + an arch/ppc 
based kernel, 2: U-boot based on a version, capable of booting kernels 
with an fdt blob (i.e., per "mboot <kernel-addr> [<initrd-addr>] 
<fdt-addr>"). If you want the vanilla kernel you need the second method, 
hence a newer version of U-boot.

Look here: http://www.kurobox.com/revolution/downloads/contest/patchREADME 
for a somewhat rough README and here 
http://www.kurobox.com/revolution/downloads/contest/patches.zip are the 
patches (sorry about the zip - that was revolution's format of choice...)

But even if I send you an image of U-boot that works for me, I'd have to 
warn you if you don't have the jtag port enabled / are not ready to use it 
to recover a possible bricked kurobox. You've been warned...

> I have ordered some serial port voltage converters, which I hope to use 
> to get some diagnostics from the 2.6.20-rc2 kernel.  I don't hear any 
> disk activity, and I wasn't able to get netconsole working, so I think 
> it is dying fairly early in the boot process.  (At least, before PCI and 
> network are up.)

Now you know why your kernel doesn't boot...

Thanks
Guennadi
---
Guennadi Liakhovetski
