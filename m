Return-Path: <oohall@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GSPK424bzF1b9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 00:04:04 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id v194-v6so27714411itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 07:04:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180404220750.0436bbe1@gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
 <20180403142415.30083-3-oohall@gmail.com>
 <CAPcyv4jW5H8A96MFD7-UazNSZq-t1_NfrChNB3p9=somdBpsNw@mail.gmail.com>
 <20180404220750.0436bbe1@gmail.com>
From: Oliver <oohall@gmail.com>
Date: Thu, 5 Apr 2018 00:04:01 +1000
Message-ID: <CAOSf1CGdKU4zQQauqo3UoNvKnKDMHteAEtsMWVtTG7T01csMbg@mail.gmail.com>
Subject: Re: [RESEND v2 3/4] doc/devicetree: Persistent memory region bindings
To: Balbir Singh <bsingharora@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Device Tree <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 4, 2018 at 10:07 PM, Balbir Singh <bsingharora@gmail.com> wrote:
> On Tue, 3 Apr 2018 10:37:51 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> On Tue, Apr 3, 2018 at 7:24 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
>> > Add device-tree binding documentation for the nvdimm region driver.
>> >
>> > Cc: devicetree@vger.kernel.org
>> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> > ---
>> > v2: Changed name from nvdimm-region to pmem-region.
>> >     Cleaned up the example binding and fixed the overlapping regions.
>> >     Added support for multiple regions in a single reg.
>> > ---
>> >  .../devicetree/bindings/pmem/pmem-region.txt       | 80 ++++++++++++++++++++++
>> >  MAINTAINERS                                        |  1 +
>> >  2 files changed, 81 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/pmem/pmem-region.txt
>>
>> Device-tree folks, does this look, ok?
>>
>> Oliver, is there any concept of a management interface to the
>> device(s) backing these regions? libnvdimm calls these "nmem" devices
>> and support operations like health status and namespace label
>> management.

It's something I'm planning on implementing as soon as someone gives
me some hardware that isn't hacked up lab crap. I'm posting this
version with just regions since people have been asking for something
in upstream even if it's not fully featured.

Grumbling aside, the plan is to have separate drivers for the DIMM
type. Discovering DIMM devices happens via the normal discovery
mechanisms (e.g. an NVDIMM supporting the JEDEC interface is an I2C
device) and when binding to a specific DIMM device it registers a DIMM
descriptor structure and a ndctl implementation for that DIMM type
with of_pmem. When of_pmem binds to a region it can plug everything
into the region specific bus. There's a few details to work out, but I
think it's a reasonable approach.

> We would need a way to have nmem and pmem-regions find each other. Since we
> don't have the ACPI abstractions, the nmem region would need to add the
> ability for a driver to have a phandle to the interleaving and nmem properties.
>
> I guess that would be a separate driver, that would manage the nmem devices
> and there would be a way to relate the pmem and nmems. Oliver?

Yes, that's the plan.
