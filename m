Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 506DEB6ED0
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 04:09:48 +1100 (EST)
Received: by wibhm17 with SMTP id hm17so343260wib.3
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2012 10:09:45 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4F677E51.8030905@freescale.com>
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
 <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
 <4F63A7A4.4000205@freescale.com> <20120319160452.B57D13E05A5@localhost>
 <4F677E51.8030905@freescale.com>
Date: Tue, 20 Mar 2012 17:09:42 +0000
Message-Id: <20120320170942.0C4143E2834@localhost>
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Mar 2012 13:43:29 -0500, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
> > The problem is that you want to create devices for grandchildren
> > nodes when the bus ids passed in don't match any of the child nodes so
> > the of_platform_bus_probe() doesn't iterate down to that level.  This
> > is correct and expected behaviour.
> 
> Well, I'm not still not 100% sure on what I'm supposed to do, so I tried this:
> 
> static struct of_device_id __initdata p1022_ds_ids[] = {
> 	/* The audio driver probes the SSI DMA channels individually */
> 	{ .compatible = "fsl,ssi-dma-channel", },
> 	{},
> };
> 
> static int __init p1022_ds_publish_devices(void)
> {
> 	struct device_node *np;
> 	int ret;
> 
> 	mpc85xx_common_publish_devices();
> 
> 	for_each_compatible_node(np, NULL, "fsl,eloplus-dma") {
> 		ret = of_platform_bus_probe(np, p1022_ds_ids, NULL);
> 		if (ret)
> 			return ret;

Does a driver bind against "fsl,eloplus-dma"?  If so, then I would
call of_platform_populate() from within the fsl,eloplus-dma driver's
probe method.

g.
