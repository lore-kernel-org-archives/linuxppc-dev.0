Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x234.google.com (mail-yk0-x234.google.com
 [IPv6:2607:f8b0:4002:c07::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 135C41A009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 00:09:33 +1000 (AEST)
Received: by ykoo205 with SMTP id o205so63142601yko.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2015 07:09:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-39-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-39-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 6 Aug 2015 09:09:11 -0500
Message-ID: <CAL_JsqJsfQjUiPFToyhkLYPbmxppb9BgWysgg46DrifFUqtQsw@mail.gmail.com>
Subject: Re: [PATCH v6 38/42] drivers/of: Unflatten subordinate nodes after
 specified level
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>, aik@ozlabs.ru
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 5, 2015 at 11:11 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> unflatten_dt_node() is called recursively to unflatten FDT nodes
> with the assumption that FDT blob has only one root node, which
> isn't true when the FDT blob represents device sub-tree. This
> improves the function to supporting device sub-tree that have
> multiple nodes in the first level:
>
>    * Rename original unflatten_dt_node() to __unflatten_dt_node().
>    * Wrapper unflatten_dt_node() calls __unflatten_dt_node() with
>      adjusted current node depth to 1 to avoid underflow.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/fdt.c | 53 ++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 0749656..a18a2ce 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -161,7 +161,7 @@ static void *unflatten_dt_alloc(void **mem, unsigned long size,
>  }
>
>  /**
> - * unflatten_dt_node - Alloc and populate a device_node from the flat tree
> + * __unflatten_dt_node - Alloc and populate a device_node from the flat tree
>   * @blob: The parent device tree blob
>   * @mem: Memory chunk to use for allocating device nodes and properties
>   * @poffset: pointer to node in flat tree
> @@ -171,20 +171,20 @@ static void *unflatten_dt_alloc(void **mem, unsigned long size,
>   * @dryrun: If true, do not allocate device nodes but still calculate needed
>   * memory size
>   */
> -static void * unflatten_dt_node(const void *blob,
> +static void *__unflatten_dt_node(const void *blob,
>                                 void *mem,
>                                 int *poffset,
>                                 struct device_node *dad,
>                                 struct device_node **nodepp,
>                                 unsigned long fpsize,
> -                               bool dryrun)
> +                               bool dryrun,
> +                               int *depth)
>  {
>         const __be32 *p;
>         struct device_node *np;
>         struct property *pp, **prev_pp = NULL;
>         const char *pathp;
>         unsigned int l, allocl;
> -       static int depth = 0;
>         int old_depth;
>         int offset;
>         int has_name = 0;
> @@ -337,13 +337,25 @@ static void * unflatten_dt_node(const void *blob,
>                         np->type = "<NULL>";
>         }
>
> -       old_depth = depth;
> -       *poffset = fdt_next_node(blob, *poffset, &depth);
> -       if (depth < 0)
> -               depth = 0;
> -       while (*poffset > 0 && depth > old_depth)
> -               mem = unflatten_dt_node(blob, mem, poffset, np, NULL,
> -                                       fpsize, dryrun);
> +       /* Multiple nodes might be in the first depth level if
> +        * the device tree is sub-tree. All nodes in current
> +        * or deeper depth are unflattened after it returns.
> +        */
> +       old_depth = *depth;
> +       *poffset = fdt_next_node(blob, *poffset, depth);
> +       while (*poffset > 0) {
> +               if (*depth < old_depth)
> +                       break;
> +
> +               if (*depth == old_depth)
> +                       mem = __unflatten_dt_node(blob, mem, poffset,
> +                                                 dad, NULL, fpsize,
> +                                                 dryrun, depth);
> +               else if (*depth > old_depth)
> +                       mem = __unflatten_dt_node(blob, mem, poffset,
> +                                                 np, NULL, fpsize,
> +                                                 dryrun, depth);
> +       }
>
>         if (*poffset < 0 && *poffset != -FDT_ERR_NOTFOUND)
>                 pr_err("unflatten: error %d processing FDT\n", *poffset);
> @@ -369,6 +381,20 @@ static void * unflatten_dt_node(const void *blob,
>         return mem;
>  }
>
> +static void *unflatten_dt_node(const void *blob,
> +                              void *mem,
> +                              int *poffset,
> +                              struct device_node *dad,
> +                              struct device_node **nodepp,
> +                              bool dryrun)
> +{
> +       int depth = 1;
> +
> +       return __unflatten_dt_node(blob, mem, poffset,
> +                                  dad, nodepp, 0,
> +                                  dryrun, &depth);
> +}
> +
>  /**
>   * __unflatten_device_tree - create tree of device_nodes from flat blob
>   *
> @@ -408,7 +434,8 @@ static void __unflatten_device_tree(const void *blob,
>
>         /* First pass, scan for size */
>         start = 0;
> -       size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL, NULL, 0, true);
> +       size = (unsigned long)unflatten_dt_node(blob, NULL, &start,
> +                                               NULL, NULL, true);
>         size = ALIGN(size, 4);
>
>         pr_debug("  size is %lx, allocating...\n", size);
> @@ -423,7 +450,7 @@ static void __unflatten_device_tree(const void *blob,
>
>         /* Second pass, do actual unflattening */
>         start = 0;
> -       unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false);
> +       unflatten_dt_node(blob, mem, &start, NULL, mynodes, false);
>         if (be32_to_cpup(mem + size) != 0xdeadbeef)
>                 pr_warning("End of tree marker overwritten: %08x\n",
>                            be32_to_cpup(mem + size));
> --
> 2.1.0
>
