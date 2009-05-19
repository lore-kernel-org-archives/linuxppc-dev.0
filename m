Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id 74E7FDE0DF
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 01:28:53 +1000 (EST)
Received: by gxk20 with SMTP id 20so7907906gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 08:28:52 -0700 (PDT)
MIME-Version: 1.0
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 09:28:32 -0600
Message-ID: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
Subject: Musings on PCI busses
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Roderick Colenbrander <thunderbird2k@gmail.com>,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey all,

I've been having some thoughts on PCI host controller probing and how
best to handle it.  Currently AFAICT, the SoC platform code explicitly
calls the PCI setup code.  In all of the existing SoCs this works fine
because there is SoC specific platform code which knows what PCI
busses to expect on the SoC.

I'm now looking at the case of Xilinx Virtex FPGA support.  Because it
is an FPGA and the SW view of the design is so flexible and fluid, I'm
trying to keep platform code unified for all Virtex platforms.  (ie.
two radically different board layouts can look identical from the
CPU's perspective, or the behaviour of one board can be completely
changed with a new bitstream).

Roderick has written a patch to support one of the Xilinx reference
designs that includes a PCI host controller.  Right now the patch adds
a separate platform file, but I'm not comfortable with the approach
(despite suggesting it to Roderick in the first place) because it
relegates PCI support to only work with the ml510 reference design.
ie. PCI will not be automatically supported for anyone who modifies
the reference design or adds the PCI host controller to their own
design.  So I've been thinking of alternatives.  Here's what I've come
up with.

1) Probe the host controller in an of_platform driver.  This has the
advantage of simplicity.  The probe routine will get automatically
called when the PCI host controller device tree node is registered
with the of_platform bus.  The bus parenthood also gets reflected in
the device model and sysfs.  The disadvantage is that it defers PCI
bus probing until after the of_platform bus is probed (maybe this is
okay; maybe this already happens anyway).

2) Probe the host controller in an subsys_initcall().  Advantage is
PCI can be probed earlier in the init path.  Disadvantages (minor) are
that it will always get called if the driver is enabled, and it needs
to manually search the device tree for PCI nodes.

I'm leaning towards making it an of_platform driver.  Doing so also
makes it available to other powerpc processors (not just virtex) in
the case where a Xilinx FPGA is welded up to a discrete SoC and a host
controller instance is put into the FPGA.  (one of those weird things
people do when they have an FPGA in their system).

Comments?  Opinions?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
