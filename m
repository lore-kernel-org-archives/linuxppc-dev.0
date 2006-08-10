Return-Path: <TSchnuerer@men.de>
Received: from [172.16.102.117] (mail.men.de [195.127.220.117])
	by ozlabs.org (Postfix) with ESMTP id 2775167A5E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 02:04:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: MPC5200B FEC  Fullduplex Performance problem
Date: Thu, 10 Aug 2006 17:52:39 +0200
Message-ID: <CFCBBD7501900A4398AB3EE28C6469DB5B4008@men-exch1.intra.men.de>
From: =?iso-8859-1?Q?Thomas_Schn=FCrer?= <TSchnuerer@men.de>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hello everybody,

I experience a Problem with obtaining the maximum FEC Performance.

I use Linux 2.6.15 with bestcomm 2.2 already and use the FEC in =
fullduplex mode. When I use
a test tool, the maximum transfer rates I get are 90 Mbit vs. 40 Mbit.
(the tool is called iperf, can be downloaded).

Also when checking /proc/interrupts after some time of fullduplex data =
transfer I see that there
are much more rx IRQs than tx IRQs.
In the driver linux/drivers/net/fec_mpc52xx.c I made some debug outputs =
which show me that
also TX FIFO underruns occur.

It seems to me that somehow the RX SDMA task is priorized before TX =
task, and this doesnt change
when I alter the priority values used in the driver.

The board is a MEN Mikro EM01, used clocks are XLB 128 MHz, CPU 384 MHz, =
SDRAM 132 MHz.

Does anyone have Performance measurements for FEC made on the 5200B ?

I would be happy already with reaching some 60/60 Mbits/s.

Thanks!

=20
