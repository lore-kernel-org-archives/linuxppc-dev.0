Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54803DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 17:47:27 +1000 (EST)
Date: Wed, 25 Jun 2008 08:46:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Message-ID: <20080625074602.GA14791@flint.arm.linux.org.uk>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: chris@zankel.net, dev-etrax@axis.com, ysato@users.sourceforge.jp,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@linux-mips.org, cooloney@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gerg@uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>,
	yasutake.koichi@jp.panasonic.com, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 08:48:09PM +0300, Adrian Bunk wrote:
> diff --git a/include/asm-arm/ptrace.h b/include/asm-arm/ptrace.h
> index 7aaa206..8382b75 100644
> --- a/include/asm-arm/ptrace.h
> +++ b/include/asm-arm/ptrace.h
> @@ -139,8 +139,6 @@ static inline int valid_user_regs(struct pt_regs *regs)
>  	return 0;
>  }
>  
> -#endif	/* __KERNEL__ */
> -
>  #define pc_pointer(v) \
>  	((v) & ~PCMASK)
>  
> @@ -153,10 +151,10 @@ extern unsigned long profile_pc(struct pt_regs *regs);
>  #define profile_pc(regs) instruction_pointer(regs)
>  #endif
>  
> -#ifdef __KERNEL__
>  #define predicate(x)		((x) & 0xf0000000)
>  #define PREDICATE_ALWAYS	0xe0000000
> -#endif
> +
> +#endif /* __KERNEL__ */
>  
>  #endif /* __ASSEMBLY__ */
>  

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
