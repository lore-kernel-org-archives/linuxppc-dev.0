Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17798.9347.907648.418957@cargo.ozlabs.ibm.com>
Date: Mon, 18 Dec 2006 16:17:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
In-Reply-To: <20061211155155.26868ca6.kim.phillips@freescale.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips writes:

> so the contents of 83xx/fsl.c would look like:
> #ifdef CONFIG_MPC834x_SYS
> define_machine(mpc834x_sys) {
> 	.name 		= "MPC834x SYS",
> 	.probe 		= mpc83xx_probe,
> 	.setup_arch 	= mpc83xx_setup_arch,
> 	.init_IRQ 	= mpc83xx_init_IRQ,
> 	.get_irq 	= ipic_get_irq,
> 	.restart 	= mpc83xx_restart,
> 	.time_init 	= mpc83xx_time_init,
> 	.calibrate_decr	= generic_calibrate_decr,
> 	.progress 	= udbg_progress,
> };
> #else

Why do you have this #else here?  Doesn't it just restrict you for no
gain?

> #ifdef CONFIG_MPC834x_ITX
> define_machine(mpc83xx) {
> 	.name 		= "MPC834x ITX",
> <rest is the same>

Your probe function can set ppc_md.name to whatever it wants.  So you
could have a define_machine(fsl_83xx_eval_board) whose probe function
would pick up the actual board name from the device tree (e.g. the
root node's model property), put that in ppc_md and return 1 (assuming
of course that the device tree looks like one of your boards).

Paul.
