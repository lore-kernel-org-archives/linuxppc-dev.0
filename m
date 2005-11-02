Return-Path: <SRS0+86b099cbe611c29e26f6+801+infradead.org+dwmw2@pentafluge.srs.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17256.17408.247708.622755@cargo.ozlabs.ibm.com>
References: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
	<1130861207.21212.66.camel@hades.cambridge.redhat.com>
	<17256.17408.247708.622755@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 16:54:46 +0000
Message-Id: <1130950487.21212.89.camel@hades.cambridge.redhat.com>
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

On Wed, 2005-11-02 at 15:43 +1100, Paul Mackerras wrote:
> Those errors were all due to getting powerbook sleep code included
> because you have CONFIG_PM=y.  I have changed things so that that code
> doesn't get included on a 64-bit build (at least until BenH gets sleep
> going on the G5 :).

OK, now the Fedora rawhide kernel builds for ppc64 with arch/powerpc and
runs on both my POWER5 and G5 test boxes. I need this if I want nvram
support on the G5 though.

Should we be using CONFIG_GENERIC_NVRAM on ppc64, and actually allowing
the nvram support to be optional?

--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -351,7 +350,7 @@ void __init pmac_setup_arch(void)
 	find_via_pmu();
 	smu_init();
 
-#ifdef CONFIG_NVRAM
+#if defined(CONFIG_NVRAM) || defined(CONFIG_PPC64)
 	pmac_nvram_init();
 #endif
 


-- 
dwmw2
