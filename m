Return-Path: <raul.flores@lmco.com>
Received: from mailgw2a.lmco.com (mailgw2a.lmco.com [192.91.147.7])
	by ozlabs.org (Postfix) with ESMTP id C7639DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 12:00:35 +1100 (EST)
Date: Thu, 04 Dec 2008 18:12:16 -0600
From: "Flores, Raul" <raul.flores@lmco.com>
Subject: RE: PCI Resource allocation
In-reply-to: <1228431244.10722.4.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Deepak Pandian <peerlessdeepaks@gmail.com>
Message-id: <28CF047BB51A9C40A89E308370E2DA1117A4AB34@emss07m13.us.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <cbaa36330812041036u751ea939qc0aea60002655d07@mail.gmail.com>
	<1228431244.10722.4.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A bit off topic, but since the subject is pci resource allocation:

As entered here:
http://bugs.gentoo.org/show_bug.cgi?id=249832

the 2.6.24-gentoo-r3 kernel; iomem tree for my video display works, but
has not worked in the following kernels:
2.6.26-gentoo-r2
2.6.27-gentoo-r2
2.6.28-rc4 (perfmon2 git)

Using g5_defconfig on an iMac G5 iSight PowerMac 12,1 ppc64 (cross 32
userspace) PPC970FX

Had to hack to arch/powerpc/kernel/pci-common.c in alloc_resource() so
that I could run the 2.6.28 kernel with perfmon2.


Thanks for all the work that gets done here,

Raul


-----Original Message-----
From: linuxppc-dev-bounces+raul.flores=lmco.com@ozlabs.org
[mailto:linuxppc-dev-bounces+raul.flores=lmco.com@ozlabs.org] On Behalf
Of Benjamin Herrenschmidt
Sent: Thursday, December 04, 2008 4:54 PM
To: Deepak Pandian
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PCI Resource allocation

On Fri, 2008-12-05 at 00:06 +0530, Deepak Pandian wrote:
> Hi,
> 
> In ppc4xx_pci i see the pci size to be declared as
>  u32 lah, lal, pciah, pcial, sa;

I think the 4xx code is pretty much ok at this stage no ?

> Also at many other places I see the pci region is not capable of
> handling resources > 4GB. I am planning to work on this arch specific
> code to make it handle pci resource of width greater than 4 GB.

Which "many other places" ?

> But before that i wanted to clarify whether the core kernel will be
> able to handle pci regions with width greater than  4GB.

There's at least one place in the generic PCI code, in
pci_read_bridge_bases(), that needs fixing in a similar way as we
already fixed __pci_read_base(), ie by testing the resource_size_t size
rather than whether the platform is 64-bit.

There might be a few more.

Cheers,
Ben.


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
