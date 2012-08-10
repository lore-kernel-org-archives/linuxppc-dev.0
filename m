Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B94F2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 23:00:11 +1000 (EST)
Subject: Re: [PATCH 3/3 v5] powerpc/mpic: FSL MPIC error interrupt support.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344398769-31536-1-git-send-email-Varun.Sethi@freescale.com>
Date: Fri, 10 Aug 2012 07:58:17 -0500
Message-Id: <E58FC499-AF6C-4658-BBB9-438067B4F0DD@kernel.crashing.org>
References: <1344398769-31536-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 7, 2012, at 11:06 PM, Varun Sethi wrote:

> All SOC device error interrupts are muxed and delivered to the core
> as a single MPIC error interrupt. Currently all the device drivers
> requiring access to device errors have to register for the MPIC error
> interrupt as a shared interrupt.
>=20
> With this patch we add interrupt demuxing capability in the mpic =
driver,
> allowing device drivers to register for their individual error =
interrupts.
> This is achieved by handling error interrupts in a cascaded fashion.
>=20
> MPIC error interrupt is handled by the "error_int_handler", which
> subsequently demuxes it using the EISR and delivers it to the =
respective
> drivers.=20
>=20
> The error interrupt capability is dependent on the MPIC EIMR register,
> which was introduced in FSL MPIC version 4.1 (P4080 rev2). So, error
> interrupt demuxing capability is dependent on the MPIC version and can
> be used for versions >=3D 4.1.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>
> [In the initial version of the patch we were using handle_simple_irq
> as the handler for cascaded error interrupts, this resulted
> in issues in case of threaded isrs (with RT kernel). This issue was
> debugged by Bogdan and decision was taken to use the handle_level_irq
> handler]
> ---
> arch/powerpc/include/asm/mpic.h    |   14 ++++
> arch/powerpc/sysdev/Makefile       |    2 +-
> arch/powerpc/sysdev/fsl_mpic_err.c |  149 =
++++++++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/mpic.c         |   44 ++++++++++-
> arch/powerpc/sysdev/mpic.h         |   22 +++++
> 5 files changed, 229 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_mpic_err.c

applied to next

- k
