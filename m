Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EC292C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Apr 2013 20:21:24 +1000 (EST)
Date: Sun, 28 Apr 2013 18:20:42 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 02/15] powerpc/85xx: add sleep and deep sleep support
Message-ID: <20130428102042.GB27100@localhost.localdomain>
References: <1366368468-29143-2-git-send-email-chenhui.zhao@freescale.com>
 <1366761200.5825.18@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366761200.5825.18@snotra>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 r58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 06:53:20PM -0500, Scott Wood wrote:
> On 04/19/2013 05:47:35 AM, Zhao Chenhui wrote:
> > static int pmc_suspend_enter(suspend_state_t state)
> > {
> >-	int ret;
> >+	int ret = 0;
> >+
> >+	switch (state) {
> >+#ifdef CONFIG_PPC_85xx
> >+	case PM_SUSPEND_MEM:
> >+#ifdef CONFIG_SPE
> >+		enable_kernel_spe();
> >+#endif
> >+		enable_kernel_fp();
> 
> Why does enable_kernel_spe() need an ifdef but enable_kernel_fp()
> doesn't?
> 

will enclose it with CONFIG_PPC_FPU.

> >+	case PM_SUSPEND_STANDBY:
> >+#ifdef CONFIG_FSL_SOC_BOOKE
> >+		flush_dcache_L1();
> >+#endif
> >+		setbits32(&pmc_regs->powmgtcsr, POWMGTCSR_SLP);
> 
> Only L1, even on e500mc?
> 
> -Scott

This patch is just for chips with pmc unit. They have no e500mc core.

-Chenhui
