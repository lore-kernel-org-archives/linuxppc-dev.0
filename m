Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id 79C80B70CD
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 02:15:04 +1000 (EST)
Received: from mail159-va3 (localhost.localdomain [127.0.0.1])	by
	mail159-va3-R.bigfish.com (Postfix) with ESMTP id DD87968009D	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 16:14:59 +0000 (UTC)
Received: from VA3EHSMHS029.bigfish.com (unknown [10.7.14.244])	by
	mail159-va3.bigfish.com (Postfix) with ESMTP id 6EF9C8E004C	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 16:14:59 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8GGEoxp003899	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 09:14:50 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8GGRSH9013149	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 11:27:28 -0500 (CDT)
Date: Thu, 16 Sep 2010 11:14:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100916111448.27ef7440@schlenkerla.am.freescale.net>
In-Reply-To: <20100916112624.GA32074@oksana.dev.rtsoft.ru>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
	<20100916082141.GA10978@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6B8@zch01exm23.fsl.freescale.net>
	<20100916092551.GA17548@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6DB@zch01exm23.fsl.freescale.net>
	<20100916101429.GA27393@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6E1@zch01exm23.fsl.freescale.net>
	<20100916112624.GA32074@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Zang Roy-R61911 <r61911@freescale.com>,
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

On Thu, 16 Sep 2010 15:26:24 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> On Thu, Sep 16, 2010 at 06:39:40PM +0800, Zang Roy-R61911 wrote:
> [...]
> > But my code has some assignment for "foo" instead of a simple
> > allocation, how about this way for my code:
> 
> This will surely work, and all the rest is just a matter of
> taste. So, I'm fine with it. But see below, I think I found
> some new, quite serious issues.
> 
> > DEFINE_MUTEX(fsl_elbc_mutex);
> 
> I'd place the mutex inside the fsl_lbc_ctrl_dev,
> i.e. fsl_lbc_ctrl_dev->nand_lock. This is to avoid more
> global variables.

I wouldn't.  If the lock is only meaningful to the NAND driver, it
should be declared in the NAND driver.

Besides, it's not any less of a global just because it's sitting inside
a singleton struct.

Perhaps it should be declared as a static local inside the probe
function, if it's just to guard against this one race.

> >                 elbc_fcm_ctrl->read_bytes = 0;
> >                 elbc_fcm_ctrl->index = 0;
> >                 elbc_fcm_ctrl->addr = NULL;
> 
> I guess these variables should be per chip select, as
> otherwise there will be tons of races when somebody try
> to access two or more NAND chips simultaneously.

The NAND layer has its own per-controller mutex that prevents this.

> So, I'd suggest to redo the whole thing this way: don't allocate
> elbc_fcm_ctrl in this driver, but make an array inside the
> fsl_lbc_ctrl_dev. I.e.
> fsl_lbc_ctrl_dev->nand_ctrl[MAX_CHIP_SELECTS]

NACK.

There is not a separate controller per chip select.

> Btw, even before this patch, it seems that the driver had
> all these bugs/races, i.e. ctrl->controller.lock was not
> used at all. Ugh.

It is used, search nand_base.c for controller->lock.

-Scott
