Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Gqwb5fLSzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 14:43:59 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id g20-v6so17481036plo.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 21:43:59 -0700 (PDT)
Date: Thu, 5 Apr 2018 14:43:48 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Oliver <oohall@gmail.com>, Device Tree <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm
 <linux-nvdimm@lists.01.org>
Subject: Re: [RESEND v2 3/4] doc/devicetree: Persistent memory region bindings
Message-ID: <20180405144348.141fd93f@gmail.com>
In-Reply-To: <CAPcyv4if4un9mgFon4ttjKDYEtHC_GP6VoxUENp7YNS50T3afA@mail.gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
 <20180403142415.30083-3-oohall@gmail.com>
 <CAPcyv4jW5H8A96MFD7-UazNSZq-t1_NfrChNB3p9=somdBpsNw@mail.gmail.com>
 <20180404220750.0436bbe1@gmail.com>
 <CAOSf1CGdKU4zQQauqo3UoNvKnKDMHteAEtsMWVtTG7T01csMbg@mail.gmail.com>
 <CAPcyv4if4un9mgFon4ttjKDYEtHC_GP6VoxUENp7YNS50T3afA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 4 Apr 2018 07:21:32 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Apr 4, 2018 at 7:04 AM, Oliver <oohall@gmail.com> wrote:
> > On Wed, Apr 4, 2018 at 10:07 PM, Balbir Singh <bsingharora@gmail.com> wrote:  
> >> On Tue, 3 Apr 2018 10:37:51 -0700
> >> Dan Williams <dan.j.williams@intel.com> wrote:
> >>  
> >>> On Tue, Apr 3, 2018 at 7:24 AM, Oliver O'Halloran <oohall@gmail.com> wrote:  
> >>> > Add device-tree binding documentation for the nvdimm region driver.
> >>> >
> >>> > Cc: devicetree@vger.kernel.org
> >>> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> >>> > ---
> >>> > v2: Changed name from nvdimm-region to pmem-region.
> >>> >     Cleaned up the example binding and fixed the overlapping regions.
> >>> >     Added support for multiple regions in a single reg.
> >>> > ---
> >>> >  .../devicetree/bindings/pmem/pmem-region.txt       | 80 ++++++++++++++++++++++
> >>> >  MAINTAINERS                                        |  1 +
> >>> >  2 files changed, 81 insertions(+)
> >>> >  create mode 100644 Documentation/devicetree/bindings/pmem/pmem-region.txt  
> >>>
> >>> Device-tree folks, does this look, ok?
> >>>
> >>> Oliver, is there any concept of a management interface to the
> >>> device(s) backing these regions? libnvdimm calls these "nmem" devices
> >>> and support operations like health status and namespace label
> >>> management.  
> >
> > It's something I'm planning on implementing as soon as someone gives
> > me some hardware that isn't hacked up lab crap. I'm posting this
> > version with just regions since people have been asking for something
> > in upstream even if it's not fully featured.
> >
> > Grumbling aside, the plan is to have separate drivers for the DIMM
> > type. Discovering DIMM devices happens via the normal discovery
> > mechanisms (e.g. an NVDIMM supporting the JEDEC interface is an I2C
> > device) and when binding to a specific DIMM device it registers a DIMM
> > descriptor structure and a ndctl implementation for that DIMM type
> > with of_pmem. When of_pmem binds to a region it can plug everything
> > into the region specific bus. There's a few details to work out, but I
> > think it's a reasonable approach.  
> 
> Yeah, that sounds reasonable. It would mean that your management
> interface would need to understand that nmems on different buses could
> potentially move to another bus after a reconfiguration, but that's
> not too much different than the ACPI case where nmems can join and
> leave regions after a reset / reconfig.
> 
> >> We would need a way to have nmem and pmem-regions find each other. Since we
> >> don't have the ACPI abstractions, the nmem region would need to add the
> >> ability for a driver to have a phandle to the interleaving and nmem properties.
> >>
> >> I guess that would be a separate driver, that would manage the nmem devices
> >> and there would be a way to relate the pmem and nmems. Oliver?  
> >
> > Yes, that's the plan.  
> 
> So Balbir, is that enough for an Acked-by for this device-tree proposal?

I don't see any major problems with the binding, but I think Oliver wanted
to send in a few clarifications based on a private discussion.

Balbir Singh.
