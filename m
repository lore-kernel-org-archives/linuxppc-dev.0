From: "Ron Bianco" <ronb@junction.net>
To: "Dag Nygren" <dag@newtech.fi>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Does th sym53c8xx driver really work on PPC ?
Date: Mon, 29 Jan 2001 17:05:07 -0800
Message-ID: <001301c08a58$afd7bb40$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010127081108.10265.qmail@dag.newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Nygren,

We been using the 53c895 chip, OK on our 8240 board running HHL (area51) 2.3.16
linux.
If the '875 has on chip script ram then you have to add code to map it somewhere
'safe'.  I chose 0x80000000

(We don't have a eprom for the SCSI chip on our board, your case may be different.)

This amounts to just setting the appropriate base address in the chip's config
registers.
Also, make sure you have the appropriate '875 config signals terminated
appropriately.  i.e. no eprom, internal sram enabled etc.
And of course, make sure the irq line is pulled up if open drain.  On the '895, the
irq line driver type is programmable.
And make sure the sense line on your PIC is config'd correctly.

File system thruput was tested up to ~10Mb/s read and ~10Mb/s write at the same time.
On a fast40, wide, drive.
Not too bad!

Cheers, Ron

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dag
> Nygren
> Sent: Saturday, January 27, 2001 12:11 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Does th sym53c8xx driver really work on PPC ?
>
>
>
> Hi,
>
> just got my very own port of Linux to a PPC
> going, but are having problems with the SCSI.
> It uses a Symbios 53c875 chip and works fine
> if I disable the "Special features" by booting
> with sym53c8xx=specf:n, but if I keep these on
> there are problems downloading the scripts and
> the driver loops with an "Illegal instruction in the
> SCRIPT "error.
>
> The thing is that the SCRIPT seems to be written
> directly to a region that is ioremap():ed from the
> address read from the PCI-config for the RAM.
> This cannot possibly be right ?
> This address is the local PCI bus address and the
> address seen from the PPC will have an offset for
> the PCI window, in my case 0xc0000000.
>
> So my questions are:
>
> 1. Does ths above reasoning sound OK to you ?
> 2. Is there anyone that have seen this working with the
>   stock 2.2.18 (also tried ths 2.2.14) kernel ?
>
> BRGDS
>
>
> --
> Dag Nygren                               email: dag@newtech.fi
> Oy NewTech Ab                            phone: +358 9 8024910
> Trasktorpet 3                              fax: +358 9 8024916
> 02360 ESBO                                 GSM: 0400-426312
> FINLAND
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
