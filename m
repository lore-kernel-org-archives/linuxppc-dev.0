Message-ID: <3D62C102.3070400@dslextreme.com>
Date: Tue, 20 Aug 2002 15:21:54 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Cc: Tom Rini <trini@kernel.crashing.org>, paulus@samba.org,
	Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix percpu heartbeats
References: <200208190419.g7J4J1e25498@sullivan.realtime.net>
Content-Type: multipart/mixed;
 boundary="------------010707020801080706030401"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010707020801080706030401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Milton Miller wrote:
> The changeset of Cort's patch that Troy checked in is broken in several ways:
>
> 1) The slave cpus no longer call heartbeats at all because there was a
> previous continue in the loop. (reordered and used remembered cpu number)
>
> 2) The rtas call rate is per-minute not per-second.  (correct the rate)
>
> 3) All the rtas calls will occur at the same time, modulo the contended
> rtas lock.  (wait to divide the rate until smp_kick_cpus).
>
> 4) It added NRCPUS*3 words to ppc_md.  It also pointed out we were modifing
> this structre repeatedly at runtime.  [moved the counts to the cache hot
> and dirty per-cpu irqstat and allow only one choice of function, just per
> cpu countdown and period.  The count is always decremented, but only when
> it reaches zero do we decide to call the function by checking the reset
> value for non-zero.  The period is reset after the call, so aperiodic
> users (like 4xx watchdog maybe?) could clear the count during their callback.]
>
> I know there are other alternatives, but the cost to non-users is minimal
> (an extra branch and compare every 2*32 jiffies), and the the periodic
> call usage is set it up and forget it.
>
>
> I'll read comments through the lists, so no need to cc me.
>
> milton
>
> ===== arch/ppc/kernel/ppc4xx_setup.c 1.46 vs 1.47 =====
> --- 1.46/arch/ppc/kernel/ppc4xx_setup.c	Fri Aug  2 11:30:01 2002
> +++ 1.47/arch/ppc/kernel/ppc4xx_setup.c	Sun Aug 18 21:03:03 2002
> @@ -383,6 +383,8 @@
>  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
>  	}
>  #if defined(CONFIG_PPC405_WDT)
> +	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;
> +
>  /* Look for wdt= option on command line */
>  	if (strstr(cmd_line, "wdt=")) {
>  		int valid_wdt = 0;
> @@ -396,6 +398,26 @@
>  			++q;
>  		}
>  		wdt_enable = valid_wdt;
> +
> +		/* XXX why is the wdt functoin modifing count and not
> +		 * using reset ??  If this code wants kernel heartbeat
> +		 * calls then:
> +		 *
> +		 * #include <asm/hwirq.h>
> +		 * heartbeat_reset(cpu) = period_in_jiffies;
> +		 * heartbeat_count(cpu) = period_in_jiffies;
> +		 *
> +		 * The function will be called from the timer interrupt
> +		 * when the counts reaches 0, afterwards the count will
> +		 * be set to the heartbeat_reset(cpu) value (which
> +		 * could be cleard during call for one-shot mode).
> +		 *
> +		 * If the code doesn't want the count manageed it
> +		 * should not use the kernel callbacks (or set reset
> +		 * to 1 and use its own counters).
> +		 */
> +#error sanitize wdt and kernel heartbeat interactions
> +
>  	}
>  #endif
>
> @@ -411,11 +433,6 @@
>  	ppc_md.halt = ppc4xx_halt;
>
>  	ppc_md.calibrate_decr = ppc4xx_calibrate_decr;
> -
> -#ifdef CONFIG_PPC405_WDT
> -	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;
> -#endif
> -	ppc_md.heartbeat_count = 0;
>
>  	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
>  	ppc_md.setup_io_mappings = m4xx_map_io;

To all

Attcahed is a patch for 40x to get wdt working on top of Milton's
orginal patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#
            ChangeSet	1.1138  -> 1.1139
#
drivers/char/ppc405_wdt.c
1.3     -> 1.4
#
arch/ppc/kernel/ppc4xx_setup.c
1.46    -> 1.47
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/20	armin@essen.mvista.com	1.1139
# changes to make driver work w/ heartbeat_* changes
# changes to setup on top of mintons patch to make 40x to work


Armin



--------------010707020801080706030401
Content-Type: application/x-gunzip;
 name="wdt_0820.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="wdt_0820.patch.gz"

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
OgaR4VNraGzB139jsuufthEAAA==
--------------010707020801080706030401--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
