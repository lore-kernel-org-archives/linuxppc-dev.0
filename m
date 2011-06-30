Return-Path: <dedekind1@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63892B6F53
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 21:52:23 +1000 (EST)
Received: by iwn36 with SMTP id 36so2249517iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 04:52:20 -0700 (PDT)
Subject: Re: [PATCH 1/2] mtd/nand : don't free the global data
	fsl_lbc_ctrl_dev->nand in fsl_elbc_chip_remove()
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 30 Jun 2011 14:53:13 +0300
In-Reply-To: <20110629114558.13975519@schlenkerla.am.freescale.net>
References: <1309225852-1664-1-git-send-email-b35362@freescale.com>
	<1309328435.23597.104.camel@sauron>
	<20110629114558.13975519@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309434797.23597.178.camel@sauron>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, b35362@freescale.com, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-29 at 11:45 -0500, Scott Wood wrote:
> On Wed, 29 Jun 2011 09:20:25 +0300
> Artem Bityutskiy <dedekind1@gmail.com> wrote:
> 
> > On Tue, 2011-06-28 at 09:50 +0800, b35362@freescale.com wrote:
> > > From: Liu Shuo <b35362@freescale.com>
> > > 
> > > The global data fsl_lbc_ctrl_dev->nand don't have to be freed in
> > > fsl_elbc_chip_remove(). The right place to do that is in fsl_elbc_nand_remove()
> > > if elbc_fcm_ctrl->counter is zero.
> > > 
> > > Signed-off-by: Liu Shuo <b35362@freescale.com>
> > > ---
> > >  drivers/mtd/nand/fsl_elbc_nand.c |    1 -
> > >  1 files changed, 0 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
> > > index 0bb254c..a212116 100644
> > > --- a/drivers/mtd/nand/fsl_elbc_nand.c
> > > +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> > > @@ -829,7 +829,6 @@ static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
> > >  
> > >  	elbc_fcm_ctrl->chips[priv->bank] = NULL;
> > >  	kfree(priv);
> > > -	kfree(elbc_fcm_ctrl);
> > >  	return 0;
> > >  }
> > 
> > Do we have to assign fsl_lbc_ctrl_dev->nand to NULL in
> > fsl_elbc_nand_remove() then? I think that assignment can be killed then.
> > 
> >         if (!elbc_fcm_ctrl->counter) {
> >                 fsl_lbc_ctrl_dev->nand = NULL;
> >                 kfree(elbc_fcm_ctrl);
> >         }
> > 
> 
> If we're freeing fsl_lbc_ctrl, we'd better get rid of references to it...

Yes, on the one hand this is a good defensive programming practice, on
the other hand it hides double-free bugs. Like this patch fixes a
double-free bug, and why it was noticed before? I thought may be because
of this NULL assignment?

I do not insist though, that was just a suggestion/question.

-- 
Best Regards,
Artem Bityutskiy
