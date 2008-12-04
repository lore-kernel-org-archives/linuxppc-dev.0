Return-Path: <arieswar24b@yahoo.de>
Date: Thu, 4 Dec 2008 10:01:31 +0000 (GMT)
From: Dave Best <arieswar24b@yahoo.de>
Subject: Re: Using Bestcomm API (DMA) on MPC5200b with Linux?
To: Linuxppc-embedded@ozlabs.org
In-Reply-To: <4900FA72.1040201@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <99808.65832.qm@web25808.mail.ukl.yahoo.com>
Reply-To: arieswar24b@yahoo.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I tried to use GenBD.
I looked at "mpc52xx_ac97.c" which seems to be a sound driver which apparen=
tly uses the GenBD tasks, if only the tx ones and the buffers.

As i connected my FPGA/FiFo to the LocalPlus i called bcom_gen_bd_rx_init w=
ith LP as initiator and the LP FiFo address. I called  bcom_prepare_next_bu=
ffer and then bcom_submit_next_buffer and enabled my task.
In advance i prepared the LP registers to my intended transfers and to use =
CS1. But the task doesn't seem to call any chip select to fill its buffers.=
=20

Frankly, i'm really at a loss on how to proceed.

Dave


--- Matt Sealey <matt@genesi-usa.com> schrieb am Fr, 24.10.2008:

> Von: Matt Sealey <matt@genesi-usa.com>
> Betreff: Re: Using Bestcomm API (DMA) on MPC5200b with Linux?
> An: linuxppc-embedded@ozlabs.org
> CC: arieswar24b@yahoo.de
> Datum: Freitag, 24. Oktober 2008, 0:28
> You need to write a task that does the DMA operation you
> want; GenBD is actually pretty generic and lets you just
> copy from one place to another.
>=20
> The API is pretty simple; make sure genbd is compiled in,
> get the task structure using bcom_gen_bd_[tr]x_init, and
> then.. uhh.. this is where I always forget.
>=20
> There is a way to submit a buffer descriptor and have the
> engine basically perform that transfer. I think it's
> bcom_prepare_next_buffer and then bcom_submit_next_buffer.
>=20
> Actually I can't even FIND those functions in the Linux
> tree right now, but they have to be in there because the FEC
> driver uses them..
>=20
> -- Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
>=20
> Dave Best wrote:
> > I am trying to connect a FPGA/FIFO with my MPC5200b on
> a phytec PCM 030 board  while running a 2.6.23.1 Linux.
> >=20
> > The Linux Kernel source contains an implementation for
> the Bestcomm API in the form of a driver for ethernet (fec)
> and ATA.(situated in the arch-powerpc/sysdev/bestcomm path)
> I tried to make use of it but i've run into some
> problems.
> >=20
> > So i tried to include the API in a module to utilize
> its functionality but no luck till now.
> >=20
> > Freescale supports the Bestcomm DMA API not on an OS
> level. So the problem is adopting this API into a Linux
> environment, which distinguishes between kernel space and
> user space while writing to the appropriate registers.
> >=20
> > Further information is very hard to find for such a
> common task as starting a DMA transfer.
> >=20
> > Dave
> >=20
> >=20
> >=20
> >       _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A=0A=0A      
