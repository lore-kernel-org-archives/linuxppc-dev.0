Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 272BB2C0456
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 13:35:02 +1100 (EST)
Message-ID: <1383532491.4776.42.camel@pasglop>
Subject: Re: [V2 PATCH 3/3] powerpc: Fix Unaligned LE Floating Point Loads
 and Stores
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom <tommusta@gmail.com>
Date: Mon, 04 Nov 2013 13:34:51 +1100
In-Reply-To: <1383244738-5986-4-git-send-email-tommusta@gmail.com>
References: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
 <1383244738-5986-4-git-send-email-tommusta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-31 at 13:38 -0500, Tom wrote:
> From: Tom Musta <tommusta@gmail.com>
> 
> This patch addresses unaligned single precision floating point loads
> and stores in the single-step code.  The old implementation
> improperly treated an 8 byte structure as an array of two 4 byte
> words, which is a classic little endian bug.

Do that patch differ from v1 ? I also already merged v1 of this
one (the only one I didn't merge is the emulate_step one)

Cheers,
Ben.

> Signed-off-by: Tom Musta <tommusta@gmail.com>
> ---
>  arch/powerpc/lib/sstep.c |   52 +++++++++++++++++++++++++++++++++++----------
>  1 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index c8743e1..1cfd150 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -355,22 +355,36 @@ static int __kprobes do_fp_load(int rn, int (*func)(int, unsigned long),
>  				struct pt_regs *regs)
>  {
>  	int err;
> -	unsigned long val[sizeof(double) / sizeof(long)];
> +	union {
> +		double dbl;
> +		unsigned long ul[2];
> +		struct {
> +#ifdef __BIG_ENDIAN__
> +			unsigned _pad_;
> +			unsigned word;
> +#endif
> +#ifdef __LITTLE_ENDIAN__
> +			unsigned word;
> +			unsigned _pad_;
> +#endif
> +		} single;
> +	} data;
>  	unsigned long ptr;
>  
>  	if (!address_ok(regs, ea, nb))
>  		return -EFAULT;
>  	if ((ea & 3) == 0)
>  		return (*func)(rn, ea);
> -	ptr = (unsigned long) &val[0];
> +	ptr = (unsigned long) &data.ul;
>  	if (sizeof(unsigned long) == 8 || nb == 4) {
> -		err = read_mem_unaligned(&val[0], ea, nb, regs);
> -		ptr += sizeof(unsigned long) - nb;
> +		err = read_mem_unaligned(&data.ul[0], ea, nb, regs);
> +		if (nb == 4)
> +			ptr = (unsigned long)&(data.single.word);
>  	} else {
>  		/* reading a double on 32-bit */
> -		err = read_mem_unaligned(&val[0], ea, 4, regs);
> +		err = read_mem_unaligned(&data.ul[0], ea, 4, regs);
>  		if (!err)
> -			err = read_mem_unaligned(&val[1], ea + 4, 4, regs);
> +			err = read_mem_unaligned(&data.ul[1], ea + 4, 4, regs);
>  	}
>  	if (err)
>  		return err;
> @@ -382,28 +396,42 @@ static int __kprobes do_fp_store(int rn, int (*func)(int, unsigned long),
>  				 struct pt_regs *regs)
>  {
>  	int err;
> -	unsigned long val[sizeof(double) / sizeof(long)];
> +	union {
> +		double dbl;
> +		unsigned long ul[2];
> +		struct {
> +#ifdef __BIG_ENDIAN__
> +			unsigned _pad_;
> +			unsigned word;
> +#endif
> +#ifdef __LITTLE_ENDIAN__
> +			unsigned word;
> +			unsigned _pad_;
> +#endif
> +		} single;
> +	} data;
>  	unsigned long ptr;
>  
>  	if (!address_ok(regs, ea, nb))
>  		return -EFAULT;
>  	if ((ea & 3) == 0)
>  		return (*func)(rn, ea);
> -	ptr = (unsigned long) &val[0];
> +	ptr = (unsigned long) &data.ul[0];
>  	if (sizeof(unsigned long) == 8 || nb == 4) {
> -		ptr += sizeof(unsigned long) - nb;
> +		if (nb == 4)
> +			ptr = (unsigned long)&(data.single.word);
>  		err = (*func)(rn, ptr);
>  		if (err)
>  			return err;
> -		err = write_mem_unaligned(val[0], ea, nb, regs);
> +		err = write_mem_unaligned(data.ul[0], ea, nb, regs);
>  	} else {
>  		/* writing a double on 32-bit */
>  		err = (*func)(rn, ptr);
>  		if (err)
>  			return err;
> -		err = write_mem_unaligned(val[0], ea, 4, regs);
> +		err = write_mem_unaligned(data.ul[0], ea, 4, regs);
>  		if (!err)
> -			err = write_mem_unaligned(val[1], ea + 4, 4, regs);
> +			err = write_mem_unaligned(data.ul[1], ea + 4, 4, regs);
>  	}
>  	return err;
>  }
