From: "Jim Lin" <jimmlin@solomon.com.tw>
To: "linuppc" <linuxppc-embedded@lists.linuxppc.org>,
	"Georg Klug" <gklug@giga-stream.de>, <clark@esteem.com>,
	<jcampos@mvista.com>
Subject: RE: Poor 8xx SCC Ethernet mode performence..
Date: Wed, 17 Jul 2002 11:39:14 +0800
Message-ID: <NFBBLLKCILMGHKJGDFGHEEMGCCAA.jimmlin@solomon.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
In-Reply-To: <FFECLICFNBJAHONLGAKMKEGICFAA.gklug@giga-stream.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi :

After I change 10/100 T hub . It's speed up to 370KBps at Half duplex. 480 KBps at Full duplex in NFS envirment.
I had work follow ..

1. 10/100 HUB turn to Halt duplex because RTL 8201 not  support auto-negotiaon.
    I check our hardware component PHY Rtl 8201. It's not support  auto-negotiation when it's wired SMI .

2.enable  SCC_PMSR_FDE | SCC_PMSR_LPB  , and Tested FTP Transfer again through 10/100 T HUB at Full           duplex .  It's about 200KBps.It's collision between HUB and RTL8201..

3.enfore FTP host nic running at 10 Full duplex  mode ,  pulg cross line between  FTP host and custom board .
   It's got 470 KBps .

4. Due to custom board running in  NFS  envirment . It's cost some throughput.. now I trying test it without NFS envirment.
    If I got more  information  I will post again.


Thanks and Regards

Sent: Tuesday, July 16, 2002 8:28 PM
To: Jim Lin
Subject: AW: Poor 8xx SCC Ethernet mode performence..


Hi Jim,

> I  was testing SCC ethernet performance at our 850 custom board and
> found somting interesting.
>
> 1. Tested FTP  Transfer about 20MB file with 10T hub  I got  about
> 250 k bps (someting poor ..)

Yes that is poor, indeed.

> 2. and I found the hhl20 arch/ppc/8xx_io/enet.c source code NOT
> enable full duplex ..
>      and I had  pmsr  added SCC_PMSR_FDE | SCC_PMSR_LPB .. and
> compiling , tested FTP Transfer again.
>      I got about 200 Kbps!
>
> I do not understand what is happen? Has anyone experience this?

The other performance is also poor.

First I think you should check your whole ethernet. If you really have
2 stations at a 10BaseT Hub, you definetely need half duplex traffic. It
might be that not all station are half duplex connected, so there would be
collisions and even late collisions on the network that could not be
detected. This would make the performance decrease.

Probably your hub has a collision LED This would make it easier for you to
debug the situation.

What about installing a little switch with 10/100 connectors? Then you
could use full duplex on each connector and that would boost your
performance.

Georg Klug

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
