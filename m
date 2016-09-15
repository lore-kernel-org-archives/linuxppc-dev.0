Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZfkx2dYLzDsXk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:43:35 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 7B8BB20534
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 13:43:31 +0000 (UTC)
Received: from mail-yb0-f177.google.com (mail-yb0-f177.google.com
 [209.85.213.177])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1E1C2046F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 13:43:29 +0000 (UTC)
Received: by mail-yb0-f177.google.com with SMTP id d69so33035866ybf.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 06:43:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1473883618-14998-2-git-send-email-arbab@linux.vnet.ibm.com>
References: <1473883618-14998-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1473883618-14998-2-git-send-email-arbab@linux.vnet.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Sep 2016 08:43:08 -0500
Message-ID: <CAL_JsqK5ngY-eJggPSo5AGcv4CC2b8Y1X_aYzr06_Zf6Kv-u=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers/of: recognize status property of dt memory
 nodes
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 14, 2016 at 3:06 PM, Reza Arbab <arbab@linux.vnet.ibm.com> wrote:
> Respect the standard dt "status" property when scanning memory nodes in
> early_init_dt_scan_memory(), so that if the property is present and not
> "okay", no memory will be added.
>
> The use case at hand is accelerator or device memory, which may be
> unusable until post-boot initialization of the memory link. Such a node
> can be described in the dt as any other, given its status is "disabled".
> Per the device tree specification,
>
> "disabled"
>         Indicates that the device is not presently operational, but it
>         might become operational in the future (for example, something
>         is not plugged in, or switched off).
>
> Once such memory is made operational, it can then be hotplugged.
>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 085c638..fc19590 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1022,8 +1022,10 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>                                      int depth, void *data)
>  {
>         const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +       const char *status;
>         const __be32 *reg, *endp;
>         int l;
> +       bool add_memory;
>
>         /* We are scanning "memory" nodes only */
>         if (type == NULL) {
> @@ -1044,6 +1046,9 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>
>         endp = reg + (l / sizeof(__be32));
>
> +       status = of_get_flat_dt_prop(node, "status", NULL);
> +       add_memory = !status || !strcmp(status, "okay");

Move this into it's own function to mirror the unflattened version
(of_device_is_available). Also, make sure the logic is the same. IIRC,
"ok" is also allowed.

> +
>         pr_debug("memory scan node %s, reg size %d,\n", uname, l);
>
>         while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
> @@ -1057,6 +1062,9 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>                 pr_debug(" - %llx ,  %llx\n", (unsigned long long)base,
>                     (unsigned long long)size);
>
> +               if (!add_memory)
> +                       continue;

There's no point in checking this in the loop. status applies to the
whole node. Just return up above.

Rob
