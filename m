Return-Path: <rick.moleres@xilinx.com>
Received: from outbound2-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6EAB267BEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 01:31:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Making Two ethernet interfaces up in Linux
Date: Thu, 8 Jun 2006 09:30:58 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C026792FD@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Shantanu Nalage" <shantanu.nalage@gmail.com>,
	"Antonio Di Bacco" <antonio.dibacco@aruba.it>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Shantanu,

Can you post the xemac_g.c file in the xilinx_enet directory?  Also,
which version of the EDK are you using?  There was a bug in EDK 7.x that
prevented multiple Ethernet interfaces from working properly.

It would also be helpful to see xparameters_ml300.h from the
arch/ppc/platforms/xilinx_ocp directory.

Thanks,
-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Shantanu Nalage
Sent: Wednesday, June 07, 2006 11:16 PM
To: Antonio Di Bacco; linuxppc-embedded@ozlabs.org
Subject: Re: Making Two ethernet interfaces up in Linux

Thanks for the reply.
The driver which we are using for the ethernet is provided by Xilinx.
In the Linux kernel source, it is located in net/xilinx_enet
directory. We are attaching the adapter file for the driver provided
by Xilinx for the ethernet.
When we gave a first try, it showed two ethernet interfaces eth0 and
eth1 as an output of ifconfig command but only eth0 works, when eth1
is disabled. When both interfaces are up, neither interface works.
While even when eth0 is disabled, eth1 interface doesn't work.

With regards,
Shantanu.

On 6/4/06, Antonio Di Bacco <antonio.dibacco@aruba.it> wrote:
> >          We are trying to port Linux on Xilinx Board XUPV2Pro which
is
> > similar in most aspects to the Xilinx ML300 board. Linux is up and
> > running for the original board i.e. having only one ethrnet
interface.
> > Now since we wanted to have the board working as router, we designed
a
> > daughter board with two ethernet phy interfaces. The MACs required
for
> > that are instantiated in Xilinx ....
>
> You have already the driver for the first MAC, then you should start
from that
> modifying the init procedure for example and all the others. Your
driver
> should initialize both the MACs and also create two devices calling
> init_etherdev tow times. If you post your driver I can suggest what to
> change. It is not so difficult.
>
> Bye,
> Antonio.
>
>
