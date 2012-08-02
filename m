Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4D2FD2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 22:24:01 +1000 (EST)
Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343907741-20589-4-git-send-email-B38951@freescale.com>
Date: Thu, 2 Aug 2012 07:23:37 -0500
Message-Id: <A4B0DB85-7B49-4748-8B94-0E1F1B7B663A@kernel.crashing.org>
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-4-git-send-email-B38951@freescale.com>
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


On Aug 2, 2012, at 6:42 AM, Jia Hongtao wrote:

> We unified the Freescale pci/pcie initialization by changing the =
fsl_pci
> to a platform driver. In previous PCI code architecture the =
initialization
> routine is called at board_setup_arch stage. Now the initialization is =
done
> in probe function which is architectural better. Also It's convenient =
for
> adding PM support for PCI controller in later patch.
>=20
> Now we registered pci controllers as platform devices. So we combine =
two
> initialization code as one platform driver.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   32 ++--------
> arch/powerpc/sysdev/fsl_pci.c            |  102 =
++++++++++++++++++-----------
> arch/powerpc/sysdev/fsl_pci.h            |    6 +-
> drivers/edac/mpc85xx_edac.c              |   43 ++++---------
> 4 files changed, 83 insertions(+), 100 deletions(-)

You need to convert all boards to use fsl_pci_init before this patch.  =
Otherwise we'll end up with PCI getting initialized twice on boards.

- k=
