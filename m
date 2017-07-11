Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x235.google.com (mail-qk0-x235.google.com
 [IPv6:2607:f8b0:400d:c09::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x68Tn1R2DzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 14:38:21 +1000 (AEST)
Received: by mail-qk0-x235.google.com with SMTP id 16so91149929qkg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 21:38:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g-vgaAZu9DWXfOcwH5p_ZJBwiMJFZ43rKWuJB2L-W7VQ@mail.gmail.com>
References: <20170627102851.15484-1-oohall@gmail.com>
 <CAPcyv4g-vgaAZu9DWXfOcwH5p_ZJBwiMJFZ43rKWuJB2L-W7VQ@mail.gmail.com>
From: Oliver <oohall@gmail.com>
Date: Tue, 11 Jul 2017 14:38:18 +1000
Message-ID: <CAOSf1CF=4E28H4Fu5Pmwb-iCVio5pM_pFoBy+gvkcSsNQkpeEA@mail.gmail.com>
Subject: Re: [RFC 1/4] libnvdimm: add to_{nvdimm,nd_region}_dev()
To: Dan Williams <dan.j.williams@intel.com>
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

On Tue, Jul 11, 2017 at 9:53 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, Jun 27, 2017 at 3:28 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
>> struct device contains the ->of_node pointer so that devices can be
>> assoicated with the device-tree node that created them on DT platforms.
>> libnvdimm hides the struct device for regions and nvdimm devices inside
>> of an opaque structure so this patch adds accessors for each to allow
>> the of_nvdimm driver to set the of_node pointer.
>
> I'd rather go the other way and pass in the of_node to the bus and
> dimm registration routines. It's a generic property of the device so
> we should handle it like other generic device properties that get set
> at initialization time like 'attr_groups' in nvdimm_bus_descriptor, or
> a new parameter to nvdimm_create().

Sure. I just figured it would be preferable to keep firmware specific
details inside the firmware driver rather than adding #ifdef CONFIG_OF
around the place. Do you have any objections to making nvdimm_create()
take a descriptor structure rather than adding a parameter?
