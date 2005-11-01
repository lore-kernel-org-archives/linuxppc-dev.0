Return-Path: <SRS0+4a536cd6c556040094b6+800+infradead.org+dwmw2@pentafluge.srs.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
References: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Nov 2005 16:06:47 +0000
Message-Id: <1130861207.21212.66.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: please pull the powerpc-merge.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-10-31 at 15:23 +1100, Paul Mackerras wrote:
> It is now possible to build kernels for powermac, pSeries, iSeries and
> maple with ARCH=powerpc, and for powermac, both 32-bit and 64-bit
> build and run. 

The ppc64 build (http://david.woodhou.se/powerpc-merge-64.config) fares
worse than ppc32 for me -- it doesn't even build. 

arch/powerpc/platforms/powermac/pic.c:614: error: ‘ppc_cached_irq_mask’ undeclared (first use in this function)
arch/powerpc/platforms/powermac/pic.c:620: error: ‘pmac_irq_hw’ undeclared (first use in this function)
arch/powerpc/platforms/powermac/pic.c:621: error: ‘max_real_irqs’ undeclared (first use in this function)
arch/powerpc/platforms/powermac/pic.c:641: warning: implicit declaration of function ‘pmac_unmask_irq’

If I leave CONFIG_ADB_PMU enabled (as I think I should since some G5s
have it?) I also see this:

drivers/macintosh/via-pmu.c:2410: undefined reference to `.pmac_tweak_clock_spreading'
drivers/macintosh/via-pmu.c:2494: undefined reference to `.set_context'
drivers/macintosh/via-pmu.c:2670: undefined reference to `._nmask_and_or_msr'
drivers/macintosh/via-pmu.c:2592: undefined reference to `.set_context'

If I turn CONFIG_ADB_PMU off, I see this:

arch/powerpc/platforms/powermac/time.c:335: undefined reference to `.pmu_register_sleep_notifier'

I think I'll leave the task of switching the Fedora rawhide kernel to
arch/powerpc to another day :)

-- 
dwmw2
