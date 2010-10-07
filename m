Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 717F4B70DE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:29:18 +1100 (EST)
Received: by ewy2 with SMTP id 2so223333ewy.15
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Oct 2010 23:29:16 -0700 (PDT)
Date: Thu, 7 Oct 2010 10:29:09 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers (fix)
Message-ID: <20101007062909.GA27110@oksana.dev.rtsoft.ru>
References: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
	<20100716151224.21d499a3@schlenkerla.am.freescale.net>
	<20100721153933.64d02086.akpm@linux-foundation.org>
	<20100721182108.5a22c822@schlenkerla.am.freescale.net>
	<20100801105419.GA352@oksana.dev.rtsoft.ru>
	<5628792F-9A5F-4200-90B3-FB3939F02969@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5628792F-9A5F-4200-90B3-FB3939F02969@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, Peter Tyser <ptyser@xes-inc.com>,
	Doug Thompson <dougthompson@xmission.com>,
	Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 07, 2010 at 01:18:19AM -0500, Kumar Gala wrote:
[...]
> > diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> > index cfa86f7..b178cfa 100644
> > --- a/drivers/edac/mpc85xx_edac.c
> > +++ b/drivers/edac/mpc85xx_edac.c
> > @@ -652,7 +652,6 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
> > 	{ .compatible = "fsl,p1020-l2-cache-controller", },
> > 	{ .compatible = "fsl,p1021-l2-cache-controller", },
> > 	{ .compatible = "fsl,p2020-l2-cache-controller", },
> > -	{ .compatible = "fsl,p4080-l2-cache-controller", },
> > 	{},
> > };
> > MODULE_DEVICE_TABLE(of, mpc85xx_l2_err_of_match);
> > -- 
> > 1.7.0.5
> 
> Can you post a new patch as it doesn't look like this got merged by Andrew so we need to clean up after ourselves.

It's already in Linus' tree.

Thanks,

- - - -
commit cd1542c8197fc3c2eb3a8301505d5d9738fab1e4
Author: Anton Vorontsov <avorontsov@mvista.com>
Date:   Tue Aug 10 18:03:21 2010 -0700

    edac: mpc85xx: add support for new MPCxxx/Pxxxx EDAC controllers
    
    Simply add proper IDs into the device table.
    
    Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
    Cc: Scott Wood <scottwood@freescale.com>
    Cc: Peter Tyser <ptyser@xes-inc.com>
    Cc: Dave Jiang <djiang@mvista.com>
    Cc: Doug Thompson <dougthompson@xmission.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index fdbad55..af75e27 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -647,7 +647,10 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
 	{ .compatible = "fsl,mpc8555-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8560-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8568-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8569-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8572-l2-cache-controller", },
+	{ .compatible = "fsl,p1020-l2-cache-controller", },
+	{ .compatible = "fsl,p1021-l2-cache-controller", },
 	{ .compatible = "fsl,p2020-l2-cache-controller", },
 	{},
 };
@@ -1125,7 +1128,10 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
 	{ .compatible = "fsl,mpc8569-memory-controller", },
 	{ .compatible = "fsl,mpc8572-memory-controller", },
 	{ .compatible = "fsl,mpc8349-memory-controller", },
+	{ .compatible = "fsl,p1020-memory-controller", },
+	{ .compatible = "fsl,p1021-memory-controller", },
 	{ .compatible = "fsl,p2020-memory-controller", },
+	{ .compatible = "fsl,p4080-memory-controller", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpc85xx_mc_err_of_match);
