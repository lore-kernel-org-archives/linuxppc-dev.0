Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D83B61A0808
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 00:20:06 +1000 (AEST)
Received: by ykax123 with SMTP id x123so63659735yka.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2015 07:20:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-41-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-41-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 6 Aug 2015 09:19:45 -0500
Message-ID: <CAL_JsqK940pWJXazofnup8MHNTVO+0_1Zzcos4+uhhtwi=gwGQ@mail.gmail.com>
Subject: Re: [PATCH v6 40/42] drivers/of: Return allocated memory chunk from
 of_fdt_unflatten_tree()
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
> This changes of_fdt_unflatten_tree() so that it returns the allocated
> memory chunk for unflattened device-tree, which can be released once
> it's obsoleted.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/fdt.c       | 11 ++++++-----
>  include/linux/of_fdt.h |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 074870a..8e1ba7e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -408,7 +408,7 @@ static void *unflatten_dt_node(const void *blob,
>   * @dt_alloc: An allocator that provides a virtual address to memory
>   * for the resulting tree
>   */
> -static void __unflatten_device_tree(const void *blob,
> +static void *__unflatten_device_tree(const void *blob,
>                              struct device_node *dad,
>                              struct device_node **mynodes,
>                              void * (*dt_alloc)(u64 size, u64 align))
> @@ -421,7 +421,7 @@ static void __unflatten_device_tree(const void *blob,
>
>         if (!blob) {
>                 pr_debug("No device tree pointer\n");
> -               return;
> +               return NULL;
>         }
>
>         pr_debug("Unflattening device tree:\n");
> @@ -431,7 +431,7 @@ static void __unflatten_device_tree(const void *blob,
>
>         if (fdt_check_header(blob)) {
>                 pr_err("Invalid device tree blob header\n");
> -               return;
> +               return NULL;
>         }
>
>         /* First pass, scan for size */
> @@ -458,6 +458,7 @@ static void __unflatten_device_tree(const void *blob,
>                            be32_to_cpup(mem + size));
>
>         pr_debug(" <- unflatten_device_tree()\n");
> +       return mem;
>  }
>
>  static void *kernel_tree_alloc(u64 size, u64 align)
> @@ -473,11 +474,11 @@ static void *kernel_tree_alloc(u64 size, u64 align)
>   * pointers of the nodes so the normal device-tree walking functions
>   * can be used.
>   */
> -void of_fdt_unflatten_tree(const unsigned long *blob,
> +void *of_fdt_unflatten_tree(const unsigned long *blob,
>                         struct device_node *dad,
>                         struct device_node **mynodes)
>  {
> -       __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
> +       return __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
>  }
>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 3644960..00db279 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -37,7 +37,7 @@ extern bool of_fdt_is_big_endian(const void *blob,
>                                  unsigned long node);
>  extern int of_fdt_match(const void *blob, unsigned long node,
>                         const char *const *compat);
> -extern void of_fdt_unflatten_tree(const unsigned long *blob,
> +extern void *of_fdt_unflatten_tree(const unsigned long *blob,
>                                struct device_node *dad,
>                                struct device_node **mynodes);
>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
