Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id ACCBCDDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:40:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 4/4] powerpc 2.6.21-rt1: reduce scheduling latency by
	changing tlb flush size
Date: Mon, 14 May 2007 16:40:02 +0200
References: <yyi3b1zapqa.wl@toshiba.co.jp>
	<1179125506.22481.297.camel@localhost.localdomain>
	<yyitzuf9857.wl@toshiba.co.jp>
In-Reply-To: <yyitzuf9857.wl@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705141640.02561.arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 May 2007, Tsutomu OWA wrote:
> --- linux-2.6.21-rt1/include/asm-powerpc/tlbflush.h=A0=A0=A0=A0=A02007-04=
=2D26 12:08:32.000000000 +0900
> +++ rt/include/asm-powerpc/tlbflush.h=A0=A0=A02007-05-14 16:12:47.0000000=
00 +0900
> @@ -25,7 +25,12 @@ struct mm_struct;
> =A0#include <linux/percpu.h>
> =A0#include <asm/page.h>
> =A0
> +#if defined(CONFIG_PPC_CELLEB) && defined(CONFIG_PREEMPT_RT)
> +/* Since tlb flush takes long time on Celleb, reduce it to 1 when Celleb=
 && RT */
> +#define PPC64_TLB_BATCH_NR 1
> +#else
> =A0#define PPC64_TLB_BATCH_NR 192
> +#endif /* defined(CONFIG_PPC_CELLEB) && defined(CONFIG_PREEMPT_RT) */

With this code, you get silent side-effects of enabling PPC_CELLEB
along with another platform.

Maybe instead you should change the hpte_need_flush() to always flush
when running on the celleb platform and PREEMPT_RT is enabled.

	Arnd <><
