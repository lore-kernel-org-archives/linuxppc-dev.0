Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15371DDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 09:24:43 +1100 (EST)
Subject: Re: [PATCH] powerpc: Get rid of invalid shifts in math-emu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <410c322e7d7e4b9a420a7209f12dfbd105583f6f.1203708822.git.segher@kernel.crashing.org>
References: <410c322e7d7e4b9a420a7209f12dfbd105583f6f.1203708822.git.segher@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 23 Feb 2008 09:24:23 +1100
Message-Id: <1203719063.6976.22.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-02-22 at 21:01 +0100, Segher Boessenkool wrote:
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> ---

Amen !

_However_ there are significant code changes in there, and I don't
actually understand that code (well, I admit I haven't tried),
so it could definitely use a bit of a commit message explaining
the rationale (you are removing a lot of stuff), and maybe somebody
can run a few tests to make sure things work fine ?

Ben.

>  arch/powerpc/math-emu/op-2.h |   75 ++++++++++++++++-------------------------
>  1 files changed, 29 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/powerpc/math-emu/op-2.h b/arch/powerpc/math-emu/op-2.h
> index 7d6f17c..16d3e3c 100644
> --- a/arch/powerpc/math-emu/op-2.h
> +++ b/arch/powerpc/math-emu/op-2.h
> @@ -11,58 +11,43 @@
>  
>  #define _FP_FRAC_SLL_2(X,N)						\
>    do {									\
> -    if ((N) < _FP_W_TYPE_SIZE)						\
> +    int n = (N);							\
> +    if (n >= _FP_W_TYPE_SIZE)						\
>        {									\
> -        if (__builtin_constant_p(N) && (N) == 1) 			\
> -          {								\
> -            X##_f1 = X##_f1 + X##_f1 + (((_FP_WS_TYPE)(X##_f0)) < 0);	\
> -            X##_f0 += X##_f0;						\
> -          }								\
> -        else								\
> -          {								\
> -	    X##_f1 = X##_f1 << (N) | X##_f0 >> (_FP_W_TYPE_SIZE - (N));	\
> -	    X##_f0 <<= (N);						\
> -	  }								\
> -      }									\
> -    else								\
> -      {									\
> -	X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);			\
> +	X##_f1 = X##_f0;						\
>  	X##_f0 = 0;							\
> +	n -= _FP_W_TYPE_SIZE;						\
>        }									\
> +    X##_f1 = X##_f1 << n | X##_f0 >> (_FP_W_TYPE_SIZE - n - 1) >> 1;	\
> +    X##_f0 <<= n;							\
>    } while (0)
>  
>  #define _FP_FRAC_SRL_2(X,N)						\
>    do {									\
> -    if ((N) < _FP_W_TYPE_SIZE)						\
> -      {									\
> -	X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N));	\
> -	X##_f1 >>= (N);							\
> -      }									\
> -    else								\
> +    int n = (N);							\
> +    if (n >= _FP_W_TYPE_SIZE)						\
>        {									\
> -	X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);			\
> +	X##_f0 = X##_f1;						\
>  	X##_f1 = 0;							\
> +	n -= _FP_W_TYPE_SIZE;						\
>        }									\
> +    X##_f0 = X##_f0 >> n | X##_f1 << (_FP_W_TYPE_SIZE - n - 1) << 1;	\
> +    X##_f1 >>= n;							\
>    } while (0)
>  
>  /* Right shift with sticky-lsb.  */
>  #define _FP_FRAC_SRS_2(X,N,sz)						\
>    do {									\
> -    if ((N) < _FP_W_TYPE_SIZE)						\
> -      {									\
> -	X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N) |	\
> -		  (__builtin_constant_p(N) && (N) == 1			\
> -		   ? X##_f0 & 1						\
> -		   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0));	\
> -	X##_f1 >>= (N);							\
> -      }									\
> -    else								\
> +    int n = (N);							\
> +    if (n >= _FP_W_TYPE_SIZE)						\
>        {									\
> -	X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE) |			\
> -	          (((X##_f1 << (2 * _FP_W_TYPE_SIZE - (N))) |		\
> -		   X##_f0) != 0));					\
> +	X##_f0 = X##_f1;						\
>  	X##_f1 = 0;							\
> +	n -= _FP_W_TYPE_SIZE;						\
>        }									\
> +    X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - n - 1) << 1 | X##_f0 >> n |	\
> +	      ((X##_f0 << (_FP_W_TYPE_SIZE - n - 1) << 1) != 0));	\
> +    X##_f1 >>= n;							\
>    } while (0)
>  
>  #define _FP_FRAC_ADDI_2(X,I) \
> @@ -398,20 +383,18 @@
>  
>  #define _FP_FRAC_ASSEMBLE_2(r, X, rsize)	\
>    do {						\
> -    if (rsize <= _FP_W_TYPE_SIZE)		\
> -      r = X##_f0;				\
> -    else					\
> -      {						\
> -	r = X##_f1;				\
> -	r <<= _FP_W_TYPE_SIZE;			\
> -	r += X##_f0;				\
> -      }						\
> +    r = X##_f1;					\
> +    r <<= _FP_W_TYPE_SIZE - 1;			\
> +    r <<= 1;					\
> +    r += X##_f0;				\
>    } while (0)
>  
> -#define _FP_FRAC_DISASSEMBLE_2(X, r, rsize)				\
> -  do {									\
> -    X##_f0 = r;								\
> -    X##_f1 = (rsize <= _FP_W_TYPE_SIZE ? 0 : r >> _FP_W_TYPE_SIZE);	\
> +#define _FP_FRAC_DISASSEMBLE_2(X, r, rsize)	\
> +  do {						\
> +    X##_f0 = r;					\
> +    r >>= _FP_W_TYPE_SIZE - 1;			\
> +    r >>= 1;					\
> +    X##_f1 = r;					\
>    } while (0)
>  
>  /*
