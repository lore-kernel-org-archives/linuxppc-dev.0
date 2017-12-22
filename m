Return-Path: <ross.zwisler@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3PgJ50dnzF07Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 10:22:35 +1100 (AEDT)
Date: Fri, 22 Dec 2017 16:22:31 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Brice Goglin <brice.goglin@gmail.com>,
 Ross Zwisler <ross.zwisler@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 Michal Hocko <mhocko@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 Balbir Singh <bsingharora@gmail.com>, Jerome Glisse <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Len Brown <lenb@kernel.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, devel@acpica.org,
 Linux ACPI <linux-acpi@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 Linux API <linux-api@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Message-ID: <20171222232231.GA26715@linux.intel.com>
References: <20171214130032.GK16951@dhcp22.suse.cz>
 <20171218203547.GA2366@linux.intel.com>
 <20171220181937.GB12236@bombadil.infradead.org>
 <2da89d31-27a3-34ab-2dbb-92403c8215ec@intel.com>
 <20171220211649.GA32200@bombadil.infradead.org>
 <20171220212408.GA8308@linux.intel.com>
 <CAPcyv4gTknp=0yQnVrrB5Ui+mJE_x-wdkV86UD4hsYnx3CAjfA@mail.gmail.com>
 <20171220224105.GA27258@linux.intel.com>
 <39cbe02a-d309-443d-54c9-678a0799342d@gmail.com>
 <CAPcyv4j9shdJFrvADa=qW4L-jPJJ4S_TJc_c=aRoW3EmSCCChQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAPcyv4j9shdJFrvADa=qW4L-jPJJ4S_TJc_c=aRoW3EmSCCChQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 22, 2017 at 02:53:42PM -0800, Dan Williams wrote:
> On Thu, Dec 21, 2017 at 12:31 PM, Brice Goglin <brice.goglin@gmail.com> wrote:
> > Le 20/12/2017 à 23:41, Ross Zwisler a écrit :
> [..]
> > Hello
> >
> > I can confirm that HPC runtimes are going to use these patches (at least
> > all runtimes that use hwloc for topology discovery, but that's the vast
> > majority of HPC anyway).
> >
> > We really didn't like KNL exposing a hacky SLIT table [1]. We had to
> > explicitly detect that specific crazy table to find out which NUMA nodes
> > were local to which cores, and to find out which NUMA nodes were
> > HBM/MCDRAM or DDR. And then we had to hide the SLIT values to the
> > application because the reported latencies didn't match reality. Quite
> > annoying.
> >
> > With Ross' patches, we can easily get what we need:
> > * which NUMA nodes are local to which CPUs? /sys/devices/system/node/
> > can only report a single local node per CPU (doesn't work for KNL and
> > upcoming architectures with HBM+DDR+...)
> > * which NUMA nodes are slow/fast (for both bandwidth and latency)
> > And we can still look at SLIT under /sys/devices/system/node if really
> > needed.
> >
> > And of course having this in sysfs is much better than parsing ACPI
> > tables that are only accessible to root :)
> 
> On this point, it's not clear to me that we should allow these sysfs
> entries to be world readable. Given /proc/iomem now hides physical
> address information from non-root we at least need to be careful not
> to undo that with new sysfs HMAT attributes.

This enabling does not expose any physical addresses to userspace.  It only
provides performance numbers from the HMAT and associates them with existing
NUMA nodes.  Are you worried that exposing performance numbers to non-root
users via sysfs poses a security risk?

> Once you need to be root for this info, is parsing binary HMAT vs sysfs a
> blocker for the HPC use case?
> 
> Perhaps we can enlist /proc/iomem or a similar enumeration interface
> to tell userspace the NUMA node and whether the kernel thinks it has
> better or worse performance characteristics relative to base
> system-RAM, i.e. new IORES_DESC_* values. I'm worried that if we start
> publishing absolute numbers in sysfs userspace will default to looking
> for specific magic numbers in sysfs vs asking the kernel for memory
> that has performance characteristics relative to base "System RAM". In
> other words the absolute performance information that the HMAT
> publishes is useful to the kernel, but it's not clear that userspace
> needs that vs a relative indicator for making NUMA node preference
> decisions.
