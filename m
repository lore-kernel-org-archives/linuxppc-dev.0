Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 363D92C00EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 10:25:22 +1000 (EST)
Message-ID: <1378859106.12204.381.camel@snotra.buserror.net>
Subject: Re: [PATCH][RFC][v2] pci: fsl: rework PCIe driver compatible with
 Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Date: Tue, 10 Sep 2013 19:25:06 -0500
In-Reply-To: <1377686572-3981-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1377686572-3981-1-git-send-email-Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-28 at 18:42 +0800, Minghuan Lian wrote:
> The Freescale's Layerscape series processors will use ARM cores.
> The LS1's PCIe controllers is the same as T4240's. So it's better
> the PCIe controller driver can support PowerPC and ARM
> simultaneously. This patch is for this purpose. It derives
> the common functions from arch/powerpc/sysdev/fsl_pci.c to
> drivers/pci/host/pcie-fsl.c and leaves several platform-dependent
> functions which should be implemented in platform files.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> Based on upstream master 3.11-rc7
> The function has been tested on MPC8315ERDB MPC8572DS P5020DS P3041DS
> and T4240QDS boards 
> 
> Change log:
> v2:
> 1. Use 'pci' instead of 'pcie' in new file name and file contents. 
> 2. Use iowrite32be()/iowrite32() instead of out_be32/le32()
> 3. Fix ppc_md.dma_set_mask setting
> 4. Synchronizes host->first_busno and pci->first_busno.
> 5. Fix PCI IO space settings
> 6. Some small changes according to Scott's comments.

Could you please split this into two patches, where one moves the code,
and the other makes changes to it?

-Scott
