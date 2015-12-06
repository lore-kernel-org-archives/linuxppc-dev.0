Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com
 [IPv6:2607:f8b0:4002:c07::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C1571A065B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 07:28:53 +1100 (AEDT)
Received: by ykfs79 with SMTP id s79so175923793ykf.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Dec 2015 12:28:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Sun, 6 Dec 2015 14:28:30 -0600
Message-ID: <CAL_Jsq+BnPEKkRgQX4+e0MA9dKLVLhy8rVF25Fr9yXL2jp+WLA@mail.gmail.com>
Subject: Re: [PATCH v7 45/50] drivers/of: Avoid recursively calling
 unflatten_dt_node()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+Guenter

On Wed, Nov 4, 2015 at 7:12 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> In current implementation, unflatten_dt_node() is called recursively
> to unflatten device nodes in FDT blob. It's stress to limited stack
> capacity.
>
> This avoids calling the function recursively, meaning the device
> nodes are unflattened in one call on unflatten_dt_node(): two arrays
> are introduced to track the parent path size and the device node of
> current level of depth, which will be used by the device node on next
> level of depth to be unflattened. Also, the parameter "poffset" and
> "fpsize" are unused and dropped.

Do you plan to respin the OF parts at least soon? There's another
problem Guenter found that of_fdt_unflatten_tree is not re-entrant due
to "depth" being static and this series fixes that. So I'd rather
apply this and avoid adding a mutex if possible.

Rob

>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 94 +++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 56 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 173b036..f4793d0 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -355,61 +355,82 @@ static unsigned long populate_node(const void *blob,
>         return fpsize;
>  }
>
> +static void reverse_nodes(struct device_node *parent)
> +{
> +       struct device_node *child, *next;
> +
> +       /* In-depth first */
> +       child = parent->child;
> +       while (child) {
> +               reverse_nodes(child);
> +
> +               child = child->sibling;
> +       }
> +
> +       /* Reverse the nodes in the child list */
> +       child = parent->child;
> +       parent->child = NULL;
> +       while (child) {
> +               next = child->sibling;
> +
> +               child->sibling = parent->child;
> +               parent->child = child;
> +               child = next;
> +       }
> +}
> +
>  /**
>   * unflatten_dt_node - Alloc and populate a device_node from the flat tree
>   * @blob: The parent device tree blob
>   * @mem: Memory chunk to use for allocating device nodes and properties
> - * @poffset: pointer to node in flat tree
>   * @dad: Parent struct device_node
>   * @nodepp: The device_node tree created by the call
> - * @fpsize: Size of the node path up at the current depth.
>   * @dryrun: If true, do not allocate device nodes but still calculate needed
>   * memory size
>   */
>  static void *unflatten_dt_node(const void *blob,
>                                void *mem,
> -                              int *poffset,
>                                struct device_node *dad,
>                                struct device_node **nodepp,
> -                              unsigned long fpsize,
>                                bool dryrun)
>  {
> -       struct device_node *np;
> -       static int depth;
> -       int old_depth;
> -
> -       fpsize = populate_node(blob, *poffset, &mem, dad, fpsize, &np, dryrun);
> -       if (!fpsize)
> -               return mem;
> +       struct device_node *root;
> +       int offset = 0, depth = 0;
> +       unsigned long fpsizes[64];
> +       struct device_node *nps[64];
>
> -       old_depth = depth;
> -       *poffset = fdt_next_node(blob, *poffset, &depth);
> -       if (depth < 0)
> -               depth = 0;
> -       while (*poffset > 0 && depth > old_depth)
> -               mem = unflatten_dt_node(blob, mem, poffset, np, NULL,
> -                                       fpsize, dryrun);
> +       if (nodepp)
> +               *nodepp = NULL;
> +
> +       root = dad;
> +       fpsizes[depth] = dad ? strlen(of_node_full_name(dad)) : 0;
> +       nps[depth++] = dad;
> +       while (offset >= 0 && depth < 64) {
> +               fpsizes[depth] = populate_node(blob, offset, &mem,
> +                                              nps[depth - 1],
> +                                              fpsizes[depth - 1],
> +                                              &nps[depth], dryrun);
> +               if (!fpsizes[depth])
> +                       return mem;
> +
> +               if (!dryrun && nodepp && !*nodepp)
> +                       *nodepp = nps[depth];
> +               if (!dryrun && !root)
> +                       root = nps[depth];
> +
> +               offset = fdt_next_node(blob, offset, &depth);
> +       }
>
> -       if (*poffset < 0 && *poffset != -FDT_ERR_NOTFOUND)
> -               pr_err("unflatten: error %d processing FDT\n", *poffset);
> +       if (offset < 0 && offset != -FDT_ERR_NOTFOUND)
> +               pr_err("%s: Error %d processing FDT\n",
> +                      __func__, offset);
>
>         /*
>          * Reverse the child list. Some drivers assumes node order matches .dts
>          * node order
>          */
> -       if (!dryrun && np->child) {
> -               struct device_node *child = np->child;
> -               np->child = NULL;
> -               while (child) {
> -                       struct device_node *next = child->sibling;
> -                       child->sibling = np->child;
> -                       np->child = child;
> -                       child = next;
> -               }
> -       }
> -
> -       if (nodepp)
> -               *nodepp = np;
> +       if (!dryrun)
> +               reverse_nodes(root);
>
>         return mem;
>  }
> @@ -431,7 +452,6 @@ static void __unflatten_device_tree(const void *blob,
>                              void * (*dt_alloc)(u64 size, u64 align))
>  {
>         unsigned long size;
> -       int start;
>         void *mem;
>
>         pr_debug(" -> unflatten_device_tree()\n");
> @@ -452,8 +472,7 @@ static void __unflatten_device_tree(const void *blob,
>         }
>
>         /* First pass, scan for size */
> -       start = 0;
> -       size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL, NULL, 0, true);
> +       size = (unsigned long)unflatten_dt_node(blob, NULL, NULL, NULL, true);
>         size = ALIGN(size, 4);
>
>         pr_debug("  size is %lx, allocating...\n", size);
> @@ -467,8 +486,7 @@ static void __unflatten_device_tree(const void *blob,
>         pr_debug("  unflattening %p...\n", mem);
>
>         /* Second pass, do actual unflattening */
> -       start = 0;
> -       unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false);
> +       unflatten_dt_node(blob, mem, NULL, mynodes, false);
>         if (be32_to_cpup(mem + size) != 0xdeadbeef)
>                 pr_warning("End of tree marker overwritten: %08x\n",
>                            be32_to_cpup(mem + size));
> --
> 2.1.0
>
