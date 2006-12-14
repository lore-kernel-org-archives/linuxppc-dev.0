Return-Path: <yang.reeve@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.230])
	by ozlabs.org (Postfix) with ESMTP id 5E8CE67CCE
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 07:39:59 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id q12so104456qbq
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:39:57 -0800 (PST)
Message-ID: <198592450612141239s539e6702m810b4b78ab43ff59@mail.gmail.com>
Date: Thu, 14 Dec 2006 20:39:56 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: "Ben Warren" <bwarren@qstreams.com>
Subject: Re: [spi-devel-general] [PATCH] Adapt spi_mpc83xx SPI driver for 832x
In-Reply-To: <859707.81440.qm@web314.biz.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <198592450612141159u6ad69302m86f1678ca5e1e62b@mail.gmail.com>
	<859707.81440.qm@web314.biz.mail.mud.yahoo.com>
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi ben, what you have done is exactly I'm trying to do. (I'm using
2.6.14 too, it's a typo in previous email). Could you elighten me what
board specific things need to be done? Following are the things I have
done.

********************************
<<< file 1: /vobs/kernel/linux-2.6.14/arch/ppc/syslib/mpc83xx_devices.c@@/main/linux-2.6.14_int/ryang_ATS89_1.0.0_dev_2/0
>>> file 2: mpc83xx_devices.c
********************************
-----[after 66 inserted 67-69]-----
> /* init this in board specific code */
> static struct fsl_spi_platform_data mpc83xx_spi_pdata = { 0 };
>
====> [reeve] pstruct platform_device ppc_sys_platform_devices[] = {

-----[after 217 inserted 221-238]-----
> 				.flags	= IORESOURCE_IRQ,
> 			},
> 		},
> 	},
> 	[MPC83xx_SPI] = {
> 		.name = "fsl-spi",
> 		.id	= 1,
>         .dev.platform_data = &mpc83xx_spi_pdata,
> 		.num_resources	 = 2,
> 		.resource = (struct resource[]) {
> 			{
> 				.start	= 0x7000,
> 				.end	= 0x7fff,
> 				.flags	= IORESOURCE_MEM,
> 			},
> 			{
> 				.start	= MPC83xx_IRQ_SPI,
> 				.end	= MPC83xx_IRQ_SPI,

In function mpc834x_sys_setup_arch, I add setup for spi platform data:

-----[after 175 inserted 203-212]-----
>     /* setup board specific spi information */
>     spi_pdata = (struct fsl_spi_platform_data *)ppc_sys_get_pdata(MPC83xx_SPI);
>     if (spi_pdata) {
>         spi_pdata->initial_spmode = 0;
>         spi_pdata->bus_num = 1;
>         spi_pdata->max_chipselect = 1;
>         spi_pdata->activate_cs = at10408_spi_activate_cs;
>         spi_pdata->deactivate_cs = at10408_spi_deactivate_cs;

We're doing chip select through CPLD gpio pins.

That's all I could image for board specific for fsl spi controller.
Did I miss anything?

- Reeve
On 12/14/06, Ben Warren <bwarren@qstreams.com> wrote:
> Reeve,
>
> --- Reeve Yang <yang.reeve@gmail.com> wrote:
>
> > Hello, I'm working on the same thing but our board
> > is using MPC8343E
> > processor. Should the same patch be applied? If so
> > could someone post
> > a complete and clean patch? Though our kernel is
> > 2.6.13, I back ported
> > spi_mpc83xx but it's not working (the fsl controller
> > cannot be
> > detected). I'm hoping this patch could help on that
> > ...
> >
>
> I had the mpc83xx driver working on an MPC8349
> processor under 2.6.14 a while ago.  The driver's very
> small but requires a fair amount of board specific
> initialization code.  Are you sure you added the
> proper platform resources, etc?
>
> regards,
> Ben
>
