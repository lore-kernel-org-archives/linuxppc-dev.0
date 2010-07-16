Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 7D8E0B6EF1
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 06:12:35 +1000 (EST)
Received: from mail53-va3 (localhost.localdomain [127.0.0.1])	by
	mail53-va3-R.bigfish.com (Postfix) with ESMTP id 47F1114282AA	for
	<linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 20:12:32 +0000 (UTC)
Received: from VA3EHSMHS019.bigfish.com (unknown [10.7.14.244])	by
	mail53-va3.bigfish.com (Postfix) with ESMTP id E504DD80052	for
	<linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 20:12:31 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6GKCQSP021295	for <linuxppc-dev@ozlabs.org>;
	Fri, 16 Jul 2010 13:12:26 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6GKNCFF012503	for <linuxppc-dev@ozlabs.org>;
	Fri, 16 Jul 2010 15:23:12 -0500 (CDT)
Date: Fri, 16 Jul 2010 15:12:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH v2] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers
Message-ID: <20100716151224.21d499a3@schlenkerla.am.freescale.net>
In-Reply-To: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
References: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, linuxppc-dev@ozlabs.org,
	Doug Thompson <dougthompson@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Jul 2010 22:25:07 +0400
Anton Vorontsov <avorontsov@mvista.com> wrote:

> Simply add proper IDs into the device table.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> 
> It appears that the driver has two device ID tables. :-)
> So, my previous attempt enabled only half of the functionality.
> 
> Andrew,
> 
> Can you please replace
> 
>   edac-mpc85xx-add-support-for-mpc8569-edac-controllers.patch
> 
> with this patch? It also adds some more IDs for the newer chips.
> 
> Thanks!
> 
>  drivers/edac/mpc85xx_edac.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 52ca09b..3820879 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -646,8 +646,12 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
>  	{ .compatible = "fsl,mpc8555-l2-cache-controller", },
>  	{ .compatible = "fsl,mpc8560-l2-cache-controller", },
>  	{ .compatible = "fsl,mpc8568-l2-cache-controller", },
> +	{ .compatible = "fsl,mpc8569-l2-cache-controller", },
>  	{ .compatible = "fsl,mpc8572-l2-cache-controller", },
> +	{ .compatible = "fsl,p1020-l2-cache-controller", },
> +	{ .compatible = "fsl,p1021-l2-cache-controller", },
>  	{ .compatible = "fsl,p2020-l2-cache-controller", },
> +	{ .compatible = "fsl,p4080-l2-cache-controller", },

L2 on the p4080 is quite different from those other chips.  It's part
of the core, controlled by SPRs.

-Scott
