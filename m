Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C99B92C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 20:36:45 +1000 (EST)
Message-ID: <1375785398.12557.62.camel@pasglop>
Subject: Re: [PATCH 3/3] powerpc: check CPU_FTR_COHERENT_ICACHE in
 __flush_dcache_icache for 64bit kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Tue, 06 Aug 2013 20:36:38 +1000
In-Reply-To: <1375784612-14399-4-git-send-email-haokexin@gmail.com>
References: <1375784612-14399-1-git-send-email-haokexin@gmail.com>
 <1375784612-14399-4-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-06 at 18:23 +0800, Kevin Hao wrote:
> We don't need to flush the dcache and invalidate the icache on the
> CPU which has CPU_FTR_COHERENT_ICACHE set.

Actually we probably need an isync...

Ben.

> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/kernel/misc_64.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index a781566..32e78e2 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -207,6 +207,9 @@ _GLOBAL(flush_inval_dcache_range)
>   *	void __flush_dcache_icache(void *page)
>   */
>  _GLOBAL(__flush_dcache_icache)
> +BEGIN_FTR_SECTION
> +	blr
> +END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  /*
>   * Flush the data cache to memory 
>   * 
