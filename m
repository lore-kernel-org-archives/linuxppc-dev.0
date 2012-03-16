Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B176FB6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 08:03:39 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1328861387-31390-1-git-send-email-shuo.liu@freesacle.com>
Date: Fri, 16 Mar 2012 16:03:34 -0500
Message-Id: <5A2DE148-B029-4FF0-A49B-29172F234874@kernel.crashing.org>
References: <1328861387-31390-1-git-send-email-shuo.liu@freesacle.com>
To: "<shuo.liu@freesacle.com>" <shuo.liu@freesacle.com>
Cc: Zhao Chenhui <b35336@freescale.com>, Liu Shuo <b35362@freescale.com>,
 r61911@freescale.com, Liu Shuo <shuo.liu@freescale.com>,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 10, 2012, at 2:09 AM, <shuo.liu@freesacle.com> =
<shuo.liu@freesacle.com> wrote:

> From: Liu Shuo <shuo.liu@freescale.com>
>=20
> A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> goes down. when the link goes down, Non-posted transactions issued
> via the ATMU requiring completion result in an instruction stall.
> At the same time a machine-check exception is generated to the core
> to allow further processing by the handler. We implements the handler
> which skips the instruction caused the stall.
>=20
> Signed-off-by: Zhao Chenhui <b35336@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Liu Shuo <b35362@freescale.com>
> ---
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |    2 +-
> arch/powerpc/kernel/traps.c               |    3 ++
> arch/powerpc/sysdev/fsl_pci.c             |   36 =
+++++++++++++++++++++++++++++
> arch/powerpc/sysdev/fsl_pci.h             |    6 +++++
> 4 files changed, 46 insertions(+), 1 deletions(-)

Should we have a check to make sure the hose is for PCIe and not PCI?

- k=
