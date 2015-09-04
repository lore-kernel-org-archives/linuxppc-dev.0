Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41C6D1A1E32
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 05:20:15 +1000 (AEST)
Received: by ykcf206 with SMTP id f206so30454682ykc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2015 12:20:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441385411-7624-2-git-send-email-marc.zyngier@arm.com>
References: <1441385411-7624-1-git-send-email-marc.zyngier@arm.com>
 <1441385411-7624-2-git-send-email-marc.zyngier@arm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 4 Sep 2015 14:19:53 -0500
Message-ID: <CAL_JsqKjXqgCvzUcTZkCfgpvub6uh_XzLTfyHpgSZzh4dJaOEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] of/pci: Add of_pci_check_probe_only to parse
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

On Fri, Sep 4, 2015 at 11:50 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Both pci-host-generic and Pseries parse the "linux,pci-probe-only"
> property to engage the PCI_PROBE_ONLY mode, and both have a subtle
> bug that can be triggered if the property has no parameter.
>
> Provide a generic, safe implementation that can be used by both.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/of/of_pci.c    | 28 ++++++++++++++++++++++++++++
>  include/linux/of_pci.h |  3 +++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5..5dd4966 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -118,6 +118,34 @@ int of_get_pci_domain_nr(struct device_node *node)
>  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>
>  /**
> + * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
> + *                           is present and valid
> + *
> + * @node: device tree node that may contain the property (usually "chosen")

This line should be removed. Perhaps Bjorn will fix it up.

Rob
