Message-ID: <36932B99.20AE3AA4@mpifr-bonn.mpg.de>
Date: Wed, 06 Jan 1999 10:23:37 +0100
From: "Albrecht =?iso-8859-1?Q?Dre=DF?=" <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Strange PMAC IDE performance problem
References: <19990105234815.008275@smtp.calvacom.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
[snip]
> Is there some common denominator with all those problems ? For example, I
> never connect anything to my PowerBook's MESH. Did the people with the
> problem have something connected to it ? never ? always ? both ? Maybe we
> could collect the disk models to see if the seem to be related. Also, are
> the problem similar when booting with OF and BootX or are there any
> differences ?

I use the latest test kernel form your web page (2.1.130 with patches; btw. the
trackpad patch is REALLY great!!) and boot with BootX 1.0.1. Bogus interrupts
appear both with nothing attached to external SCSI and with a tape drive. I get
very few bogus irq's from via_pmu_interrupt (c01d43fc, c01d4410) and LOTS from
do_IRQ (c0005518) in both cases. According to /proc/interrupts, doing a dd of
200 MBytes form /dev/zero to the internal hd resulted in 31 bad irq's from
do_IRQ (and a transfer rate of 1.71 MB/s).

Some time ago I compiled a 2.1.130 kernel WITHOUT SCSI/MESH SUPPORT (also booted
via BootX), but got exactly the same results as with the "normal" kernels.

Yours, Albrecht.

-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\3                                      ----           |
| Max-Planck-Institut f"ur Radioastronomie    |\       /      /o  o\          |
| Technische Abt. Optische Interferometrie    |  \    /      |  /   |         |
| Auf dem H"ugel 69                           |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
