Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB2BF1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 07:08:31 +1000 (AEST)
Received: by ykdt205 with SMTP id t205so79789235ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 14:08:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439569159-10051-2-git-send-email-marc.zyngier@arm.com>
References: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
 <1439569159-10051-2-git-send-email-marc.zyngier@arm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 14 Aug 2015 16:08:10 -0500
Message-ID: <CAL_JsqL7VPB6nc-zRYm_73ZSgYVq_+a6sW_XZZ_LRaUXf4jTng@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] of/pci: Add of_pci_check_probe_only to parse
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

On Fri, Aug 14, 2015 at 11:19 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Both pci-host-generic and Pseries parse the "linux,pci-probe-only"
> to engage the PCI_PROBE_ONLY mode, and both have a subtle bug that
> can be triggered if the property has no parameter.

Humm, I bet we could break a lot of machines if we fixed the core code
to properly make pp->value NULL when there is no value.

> Provide a generic implementation that can be used by both.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/of/of_pci.c    | 30 ++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |  3 +++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5..a4e29ff 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -118,6 +118,36 @@ int of_get_pci_domain_nr(struct device_node *node)
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
> +{
> +       const int *prop;
> +       int len;
> +
> +       if (!node)
> +               return;
> +
> +       prop = of_get_property(node, "linux,pci-probe-only", &len);

It is preferred to use of_property_read_u32 to avoid just these types
of problems.

Rob
