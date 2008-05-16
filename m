Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7DF69DDF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 19:17:58 +1000 (EST)
Message-ID: <482D5129.6050402@scram.de>
Date: Fri, 16 May 2008 11:17:29 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/8] [WATCHDOG] mpc8xxx_wdt: add support for
	MPC8xx	watchdogs
References: <20080515165250.GA30738@polina.dev.rtsoft.ru>
	<20080515165401.GF3887@polina.dev.rtsoft.ru>
In-Reply-To: <20080515165401.GF3887@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Chen Gong <G.Chen@freescale.com>,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> The mpc8xxx_wdt driver is using two registers: SWSRR to push magic
> numbers, and SWCRR to control the watchdog. Both registers are available
> on the MPC8xx, and seem to have the same offsets and semantics as in
> MPC83xx/MPC86xx watchdogs. The only difference is prescale value. So this
> driver should simply work on the MPC8xx CPUs.
> 
> MPC823 seem to be the first CPU in MPC8xx line, so we use fsl,mpc823-wdt
> compatible matching.
> 
> Though, this patch was only build-tested and okay to drop from this
> series until tested or corrected to work on the actual hardware.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Tested-by: Jochen Friedrich <jochen@scram.de>

The driver works OK on MPC823.

One nit however ist the late initialisation of the wdt timer. I had to add
two hardcoded wdt resets in the board setup, one in setup_arch and one in
arch_initcall, to prevent a reset until mpc8xxx_wdt kicks in. However, IMHO
this is acceptable as it only hits the 8xx series with the small prescale.

Some time ago in http://patchwork.ozlabs.org/linuxppc/patch?person=1023&id=16189,
i tried a different aproach to the problem (mainly a port of the old ARC=ppc
stuff), but the code became very ugly and the wdt maintainers didn't like it
very much.

So the only thing left for full 8xx support is a refactoring / cleanup of
http://patchwork.ozlabs.org/linuxppc/patch?person=1023&id=16262.

Thanks,
Jochen
