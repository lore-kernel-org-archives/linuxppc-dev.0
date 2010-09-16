Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 34499B70E6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 02:40:50 +1000 (EST)
Received: by ewy2 with SMTP id 2so930814ewy.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 09:40:48 -0700 (PDT)
Date: Thu, 16 Sep 2010 20:40:44 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100916164044.GA5669@oksana.dev.rtsoft.ru>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
	<20100916082141.GA10978@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6B8@zch01exm23.fsl.freescale.net>
	<20100916092551.GA17548@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6DB@zch01exm23.fsl.freescale.net>
	<20100916101429.GA27393@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6E1@zch01exm23.fsl.freescale.net>
	<20100916112624.GA32074@oksana.dev.rtsoft.ru>
	<20100916111448.27ef7440@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100916111448.27ef7440@schlenkerla.am.freescale.net>
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

On Thu, Sep 16, 2010 at 11:14:48AM -0500, Scott Wood wrote:
> > > DEFINE_MUTEX(fsl_elbc_mutex);
> > 
> > I'd place the mutex inside the fsl_lbc_ctrl_dev,
> > i.e. fsl_lbc_ctrl_dev->nand_lock. This is to avoid more
> > global variables.
> 
> I wouldn't.  If the lock is only meaningful to the NAND driver, it
> should be declared in the NAND driver.
> 
> Besides, it's not any less of a global just because it's sitting inside
> a singleton struct.
> 
> Perhaps it should be declared as a static local inside the probe
> function, if it's just to guard against this one race.

OK, in that case better be persistent and not introduce
fsl_lbc_ctrl_dev->nand at all, as it isn't used outside
of the driver.

Having fsl_lbc_ctrl_dev->nand and its lock elsewhere in
the code makes no sense.

> > Btw, even before this patch, it seems that the driver had
> > all these bugs/races, i.e. ctrl->controller.lock was not
> > used at all. Ugh.
> 
> It is used, search nand_base.c for controller->lock.

OK, now I see, the driver implements its own chip->controller
(which is exactly what ctrl->controller is). Then we're fine.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
