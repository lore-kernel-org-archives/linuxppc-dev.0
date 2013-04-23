Return-Path: <B35336@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAC952C0142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 19:53:59 +1000 (EST)
Date: Tue, 23 Apr 2013 17:53:37 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: Re: [linuxppc-release] [PATCH v2 01/15] powerpc/85xx: cache
 operations for Freescale SoCs based on BOOK3E
Message-ID: <20130423095337.GA26010@localhost.localdomain>
References: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar, Scott,

Do you have any comments on this set of patches?

Best Regards,
-Chenhui

On Fri, Apr 19, 2013 at 06:47:34PM +0800, Zhao Chenhui wrote:
> These cache operations support Freescale SoCs based on BOOK3E.
> Move L1 cache operations to fsl_booke_cache.S in order to maintain
> easily. And, add cache operations for backside L2 cache and platform cache.
> 
> The backside L2 cache appears on e500mc and e5500 core. The platform cache
> supported by this patch is L2 Look-Aside Cache, which appears on SoCs
> with e500v1/e500v2 core, such as MPC8572, P1020, etc.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/include/asm/cacheflush.h |    8 ++
>  arch/powerpc/kernel/Makefile          |    1 +
>  arch/powerpc/kernel/fsl_booke_cache.S |  210 +++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/head_fsl_booke.S  |   74 ------------
>  4 files changed, 219 insertions(+), 74 deletions(-)
>  create mode 100644 arch/powerpc/kernel/fsl_booke_cache.S
> 
