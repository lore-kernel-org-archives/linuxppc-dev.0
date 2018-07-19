Return-Path: <srs0=8uks=kd=kernel.org=mhocko@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WRTk59XnzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 18:08:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41WRTk4HJgz8tCf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 18:08:10 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41WRTj5pm6z9s1R
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2018 18:08:09 +1000 (AEST)
Date: Thu, 19 Jul 2018 10:08:05 +0200
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
Message-ID: <20180719080805.GM7193@dhcp22.suse.cz>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
 <20180716082646.GF17280@dhcp22.suse.cz>
 <cb5fc554-7fa3-1356-c304-ae8c27a0c70c@linux.vnet.ibm.com>
 <20180717115232.GF7193@dhcp22.suse.cz>
 <b2c316b9-520e-0a31-3ebd-d3ade50c3783@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b2c316b9-520e-0a31-3ebd-d3ade50c3783@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 18-07-18 21:52:17, Mahesh Jagannath Salgaonkar wrote:
> On 07/17/2018 05:22 PM, Michal Hocko wrote:
> > On Tue 17-07-18 16:58:10, Mahesh Jagannath Salgaonkar wrote:
> >> On 07/16/2018 01:56 PM, Michal Hocko wrote:
> >>> On Mon 16-07-18 11:32:56, Mahesh J Salgaonkar wrote:
> >>>> One of the primary issues with Firmware Assisted Dump (fadump) on Power
> >>>> is that it needs a large amount of memory to be reserved. This reserved
> >>>> memory is used for saving the contents of old crashed kernel's memory before
> >>>> fadump capture kernel uses old kernel's memory area to boot. However, This
> >>>> reserved memory area stays unused until system crash and isn't available
> >>>> for production kernel to use.
> >>>
> >>> How much memory are we talking about. Regular kernel dump process needs
> >>> some reserved memory as well. Why that is not a big problem?
> >>
> >> We reserve around 5% of total system RAM. On large systems with
> >> TeraBytes of memory, this reservation can be quite significant.
> >>
> >> The regular kernel dump uses the kexec method to boot into capture
> >> kernel and it can control the parameters that are being passed to
> >> capture kernel. This allows a capability to strip down the parameters
> >> that can help lowering down the memory requirement for capture kernel to
> >> boot. This allows regular kdump to reserve less memory to start with.
> >>
> >> Where as fadump depends on power firmware (pHyp) to load the capture
> >> kernel after full reset and boots like a regular kernel. It needs same
> >> amount of memory to boot as the production kernel. On large systems
> >> production kernel needs significant amount of memory to boot. Hence
> >> fadump needs to reserve enough memory for capture kernel to boot
> >> successfully and execute dump capturing operations. By default fadump
> >> reserves 5% of total system RAM and in most cases this has worked
> >> flawlessly on variety of system configurations. Optionally,
> >> 'crashkernel=X' can also be used to specify more fine-tuned memory size
> >> for reservation.
> > 
> > So why do we even care about fadump when regular kexec provides
> > (presumably) same functionality with a smaller memory footprint? Or is
> > there any reason why kexec doesn't work well on ppc?
> 
> Kexec based kdump is loaded by crashing kernel. When OS crashes, the
> system is in an inconsistent state, especially the devices. In some
> cases, a rogue DMA or ill-behaving device drivers can cause the kdump
> capture to fail.
> 
> On power platform, fadump solves these issues by taking help from power
> firmware, to fully-reset the system, load the fresh copy of same kernel
> to capture the dump with PCI and I/O devices reinitialized, making it
> more reliable.

Thanks for the clarification.

> Fadump does full system reset, booting system through the regular boot
> options i.e the dump capture kernel is booted in the same fashion and
> doesn't have specialized kernel command line option. This implies, we
> need to give more memory for the system boot. Since the new kernel boots
> from the same memory location as crashed kernel, we reserve 5% of memory
> where power firmware moves the crashed kernel's memory content. This
> reserved memory is completely removed from the available memory. For
> large memory systems like 64TB systems, this account to ~ 3TB, which is
> a significant chunk of memory production kernel is deprived of. Hence,
> this patch adds an improvement to exiting fadump feature to make the
> reserved memory available to system for use, using zone movable.

Is the 5% a reasonable estimate or more a ballpark number? I find it a
bit strange to require 3TB of memory to boot a kernel just to dump the
crashed kernel image. Shouldn't you rather look into this estimate than
spreading ZONE_MOVABLE abuse? Larger systems need more memory to dump
even with the regular kexec kdump but I have never seen any to use more
than 1G or something like that.
-- 
Michal Hocko
SUSE Labs
