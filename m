Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 510B2DDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 02:18:05 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m1DFHxLn061668
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 15:17:59 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m1DFHx9F2175194
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 16:17:59 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m1DFHxBY025679
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 16:17:59 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] drivers/base: export gpl (un)register_memory_notifier
Date: Wed, 13 Feb 2008 16:17:57 +0100
References: <200802111724.12416.ossthema@de.ibm.com>
	<1202748429.8276.21.camel@nimitz.home.sr71.net>
In-Reply-To: <1202748429.8276.21.camel@nimitz.home.sr71.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802131617.58646.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, "Themann, Jan-Bernd" <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	Dave Hansen <haveblue@us.ibm.com>, apw <apw@uk.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>, Greg KH <greg@kroah.com>,
	Thomas Klein <osstklei@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dave,

On Monday 11 February 2008 17:47, Dave Hansen wrote:
> Also, just ripping down and completely re-doing the entire mass of cards
> every time a 16MB area of memory is added or removed seems like an
> awfully big sledgehammer to me.  I would *HATE* to see anybody else
> using this driver as an example to work off of?  Can't you just keep
> track of which areas the driver is actually *USING* and only worry about
> changing mappings if that intersects with an area having hotplug done on
> it?


to form a base for the eHEA memory add / remove concept discussion:

Explanation of the current eHEA memory add / remove concept:

Constraints imposed by HW / FW:
=2D eHEA has own MMU
=2D eHEA =A0Memory Regions (MRs) are used by the eHEA MMU =A0to translate v=
irtual
=A0 addresses to absolute addresses (like DMA mapped memory on a PCI bus)
=2D The number of MRs is limited (not enough to have one MR per packet)
=2D Registration of MRs is comparativley slow as done via slow firmware call
(H_CALL)
=2D MRs can have a maximum size of the memory available under linux
=2D MRs cover a contiguous virtual memory block (no holes)

Because of this there is just one big MR that covers entire kernel memory.
We also need a mapping table from kernel addresses to this
contiguous "virtual memory IO space" (here called ehea_bmap).

=2D When memory is added / removed to LPAR (and linux), the MR has to be up=
dated.
=A0 This can only be done by destroying and recreating the MR. There is no =
H_CALL
=A0 to modify MR size. To find holes in the linux kernel memory layout we h=
ave to
=A0 iterate over the memory sections for recreating a ehea_bmap
  (otherwise MR would be bigger then available memory causing the
  registration to fail)

=2D DLPAR userspace tools, kernel, driver, firmware and HMC are involved in=
 that
=A0 process on System p

Memory add: version without a external memory notifier call
=2D new memory used in a transfer_xmit will result in a "ehea_bmap
  translation miss", which triggers a rebuild and reregistration
=A0 of the ehea_bmap based on the current kernel memory setup.
=2D advantage: the number of MR rebuilds is reduced significantly compared =
to
  a rebuild for each 16MB chunk of memory added.

Memory add: version with external notifier call:
=2D We still need a ehea_bmap (whatever structure it has)

Memory remove with notifier:
=2D We have to rebuild the ehea_bmap instantly to remove the pages that are
  no longer available. Without doing that, the firmware (pHYP) cannot remove
  that memory from the LPAR. As we don't know if or how many additional=20
  sections are to be removed before the DLPAR user space tool tells the=20
  firmware to remove the memory, we can't wait with the rebuild.


Our current understanding about the current Memory Hotplug System are
(please correct me
if I'm wrong):

=2D depends on sparse mem
=2D only whole memory sections are added / removed
=2D for each section a memory resource is registered


=46rom the driver side we need:
=2D some kind of memory notification mechanism.
=A0 For memory add we can live without any external memory notification
  event. For memory remove we do need an external trigger (see explanation
  above).
=2D a way to iterate over all kernel pages and a way to detect holes in the
  kernel memory layout in order to build up our own ehea_bmap.


Memory notification trigger:
=2D These triggers exist, an exported "register_memory_notifier" /
=A0 "unregister_memory_notifier" would work in this scheme

=46unctions to use while building ehea_bmap + MRs:
=2D Use either the functions that are used by the memory hotplug system as
  well, that means using the section defines + functions (section_nr_to_pfn,
=A0 pfn_valid)
=2D Use currently other not exported functions in kernel/resource.c, like
  walk_memory_resource (where we would still need the maximum possible numb=
er
  of pages NR_MEM_SECTIONS)
=2D Maybe some kind of new interface?

What would you suggest?

Regards,
Jan-Bernd & Christoph
