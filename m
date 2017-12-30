Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7vSg17mTzDr29
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Dec 2017 17:58:58 +1100 (AEDT)
Date: Fri, 29 Dec 2017 22:58:45 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Brice Goglin <brice.goglin@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Ross Zwisler <ross.zwisler@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20171230065845.GD27959@bombadil.infradead.org>
References: <20171218203547.GA2366@linux.intel.com>
 <20171220181937.GB12236@bombadil.infradead.org>
 <2da89d31-27a3-34ab-2dbb-92403c8215ec@intel.com>
 <20171220211649.GA32200@bombadil.infradead.org>
 <20171220212408.GA8308@linux.intel.com>
 <CAPcyv4gTknp=0yQnVrrB5Ui+mJE_x-wdkV86UD4hsYnx3CAjfA@mail.gmail.com>
 <20171220224105.GA27258@linux.intel.com>
 <39cbe02a-d309-443d-54c9-678a0799342d@gmail.com>
 <CAPcyv4j9shdJFrvADa=qW4L-jPJJ4S_TJc_c=aRoW3EmSCCChQ@mail.gmail.com>
 <71317994-af66-a1b2-4c7a-86a03253cf62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <71317994-af66-a1b2-4c7a-86a03253cf62@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 27, 2017 at 10:10:34AM +0100, Brice Goglin wrote:
> > Perhaps we can enlist /proc/iomem or a similar enumeration interface
> > to tell userspace the NUMA node and whether the kernel thinks it has
> > better or worse performance characteristics relative to base
> > system-RAM, i.e. new IORES_DESC_* values. I'm worried that if we start
> > publishing absolute numbers in sysfs userspace will default to looking
> > for specific magic numbers in sysfs vs asking the kernel for memory
> > that has performance characteristics relative to base "System RAM". In
> > other words the absolute performance information that the HMAT
> > publishes is useful to the kernel, but it's not clear that userspace
> > needs that vs a relative indicator for making NUMA node preference
> > decisions.
> 
> Some HPC users will benchmark the machine to discovery actual
> performance numbers anyway.
> However, most users won't do this. They will want to know relative
> performance of different nodes. If you normalize HMAT values by dividing
> them with system-RAM values, that's likely OK. If you just say "that
> node is faster than system RAM", it's not precise enough.

So "this memory has 800% bandwidth of normal" and "this memory has 70%
bandwidth of normal"?
