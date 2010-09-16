Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 0EFB2B70F0
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 02:53:34 +1000 (EST)
Received: from mail31-va3 (localhost.localdomain [127.0.0.1])	by
	mail31-va3-R.bigfish.com (Postfix) with ESMTP id D3581135055B	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 16:53:30 +0000 (UTC)
Received: from VA3EHSMHS009.bigfish.com (unknown [10.7.14.236])	by
	mail31-va3.bigfish.com (Postfix) with ESMTP id 0A7AD54004E	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 16:53:23 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8GGrEHn006826	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 09:53:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8GH5qtW027608	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 12:05:52 -0500 (CDT)
Date: Thu, 16 Sep 2010 11:53:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100916115312.580671cb@schlenkerla.am.freescale.net>
In-Reply-To: <20100916164044.GA5669@oksana.dev.rtsoft.ru>
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
	<20100916164044.GA5669@oksana.dev.rtsoft.ru>
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

On Thu, 16 Sep 2010 20:40:44 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> On Thu, Sep 16, 2010 at 11:14:48AM -0500, Scott Wood wrote:
> > > > DEFINE_MUTEX(fsl_elbc_mutex);
> > > 
> > > I'd place the mutex inside the fsl_lbc_ctrl_dev,
> > > i.e. fsl_lbc_ctrl_dev->nand_lock. This is to avoid more
> > > global variables.
> > 
> > I wouldn't.  If the lock is only meaningful to the NAND driver, it
> > should be declared in the NAND driver.
> > 
> > Besides, it's not any less of a global just because it's sitting inside
> > a singleton struct.
> > 
> > Perhaps it should be declared as a static local inside the probe
> > function, if it's just to guard against this one race.
> 
> OK, in that case better be persistent and not introduce
> fsl_lbc_ctrl_dev->nand at all, as it isn't used outside
> of the driver.

We could, though it would be a step further away from being able to
support multiple controllers if that ever does happen.  Whereas sharing
a mutex between multiple controllers isn't a problem (it's just init,
not a performance-sensitive path where fine-grained locking is
desireable).

> Having fsl_lbc_ctrl_dev->nand and its lock elsewhere in
> the code makes no sense.

That depends on whether you see it as that field's lock or as the init
code's lock, I guess.

It's not that big of a deal either way.

-Scott
