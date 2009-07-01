Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0A69AB70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:27:47 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EF9DDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 07:27:45 +1000 (EST)
Message-Id: <0B693A82-F60B-4451-9747-1A54EAB64FEC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090701205957.GA9583@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc: Don't use alloc_bootmem() in init_IRQ() path
Date: Wed, 1 Jul 2009 16:25:22 -0500
References: <20090701230831.3828e0bf@power-debian>
	<20090701194819.GB20522@ovro.caltech.edu>
	<20090701205957.GA9583@oksana.dev.rtsoft.ru>
Cc: Arnd Bergmann <arnd@arndb.de>, Ira Snyder <iws@ovro.caltech.edu>,
	linuxppc-dev@ozlabs.org, Andrey Gusev <a.gusev1980@mail.ru>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 1, 2009, at 3:59 PM, Anton Vorontsov wrote:

> qe_ic is in the same boat, just as every other PIC controller. Heh..
> doing some 'grep alloc_bootmem', it seems that there are pretty
> much offenders. Let's fix them?
>
> arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |    2 +-
> arch/powerpc/sysdev/ipic.c                   |    4 +---
> arch/powerpc/sysdev/mpic.c                   |    9 ++++-----
> arch/powerpc/sysdev/qe_lib/qe_ic.c           |    4 +---
> arch/powerpc/sysdev/uic.c                    |    3 +--
> 5 files changed, 8 insertions(+), 14 deletions(-)

mpic should already be fixed.. I just thing the pull occurred after - 
rc1 because of Ben being sick.

- k
