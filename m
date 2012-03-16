Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 49536B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 07:41:26 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: check the return value of fsl_add_bridge
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326087931-2515-1-git-send-email-r66093@freescale.com>
Date: Fri, 16 Mar 2012 15:41:20 -0500
Message-Id: <89D5B60B-76A1-4691-AF0A-FBAC0CBC9528@kernel.crashing.org>
References: <1326087931-2515-1-git-send-email-r66093@freescale.com>
To: "<r66093@freescale.com>" <r66093@freescale.com>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 8, 2012, at 11:45 PM, <r66093@freescale.com> =
<r66093@freescale.com> wrote:

> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>=20
> For all mpc85xx DS/MDS boards, we should check the return value from
> function "fsl_add_bridge", otherwise, when pcie node status is =
disabled,
> the kernel will panic when perform the function =
"pci_find_hose_for_OF_device"
> because the hose controller is NULL.
>=20
> below is the call trace log:
> NIP: c05bca80 LR: c05bca78 CTR: c000ec54
> REGS: c0615eb0 TRAP: 0300   Not tainted  =
(3.2.0-rc3-00090-gfa8cbaa-dirty)
> MSR: 00021000 <CE,ME>  CR: 84044022  XER: 20000000
> DEAR: 00000110, ESR: 00000000
> TASK =3D c05e8380[0] 'swapper' THREAD: c0614000
> GPR00: c05bca70 c0615f60 c05e8380 00000000 c0550a08 ffffffff c0613140 =
c061314c
> GPR08: 00000000 00000000 00000286 c0620000 84044022 1009d368 00000000 =
00000000
> GPR16: c0000a00 00000014 3fffffff 03ff9000 00000015 7ff3a724 c0614000 =
00000000
> GPR24: 00000000 00000000 00008000 c0550a08 c0534808 efbe3834 00000000 =
ffffffff
> NIP [c05bca80] p1022_ds_setup_arch+0xa8/0x1ac
> LR [c05bca78] p1022_ds_setup_arch+0xa0/0x1ac
> Call Trace:
> [c0615f60] [c05bca70] p1022_ds_setup_arch+0x98/0x1ac (unreliable)
> [c0615fb0] [c05b88e0] setup_arch+0x1e8/0x224
> [c0615fc0] [c05b4524] start_kernel+0x84/0x2d8
> [c0615ff0] [c00003c4] skpinv+0x2b0/0x2ec
> Instruction dump:
> 5400033e 7f80d000 7fa3eb78 40be0010 38800001 4bffedf1 48000008 =
4bffede9
> 7fa3eb78 4ba53119 7f64db78 7c691b78
> 81830114 7f85e378 8149010c
> ---[ end trace 31fd0ba7d8756001 ]---
> Kernel panic - not syncing: Attempted to kill the idle task!
> Call Trace:
> [c0615d90] [c0007b74] show_stack+0x44/0x154 (unreliable)
> [c0615dd0] [c04495b8] panic+0xa4/0x1d4
> [c0615e20] [c003e7b8] do_exit+0x588/0x614
> [c0615e70] [c000a00c] die+0xc8/0x198
> [c0615e90] [c0011a1c] bad_page_fault+0xb4/0xfc
> [c0615ea0] [c000e2e0] handle_page_fault+0x7c/0x80
> --- Exception: 300 at p1022_ds_setup_arch+0xa8/0x1ac
>    LR =3D p1022_ds_setup_arch+0xa0/0x1ac
> [c0615f60] [c05bca70] p1022_ds_setup_arch+0x98/0x1ac (unreliable)
> [c0615fb0] [c05b88e0] setup_arch+0x1e8/0x224
> [c0615fc0] [c05b4524] start_kernel+0x84/0x2d8
> [c0615ff0] [c00003c4] skpinv+0x2b0/0x2ec
>=20
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
> arch/powerpc/platforms/85xx/corenet_ds.c   |    5 ++++-
> arch/powerpc/platforms/85xx/mpc8536_ds.c   |   13 +++++++++----
> arch/powerpc/platforms/85xx/mpc85xx_ds.c   |   13 +++++++++----
> arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   13 +++++++++----
> arch/powerpc/platforms/85xx/p1022_ds.c     |   13 +++++++++----
> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   14 ++++++++++----
> 6 files changed, 50 insertions(+), 21 deletions(-)

We need to fixup 85xx/ge_imp3a.c as well.

>=20
> diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c =
b/arch/powerpc/platforms/85xx/corenet_ds.c
> index c48b661..9d72e3a 100644
> --- a/arch/powerpc/platforms/85xx/corenet_ds.c
> +++ b/arch/powerpc/platforms/85xx/corenet_ds.c
> @@ -85,8 +85,11 @@ void __init corenet_ds_setup_arch(void)
> 	for_each_node_by_type(np, "pci") {
> 		if (of_device_is_compatible(np, "fsl,p4080-pcie") ||
> 		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2")) =
{
> -			fsl_add_bridge(np, 0);
> +			if (fsl_add_bridge(np, 0) < 0)
> +				continue;
> 			hose =3D pci_find_hose_for_OF_device(np);
> +			if (!hose)
> +				continue;
> 			max =3D min(max, hose->dma_window_base_cur +
> 					hose->dma_window_size);
> 		}

Can we just make this:

	fsl_add_bridge()
	hose =3D pci_find_hose_for_OF_device(np);
	if (hose)
		max =3D min(...);

?

- k
