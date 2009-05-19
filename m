Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from IE1EHSOBE006.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id B2484DE0F3
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 02:25:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Musings on PCI busses
Date: Tue, 19 May 2009 09:25:09 -0700
In-Reply-To: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Kumar Gala" <galak@kernel.crashing.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"Roderick Colenbrander" <thunderbird2k@gmail.com>,
	"John Linn" <linnj@xilinx.com>, "linuxppc-dev" <linuxppc-dev@ozlabs.org>
Message-ID: <20090519162511.7454D17E8058@mail19-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 1) Probe the host controller in an of_platform driver.  This has the
> advantage of simplicity.  The probe routine will get automatically
> called when the PCI host controller device tree node is registered
> with the of_platform bus.  The bus parenthood also gets reflected in
> the device model and sysfs.  The disadvantage is that it defers PCI
> bus probing until after the of_platform bus is probed (maybe this is
> okay; maybe this already happens anyway).
> =

> 2) Probe the host controller in an subsys_initcall().  Advantage is
> PCI can be probed earlier in the init path.  Disadvantages (minor) are
> that it will always get called if the driver is enabled, and it needs
> to manually search the device tree for PCI nodes.
> =

> I'm leaning towards making it an of_platform driver.  Doing so also
> makes it available to other powerpc processors (not just virtex) in
> the case where a Xilinx FPGA is welded up to a discrete SoC and a host
> controller instance is put into the FPGA.  (one of those weird things
> people do when they have an FPGA in their system).

I agree that something is called for...  The first might be slightly
simpler, since it would probably transparently deal with the presence
of more than one PLB->PCI bridge?

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
