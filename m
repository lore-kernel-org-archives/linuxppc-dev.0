Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1A5761007E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 03:47:50 +1100 (EST)
Date: Thu, 10 Nov 2011 10:47:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Subject: Re: [RFC PATCH 16/17] powerpc/e500: Make
 __setup_cpu_{e200,e500,e500mc,e5500} optional
Message-ID: <20111110164741.GC11983@schlenkerla.am.freescale.net>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-17-git-send-email-Kyle.D.Moffett@boeing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1320883635-17194-17-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Shaohui Xie <b21989@freescale.com>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Timur Tabi <B04825@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2011 at 07:07:14PM -0500, Kyle Moffett wrote:
> Only build the setup functions when the corresponding entries are
> included in the CPU table.
> 
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> ---
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index 8053db0..77721b2 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -17,6 +17,8 @@
>  #include <asm/cputable.h>
>  #include <asm/ppc_asm.h>
>  
> +#if defined(CONFIG_FSL_E500_V1_V2) || defined(CONFIG_FSL_E500MC) \
> +		|| defined(CONFIG_FSL_E5500)

This seems like the kind of thing that CONFIG_E500 should be retained
for.

-Scott
