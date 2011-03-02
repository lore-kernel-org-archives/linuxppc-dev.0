Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA4FDB6EED
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2011 14:08:48 +1100 (EST)
Subject: Re: [PATCH] powerpc/ptrace: remove BUG_ON when full register set
	not available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mjw@us.ibm.com
In-Reply-To: <1299011204.28753.8.camel@w500>
References: <1299011204.28753.8.camel@w500>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 14:08:36 +1100
Message-ID: <1299035316.8833.806.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> --- ptracev2.orig/include/linux/regset.h	2011-02-20 12:15:57.000000000 -0600
> +++ ptracev2/include/linux/regset.h	2011-02-28 13:33:36.685302349 -0600
> @@ -240,6 +240,34 @@ static inline int user_regset_copyout(un
>  	}
>  	return 0;
>  }
> +/* want the count to be the registers 14-31 inclusive */
> +#define POISON_REG_CNT (PT_R31-PT_R14+1)
> +static inline int user_regset_copyout_poison(unsigned int *pos,
> +					   unsigned int *count,
> +					   void **kbuf, void __user **ubuf,
> +					   const int start_pos,
> +					   const int end_pos)
> +{

I wouldn't put that in a generic location... especially something
like POISON_REG_CNT is very specific to powerpc and our ABI.

.../...

>  static inline int user_regset_copyin(unsigned int *pos, unsigned int *count,
>  				     const void **kbuf,
> --- ptracev2.orig/arch/powerpc/kernel/ptrace.c	2011-02-20 12:15:57.000000000 -0600
> +++ ptracev2/arch/powerpc/kernel/ptrace.c	2011-03-01 13:49:12.686354353 -0600
> @@ -234,11 +234,29 @@ static int gpr_get(struct task_struct *t
>  	if (target->thread.regs == NULL)
>  		return -EIO;
>  
> -	CHECK_FULL_REGS(target->thread.regs);

Wouldn't it be a simpler/cleaner approach to use a single function call
here that checks if the reg set is full and if not, put poison values
in the thread.regs structure itself ?

The resulting code would be more palatable...

Cheers,
Ben.
 
> -	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -				  target->thread.regs,
> -				  0, offsetof(struct pt_regs, msr));
> +	if (!FULL_REGS(target->thread.regs)) {
> +                /* Don't have the full register set. Copy out register r0-r13 */
> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +					  target->thread.regs,
> +					  0, sizeof(long)*PT_R14);
> +
> +		/* Dont want to change the actual register values so rather than read the */
> +		/* actual register copy a poison value into the buffer instead		  */
> +		if (!ret)
> +			ret = user_regset_copyout_poison(&pos, &count, &kbuf, &ubuf,
> +						  sizeof(long)*PT_R14, offsetof(struct pt_regs, nip));
> +
> +		/* Copy out the rest of the registers as usual */
> +		if (!ret)
> +			ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +						  target->thread.regs,
> +						  offsetof(struct pt_regs, nip), offsetof(struct pt_regs, msr));
> +		
> +	} else 
> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +					  target->thread.regs,
> +					  0, offsetof(struct pt_regs, msr));
>  	if (!ret) {
>  		unsigned long msr = get_user_msr(target);
>  		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &msr,
> @@ -645,11 +663,29 @@ static int gpr32_get(struct task_struct 
>  	if (target->thread.regs == NULL)
>  		return -EIO;
>  
> -	CHECK_FULL_REGS(target->thread.regs);
> -
>  	pos /= sizeof(reg);
>  	count /= sizeof(reg);
>  
> +	if(!FULL_REGS(target->thread.regs)) {
> +		if (kbuf) {
> +                	/* Don't have the full register set. Copy out register r0-r13 */
> +			for (; count > 0 && pos < PT_R14; --count)
> +				*k++ = regs[pos++];
> +
> +			/* Dont want to change the actual register values so rather than read the */
> +			/* actual register copy a poison value into the buffer instead		  */
> +			for (; count > 0 && pos <= PT_R31; --count,pos++)
> +				*k++ = 0xdeadbeef;
> +
> +		} else { 
> +			for (; count > 0 && pos < PT_R14; --count)
> +				if (__put_user((compat_ulong_t) regs[pos++], u++))
> +					return -EFAULT;
> +			for (; count > 0 && pos <= PT_R31; --count,pos++)
> +				if (__put_user((compat_ulong_t) 0xdeadbeef, u++))
> +					return -EFAULT;
> +		}
> +	}
>  	if (kbuf)
>  		for (; count > 0 && pos < PT_MSR; --count)
>  			*k++ = regs[pos++];
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
