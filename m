Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F59C1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:04:39 +1000 (EST)
Subject: Re: [PATCH 01/13] powerpc/e500: Save SPEFCSR in flush_spe_to_thread()
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110517233551.GA3511@schlenkerla.am.freescale.net>
Date: Thu, 19 May 2011 01:04:28 -0500
Message-Id: <DC207279-54AC-41CC-BF21-25181D16A6AB@kernel.crashing.org>
References: <20110517233551.GA3511@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 17, 2011, at 6:35 PM, Scott Wood wrote:

> From: yu liu <yu.liu@freescale.com>
>=20
> giveup_spe() saves the SPE state which is protected by MSR[SPE].
> However, modifying SPEFSCR does not trap when MSR[SPE]=3D0.
> And since SPEFSCR is already saved/restored in _switch(),
> not all the callers want to save SPEFSCR again.
> Thus, saving SPEFSCR should not belong to giveup_spe().
>=20
> This patch moves SPEFSCR saving to flush_spe_to_thread(),
> and cleans up the caller that needs to save SPEFSCR accordingly.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This is a resending of http://patchwork.ozlabs.org/patch/88677/
>=20
> Kumar, please ack to go via kvm.  This is holding up the rest of the =
SPE
> patches, which in turn are holding up the MMU patches due to both
> touching the MSR update code.
>=20
> arch/powerpc/kernel/head_fsl_booke.S |    2 --
> arch/powerpc/kernel/process.c        |    1 +
> arch/powerpc/kernel/traps.c          |    5 +----
> 3 files changed, 2 insertions(+), 6 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

[ Alex, let me know if you want this via my powerpc.git tree or your kvm =
tree ]

- k=
