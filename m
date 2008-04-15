Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18436.32670.670138.323139@cargo.ozlabs.ibm.com>
Date: Tue, 15 Apr 2008 20:12:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 09/12] [POWERPC] Move phys_addr_t definition into
	asm/types.h
In-Reply-To: <1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-5-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-6-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-7-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-8-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-9-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Moved phys_addr_t out of mmu-*.h and into asm/types.h so we can use it in
> places that before would have caused recursive includes.

...

> diff --git a/include/asm-powerpc/types.h b/include/asm-powerpc/types.h
> index 903fd19..d853cf0 100644
> --- a/include/asm-powerpc/types.h
> +++ b/include/asm-powerpc/types.h
> @@ -50,6 +50,13 @@ typedef struct {
>  	__u32 u[4];
>  } __attribute__((aligned(16))) __vector128;
>  
> +/* Physical address used by some IO functions */
> +#if defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
> +typedef __u64 phys_addr_t;
> +#else
> +typedef __u32 phys_addr_t;
> +#endif

That appears to be being added in the part of that file that is
visible to userspace, which isn't a good idea, since phys_addr_t is
not something we want to export to userspace.

I can fix up the patch when I apply it if you like.

Paul.
