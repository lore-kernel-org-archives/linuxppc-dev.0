Return-Path: <SRS0+4f1e0d28af8560107a14+1293+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE591DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 17:55:51 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Wire up sys_sync_file_range
From: David Woodhouse <dwmw2@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
References: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 06:55:41 +0000
Message-Id: <1173423341.3461.548.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>,
	paulus@samba.org, rmk@arm.linux.org.uk, ralf@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-09 at 15:22 +1100, Stephen Rothwell wrote:
> This requires an architecture specific compat routine as u64s are passed
> in odd/even (high/low) register pairs on ppc32.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Doesn't that apply to ARM and to 32-bit MIPS too? And perhaps others?

> --- a/arch/powerpc/kernel/sys_ppc32.c
> +++ b/arch/powerpc/kernel/sys_ppc32.c
> @@ -814,3 +814,12 @@ asmlinkage long compat_sys_request_key(const char __user *_type,
>  	return sys_request_key(_type, _description, _callout_info, destringid);
>  }
>  
> +asmlinkage long compat_sys_sync_file_range(int fd, u32 unused,
> +		u32 offset_high, u32 offset_low,
> +		u32 nbytes_high, u32 nbytes_low,
> +		compat_uint_t flags)
> +{
> +	return sys_sync_file_range(fd, (loff_t)offset_high << 32 | offset_low,
> +			(loff_t)nbytes_high << 32 | nbytes_low,
> +			(unsigned int)flags);
> +}

-- 
dwmw2
