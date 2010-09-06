Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id E7FB9B70F1
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 18:21:47 +1000 (EST)
Received: by eyg24 with SMTP id 24so2510626eyg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Sep 2010 01:21:46 -0700 (PDT)
Date: Mon, 6 Sep 2010 12:21:42 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc interrupt
	common to elbc devices
Message-ID: <20100906082142.GB13755@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<20100903112755.GA11847@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1B378F@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A1B378F@zch01exm23.fsl.freescale.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 06, 2010 at 11:38:09AM +0800, Zang Roy-R61911 wrote:
[...]
> > >  	switch (br & BR_MSEL) {
> > >  	case BR_MS_UPMA:
> > > -		upm->mxmr = &fsl_lbc_regs->mamr;
> > > +		upm->mxmr = &fsl_lbc_ctrl_dev->regs->mamr;
> > 
> > Ditto, a very repetitive stuff, desires a variable for regs?
> But the fact is that the variable represents different reg
> address according to the condition. It will be ugly to use
> the reg address directoly.

I meant a dedicated var for 'fsl_lbc_ctrl_dev->regs'.
I.e.

regs = fsl_lbc_ctrl_dev->regs;
...
mxmr = &regs->mamr;
...
mxmr = &regs->mbmr;
..
mxmr = &regs->mcmr;

Instead of

mxmr = &fsl_lbc_ctrl_dev->regs->mamr;
...
mxmr = &fsl_lbc_ctrl_dev->regs->mbmr;
..
mxmr = &fsl_lbc_ctrl_dev->regs->mcmr;

[...]
> > > +static int __devinit fsl_lbc_ctrl_probe(struct of_device *ofdev,
> > > +					 const struct of_device_id *match)
> > > +{
> > > +	int ret = 0;
> > 
> > no need for the initial value here.
> Any harm?

Probably not as gcc will likely optimize it away,
but it's not needed, so why keep it there?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
