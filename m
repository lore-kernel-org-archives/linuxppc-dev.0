Return-Path: <Rick.Moleres@xilinx.com>
Received: from mail91-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E39C7DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 06:46:25 +1100 (EST)
MIME-Version: 1.0
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Mon, 12 Feb 2007 12:45:51 -0700
In-Reply-To: <BAY110-F2669499909689C5DC2B93B2920@phx.gbl>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Ming Liu" <eemingliu@hotmail.com>
Content-Type: text/plain;
	charset="US-ASCII"
Message-Id: <20070212194619.03083EA0097@mail91-dub.bigfish.com>
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


Ming,

<snip>

>>1. Results are from PLB_TEMAC, not GSRD.  You would likely see similar

>throughput rates with GSRD and Linux.
>
>Problem 1: From the website for GSRD, I know that it uses a different=20
>structure than PLB, where a Multi port mem controller and DMA are added
to=20
>release the CPU from move data between Memory and TEMAC. So can GSRD=20
>achieve a higher performance than PLB_TEMAC, or similar performance
like=20
>what you said above? If their performance is similar, what's the
advantage=20
>for GSRD? Could you please explain some differences between these two=20
>structures?=20

GSRD is a reference design intended to exhibit high-performance gigabit
rates.  It offloads the data path of the Ethernet traffic from the PLB
bus, under the assumption that the arbitrated bus is best used for other
things (control, other data, etc...).  With Linux, however, GSRD still
only achieves slightly more than 500Mbps TCP.  We see similar numbers
with PLB TEMAC, and with other stacks we see similar numbers as GSRD as
well (e.g., Treck).  The decision points for using GSRD would be a) what
else needs to happen on the PLB in your system, and b) Xilinx support.
GSRD is a reference design, so it's not officially supported through the
Xilinx support chain.  However, many of its architectural concepts are
being considered for future EDK IP (sorry, no timeframe).  For now, I
recommend PLB TEMAC because it's part of the EDK, supported, and gets as
good performance in most use cases.


>>2. Assuming you have everything tuned for SGDMA based on previous
emails,=20
>I would suspect the bottleneck is the 300MHz CPU *when* running Linux.
In=20
>Linux 2.6 we've not spent any time trying to tune the TCP/Ethernet=20
>parameters on the target board or the host, so there could be some=20
>optimizations that can be done at that level.  In the exact same system
we=20
>can achieve over 800Mbps using the Treck TCP/IP stack, and with VxWorks
it=20
>was over 600Mbps. =20
>
>Problem 2. I read XAPP546 of High performance TCP/IP on xilinx FPGA
devices=20
>using the Treck embedded TCP/IP stack. I notice that the features of
Treck=20
>TCP/IP stack include: Zero-copy send and receive, Jumbo-frame support,
CSUM=20
>offload, etc. which could achieve a much higher performance than not
using=20
>it. However in the Xilinx TEMAC core V3.00, these features are all=20
>supported: Zero-copy is supported by sendfile() when using Netperf;=20
>Jumbo-frame is also supported; CSUM offload and DRE are also supported
by=20
>the hardware. So does this mean I can achieve a similarly high
performance=20
>with PLB_TEMAC V3.00 and without Treck TCP/IP stack? I mean if all the=20
>features of Treck stack have been included in the PLB_TEMAC cores,
what's=20
>the use for Treck stack?=20

Note that Linux only supports zero-copy on the transmit side (i.e.,
sendfile), not on the receive side.  I'm not going to recommend one RTOS
or network stack over another.  Treck is a general purpose TCP/IP stack
that can be used in a standalone environment or in various RTOS
environments (I think).  We've found that Treck, in the case where it is
used without an RTOS, is a higher performing stack than the Linux stack.
The VxWorks stack is also good, and Linux (of the three I've mentioned)
seems to be the slowest.  Again, it's possible that the Linux stack
could be tuned better, but we haven't taken the time to try this.
