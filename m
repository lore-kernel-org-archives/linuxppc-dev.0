Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] cell: use ppc_md->power_save instead of
	cbe_idle_loop
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200610231152.07675.arnd.bergmann@de.ibm.com>
References: <200610201840.14389.arnd.bergmann@de.ibm.com>
	<20061020182203.7871d1b1@pb15>
	<200610231152.07675.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 20:16:27 +1000
Message-Id: <1161598587.10524.455.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	Anthony J Marsala <marsala@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +	/*
> +	 * We need to call cbe_enable_pause_zero on each CPU
> +	 * before first entering power_save(). The most convenient
> +	 * place for this is ppc_md->idle, because that is called
> +	 * right before entering the idle loop.
> +	 */
> +	ppc_md.idle_loop = cbe_enable_pause_zero;

I disagree here... this should be done in setup_cpu() for non-boot CPUs,
and sometime in setup_arch for the boot CPU. 

Another option is to have the pm_control bit done once for all CPUs at
boot in setup_arch() or such, and the TSC_CELL SPR bit done
unconditionally in powersave...

Ben.
