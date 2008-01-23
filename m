Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 5B124DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 23:35:01 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so95728uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 04:35:00 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ppc: fix #ifdef-s in mediabay driver
Date: Wed, 23 Jan 2008 13:47:38 +0100
References: <200801230012.38516.bzolnier@gmail.com>
	<200801230158.42017.bzolnier@gmail.com>
	<1201061832.6807.64.camel@pasglop>
In-Reply-To: <1201061832.6807.64.camel@pasglop>
MIME-Version: 1.0
Message-Id: <200801231347.38853.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="utf-8"
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 23 January 2008, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2008-01-23 at 01:58 +0100, Bartlomiej Zolnierkiewicz wrote:
> > I'm more worried about breaking automatic build checking (make randconfig)
> > than a few extra bytes so if you remove all #ifdefs you'll have to either
> > make BLK_DEV_IDE_PMAC select PMAC_MEDIABAY or make PMAC_MEDIABAY depend
> > on BLK_DEV_IDE_PMAC (otherwise BLK_DEV_IDE=n && PMAC_MEDIABAY=y will fail
> > since mediabay.c is referencing IDE code).
> 
> I was thinking about having the pmac arch code provide an exported
> function pointer to put the hook in to avoid that problem.

BTW the other pending IDE patches (yet to posted) include rework of IDE
hot-plug support for PMAC media-bay so ide_init_hwif_ports()/ide_register_hw()
/ide_unregister() calls in mediabay.c will be replaced by "something else".
