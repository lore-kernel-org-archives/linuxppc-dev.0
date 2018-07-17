Return-Path: <srs0=1axr=kb=kernel.org=mhocko@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VJYg5p7HzF3JW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 21:52:39 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41VJYg5GYsz8tbg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 21:52:39 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41VJYf6Wl4z9s4Z
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2018 21:52:38 +1000 (AEST)
Date: Tue, 17 Jul 2018 13:52:32 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
Subject: Re: [RFC PATCH v6 0/4] powerpc/fadump: Improvements and fixes for
 firmware-assisted dump.
Message-ID: <20180717115232.GF7193@dhcp22.suse.cz>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
 <20180716082646.GF17280@dhcp22.suse.cz>
 <cb5fc554-7fa3-1356-c304-ae8c27a0c70c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cb5fc554-7fa3-1356-c304-ae8c27a0c70c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 17-07-18 16:58:10, Mahesh Jagannath Salgaonkar wrote:
> On 07/16/2018 01:56 PM, Michal Hocko wrote:
> > On Mon 16-07-18 11:32:56, Mahesh J Salgaonkar wrote:
> >> One of the primary issues with Firmware Assisted Dump (fadump) on Power
> >> is that it needs a large amount of memory to be reserved. This reserved
> >> memory is used for saving the contents of old crashed kernel's memory before
> >> fadump capture kernel uses old kernel's memory area to boot. However, This
> >> reserved memory area stays unused until system crash and isn't available
> >> for production kernel to use.
> > 
> > How much memory are we talking about. Regular kernel dump process needs
> > some reserved memory as well. Why that is not a big problem?
> 
> We reserve around 5% of total system RAM. On large systems with
> TeraBytes of memory, this reservation can be quite significant.
> 
> The regular kernel dump uses the kexec method to boot into capture
> kernel and it can control the parameters that are being passed to
> capture kernel. This allows a capability to strip down the parameters
> that can help lowering down the memory requirement for capture kernel to
> boot. This allows regular kdump to reserve less memory to start with.
> 
> Where as fadump depends on power firmware (pHyp) to load the capture
> kernel after full reset and boots like a regular kernel. It needs same
> amount of memory to boot as the production kernel. On large systems
> production kernel needs significant amount of memory to boot. Hence
> fadump needs to reserve enough memory for capture kernel to boot
> successfully and execute dump capturing operations. By default fadump
> reserves 5% of total system RAM and in most cases this has worked
> flawlessly on variety of system configurations. Optionally,
> 'crashkernel=X' can also be used to specify more fine-tuned memory size
> for reservation.

So why do we even care about fadump when regular kexec provides
(presumably) same functionality with a smaller memory footprint? Or is
there any reason why kexec doesn't work well on ppc?
 
> >> Instead of setting aside a significant chunk of memory that nobody can use,
> >> take advantage ZONE_MOVABLE to mark a significant chunk of reserved memory
> >> as ZONE_MOVABLE, so that the kernel is prevented from using, but
> >> applications are free to use it.
> > 
> > Why kernel cannot use that memory while userspace can?
> 
> fadump needs to reserve memory to be able to save crashing kernel's
> memory, with help from power firmware, before the capture kernel loads
> into crashing kernel's memory area. Any contents present in this
> reserved memory will be over-written. If kernel is allowed to use this
> memory, then we loose that kernel data and won't be part of captured
> dump, which could be critical to debug root cause of system crash.

But then you simply screw user memory sitting there. This might be not
so critical as the kernel memory but still it sounds like you are
reducing the usefulness of the dump just because of inherent limitations
of fadump.

> Kdump and fadump both uses same infrastructure/tool (makedumpfile) to
> capture the memory dump. While the tool provides flexibility to
> determine what needs to be part of the dump and what memory to filter
> out, all supported distributions defaults to "Capture only kernel data
> and nothing else". Taking advantage of this default we can at least make
> the reserved memory available for userspace to use.
> 
> If someone wants to capture userspace data as well then
> 'fadump=nonmovable' option can be used where reserved pages won't be
> marked zone movable.

Ohh, so you have an unclutter thing to support the case above.

> Advantage of movable method is the reserved memory chunk is also
> available for use.
> 
> > [...]
> >>  Documentation/powerpc/firmware-assisted-dump.txt |   18 +++
> >>  arch/powerpc/include/asm/fadump.h                |    7 +
> >>  arch/powerpc/kernel/fadump.c                     |  123 +++++++++++++++++--
> >>  arch/powerpc/platforms/pseries/hotplug-memory.c  |    7 +
> >>  include/linux/mmzone.h                           |    2 
> >>  mm/page_alloc.c                                  |  146 ++++++++++++++++++++++
> >>  6 files changed, 290 insertions(+), 13 deletions(-)
> > 
> > This is quite a large change and you didn't seem to explain why we need
> > it.
> > 
> 
> In fadump case, the reserved memory stays unused until system is
> crashed. fadump uses very small portion of this reserved memory, few
> KBs, for storing fadump metadata. Otherwise, the significant chunk of
> memory is completely unused. Hence, instead of blocking a memory that is
> un-utilized through out the lifetime of system, it's better to give it
> back to production kernel to use. But at the same time we don't want
> kernel to use that memory. While exploring we found 1) Linux kernel's
> Contiguous Memory Allocator (CMA) feature and 2) ZONE_MOVABLE, that
> suites the requirement. Initial 5 revisions of this patchset () was
> using CMA feature. However, fadump does not do any cma allocations,
> hence it will be more appropriate to use zone movable to achieve the same.
> 
> But unlike CMA, there is no interface available to mark a custom
> reserved memory area as ZONE_MOVABLE. Hence patch 1/4 proposes the same.

Well, you are adding a significant amount of code so you should be much
better in explaining why does the generic code care about a ppc specific
kdump method.
-- 
Michal Hocko
SUSE Labs
