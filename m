Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 87C6DB7CF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 21:04:31 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: MPC5200B, many FEC_IEVENT_RFIFO_ERRORs until link down
References: <201003301200.54609.roman.fietze@telemotive.de>
	<4BB1D674.2050800@grandegger.com> <4BB320D3.9090308@grandegger.com>
In-Reply-To: <4BB320D3.9090308@grandegger.com>
MIME-Version: 1.0
Message-ID: <201004011204.23994.roman.fietze@telemotive.de>
Date: Thu, 1 Apr 2010 12:04:23 +0200
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hallo Wolfgang,

On Wednesday 31 March 2010 12:15:47 Wolfgang Grandegger wrote:

> I just sent out the patch.

Thanks a lot.

> Would be nice if you, or somebody else, could do some testing and
> provide some feedback.

I tested the patches with the following setup:

=2D DENX 2.6.33 plus NAPI patch, kernel config with and w/o NAPI enabled

=2D Own Icecube based board using MPC5200B

=2D Two different hard drives (because the Toshiba gave my headaches),
  ext3 default settings of mkfs.ext3, MWDMA2

=2D FPGA on LPC receiving high bandwidth MOST150 data in PIO mode (for
  the test: generating them internally), small app writing the data to
  disk. Why PIO? SCLPC FIFO gave=20

=2D netcat receving data optionally writing the data to HD, sender is a
  Gigabit Intel NIC feeded using netcat (and /dev/zero) as well via a
  100MBit/s switch


And now the first and preliminary results of the tests (see legend and
description of the results below the table):

NAPI	MOST	HD		   load		bw	rx_irq		rfifo
=2D-----+-------+---------------+---------------+-------+---------------+--=
=2D----
				nc	most
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D

on	off	MK4036GA	93		5.15	32000-35000
		-		99		10.5	72000-74000

	on	MK4036GA	49	46	crash	15000-17500	none seen
	on	HEJ421010G9AT00	48	47		15000-17500	~100-500, recovers

=2D-----+-------+---------------+-----------------------+-------+----------=
=2D----+-------

off	off	MK4036GA	90		5.15	34000-36000
		-		99		10.5	76000-77000

	on	MK4036GA	48	47	crash	17500-19000	~200, network down

Legend:
=2D------

MOST:		PIO mode access to FPGA receiving generated MOST150 data
		very high data rates possible
HD:		used disk type
load/nc:	load netcat, %
load/most:	load MOST receiver app, %
load/idle:	was always 0%
bw:		netcat network band width, MB/s
rx_irq:		FEX RX IRQ, rate in Hz
rfifo:		RX FIFO errors, time in between in seconds

Results:
=2D-------

Using the MK4036GA HD always crashes IDE after a few seconds. A reboot
does not recover the disk, I always need a power cycle. That's why I
switched to a HEJ421010G9AT00.

NAPI reduces the FEC RX interrupt rate (/proc/interrupts) "somewhat".
Could not detect an increase of the maximum bandwidth, but that's not
the "problem" of NAPI.

NAPI nicely recovers more or less nicely from link down (link down to
up about 1 second), without NAPI I have to do that manually (e.g. ip
set link down/up). That's something I was looking for since the
modular PHY drivers.

Some network applications (e.g. our Car Head Unit GN Protocol Logger)
break up their connection when the link goes down (e.g. due to
internal timeouts? Probably fixable). Ssh and netcat connections stay
up.

Transferred many GiB of data to the MPC w/o any problems except those
recoverable FEC_IEVENT_RFIFO_ERRORs.

This patch really looks good to me.

I will run some additional tests e.g. with mixed RX and TX, different
and varying data rates, etc.


> FYI, I will be out of office next week.

Lucky Guy


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
