Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 95D19B7C48
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Apr 2010 22:22:43 +1000 (EST)
Message-ID: <4BB9D5AD.1090206@grandegger.com>
Date: Mon, 05 Apr 2010 14:21:01 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: MPC5200B, many FEC_IEVENT_RFIFO_ERRORs until link down
References: <201003301200.54609.roman.fietze@telemotive.de>
	<4BB1D674.2050800@grandegger.com> <4BB320D3.9090308@grandegger.com>
	<201004011204.23994.roman.fietze@telemotive.de>
In-Reply-To: <201004011204.23994.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hallo Roman,

Roman Fietze wrote:
> Hallo Wolfgang,
> 
> On Wednesday 31 March 2010 12:15:47 Wolfgang Grandegger wrote:
> 
>> I just sent out the patch.
> 
> Thanks a lot.
> 
>> Would be nice if you, or somebody else, could do some testing and
>> provide some feedback.
> 
> I tested the patches with the following setup:
> 
> - DENX 2.6.33 plus NAPI patch, kernel config with and w/o NAPI enabled
> 
> - Own Icecube based board using MPC5200B
> 
> - Two different hard drives (because the Toshiba gave my headaches),
>   ext3 default settings of mkfs.ext3, MWDMA2
> 
> - FPGA on LPC receiving high bandwidth MOST150 data in PIO mode (for
>   the test: generating them internally), small app writing the data to
>   disk. Why PIO? SCLPC FIFO gave 
> 
> - netcat receving data optionally writing the data to HD, sender is a
>   Gigabit Intel NIC feeded using netcat (and /dev/zero) as well via a
>   100MBit/s switch
> 
> 
> And now the first and preliminary results of the tests (see legend and
> description of the results below the table):
> 
> NAPI	MOST	HD		   load		bw	rx_irq		rfifo
> ------+-------+---------------+---------------+-------+---------------+-------
> 				nc	most
> ======+=======+===============+===============+=======+===============+=======
> 
> on	off	MK4036GA	93		5.15	32000-35000
> 		-		99		10.5	72000-74000
> 
> 	on	MK4036GA	49	46	crash	15000-17500	none seen
> 	on	HEJ421010G9AT00	48	47		15000-17500	~100-500, recovers
> 
> ------+-------+---------------+-----------------------+-------+---------------+-------
> 
> off	off	MK4036GA	90		5.15	34000-36000
> 		-		99		10.5	76000-77000
> 
> 	on	MK4036GA	48	47	crash	17500-19000	~200, network down
> 
> Legend:
> -------
> 
> MOST:		PIO mode access to FPGA receiving generated MOST150 data
> 		very high data rates possible
> HD:		used disk type
> load/nc:	load netcat, %
> load/most:	load MOST receiver app, %
> load/idle:	was always 0%
> bw:		netcat network band width, MB/s
> rx_irq:		FEX RX IRQ, rate in Hz
> rfifo:		RX FIFO errors, time in between in seconds
> 
> Results:
> --------
> 
> Using the MK4036GA HD always crashes IDE after a few seconds. A reboot
> does not recover the disk, I always need a power cycle. That's why I
> switched to a HEJ421010G9AT00.

That might be a different issue.

> NAPI reduces the FEC RX interrupt rate (/proc/interrupts) "somewhat".
> Could not detect an increase of the maximum bandwidth, but that's not
> the "problem" of NAPI.

I realized the same behavior.

> NAPI nicely recovers more or less nicely from link down (link down to
> up about 1 second), without NAPI I have to do that manually (e.g. ip
> set link down/up). That's something I was looking for since the
> modular PHY drivers.

Recovering from link down takes a while, unfortunately. I also do not
yet have an explanation why the link goes down, at all. The rather long
recovery time does not harm for my use case of "heavy packet storms" but
is rather annoying a high but not yet critical traffic.

> Some network applications (e.g. our Car Head Unit GN Protocol Logger)
> break up their connection when the link goes down (e.g. due to
> internal timeouts? Probably fixable). Ssh and netcat connections stay
> up.

That's a problem due to the overloaded network.

> Transferred many GiB of data to the MPC w/o any problems except those
> recoverable FEC_IEVENT_RFIFO_ERRORs.
> 
> This patch really looks good to me.

Doesn't sound too bad...

> I will run some additional tests e.g. with mixed RX and TX, different
> and varying data rates, etc.

OK.

Wolfgang.
