Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 65BBE67C3E
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 08:52:04 +1100 (EST)
Date: Mon, 11 Dec 2006 15:51:55 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Message-Id: <20061211155155.26868ca6.kim.phillips@freescale.com>
In-Reply-To: <91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 10 Dec 2006 21:41:24 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Dec 9, 2006, at 1:14 AM, Benjamin Herrenschmidt wrote:
> 
> > On Fri, 2006-12-08 at 19:07 -0600, Kim Phillips wrote:
> >> Eliminate code redundancy.  mpc83[246]x_{mds,itx,sys,pb} files merged
> >> into a single setup.c.  machine_probe, instead of using the model  
> >> property,
> >> checks the compatible property for "MPC83xx" (dts files updated  
> >> appropriately).
> >> This patch also utilizes of_platform_bus_probe() in lieu of manually
> >> calling of_platform_device_create for each ucc_geth device.
> >>
> >> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> 
> Nack on the patch.
> 
> > I am not completely certain this is the right approach.
> >
> > While factoring code is good, I think that every single board should
> > have it's own ppc_md, though you can definitely provide "common"
> > functions for mpc83xx that can optinally be used by those different
> > boards.
> >
> > Maybe put all the freescale ones in one file if you want...
> >
> > The rationale here is that while your approach is fine for your eval
> > boards, I don't think it's good for embedded customers. They may want
> > more complex platforms, with their own directory even if they have  
> > a lot
> > of custom stuff on the board while still possibly picking some of your
> > "common" code (and their board shouldn't match your overly generic
> > probe() implementation).
> >
> > Cheers,
> > Ben.
> 
> I'm with Ben on this.  I think consolidating the code that is common  
> is fine, but we should have a define_machine() per board.  You can  
> put them all in one mpc83xx/fsl.c
> 
so the contents of 83xx/fsl.c would look like:
#ifdef CONFIG_MPC834x_SYS
define_machine(mpc834x_sys) {
	.name 		= "MPC834x SYS",
	.probe 		= mpc83xx_probe,
	.setup_arch 	= mpc83xx_setup_arch,
	.init_IRQ 	= mpc83xx_init_IRQ,
	.get_irq 	= ipic_get_irq,
	.restart 	= mpc83xx_restart,
	.time_init 	= mpc83xx_time_init,
	.calibrate_decr	= generic_calibrate_decr,
	.progress 	= udbg_progress,
};
#else
#ifdef CONFIG_MPC834x_ITX
define_machine(mpc83xx) {
	.name 		= "MPC834x ITX",
<rest is the same>
#else
..and so on and so forth for CONFIG_MPC8360E_PB, CONFIG_MPC832x_MDS, and now CONFIG_MPC831x_RDB.  So the only thing that changes is the name?  And perhaps the _probe function?  That's still pretty redundant, esp. considering the source of the name to match in the dt is easily modifiable.  And it's not as if other platforms (52xx, 86xx, pasemi etc.) don't use of_flat_dt_is_compatible.

All 83xx platform code, define_machine included, is exactly the same on all boards, modulo the QE stuff which is ifdef protected and easily configured.  All board differences can be specified in the device tree and/or handled with proper kernel configuration.  If an embedded customer wants, they can configure their kernel based on the various 83xx defconfigs, customize their _probe() to match their device tree, all at will, just as before.  I'm concerned because 83xx has the capability of being a single kernel image basically for free (we just need to clean some things up in the ucc_geth driver first).

That said, I'm not an embedded customer, and the motivation for this patch was to prep 83xx platform filespace so that we don't have to:

sed s/834/831/ < mpc834x_itx.c > mpc831x_rdb.c
sed s/834/831/ < mpc834x_itx.h > mpc831x_rdb.h

and copy and paste the Makefile and Kconfig lines, which just feels like a terrible thing to do (and keep on doing).

Kim 
