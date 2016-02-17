Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBC1C1A0356
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 01:31:04 +1100 (AEDT)
Received: by mail-yk0-x229.google.com with SMTP id z7so7185723yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 06:31:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-41-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-41-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 17 Feb 2016 08:30:42 -0600
Message-ID: <CAL_Jsq++L-D=RD6ZYK=CPnhqcZbhEbxsKk3xT-vK2R=Qe9Z_pg@mail.gmail.com>
Subject: Re: [PATCH v8 40/45] drivers/of: Split unflatten_dt_node()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
 Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> The function unflatten_dt_node() is called recursively to unflatten
> device nodes and properties in the FDT blob. It looks complicated
> and hard to be understood.
>
> This splits the function into 3 functions: populate_properties(),
> populate_node() and unflatten_dt_node(). populate_properties(),
> which is called by populate_node(), creates properties for the
> indicated device node. The later one creates the device nodes
> from FDT blob. populate_node() gets the offset in FDT blob for
> next device nodes and then calls populate_node(). No logical
> changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 249 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 147 insertions(+), 102 deletions(-)

One nit, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

[...]

> +               /* And we process the "ibm,phandle" property
> +                * used in pSeries dynamic device tree
> +                * stuff
> +                */
> +               if (!strcmp(pname, "ibm,phandle"))
> +                       np->phandle = be32_to_cpup(val);
> +
> +               pp->name   = (char *)pname;
> +               pp->length = sz;
> +               pp->value  = (__be32 *)val;

This cast should not be needed.

> +               *pprev     = pp;
> +               pprev      = &pp->next;
> +       }
