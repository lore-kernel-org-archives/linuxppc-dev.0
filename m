Return-Path: <dan.j.williams@intel.com>
Received: from mail-yb0-x232.google.com (mail-yb0-x232.google.com
 [IPv6:2607:f8b0:4002:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6DRJ09hvzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 17:36:27 +1000 (AEST)
Received: by mail-yb0-x232.google.com with SMTP id p207so35315587yba.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 00:36:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOSf1CF=4E28H4Fu5Pmwb-iCVio5pM_pFoBy+gvkcSsNQkpeEA@mail.gmail.com>
References: <20170627102851.15484-1-oohall@gmail.com>
 <CAPcyv4g-vgaAZu9DWXfOcwH5p_ZJBwiMJFZ43rKWuJB2L-W7VQ@mail.gmail.com>
 <CAOSf1CF=4E28H4Fu5Pmwb-iCVio5pM_pFoBy+gvkcSsNQkpeEA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 11 Jul 2017 00:36:24 -0700
Message-ID: <CAPcyv4j85boeJwCy0vt0fY_E30g7ywtxPG9OH+z0XCsBdOgKFw@mail.gmail.com>
Subject: Re: [RFC 1/4] libnvdimm: add to_{nvdimm,nd_region}_dev()
To: Oliver <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2017 at 9:38 PM, Oliver <oohall@gmail.com> wrote:
> On Tue, Jul 11, 2017 at 9:53 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Tue, Jun 27, 2017 at 3:28 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
>>> struct device contains the ->of_node pointer so that devices can be
>>> assoicated with the device-tree node that created them on DT platforms.
>>> libnvdimm hides the struct device for regions and nvdimm devices inside
>>> of an opaque structure so this patch adds accessors for each to allow
>>> the of_nvdimm driver to set the of_node pointer.
>>
>> I'd rather go the other way and pass in the of_node to the bus and
>> dimm registration routines. It's a generic property of the device so
>> we should handle it like other generic device properties that get set
>> at initialization time like 'attr_groups' in nvdimm_bus_descriptor, or
>> a new parameter to nvdimm_create().
>
> Sure. I just figured it would be preferable to keep firmware specific
> details inside the firmware driver rather than adding #ifdef CONFIG_OF
> around the place. Do you have any objections to making nvdimm_create()
> take a descriptor structure rather than adding a parameter?

I don't see why we need "#ifdef CONFIG_OF". It's just a "struct
of_node *" pointer that can be forward declared as "struct of_node;"
we don't need the full definition.

Yes, I'm fine with converting nvdimm_create() to a take a descriptor,
