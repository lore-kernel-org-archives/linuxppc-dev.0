Return-Path: <vasilis.liaskovitis@profitbricks.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A7282C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 03:02:12 +1000 (EST)
Received: by bkuw5 with SMTP id w5so554197bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 10:02:08 -0700 (PDT)
Date: Wed, 19 Sep 2012 19:02:05 +0200
From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC v8 PATCH 00/20] memory-hotplug: hot-remove physical memory
Message-ID: <20120919170205.GA15549@dhcp-192-168-178-175.profitbricks.localdomain>
References: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>
 <20120831134956.fec0f681.akpm@linux-foundation.org>
 <504D467D.2080201@jp.fujitsu.com> <504D4A08.7090602@cn.fujitsu.com>
 <20120910135213.GA1550@dhcp-192-168-178-175.profitbricks.localdomain>
 <50501B9C.7000200@cn.fujitsu.com>
 <20120912171814.GB5253@dhcp-192-168-178-175.profitbricks.localdomain>
 <50584159.3020403@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50584159.3020403@cn.fujitsu.com>
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, cl@linux.com, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
On Tue, Sep 18, 2012 at 05:39:37PM +0800, Wen Congyang wrote:
> At 09/13/2012 01:18 AM, Vasilis Liaskovitis Wrote:
> > Hi,
> > 
> > On Wed, Sep 12, 2012 at 01:20:28PM +0800, Wen Congyang wrote:
> >> Hmm, seabios doesn't support ACPI table SLIT. We can specify node it for dimm
> >> device, so I think we should support SLIT in seabios. Otherwise we may meet
> >> the following kernel messages:
> >> [  325.016769] init_memory_mapping: [mem 0x40000000-0x5fffffff]
> >> [  325.018060]  [mem 0x40000000-0x5fffffff] page 2M
> >> [  325.019168] [ffffea0001000000-ffffea00011fffff] potential offnode page_structs
> >> [  325.024172] [ffffea0001200000-ffffea00013fffff] potential offnode page_structs
> >> [  325.028596]  [ffffea0001400000-ffffea00017fffff] PMD -> [ffff880035000000-ffff8800353fffff] on node 1
> >> [  325.031775] [ffffea0001600000-ffffea00017fffff] potential offnode page_structs
> >>
> >> Do you have plan to do it?
> > thanks for testing.
> > 
> > commit 5294828 from https://github.com/vliaskov/seabios/commits/memhp-v2
> > implements a SLIT table for the given numa nodes.
> 
> Hmm, why do you set node_distance(i, j) to REMOTE_DISTANCE if i != j?

What's the alternative?

Afaik SLIT[i][j] shows the distance between proximity domains (_PXM) i and j. It
doesn't correspond to individual SRAT entries. So i and j here are not memory
ranges associated with 2 different dimms. They denote domains i and j, which map
to 2 different logical nodeids in the kernel.

A default setting would be to set the entry to REMOTE_DISTANCE for all different
domains (i!=j). So this SLIT implementation is not useful, since it results
in the same numa_distance values as the non-SLIT kernel calculation in
include/linux/topology.h

> 
> > 
> > However I am not sure the SLIT is the problem. The kernel builds a default
> > numa_distance table in arch/x86/mm/numa.c: numa_alloc_distance(). If the BIOS
> > doesn't present a SLIT, this should take effect (numactl --hardware should
> > report this table)
> 
> If the BIOS doesn't present a SLIT, numa_distance_cnt is set to 0 in the
> function numa_reset_distance(). So node_distance(i, j) is REMOTE_DISTANCE(i != j).
> 
> > 
> > Do you have more details on how to reproduce the warning? e.g. how many dimms
> > are present in the system? Does this happen on the first dimm hot-plugged?
> > Are all SRAT entries parsed correctly at boot-time or do you see any other
> > warnings at boot-time?
> 
> I can't reproduce it again. IIRC, I only do the following things:
> hotplug a memory device, online the pages, offline the pages and hot remove
> the memory device.

Is the sparse_vmemmap allocation supposed to guarantee no off-node allocations?
If not, then the warning could be valid.

thanks,

- Vasilis
