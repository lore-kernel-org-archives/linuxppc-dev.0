Return-Path: <rick.moleres@xilinx.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A77C767C35
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 02:18:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: plb_temac, ML403, linux 2.4.26, EDK 7.1
Date: Thu, 12 Oct 2006 09:55:39 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C031A102F@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Robert Corley" <rcorley@aegis-inc.net>
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


Robert,

(I copied the list)

Linux 2.4 support for plb_temac was not added until EDK 8.1.1.  This
driver is not available in the MV Linux 2.4 tree.  So if you want
something (the driver) to show up in libsrc/linux_mvl31_v1_01_b/linux
then you would need to upgrade.

Note also that checksum offload was added to the plb_temac core in EDK
8.1.2 (v3.00a of the core), so using that EDK or later will provide much
better GigE throughput (I think we measured somewhere around 650Mbps TCP
traffic using netperf on Linux 2.4 with checksum offload).

In Linux 2.4 we place the plb_temac driver in drivers/net/xilinx_gige
during the BSP generation process of EDK 8.1.1 or later in order to take
advantage of the jumbo frame config option.  I looked at
source.mvista.com and this directory does appear in the Linux 2.4
repository (rsync://source.mvista.com/linuxppc-2.4).

Hope that helps,
Rick

-----Original Message-----
From: Robert Corley [mailto:rcorley@aegis-inc.net]=20
Sent: Wednesday, October 11, 2006 10:16 AM
To: Rick Moleres
Subject: Fw: plb_temac, ML403, linux 2.4.26, EDK 7.1

Rick,

Apologies for some potentially confusing parts of my last email to you.
Here is what I just posted if you care to reply.

----- Forwarded Message ----
From: robert corley <rdcorle@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Sent: Wednesday, October 11, 2006 12:14:51 PM
Subject: plb_temac, ML403, linux 2.4.26, EDK 7.1

Some background:
    ML403 devel board
    EDK 7.1
    compilation of reference design xapp902, modified to use linux and
without loopback
    use of linux_2_4_devel obtained from montavista via rsync

I am trying to use the plb_temac rather than the ll_temac.  In the long
run, I'd prefer to stick with linux 2.4.  In addition, I will need to
get both embedded EMAC's up and running, but first I just wanna get the
xapp902 working.  Also, I will need gigE support.

So, right now I am trying to get the plb_temac to compile and get errors
about the defines XPAR_XTEMAC_* within the linux directories
../drivers/net/xilinx_enet.  I see that the edk gets the defines within
the xparameters.h file of the xapp902 project.  I also see that my
C:\EDK\sw\ThirdParty\bsp\linux_mvl31_v1_01_a\drivers don't have anything
for a plb_temac.

Q:    Is my error related to an incorrect setup of the linux or with the
EDK?

Q:    t is stated that the plb_temac drivers are in EDK 8.1.  Can I
stick
with 7.1 or must I ugprade?

Q:    Where in the linux tree should I look for the xtemac
stuff?  Is this what the EDK pushes on to the tree or is it released
within the MVL distro?

Q    Based on posts by David and Ming, it
appears that I must use xilinx_gige to get up to gigE speeds.  Will the
plb_temac support this data rate and, if so, is this a transparent
support or do I need to go the route suggested to Ming and
overwrite files in xilinx_enet?

R. Corley
