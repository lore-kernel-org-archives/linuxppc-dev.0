Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id D91FAB70AB
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 19:25:57 +1000 (EST)
Received: by ewy2 with SMTP id 2so676255ewy.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 02:25:55 -0700 (PDT)
Date: Thu, 16 Sep 2010 13:25:51 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100916092551.GA17548@oksana.dev.rtsoft.ru>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
	<20100916082141.GA10978@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6B8@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A1FC6B8@zch01exm23.fsl.freescale.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2010 at 04:50:05PM +0800, Zang Roy-R61911 wrote:
> > On Thu, Sep 16, 2010 at 02:41:23PM +0800, Roy Zang wrote:
> > [...]
> > > -static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
> > > -                                      struct device_node *node)
> > > +/*
> > > + * Currently only one elbc probe is supported.
> > > + */
> > > +static int __devinit fsl_elbc_nand_probe(struct platform_device *dev)
> > >  {
> > > -     struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> > > +     struct fsl_lbc_regs __iomem *lbc;
> > >       struct fsl_elbc_mtd *priv;
> > >       struct resource res;
> > > +     struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = NULL;
> > [...]
> > > -     ctrl->chips[bank] = priv;
> > > +     if (fsl_lbc_ctrl_dev->nand == NULL) {
> > > +             elbc_fcm_ctrl = kzalloc(sizeof(*elbc_fcm_ctrl), GFP_KERNEL);
> > > +             if (!elbc_fcm_ctrl) {
> > [...]
> > > +                     goto err;
> > > +             }
> > > +             fsl_lbc_ctrl_dev->nand = elbc_fcm_ctrl;
> > > +     }
> > > +
> > > +     elbc_fcm_ctrl->chips[bank] = priv;
> > 
> > Again, this will oops on the second probe.
> Why?

Because of a NULL dereference ("elbc_fcm_ctrl->").

I understand that you don't have to believe me, but will you believe
a compiler?

oksana:~$ cat a.c
#include <stdio.h>
#include <malloc.h>

char *foo;

void probe(void)
{
        char *bar = NULL;

        if (!foo) {
                bar = malloc(sizeof(*bar));
                if (!bar)
                        return;
                foo = bar;
        }
        *bar = 'a';
}

int main(void)
{
        probe();
        probe();
        return 0;
}
oksana:~$ gcc a.c && ./a.out
Segmentation fault

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
