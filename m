Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 41231B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:30:57 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id CE9A1DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 07:30:56 +1000 (EST)
Date: Thu, 2 Jul 2009 01:30:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Don't use alloc_bootmem() in init_IRQ() path
Message-ID: <20090701213055.GA31167@oksana.dev.rtsoft.ru>
References: <20090701230831.3828e0bf@power-debian>
	<20090701194819.GB20522@ovro.caltech.edu>
	<20090701205957.GA9583@oksana.dev.rtsoft.ru>
	<0B693A82-F60B-4451-9747-1A54EAB64FEC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0B693A82-F60B-4451-9747-1A54EAB64FEC@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ira Snyder <iws@ovro.caltech.edu>,
	linuxppc-dev@ozlabs.org, Andrey Gusev <a.gusev1980@mail.ru>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 01, 2009 at 04:25:22PM -0500, Kumar Gala wrote:
> 
> On Jul 1, 2009, at 3:59 PM, Anton Vorontsov wrote:
> 
> >qe_ic is in the same boat, just as every other PIC controller. Heh..
> >doing some 'grep alloc_bootmem', it seems that there are pretty
> >much offenders. Let's fix them?
> >
> >arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |    2 +-
> >arch/powerpc/sysdev/ipic.c                   |    4 +---
> >arch/powerpc/sysdev/mpic.c                   |    9 ++++-----
> >arch/powerpc/sysdev/qe_lib/qe_ic.c           |    4 +---
> >arch/powerpc/sysdev/uic.c                    |    3 +--
> >5 files changed, 8 insertions(+), 14 deletions(-)
> 
> mpic should already be fixed.. I just thing the pull occurred after
> -rc1 because of Ben being sick.

Fixed by this?

commit 85355bb272db31a3f2dd99d547eef794805e1319
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Thu Jun 18 22:01:20 2009 +0000

    powerpc: Fix mpic alloc warning


Then this isn't enough. There were two more calls of alloc_bootmem()
in mpic.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
