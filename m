Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E6892C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 21:09:06 +1000 (EST)
Date: Wed, 24 Apr 2013 19:08:17 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 01/15] powerpc/85xx: cache operations for Freescale
 SoCs based on BOOK3E
Message-ID: <20130424110817.GA3172@localhost.localdomain>
References: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
 <1366760770.5825.17@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366760770.5825.17@snotra>
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

On Tue, Apr 23, 2013 at 06:46:10PM -0500, Scott Wood wrote:
> On 04/19/2013 05:47:34 AM, Zhao Chenhui wrote:
> >These cache operations support Freescale SoCs based on BOOK3E.
> >Move L1 cache operations to fsl_booke_cache.S in order to maintain
> >easily. And, add cache operations for backside L2 cache and
> >platform cache.
> >
> >The backside L2 cache appears on e500mc and e5500 core. The
> >platform cache
> >supported by this patch is L2 Look-Aside Cache, which appears on SoCs
> >with e500v1/e500v2 core, such as MPC8572, P1020, etc.
> >
> >Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> >Signed-off-by: Li Yang <leoli@freescale.com>
> >---
> > arch/powerpc/include/asm/cacheflush.h |    8 ++
> > arch/powerpc/kernel/Makefile          |    1 +
> > arch/powerpc/kernel/fsl_booke_cache.S |  210
> >+++++++++++++++++++++++++++++++++
> > arch/powerpc/kernel/head_fsl_booke.S  |   74 ------------
> > 4 files changed, 219 insertions(+), 74 deletions(-)
> > create mode 100644 arch/powerpc/kernel/fsl_booke_cache.S
> >
> >diff --git a/arch/powerpc/include/asm/cacheflush.h
> >b/arch/powerpc/include/asm/cacheflush.h
> >index b843e35..bc3f937 100644
> >--- a/arch/powerpc/include/asm/cacheflush.h
> >+++ b/arch/powerpc/include/asm/cacheflush.h
> >@@ -32,6 +32,14 @@ extern void flush_dcache_page(struct page *page);
> >
> > extern void __flush_disable_L1(void);
> >
> >+#ifdef CONFIG_FSL_SOC_BOOKE
> >+void flush_dcache_L1(void);
> >+void flush_backside_L2_cache(void);
> >+void disable_backside_L2_cache(void);
> >+void flush_disable_L2(void);
> >+void invalidate_enable_L2(void);
> >+#endif
> 
> Don't ifdef prototypes unless there's a good reason, such as
> providing an inline alternative.

I'll get rid of this "#ifdef".

> 
> Why do you have "flush_backside_L2_cache" and
> "disable_backside_L2_cache" as something different from
> "flush_disable_L2"?  The latter should flush whatever L2 is present.
> Don't treat pre-corenet as the default.
> 

These L2 caches are very different. The backside L2 is integrated in
the e500mc/e5500 core and controlled by SPR registers. But, the latter
L2 cache is on the SoC and controlled by registers mapped in CCSR.

> Why do we even need to distinguish L1 from L2 at all?  Shouldn't the
> function that gets exposed just be "flush and disable data caches
> that are specific to this cpu"?  What should happen on e6500?
> 
> -Scott

Yes. It is a good idea to use a set of uniform functions to operate the caches of
e500/e500mc/e5500/e6500 and SoCs. I'll think over your comments.

Thanks for you comments.

-Chenhui
