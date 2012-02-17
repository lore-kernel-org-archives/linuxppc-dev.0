Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3C0901007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 17:07:57 +1100 (EST)
Message-ID: <1329458860.2892.57.camel@pasglop>
Subject: Re: linux-next: build failure after merge of the final tree (akpm
 tree related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 17 Feb 2012 17:07:40 +1100
In-Reply-To: <20120217163057.8af53b853b36365b7fff203c@canb.auug.org.au>
References: <20120217163057.8af53b853b36365b7fff203c@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 16:30 +1100, Stephen Rothwell wrote:
> Hi Andrew,
> 
> After merging the final tree, today's linux-next build (powerpc
> allnoconfig) failed like this:
> 
> In file included from include/linux/posix_types.h:47:0,
>                  from include/linux/types.h:17,
>                  from include/linux/page-flags.h:8,
>                  from kernel/bounds.c:9:
> arch/powerpc/include/asm/posix_types.h:15:14: error: conflicting types for '__kernel_size_t'
> arch/powerpc/include/asm/posix_types.h:14:22: note: previous declaration of '__kernel_size_t' was here
> In file included from include/linux/page-flags.h:8:0,
>                  from kernel/bounds.c:9:
> include/linux/types.h:68:1: error: unknown type name '__kernel_ssize_t'
> 
> Caused by commit a9dbe86e5995 ("powerpc: use generic posix_types.h").
> 
> This think was pointed out a couple of days ago, so maybe Andrew needs a
> newer version of the patch.

Yes, I pointed that out to Peter a while back, maybe it got lost ...

Cheers,
Ben.

> I added this fix patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 17 Feb 2012 16:25:48 +1100
> Subject: [PATCH] powerpc: use generic posix_types.h fix
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/asm/posix_types.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/posix_types.h b/arch/powerpc/include/asm/posix_types.h
> index 1fbe027f..f139325 100644
> --- a/arch/powerpc/include/asm/posix_types.h
> +++ b/arch/powerpc/include/asm/posix_types.h
> @@ -12,7 +12,7 @@ typedef unsigned long	__kernel_old_dev_t;
>  #define __kernel_old_dev_t __kernel_old_dev_t
>  #else
>  typedef unsigned int	__kernel_size_t;
> -typedef int		__kernel_size_t;
> +typedef int		__kernel_ssize_t;
>  typedef long		__kernel_ptrdiff_t;
>  #define __kernel_size_t __kernel_size_t
>  
> -- 
> 1.7.9
> 
