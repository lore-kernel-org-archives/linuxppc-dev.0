Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fx734XxqzF29w
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 03:34:51 +1000 (AEST)
Received: by mail-ot0-x241.google.com with SMTP id h26-v6so20266473otj.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 10:34:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403142415.30083-2-oohall@gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
 <20180403142415.30083-2-oohall@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Apr 2018 10:34:48 -0700
Message-ID: <CAPcyv4i4w0qXwM338MeKaUWJmHdg6OqAotc+=Xsa7zhHGT7Thg@mail.gmail.com>
Subject: Re: [RESEND v2 2/4] libnvdimm: Add device-tree based driver
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Tue, Apr 3, 2018 at 7:24 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
> This patch adds peliminary device-tree bindings for persistent memory
> regions. The driver registers a libnvdimm bus for each pmem-region
> node and each address range under the node is converted to a region
> within that bus.
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> v2: Made each bus have a separate node rather having a shared bus.
>     Renamed to of_pmem rather than of_nvdimm.
>     Changed log level of happy-path messages to debug.
> ---
[..]
> +static struct platform_driver of_nd_region_driver = {
> +       .probe = of_nd_region_probe,
> +       .remove = of_nd_region_remove,
> +       .driver = {
> +               .name = "of_pmem",
> +               .owner = THIS_MODULE,
> +               .of_match_table = of_nd_region_match,
> +       },
> +};

This and the other patches look good to me. Just a nit on the
naming... since you name the regions pmem-regions in the device-tree
description shouldn't this be the "of_pmem_region" or "of_pmem_range"
driver? Otherwise, it is confusing to me that anything named
*nd_region would be creating an nvdimm_bus. In general An nd_region is
always a child of a bus.

That said, with an ack/reviewed-by on the device-tree bindings I can
take these through the nvdimm tree. I'll reply to patch 4 with that
request for ack.
