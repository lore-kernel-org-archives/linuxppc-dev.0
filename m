Return-Path: <srs0=h5fe=ka=kernel.org=mhocko@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Tc2k053MzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 18:26:54 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41Tc2j5BB3z8tDv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 18:26:53 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41Tc2j11Wdz9ryt
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 18:26:52 +1000 (AEST)
Date: Mon, 16 Jul 2018 10:26:46 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
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
Message-ID: <20180716082646.GF17280@dhcp22.suse.cz>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 16-07-18 11:32:56, Mahesh J Salgaonkar wrote:
> One of the primary issues with Firmware Assisted Dump (fadump) on Power
> is that it needs a large amount of memory to be reserved. This reserved
> memory is used for saving the contents of old crashed kernel's memory before
> fadump capture kernel uses old kernel's memory area to boot. However, This
> reserved memory area stays unused until system crash and isn't available
> for production kernel to use.

How much memory are we talking about. Regular kernel dump process needs
some reserved memory as well. Why that is not a big problem?

> Instead of setting aside a significant chunk of memory that nobody can use,
> take advantage ZONE_MOVABLE to mark a significant chunk of reserved memory
> as ZONE_MOVABLE, so that the kernel is prevented from using, but
> applications are free to use it.

Why kernel cannot use that memory while userspace can?
[...]
>  Documentation/powerpc/firmware-assisted-dump.txt |   18 +++
>  arch/powerpc/include/asm/fadump.h                |    7 +
>  arch/powerpc/kernel/fadump.c                     |  123 +++++++++++++++++--
>  arch/powerpc/platforms/pseries/hotplug-memory.c  |    7 +
>  include/linux/mmzone.h                           |    2 
>  mm/page_alloc.c                                  |  146 ++++++++++++++++++++++
>  6 files changed, 290 insertions(+), 13 deletions(-)

This is quite a large change and you didn't seem to explain why we need
it.
-- 
Michal Hocko
SUSE Labs
