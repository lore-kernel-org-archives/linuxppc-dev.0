Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 24 Feb 2006 10:16:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Herring <olh@suse.de>
Subject: Re: [PATCH] change compat shmget size arg to signed
Message-Id: <20060224101644.548b0c24.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olaf,

> change second arg (the 'size') to signed to handle a size of -1.
> ltp test shmget02 fails. This patch fixes it.
> Oddly, we see the failure only on a POWER4 LPAR with 4.6G ram.
> 
> Signed-off-by: Olaf Hering <olh at suse.de>
> 
>  arch/powerpc/kernel/sys_ppc32.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6.16-rc4-olh/arch/powerpc/kernel/sys_ppc32.c
> ===================================================================
> --- linux-2.6.16-rc4-olh.orig/arch/powerpc/kernel/sys_ppc32.c
> +++ linux-2.6.16-rc4-olh/arch/powerpc/kernel/sys_ppc32.c
> @@ -429,7 +429,7 @@ long compat_sys_ipc(u32 call, u32 first,
>  		return sys_shmdt(compat_ptr(ptr));
>  	case SHMGET:
>  		/* sign extend key_t */
> -		return sys_shmget((int)first, second, third);
> +		return sys_shmget((int)first, (int)second, third);
>  	case SHMCTL:
>  		/* sign extend shmid */
>  		return compat_sys_shmctl((int)first, second, compat_ptr(ptr));

Does the ltp test fail on a standard kernel(where SHMMAX is 0x2000000), or
only on a SLES kernel (where SHMMAX is ULONG_MAX)?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
