Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 2/2] spufs: use simple_write_to_buffer()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <201101182109.p0IL9A3h005454@imap1.linux-foundation.org>
References: <201101182109.p0IL9A3h005454@imap1.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 08:22:29 +1100
Message-ID: <1295385749.2148.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, akinobu.mita@gmail.com,
	arnd@arndb.de, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-01-18 at 13:09 -0800, akpm@linux-foundation.org wrote:
> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Simplify several write fileoperations for spufs by using
> simple_write_to_buffer().

I'll pick that one up too.

Cheers,
Ben.

> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Jeremy Kerr <jk@ozlabs.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/platforms/cell/spufs/file.c |   27 +++++----------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff -puN arch/powerpc/platforms/cell/spufs/file.c~spufs-use-simple_write_to_buffer arch/powerpc/platforms/cell/spufs/file.c
> --- a/arch/powerpc/platforms/cell/spufs/file.c~spufs-use-simple_write_to_buffer
> +++ a/arch/powerpc/platforms/cell/spufs/file.c
> @@ -219,24 +219,17 @@ spufs_mem_write(struct file *file, const
>  	loff_t pos = *ppos;
>  	int ret;
>  
> -	if (pos < 0)
> -		return -EINVAL;
>  	if (pos > LS_SIZE)
>  		return -EFBIG;
> -	if (size > LS_SIZE - pos)
> -		size = LS_SIZE - pos;
>  
>  	ret = spu_acquire(ctx);
>  	if (ret)
>  		return ret;
>  
>  	local_store = ctx->ops->get_ls(ctx);
> -	ret = copy_from_user(local_store + pos, buffer, size);
> +	size = simple_write_to_buffer(local_store, LS_SIZE, ppos, buffer, size);
>  	spu_release(ctx);
>  
> -	if (ret)
> -		return -EFAULT;
> -	*ppos = pos + size;
>  	return size;
>  }
>  
> @@ -574,18 +567,15 @@ spufs_regs_write(struct file *file, cons
>  	if (*pos >= sizeof(lscsa->gprs))
>  		return -EFBIG;
>  
> -	size = min_t(ssize_t, sizeof(lscsa->gprs) - *pos, size);
> -	*pos += size;
> -
>  	ret = spu_acquire_saved(ctx);
>  	if (ret)
>  		return ret;
>  
> -	ret = copy_from_user((char *)lscsa->gprs + *pos - size,
> -			     buffer, size) ? -EFAULT : size;
> +	size = simple_write_to_buffer(lscsa->gprs, sizeof(lscsa->gprs), pos,
> +					buffer, size);
>  
>  	spu_release_saved(ctx);
> -	return ret;
> +	return size;
>  }
>  
>  static const struct file_operations spufs_regs_fops = {
> @@ -630,18 +620,15 @@ spufs_fpcr_write(struct file *file, cons
>  	if (*pos >= sizeof(lscsa->fpcr))
>  		return -EFBIG;
>  
> -	size = min_t(ssize_t, sizeof(lscsa->fpcr) - *pos, size);
> -
>  	ret = spu_acquire_saved(ctx);
>  	if (ret)
>  		return ret;
>  
> -	*pos += size;
> -	ret = copy_from_user((char *)&lscsa->fpcr + *pos - size,
> -			     buffer, size) ? -EFAULT : size;
> +	size = simple_write_to_buffer(&lscsa->fpcr, sizeof(lscsa->fpcr), pos,
> +					buffer, size);
>  
>  	spu_release_saved(ctx);
> -	return ret;
> +	return size;
>  }
>  
>  static const struct file_operations spufs_fpcr_fops = {
> _
