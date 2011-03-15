Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2822B7416
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:07:24 +1100 (EST)
Subject: Re: [PATCH] e500: Erratum cpu a005 workaround
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1295935333-13045-1-git-send-email-yu.liu@freescale.com>
Date: Tue, 15 Mar 2011 10:07:18 -0500
Message-Id: <518DEEA6-64ED-441C-B795-BCAC9913CDB4@kernel.crashing.org>
References: <1295935333-13045-1-git-send-email-yu.liu@freescale.com>
To: Liu Yu <yu.liu@freescale.com>
Cc: B11780@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 25, 2011, at 12:02 AM, Liu Yu wrote:

> This errata can occur if a single-precision floating-point, =
double-precision
> floating-point or vector floating-point instruction on a mispredicted =
branch
> path signals one of the floating-point data interrupts which are =
enabled by the
> SPEFSCR (FINVE, FDBZE, FUNFE or FOVFE bits).  This interrupt must be =
recorded
> in a one-cycle window when the misprediction is resolved.  If this =
extremely
> rare event should occur, the result could be:
>=20
> The SPE Data Exception from the mispredicted path may be reported
> erroneously if a single-precision floating-point, double-precision
> floating-point or vector floating-point instruction is the second =
instruction
> on the correct branch path.
>=20
> According to errata description, some efp instructions
> which are not supposed to trigger SPE exceptions
> can trigger the exceptions in this case.
> However, as we haven't emulated these instructions here,
> a signal will send to userspace, and userspace application would exit.
>=20
> This patch re-issue the efp instruction that we haven't emulated,
> so that hardware can properly execute it again if this case happen.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> This is an erratum workaround patch.
> It would be better if the patch can go into 2.6.38.
>=20
> arch/powerpc/include/asm/reg.h   |    2 +
> arch/powerpc/math-emu/math_efp.c |   53 =
+++++++++++++++++++++++++++++++++++++-
> 2 files changed, 54 insertions(+), 1 deletions(-)

applied

- k=
