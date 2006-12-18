Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0740A67E08
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 04:04:46 +1100 (EST)
In-Reply-To: <17798.9347.907648.418957@cargo.ozlabs.ibm.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
	<17798.9347.907648.418957@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D0C92992-E647-4AED-A9ED-2886B603A864@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Mon, 18 Dec 2006 11:04:55 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 17, 2006, at 11:17 PM, Paul Mackerras wrote:

> Kim Phillips writes:
>
>> so the contents of 83xx/fsl.c would look like:
>> #ifdef CONFIG_MPC834x_SYS
>> define_machine(mpc834x_sys) {
>> 	.name 		= "MPC834x SYS",
>> 	.probe 		= mpc83xx_probe,
>> 	.setup_arch 	= mpc83xx_setup_arch,
>> 	.init_IRQ 	= mpc83xx_init_IRQ,
>> 	.get_irq 	= ipic_get_irq,
>> 	.restart 	= mpc83xx_restart,
>> 	.time_init 	= mpc83xx_time_init,
>> 	.calibrate_decr	= generic_calibrate_decr,
>> 	.progress 	= udbg_progress,
>> };
>> #else
>
> Why do you have this #else here?  Doesn't it just restrict you for no
> gain?

I think you're looking at an old version of the patch.

>> #ifdef CONFIG_MPC834x_ITX
>> define_machine(mpc83xx) {
>> 	.name 		= "MPC834x ITX",
>> <rest is the same>
>
> Your probe function can set ppc_md.name to whatever it wants.  So you
> could have a define_machine(fsl_83xx_eval_board) whose probe function
> would pick up the actual board name from the device tree (e.g. the
> root node's model property), put that in ppc_md and return 1 (assuming
> of course that the device tree looks like one of your boards).
>
> Paul.
