Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 743B5DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 11:00:15 +1100 (EST)
Subject: Re: [PATCH] ppc: fix #ifdef-s in mediabay driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200801230012.38516.bzolnier@gmail.com>
References: <200801230012.38516.bzolnier@gmail.com>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 10:59:54 +1100
Message-Id: <1201046394.6807.49.camel@pasglop>
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


On Wed, 2008-01-23 at 00:12 +0100, Bartlomiej Zolnierkiewicz wrote:
> * Replace incorrect CONFIG_BLK_DEV_IDE #ifdef in
>   check_media_bay() by CONFIG_MAC_FLOPPY one.
> 
> * Replace incorrect CONFIG_BLK_DEV_IDE #ifdef-s by
>   CONFIG_BLK_DEV_IDE_PMAC ones.
> 
> * check_media_bay() is used only by drivers/block/swim3.c
>   so make this function available only if CONFIG_MAC_FLOPPY
>   is defined.
> 
> * check_media_bay_by_base() and media_bay_set_ide_infos()
>   are used only by drivers/ide/ppc/pmac.c so so make these
>   functions available only if CONFIG_MAC_FLOPPY is defined.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Ben, IMO this patch is safe for 2.6.24 (assuming that it builds fine :),
> otherwise I would like to ask for permission to merge it through IDE
> tree since I have other pending IDE patches depending on this one.

I'd rather avoid touching 2.6.24 unless it actually fixes a bug or
regression...

I'm tempted to actually remove all ifdef's ... if you have a media-bay,
then there are about 99% chances it contains an IDE device, with the
remaining percent being split with putting a floppy or a battery in. I
doubt anybody will care building a kernel without the support for these
and with the mediabay support, and still want to save a handful of bytes
in that driver.

Ben.
