Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id 8448167E25
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 02:52:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 4 Aug 2005 09:52:00 -0700
Message-ID: <F795765B112E7344AF36AA91127964158494C6@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8541E DMA transfer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Clemens,
Thanks for the code, the processor I am using is MPC8541E which I
believe have the same DMA engine as mpc8540. I will try it and will let
you know how it worked.

Thanks,
Bizhan=20

-----Original Message-----
From: Clemens Koller [mailto:clemens.koller@anagramm.de]=20
Sent: Thursday, August 04, 2005 5:13 AM
To: Bizhan Gholikhamseh (bgholikh)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8541E DMA transfer

Hello, Bizhan!
and all the other mpc85xx DMA fans.

I am working on the mpc85xx dma stuff (based on Jason's work) on the
lastest 2.6.x kernels. My cpu is a mpc8540.
That's all work in progress, so have a look at the code.

Attached you will find some of my test code (a separate kernal module)
which should compile fine for 2.6 now. Make a symlink ~/linux to the
latest 2.6 kernel or change the makefile. There is also the latest
immap_85xx.h (almost complete) included. Some old code is commented
out...

Not all code is enabled in the module yet, and the dma_test routine
copys data from physical memory you might not have in your hardware.
Please change that according to your setup.

Feedback is welcome!

Enjoy!

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


Bizhan Gholikhamseh (bgholikh) wrote:
> Is there any support in Linux 2.6.X for using this controller, if so,=20
> are you aware of any test driver I can take a look at?
>=20
> Thanks,
> Bizhan
>=20
> Many thanks in
>=20
> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@freescale.com]
> Sent: Wednesday, August 03, 2005 11:24 AM
> To: Bizhan Gholikhamseh (bgholikh)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC8541E DMA transfer
>=20
> I dont see any reason you couldn't use the internal DMA engine on the=20
> MPC8541E to do what you need.  You will just need to schedule the work

> every 10ms.
>=20
> - kumar
>=20
> On Aug 3, 2005, at 10:04 AM, Bizhan Gholikhamseh \(((bgholikh\)))
wrote:
>=20
>=20
>>Hi all,
>>I am developing a linux driver (2.6.10) for Freescale MPC8541E=20
>>(customized board) to read and write 8 buffers (each buffer is 960=20
>>bytes
>>long) every 10 ms to/from a custom made PCI card with on board DSP=20
>>Chip.
>>The chip's internal and external memories are memory mapped to the CPU
>=20
>=20
>>address space.
>>For reason that is beyond the discussion here, the DMA request line on
>=20
>=20
>>the PCI card is not connected although the PCI card has DMA=20
>>capabilities.
>>So what are my options?
>>Could I still do DMA transfer from the Host to the device?
>>
>>Many thanks in advance,
>>Bizhan
>>
>><ATT293768.txt>
>>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
