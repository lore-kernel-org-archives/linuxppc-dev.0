Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x230.google.com (mail-yk0-x230.google.com
 [IPv6:2607:f8b0:4002:c07::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B28AB1A2369
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 00:02:05 +1000 (AEST)
Received: by ykcf206 with SMTP id f206so43852062ykc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2015 07:02:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441282576-7304-2-git-send-email-marc.zyngier@arm.com>
References: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
 <1441282576-7304-2-git-send-email-marc.zyngier@arm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 3 Sep 2015 09:01:43 -0500
Message-ID: <CAL_JsqJo2vH-i229fqa6T2VBdo65tAjo5q3oNijsLvde+M5+HQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] of/pci: Add of_pci_check_probe_only to parse
 "linux, pci-probe-only"
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 3, 2015 at 7:16 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Both pci-host-generic and Pseries parse the "linux,pci-probe-only"
> property to engage the PCI_PROBE_ONLY mode, and both have a subtle
> bug that can be triggered if the property has no parameter.
>
> Provide a generic, safe implementation that can be used by both.

Sorry, but a couple of other minor things I noticed.

>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/of/of_pci.c    | 31 +++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |  3 +++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5..7876343 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -118,6 +118,37 @@ int of_get_pci_domain_nr(struct device_node *node)
>  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>
>  /**
> + * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
> + *                           is present and valid
> + *
> + * @node: device tree node that may contain the property (usually "chosen")
> + *
> + */
> +void of_pci_check_probe_only(struct device_node *node)

This property is only valid in /chosen, so there's no point passing
of_chosen in and you can constrain it to only look in /chosen.

> +{
> +       u32 val;
> +       int ret;
> +
> +       if (!node)
> +               return;

I believe of_property_read_u32 will check this.

> +
> +       ret = of_property_read_u32(node, "linux,pci-probe-only", &val);
> +       if (ret) {
> +               if (ret == -ENODATA || ret == -EOVERFLOW)
> +                       pr_warn("linux,pci-probe-only without valid value, ignoring\n");
> +               return;
> +       }
> +
> +       if (val)
> +               pci_add_flags(PCI_PROBE_ONLY);
> +       else
> +               pci_clear_flags(PCI_PROBE_ONLY);
> +
> +       pr_info("PCI: PROBE_ONLY %sabled\n", val ? "en" : "dis");
> +}
> +EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
> +
> +/**
>   * of_pci_dma_configure - Setup DMA configuration
>   * @dev: ptr to pci_dev struct of the PCI device
>   *
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 29fd3fe..4c0a617 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -17,6 +17,7 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>  int of_get_pci_domain_nr(struct device_node *node);
>  void of_pci_dma_configure(struct pci_dev *pci_dev);
> +void of_pci_check_probe_only(struct device_node *node);
>  #else
>  static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
>  {
> @@ -53,6 +54,8 @@ of_get_pci_domain_nr(struct device_node *node)
>  }
>
>  static inline void of_pci_dma_configure(struct pci_dev *pci_dev) { }
> +
> +static inline void of_pci_check_probe_only(struct device_node *node) { }
>  #endif
>
>  #if defined(CONFIG_OF_ADDRESS)
> --
> 2.1.4
>
