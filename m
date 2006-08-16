Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50F5A67B55
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 23:20:02 +1000 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k7GDJrRJ017846
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 Aug 2006 15:19:53 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: *** PROBABLY SPAM *** No Clock on SPI
Date: Wed, 16 Aug 2006 15:22:36 +0200
References: <20060815164521.230780@gmx.net>
In-Reply-To: <20060815164521.230780@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200608161522.36409.laurent.pinchart@tbox.biz>
Cc: GSM909@gmx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Fred,

> I=C2=B4m writing a Driver for SPI. That is not working now.
> I have a MPC8260 using Linux 2.6.14 (rheap patch).
>
> Did someone else write a driver for SPI on this =C2=B5C or an other drive=
r? So I
> can see what i did wrong?

I'm working on an SPI driver for the MPC8248. I'll try to send a patch in a=
=20
few days.

> My SPCOM[STR] flag isn=C2=B4t cleared automatically after one clock cycle.
> What here going wrong ? ( I know this register is write only)
> There is also no Clock on my SPICLK.

Make sure you programmed the SPMODE register correctly.

> How I have to allocate the Memory for the BD=C2=B4s and the buffer for th=
e BD=C2=B4s?

The buffer descriptors should be allocated from CPM DPRAM using cpm_dpalloc=
().=20
The buffers can be allocated from any DMA-able memory (all system memory).

> Is there something special when I allocate Memory for my Parameter Ram?

You don't need to allocate memory for the parameter RAM. I declared PROFF_S=
PI=20
equal to 192 (I2C parameter RAM is at 128) in include/asm-ppc/cpm2.h:

#define PROFF_SMC1      (0)
#define PROFF_SMC2      (64)
#define PROFF_I2C       (128)
#define PROFF_SPI       (192)

Don't forget to set CPM_DATAONLY_BASE to 256 instead of 128 in the same fil=
e.

Then, set

*(u16 *)(&immap->im_dprambase[PROFF_SPI_BASE]) =3D PROFF_SPI;

in your driver code, and set the SPI pram resource to

=2Ename   =3D "pram",
=2Estart  =3D 0x00c0,
=2Eend    =3D 0x00ff,
=2Eflags  =3D IORESOURCE_MEM,

in arch/ppc/syslib/pq2_devices.c

> Is something wrong with the 2.6 Kernel so i have to use the 2.4 Kernel ?

You should not use 2.4. 2.6 is the way to go.

Laurent Pinchart
