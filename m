Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr7.xs4all.nl (smtp-vbr7.xs4all.nl [194.109.24.27])
	by ozlabs.org (Postfix) with ESMTP id 597D5DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 17:32:44 +1000 (EST)
Message-ID: <49E58C10.4080100@aimvalley.nl>
Date: Wed, 15 Apr 2009 09:26:08 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Fix bug in __futex_atomic_op
References: <18915.54309.632699.346771@cargo.ozlabs.ibm.com>
In-Reply-To: <18915.54309.632699.346771@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I'd like to understand the implications of this bug.
Obviously applications using the futex system can be affected, but
does anybody know whether GNU software packages suffer from this problem.
I mean glibc (nptl) uses futexes, so does gdb and gcc. will this bug hurt
them ?



Paul Mackerras wrote:
> Richard Henderson pointed out that the powerpc __futex_atomic_op has a
> bug: it will write the wrong value if the stwcx. fails and it has to
> retry the lwarx/stwcx. loop, since 'oparg' will have been overwritten
> by the result from the first time around the loop.  This happens
> because it uses the same register for 'oparg' (an input) as it uses
> for the result.
> 
> This fixes it by using separate registers for 'oparg' and 'ret'.
> 
> Cc: stable@kernel.org
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> Can anyone see any reason why the FUTEX_OP_SET case can't just do a
> __put_user?
> 
> diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
> index 6d406c5..9696cc3 100644
> --- a/arch/powerpc/include/asm/futex.h
> +++ b/arch/powerpc/include/asm/futex.h
> @@ -27,7 +27,7 @@
>  	PPC_LONG "1b,4b,2b,4b\n" \
>  	".previous" \
>  	: "=&r" (oldval), "=&r" (ret) \
> -	: "b" (uaddr), "i" (-EFAULT), "1" (oparg) \
> +	: "b" (uaddr), "i" (-EFAULT), "r" (oparg) \
>  	: "cr0", "memory")
>  
>  static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
> @@ -47,19 +47,19 @@ static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
>  
>  	switch (op) {
>  	case FUTEX_OP_SET:
> -		__futex_atomic_op("", ret, oldval, uaddr, oparg);
> +		__futex_atomic_op("mr %1,%4\n", ret, oldval, uaddr, oparg);
>  		break;
>  	case FUTEX_OP_ADD:
> -		__futex_atomic_op("add %1,%0,%1\n", ret, oldval, uaddr, oparg);
> +		__futex_atomic_op("add %1,%0,%4\n", ret, oldval, uaddr, oparg);
>  		break;
>  	case FUTEX_OP_OR:
> -		__futex_atomic_op("or %1,%0,%1\n", ret, oldval, uaddr, oparg);
> +		__futex_atomic_op("or %1,%0,%4\n", ret, oldval, uaddr, oparg);
>  		break;
>  	case FUTEX_OP_ANDN:
> -		__futex_atomic_op("andc %1,%0,%1\n", ret, oldval, uaddr, oparg);
> +		__futex_atomic_op("andc %1,%0,%4\n", ret, oldval, uaddr, oparg);
>  		break;
>  	case FUTEX_OP_XOR:
> -		__futex_atomic_op("xor %1,%0,%1\n", ret, oldval, uaddr, oparg);
> +		__futex_atomic_op("xor %1,%0,%4\n", ret, oldval, uaddr, oparg);
>  		break;
>  	default:
>  		ret = -ENOSYS;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
