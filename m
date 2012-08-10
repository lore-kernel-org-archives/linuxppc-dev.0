Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76AA52C05A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 23:00:35 +1000 (EST)
Subject: Re: [PATCH V5 2/3] powerpc/swiotlb: Enable at early stage and disable
 if not necessary
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343988851-884-3-git-send-email-B38951@freescale.com>
Date: Fri, 10 Aug 2012 07:58:33 -0500
Message-Id: <9234AF32-E2B2-4A54-9F8D-40E5A9FCB211@kernel.crashing.org>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-3-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 3, 2012, at 5:14 AM, Jia Hongtao wrote:

> Remove the dependency on PCI initialization for SWIOTLB initialization.
> So that PCI can be initialized at proper time.
> 
> SWIOTLB is partly determined by PCI inbound/outbound map which is assigned
> in PCI initialization. But swiotlb_init() should be done at the stage of
> mem_init() which is much earlier than PCI initialization. So we reserve the
> memory for SWIOTLB first and free it if not necessary.
> 
> All boards are converted to fit this change.
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/include/asm/swiotlb.h       |    6 ++++++
> arch/powerpc/kernel/dma-swiotlb.c        |   20 ++++++++++++++++++++
> arch/powerpc/mm/mem.c                    |    3 +--
> arch/powerpc/platforms/44x/currituck.c   |   10 ++--------
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |    1 +
> arch/powerpc/platforms/85xx/qemu_e500.c  |    1 +
> arch/powerpc/sysdev/fsl_pci.c            |    5 +----
> 7 files changed, 32 insertions(+), 14 deletions(-)

applied to next

- k
