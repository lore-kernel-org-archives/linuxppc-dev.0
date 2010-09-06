Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 315F7B70DC
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 18:09:44 +1000 (EST)
Received: by eyg24 with SMTP id 24so2507787eyg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Sep 2010 01:09:42 -0700 (PDT)
Date: Mon, 6 Sep 2010 12:09:38 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 2/3][MTD] P4080/nand: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100906080938.GA13755@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-2-git-send-email-tie-fei.zang@freescale.com>
	<20100903114357.GC11847@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1B37B0@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A1B37B0@zch01exm23.fsl.freescale.net>
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

On Mon, Sep 06, 2010 at 12:49:17PM +0800, Zang Roy-R61911 wrote:
> > On Fri, Aug 06, 2010 at 10:51:35AM +0800, Roy Zang wrote:
> > [...]
> > >
> > > +static struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl;
> > > +
> > 
> > Are you sure that you want it as a global var? A bit scary change.
> > 
> > Oh, you probably don't need it, as you can get it from
> > fsl_lbc_ctrl_dev->nand?
> Get it form fsl_lbc_ctrl_dev->nand or assign it to
> fsl_lbc_ctrl_dev->nand in probe?

I meant to get it from fsl_lbc_ctrl_dev->nand. I.e. in
probe() you do: fsl_lbc_ctrl_dev->nand = elbc_fcm_ctrl, so
you probably don't need the global var.

(fsl_lbc_ctrl_dev seems to be global as well, duh. Well,
one variable less in the global name space. But I'd
probably use lbc_np->data to store the LBC private
struct).

Scott seem to be fine with it as there are probably no
plans to to add several localbus controllers into the SoCs.

But, I saw a custom board with two MPC82xx SoCs connected
together, one as a master (core + peripheral devs), and
other as a slave (its core was halted, and only slave's
CPM peripheral devices were used by the master CPU).

I think it is possible to connect two (or more) SoCs in
a such way so that two or more LBC controllers would
be visible for the Linux.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
