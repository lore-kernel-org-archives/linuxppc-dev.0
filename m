Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
In-reply-to: <4F1370C9.9010400@freescale.com>
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
Date: Mon, 16 Jan 2012 11:52:19 +1100
Message-ID: <21913.1326675139@neuling.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <4F1370C9.9010400@freescale.com> you wrote:
> Michael Neuling wrote:
> > Fix a bunch of compiler errors and warnings introduced in:
> >    commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
> >    Author: Timur Tabi<timur@freescale.com>
> >    drivers/video: fsl-diu-fb: merge all allocated data into one block
> >
> > Signed-off-by: Michael Neuling<mikey@neuling.org>
> > ---
> > Timur: you do compile test your patches, right? :-P
> 
> I have a script that tests each commit in a set to make sure it compiles,
> so that git-bisect isn't broken.

May I suggest you actually run the script next time :-P

> > This is effecting mpc85xx_defconfig on mainline (and has been in
> > linux-next for while already).
> >
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index acf292b..78cac52 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -366,7 +366,7 @@ struct mfb_info {
> >    */
> >   struct fsl_diu_data {
> >   	dma_addr_t dma_addr;
> > -	struct fb_info fsl_diu_info[NUM_AOIS];
> > +	struct fb_info *fsl_diu_info[NUM_AOIS];
> 
> This doesn't make any sense.  If you change fsl_diu_info into a pointer,=20
> then where is the object being allocated?

OK, how about this?


From: Michael Neuling <mikey@neuling.org>

[PATCH] drivers/video: compile fixes for fsl-diu-fb.c

Fix a compiler errors introduced in:
  commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
  Author: Timur Tabi <timur@freescale.com>
  drivers/video: fsl-diu-fb: merge all allocated data into one block

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index acf292b..3006b2b 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1432,7 +1432,7 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
 	struct fsl_diu_data *data;
 
 	data = dev_get_drvdata(&ofdev->dev);
-	disable_lcdc(data->fsl_diu_info[0]);
+	disable_lcdc(&(data->fsl_diu_info[0]));
 
 	return 0;
 }
@@ -1442,7 +1442,7 @@ static int fsl_diu_resume(struct platform_device *ofdev)
 	struct fsl_diu_data *data;
 
 	data = dev_get_drvdata(&ofdev->dev);
-	enable_lcdc(data->fsl_diu_info[0]);
+	enable_lcdc(&(data->fsl_diu_info[0]));
 
 	return 0;
 }
