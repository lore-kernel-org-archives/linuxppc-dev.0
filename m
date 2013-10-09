Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B4202C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 01:54:14 +1100 (EST)
Received: by mail-ie0-f169.google.com with SMTP id tp5so2108367ieb.28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Oct 2013 07:54:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52552C8D.1050303@freescale.com>
References: <1380531175-14836-1-git-send-email-Minghuan.Lian@freescale.com>
 <CAErSpo7LXqXmrw1gPwKHsJkKaAcDr2W_+tcC8b9T_5Mab1Arnw@mail.gmail.com>
 <52552C8D.1050303@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Oct 2013 08:53:48 -0600
Message-ID: <CAErSpo7K5CCqDvHiKwypWqNxiyZ8n1MXcsjK66d=NzGSV0nYOg@mail.gmail.com>
Subject: Re: [PATCH 1/2][v2] pci: fsl: derive the common PCI driver to
 drivers/pci/host
To: Lian Minghuan-b31939 <B31939@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Zang Roy-R61911 <r61911@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 9, 2013 at 4:14 AM, Lian Minghuan-b31939
<B31939@freescale.com> wrote:

>  arch/powerpc/sysdev/fsl_pci.c                      | 521 +-----------------
>  arch/powerpc/sysdev/fsl_pci.h                      |  89 ----
>  .../fsl_pci.c => drivers/pci/host/pci-fsl-common.c | 591
> +--------------------
>  .../fsl_pci.h => include/linux/fsl/pci-common.h    |  45 +-
>
> Is there any way to avoid putting this file in include/linux?  I know
> you want to share it beyond PowerPC, and I know there are similar
> examples there already, but this is all arch-specific or
> chipset-specific stuff that seems like it should be in some
> not-so-public place.  It doesn't seem scalable to add an include/linux
> subdirectory for every chipset that might be shared across
> architectures.
>
> [Minghuan] I can move pci-common.h to drivers/pci/host/
> But in arch/powerpc/sysdev/fsl_pci.c I must include the header file
> like this:
> #include "../../../drivers/pci/host/pci-fsl-common.h".
> How about this modification?

Given the existence of include/linux/fsl/ even before this patch, I'm
OK with it as-is.

After you work through Scott's comments on [2/2] and get his ack, I'll
merge the whole bundle as a group.

Bjorn
