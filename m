Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GPqQ2bbpzF1pk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 22:08:02 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id s24-v6so13643522plq.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 05:08:02 -0700 (PDT)
Date: Wed, 4 Apr 2018 22:07:50 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>, Device Tree
 <devicetree@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [RESEND v2 3/4] doc/devicetree: Persistent memory region bindings
Message-ID: <20180404220750.0436bbe1@gmail.com>
In-Reply-To: <CAPcyv4jW5H8A96MFD7-UazNSZq-t1_NfrChNB3p9=somdBpsNw@mail.gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
 <20180403142415.30083-3-oohall@gmail.com>
 <CAPcyv4jW5H8A96MFD7-UazNSZq-t1_NfrChNB3p9=somdBpsNw@mail.gmail.com>
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

On Tue, 3 Apr 2018 10:37:51 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Apr 3, 2018 at 7:24 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
> > Add device-tree binding documentation for the nvdimm region driver.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> > ---
> > v2: Changed name from nvdimm-region to pmem-region.
> >     Cleaned up the example binding and fixed the overlapping regions.
> >     Added support for multiple regions in a single reg.
> > ---
> >  .../devicetree/bindings/pmem/pmem-region.txt       | 80 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pmem/pmem-region.txt  
> 
> Device-tree folks, does this look, ok?
> 
> Oliver, is there any concept of a management interface to the
> device(s) backing these regions? libnvdimm calls these "nmem" devices
> and support operations like health status and namespace label
> management.

We would need a way to have nmem and pmem-regions find each other. Since we
don't have the ACPI abstractions, the nmem region would need to add the
ability for a driver to have a phandle to the interleaving and nmem properties.

I guess that would be a separate driver, that would manage the nmem devices
and there would be a way to relate the pmem and nmems. Oliver?

Balbir Singh.
