Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z232r5jMyzF08c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 05:19:48 +1100 (AEDT)
Date: Wed, 20 Dec 2017 10:19:37 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
 "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>,
 "Box, David E" <david.e.box@intel.com>,
 "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>,
 "Koss, Marcin" <marcin.koss@intel.com>,
 "Koziej, Artur" <artur.koziej@intel.com>,
 "Lahtinen, Joonas" <joonas.lahtinen@intel.com>,
 "Moore, Robert" <robert.moore@intel.com>,
 "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>,
 "Odzioba, Lukasz" <lukasz.odzioba@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "Schmauss, Erik" <erik.schmauss@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "Zheng, Lv" <lv.zheng@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Brice Goglin <brice.goglin@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Jerome Glisse <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Len Brown <lenb@kernel.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, devel@acpica.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-nvdimm@lists.01.org, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Message-ID: <20171220181937.GB12236@bombadil.infradead.org>
References: <20171214021019.13579-1-ross.zwisler@linux.intel.com>
 <20171214130032.GK16951@dhcp22.suse.cz>
 <20171218203547.GA2366@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218203547.GA2366@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 18, 2017 at 01:35:47PM -0700, Ross Zwisler wrote:
> What I'm hoping to do with this series is to just provide a sysfs
> representation of the HMAT so that applications can know which NUMA nodes to
> select with existing utilities like numactl.  This series does not currently
> alter any kernel behavior, it only provides a sysfs interface.
> 
> Say for example you had a system with some high bandwidth memory (HBM), and
> you wanted to use it for a specific application.  You could use the sysfs
> representation of the HMAT to figure out which memory target held your HBM.
> You could do this by looking at the local bandwidth values for the various
> memory targets, so:
> 
> 	# grep . /sys/devices/system/hmat/mem_tgt*/local_init/write_bw_MBps
> 	/sys/devices/system/hmat/mem_tgt2/local_init/write_bw_MBps:81920
> 	/sys/devices/system/hmat/mem_tgt3/local_init/write_bw_MBps:40960
> 	/sys/devices/system/hmat/mem_tgt4/local_init/write_bw_MBps:40960
> 	/sys/devices/system/hmat/mem_tgt5/local_init/write_bw_MBps:40960
> 
> and look for the one that corresponds to your HBM speed. (These numbers are
> made up, but you get the idea.)

Presumably ACPI-based platforms will not be the only ones who have the
ability to expose different bandwidth memories in the future.  I think
we need a platform-agnostic way ... right, PowerPC people?

I don't know what the right interface is, but my laptop has a set of
/sys/devices/system/memory/memoryN/ directories.  Perhaps this is the
right place to expose write_bw (etc).

> Once you know the NUMA node of your HBM, you can figure out the NUMA node of
> it's local initiator:
> 
> 	# ls -d /sys/devices/system/hmat/mem_tgt2/local_init/mem_init*
> 	/sys/devices/system/hmat/mem_tgt2/local_init/mem_init0
> 
> So, in our made-up example our HBM is located in numa node 2, and the local
> CPU for that HBM is at numa node 0.

initiator is a CPU?  I'd have expected you to expose a memory controller
abstraction rather than re-use storage terminology.
