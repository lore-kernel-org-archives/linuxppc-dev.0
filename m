Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE002.bigfish.com (ch1ehsobe005.messaging.microsoft.com
	[216.32.181.185]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0750B6F53
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 02:46:05 +1000 (EST)
Date: Wed, 29 Jun 2011 11:45:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: <dedekind1@gmail.com>
Subject: Re: [PATCH 1/2] mtd/nand : don't free the global data
	fsl_lbc_ctrl_dev->nand in fsl_elbc_chip_remove()
Message-ID: <20110629114558.13975519@schlenkerla.am.freescale.net>
In-Reply-To: <1309328435.23597.104.camel@sauron>
References: <1309225852-1664-1-git-send-email-b35362@freescale.com>
	<1309328435.23597.104.camel@sauron>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, b35362@freescale.com, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Jun 2011 09:20:25 +0300
Artem Bityutskiy <dedekind1@gmail.com> wrote:

> On Tue, 2011-06-28 at 09:50 +0800, b35362@freescale.com wrote:
> > From: Liu Shuo <b35362@freescale.com>
> > 
> > The global data fsl_lbc_ctrl_dev->nand don't have to be freed in
> > fsl_elbc_chip_remove(). The right place to do that is in fsl_elbc_nand_remove()
> > if elbc_fcm_ctrl->counter is zero.
> > 
> > Signed-off-by: Liu Shuo <b35362@freescale.com>
> > ---
> >  drivers/mtd/nand/fsl_elbc_nand.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
> > index 0bb254c..a212116 100644
> > --- a/drivers/mtd/nand/fsl_elbc_nand.c
> > +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> > @@ -829,7 +829,6 @@ static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
> >  
> >  	elbc_fcm_ctrl->chips[priv->bank] = NULL;
> >  	kfree(priv);
> > -	kfree(elbc_fcm_ctrl);
> >  	return 0;
> >  }
> 
> Do we have to assign fsl_lbc_ctrl_dev->nand to NULL in
> fsl_elbc_nand_remove() then? I think that assignment can be killed then.
> 
>         if (!elbc_fcm_ctrl->counter) {
>                 fsl_lbc_ctrl_dev->nand = NULL;
>                 kfree(elbc_fcm_ctrl);
>         }
> 

If we're freeing fsl_lbc_ctrl, we'd better get rid of references to it...

-Scott
