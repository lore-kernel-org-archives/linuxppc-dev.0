Return-Path: <andrea.galbusera@teamware.it>
Received: from smtp3.aruba.it (smtpd3.aruba.it [62.149.128.208])
	by ozlabs.org (Postfix) with SMTP id 52302DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 01:45:44 +1100 (EST)
Subject: Re: Ethernet fails on MPC5200 based target
From: Andrea Galbusera <andrea.galbusera@teamware.it>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <45ACBE65.6050602@246tNt.com>
References: <1168439212.5271.70.camel@localhost.localdomain>
	<45A4FDAF.8020909@246tNt.com>
	<1168935615.22089.31.camel@localhost.localdomain>
	<45ACBE65.6050602@246tNt.com>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 15:46:50 +0100
Message-Id: <1168958810.22089.80.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sylvain,

On Tue, 2007-01-16 at 13:00 +0100, Sylvain Munaut wrote:

> And does the problem also appears on the denx kernel after 1k ping packets ?

I never did a long run test before on the denx kernel... seemed quite
robust even on intense root over NFS usage... But I did it today and...
I also see some corrupted packets :-(. They are a lot less frequent than
with your kernel: I see just about 5/6 corruptions over 2000 pkts. On
the opposite, the kernel from you (with XLB pipelining enabled) goes
smootly till about 1k packets and then starts behaving very bad with a
lot of corrupted ping packets in sequence. I repeated both tests a few
times with similar results.

I tend to exclude any other network source of corruption because I can't
see anything similar by pinging other hosts.

> 
> Are the fec driver the same ?
> Are the fec task code the same ? (in bestcomm/fec.c )

Still understanding what files exactly are involved, but, diffing the
following among the two source trees I found no differences:

arch/ppc/syslib/bestcomm/fec.c
arch/ppc/syslib/bestcomm/sdma_fec_rx_task.c
arch/ppc/syslib/bestcomm/sdma_fec_tx_task.c
drivers/net/fec_mpc52xx/fec.c
drivers/net/fec_mpc52xx/fec_phy.c
arch/ppc/syslib/bestcomm/bestcomm.c

If you think it may help, I can attach a full arch/ppc/syslib/bestcomm/*
diff result. There are some changes (apart from ATA code that is missing
in denx tree), mainly in inline code included in header files
(bestcomm.h).

I also noticed that corruption always affects 20th or 52nd data byte
which, expected to be repectively 0x14 and 0x52 sometimes turns out to
be one of 0x0, 0x0c, 0x14. This sounds very repetitive over hundreds of
corrupted packets. I paste some examples in case the could help:

> wrong data byte #52 should be 0x34 but was 0x0
> #8      8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
> #40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 0 35 36 37
> 
> wrong data byte #52 should be 0x34 but was 0xc0
> #8      8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
> #40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 c0 35 36 37
> 
> wrong data byte #52 should be 0x34 but was 0x14
> #8      8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
> #40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 14 35 36 37
> 
> wrong data byte #20 should be 0x14 but was 0xc0
> #8      8 9 a b c d e f 10 11 12 13 c0 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
> #40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36 37

Doing some more tests in the while...

One more aspects that may help. Looking at MPC5200B errata from
http://www.freescale.com/files/32bit/doc/errata/MPC5200BE.pdf?fsrch=1 ,
I noticed that issues 353 and 463 are ethernet related and where not
present in the previous errata. Do you think they can be related with my
problem?

Andrea
