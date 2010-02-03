Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E7D3DB7D51
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Feb 2010 17:17:22 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Albrecht =?iso-8859-15?q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
References: <1264191106.2224.0-2010-02-02-19-31-49@antares>
In-Reply-To: <1264191106.2224.0-2010-02-02-19-31-49@antares>
MIME-Version: 1.0
Message-ID: <201002030716.31280.roman.fietze@telemotive.de>
Date: Wed, 3 Feb 2010 07:16:31 +0100
Content-Type: Text/Plain;
  charset="iso-8859-15"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Albrecht,

Sorry for the delay ... your mail got stuck in a Notes "spam filter".

On Friday 22 January 2010 21:11:39 Albrecht Dre=DF wrote:

> Are there any "final" conclusions from your tests?

Yes.

=46or the small product using the 2.6 kernel we turned all snooping and
the kernel coherent flag off, which avoided crashes of the FEC and/or
hard disk since we introduced that change.

We are currently investigating problems that we are seeing on the
2.4.25 (DENX and Lite5200B based) boards for a long time. Here we are
having problems with corrupt filesystems and FEC hick ups. In this
case we are using UDMA2, because we cannot yet get MWDMA2 work on
2.4.25, well knowing that there might be a problem with UDMA2 and LPC.
So we also turned of snooping and are currently in the testing phase
(again).

> ... two compactflash cards with vfat file systems attached to the
> ata bus; - a nfs3 network drive, connected via a 100MBit line, on a
> Xeon serve

Are you using MWDMA2 with the compact flash cards? What is the load on
the different (DMA) channels? ATA reads or writes?

> ... a signal processor attached to the localbus, using bestcomm and
> the fifo for the bulk transfer

Are you using an own driver, or are you using Grant's SCLPC+SDMA
driver? BD task?


Our latest product uses an SMSC MOST150 Spynic and an FPGA to sample
data from a MOST ring via SCLPC+SDMA (single non BD task from the old
=46reescale Betstcomm API) on the 2.4.25. Here moving from memory
accesses to SCLPC+SDMA helped somewhat, probably by avoiding the
UDMA2/LPC problem by mainly letting the SDMA scheduler do the
scheduling of the LPC traffic, which avoids the LPC arbiter problem
"somehow".

The probability for seeing problems or crashes increases a lot with
the bandwidth. I think, and I might be wrong, esp. when an arbiter or
scheduler (LPC/PCI or SDMA) needs to switch users or tasks. In our
case we have data running with about 3-6 MB/s (avg.) via the LPC to
the hard disks or somewhat more using FTP from the hard disk to the
=46EC.

> I did not observe any issues

The filesystem crashes are seldom, but happen often enough to be able
to reproduce them once every 1 or 2 days under heavy load, and to
produce failures in the field, what's even worse. And they
statistically increased a lot wen we ran out of GPIO on the MPC5200B
and then used an CPLD or FPGA to replace them, just a few bits to MUX
SPI lines, but that was enough.

> but your statements are making me really nervous...

That was not my intention. The best thing is to run very ugly tests
with very high load for at least 24h. Due to the fact that we see
those problems on different boards we (the SW guys) no longer can
assume self made HW problems (HW guys), esp. when reading Freescale's
advice with the XLB config.

It might happen that we switch to 2.6 on our older products, hoping
that at least the LPC/IDE problem disappears by using MWDMA2 instead
of UDMA2.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
