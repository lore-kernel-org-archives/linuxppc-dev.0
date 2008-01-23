Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1146CDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 15:17:35 +1100 (EST)
Subject: Re: [PATCH] ppc: fix #ifdef-s in mediabay driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200801230158.42017.bzolnier@gmail.com>
References: <200801230012.38516.bzolnier@gmail.com>
	<1201046394.6807.49.camel@pasglop>
	<200801230158.42017.bzolnier@gmail.com>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 15:17:12 +1100
Message-Id: <1201061832.6807.64.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-23 at 01:58 +0100, Bartlomiej Zolnierkiewicz wrote:
> I'm more worried about breaking automatic build checking (make randconfig)
> than a few extra bytes so if you remove all #ifdefs you'll have to either
> make BLK_DEV_IDE_PMAC select PMAC_MEDIABAY or make PMAC_MEDIABAY depend
> on BLK_DEV_IDE_PMAC (otherwise BLK_DEV_IDE=n && PMAC_MEDIABAY=y will fail
> since mediabay.c is referencing IDE code).

I was thinking about having the pmac arch code provide an exported
function pointer to put the hook in to avoid that problem.

Ben.
