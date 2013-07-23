Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7460D2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 10:28:44 +1000 (EST)
Received: by mail-ie0-f178.google.com with SMTP id u16so16709809iet.23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 17:28:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51ECD6A4.3050408@asianux.com>
References: <51ECD6A4.3050408@asianux.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Jul 2013 18:28:21 -0600
Message-ID: <CAErSpo6_537nW9+7MtLcA70HhiZwQG3TFCZCUumPk+b8GAgq3Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: platforms: powernv: add '__init' for
 pnv_pci_init_ioda2_phb()
To: Chen Gang <gang.chen@asianux.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 22, 2013 at 12:52 AM, Chen Gang <gang.chen@asianux.com> wrote:
> pnv_pci_init_ioda2_phb() is only used during boot up, so need add
> '__init' to save the related memory, and avoid related warning:
>
>   The function .pnv_pci_init_ioda2_phb() references
>   the function __init .pnv_pci_init_ioda_phb().
>   This is often because .pnv_pci_init_ioda2_phb lacks a __init
>   annotation or the annotation of .pnv_pci_init_ioda_phb is wrong.
>
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Looks right to me.

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 49b57b9..d8140b1 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1266,7 +1266,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
>                 opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
>  }
>
> -void pnv_pci_init_ioda2_phb(struct device_node *np)
> +void __init pnv_pci_init_ioda2_phb(struct device_node *np)
>  {
>         pnv_pci_init_ioda_phb(np, 0, PNV_PHB_IODA2);
>  }
> --
> 1.7.7.6
