Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2Whd5JkbzF0B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 23:50:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matthew Wilcox <willy@infradead.org>,
 Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>, "Box\, David E" <david.e.box@intel.com>,
 Dave Hansen <dave.hansen@intel.com>, "Zheng\, Lv" <lv.zheng@intel.com>,
 linux-nvdimm@lists.01.org, "Verma\, Vishal L" <vishal.l.verma@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Anaczkowski\,
 Lukasz" <lukasz.anaczkowski@intel.com>, "Moore\,
 Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org, "Odzioba\,
 Lukasz" <lukasz.odzioba@intel.com>, "Schmauss\, Erik" <erik.schmauss@intel.com>,
 Len Brown <lenb@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 linuxppc-dev@lists.ozlabs.org, Jerome Glisse <jglisse@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, devel@acpica.org, "Kogut\,
 Jaroslaw" <Jaroslaw.Kogut@intel.com>, linux-mm@kvack.org, "Koss\,
 Marcin" <marcin.koss@intel.com>, linux-api@vger.kernel.org,
 Brice Goglin <brice.goglin@gmail.com>, "Nachimuthu\,
 Murugasamy" <murugasamy.nachimuthu@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 "Koziej\, Artur" <artur.koziej@intel.com>, "Lahtinen\,
 Joonas" <joonas.lahtinen@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v3 0/3] create sysfs representation of ACPI HMAT
In-Reply-To: <20171220181937.GB12236@bombadil.infradead.org>
References: <20171214021019.13579-1-ross.zwisler@linux.intel.com>
 <20171214130032.GK16951@dhcp22.suse.cz>
 <20171218203547.GA2366@linux.intel.com>
 <20171220181937.GB12236@bombadil.infradead.org>
Date: Thu, 21 Dec 2017 23:50:40 +1100
Message-ID: <87mv2cfdnj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Dec 18, 2017 at 01:35:47PM -0700, Ross Zwisler wrote:
>> What I'm hoping to do with this series is to just provide a sysfs
>> representation of the HMAT so that applications can know which NUMA nodes to
>> select with existing utilities like numactl.  This series does not currently
>> alter any kernel behavior, it only provides a sysfs interface.
>> 
>> Say for example you had a system with some high bandwidth memory (HBM), and
>> you wanted to use it for a specific application.  You could use the sysfs
>> representation of the HMAT to figure out which memory target held your HBM.
>> You could do this by looking at the local bandwidth values for the various
>> memory targets, so:
>> 
>> 	# grep . /sys/devices/system/hmat/mem_tgt*/local_init/write_bw_MBps
>> 	/sys/devices/system/hmat/mem_tgt2/local_init/write_bw_MBps:81920
>> 	/sys/devices/system/hmat/mem_tgt3/local_init/write_bw_MBps:40960
>> 	/sys/devices/system/hmat/mem_tgt4/local_init/write_bw_MBps:40960
>> 	/sys/devices/system/hmat/mem_tgt5/local_init/write_bw_MBps:40960
>> 
>> and look for the one that corresponds to your HBM speed. (These numbers are
>> made up, but you get the idea.)
>
> Presumably ACPI-based platforms will not be the only ones who have the
> ability to expose different bandwidth memories in the future.  I think
> we need a platform-agnostic way ... right, PowerPC people?

Yes!

I don't have any detail at hand but will try and rustle something up.

cheers
