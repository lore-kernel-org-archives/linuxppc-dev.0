Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2DB71DE134
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 12:13:10 +1100 (EST)
Date: Sun, 28 Jan 2007 17:13:09 -0800 (PST)
Message-Id: <20070128.171309.11624572.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1170032301.26655.140.camel@localhost.localdomain>
References: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
	<20070128.155155.51857352.davem@davemloft.net>
	<1170032301.26655.140.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 29 Jan 2007 11:58:21 +1100

> 
> > There are specific calls into the sparc64 hypervisor for MSI vs. MSI-X
> > configuration operations.  So a type is necessary.
> 
> BTW. Do you have some pointers to documentation on those sparc64
> interfaces ? I'd like to have a look as we might still try to change
> some of our approach to match some of Eric's whishes, I want to make
> sure I'm not going somewhere that will not work for sparc...
> 
> For example, I'd like to know if sparc64 HV is indeed like IBM, that is
> a single HV call does the complete setup, or if you still have some
> level of manual config space access to do.

I just started reading those docs right now in fact :-)

The sparc64 hypervisor manual is at:

	http://opensparc-t2.sunsource.net/index.html

Click on "UltraSPARC T1 Hypervisor API Specification" near
the bottom of the page.  The MSI bits are in section 21.4 on
page 105.

BTW, I like how Banjamin is being constructive by expressing
interest in how sparc64's hypervisor works instead of Eric's
seeming non-interest in how or why RTAS or sparc64 work the
way that they do :-)

That being said, it looks like the hypervisor calls just setup
the MSI config inside of the PCI host controller, you still have
to do the PCI config space writes.  So in this regard it's not
like RTAS.

The PCI controller defines a 32-bit and a 64-bit MSI address range
the PCI controller will respond to as MSI.  Then there are queues
where received MSI interrupt information is stored, you subsequently
assosciate a MSI (which they call "msi") or a MSI-X (which they call
a "msg") with one of these queues.  Each queue generates a unique
interrupt to the system, and therefore this is the granularity at
which CPU targetting is done.

All of this stuff is defined via various OFW properties in the PCI
controller root bus node.

Example:

    Node 0xf02762a0
        .node:  f02762a0
        available:  81000000.00000000.00000000.00000000.00010000.82000000.00000000.00120000.00000000.000e0000.82000000.00000000.00300000.00000000.7fcf0000
        reg:  c0000780.00000000.00000000.00000000
        ranges:  01000000.00000000.00000000.000000e8.10000000.00000000.10000000.02000000.00000000.00000000.000000ea.00000000.00000000.7fff0000.03000000.00000000.00000000.000000ec.00000000.00000003.ffff0000
        msi-eq-to-devino:  00000000.00000024.00000018
        #msi-eqs:  00000024
        msix-data-width:  00000020
        msi-eq-size:  00000080
        msi-ranges:  00000000.00000100
        msi-data-mask:  000000ff
        #msi:  00000100
        msi-address-ranges:  00000000.7fff0000.00010000.00000003.ffff0000.00010000
        bus-range:  00000002.00000007
        no-probe-list: '0'
        bus-parity-generated:  
        #address-cells:  00000003
        #size-cells:  00000002
        name: 'pci'
        compatible: 'SUNW,sun4v-pci'
        device_type: 'pciex'
        virtual-dma:  80000000.80000000
        interrupt-map:  00020000.00000000.00000000.00000001.f02762a0.00000014.00020000.00000000.00000000.00000002.f02762a0.00000015.00020000.00000000.00000000.00000003.f02762a0.00000016.00020000.00000000.00000000.00000004.f02762a0.00000017
        interrupt-map-mask:  00fff000.00000000.00000000.00000007
        #interrupt-cells:  00000001
        interrupts:  0000003f.0000003e

The "devino" is the "system interrupt", each of which you can
enable/disable/cpu-target.  The above states that there are
36 MSI queues, to which msis and msgs can be assosciated.
So this would encompass devinos 0x18 --> 0x18 + 0x24 because
the msi-eq-to-devino property specifies the triplet
"first msiQ, num msiQs, first devino".

I'm working out all of this stuff myself and will try to cut as much
of an implementation as possible over the next few evenings.
