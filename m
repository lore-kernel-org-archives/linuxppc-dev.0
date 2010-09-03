Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209]) by ozlabs.org (Postfix) with ESMTP id EF3AEB7157
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Sep 2010 03:49:09 +1000 (EST)
Received: from mail12-am1 (localhost.localdomain [127.0.0.1])	by
	mail12-am1-R.bigfish.com (Postfix) with ESMTP id ED8B312E811C	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 17:33:59 +0000 (UTC)
Received: from am1ehsmhs008.bigfish.com (unknown [10.3.201.240])	by
	mail12-am1.bigfish.com (Postfix) with ESMTP id BC8A966804B	for
	<linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 17:33:59 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o83HXeeZ008834	for
	<linuxppc-dev@ozlabs.org>; Fri, 3 Sep 2010 10:33:51 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o83HmRG4021129	for <linuxppc-dev@ozlabs.org>;
	Fri, 3 Sep 2010 12:48:27 -0500 (CDT)
Date: Fri, 3 Sep 2010 12:33:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/3][MTD] P4080/nand: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100903123338.0884a761@schlenkerla.am.freescale.net>
In-Reply-To: <20100903114357.GC11847@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-2-git-send-email-tie-fei.zang@freescale.com>
	<20100903114357.GC11847@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: B25806@freescale.com, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
	B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 3 Sep 2010 15:43:57 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> On Fri, Aug 06, 2010 at 10:51:35AM +0800, Roy Zang wrote:
> [...]
> >  
> > +static struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl;
> > +
> 
> Are you sure that you want it as a global var? A bit scary change.
> 
> Oh, you probably don't need it, as you can get it from
> fsl_lbc_ctrl_dev->nand?
> 
> I wonder if Scott saw these patches? Cc'ed.

I saw many iterations of these patches. :-)

I had the same reaction to this, but during internal review it did not
seem to be the most pressing concern to focus on.

In practice, there will only be one eLBC, and properly handling multiple
devices and binding the right one across this new boundary would have
been unnecessary complexity.

-Scott
