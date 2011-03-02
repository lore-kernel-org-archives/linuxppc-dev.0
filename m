Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F2D9B70BA
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2011 02:44:32 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p22FXm8g008293
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 08:33:48 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p22FiGRK109536
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 08:44:18 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p22FiFY0017321
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 08:44:16 -0700
Subject: Re: [PATCH] powerpc/ptrace: remove BUG_ON when full register set
	not available
From: Michael Wolf <mjw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1299035316.8833.806.camel@pasglop>
References: <1299011204.28753.8.camel@w500> <1299035316.8833.806.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 09:44:09 -0600
Message-ID: <1299080649.3087.6.camel@w500>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Reply-To: mjw@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-02 at 14:08 +1100, Benjamin Herrenschmidt wrote:
> > --- ptracev2.orig/include/linux/regset.h	2011-02-20 12:15:57.000000000 -0600
> > +++ ptracev2/include/linux/regset.h	2011-02-28 13:33:36.685302349 -0600
> > @@ -240,6 +240,34 @@ static inline int user_regset_copyout(un
> >  	}
> >  	return 0;
> >  }
> > +/* want the count to be the registers 14-31 inclusive */
> > +#define POISON_REG_CNT (PT_R31-PT_R14+1)
> > +static inline int user_regset_copyout_poison(unsigned int *pos,
> > +					   unsigned int *count,
> > +					   void **kbuf, void __user **ubuf,
> > +					   const int start_pos,
> > +					   const int end_pos)
> > +{
> 
> I wouldn't put that in a generic location... especially something
> like POISON_REG_CNT is very specific to powerpc and our ABI.

Yeah I put it there thinking about readability but only use it in the
one place.  If we go forward with this current strategy I will remove
the #define and just comment more.

> 
> .../...
> 
> >  static inline int user_regset_copyin(unsigned int *pos, unsigned int *count,
> >  				     const void **kbuf,
> > --- ptracev2.orig/arch/powerpc/kernel/ptrace.c	2011-02-20 12:15:57.000000000 -0600
> > +++ ptracev2/arch/powerpc/kernel/ptrace.c	2011-03-01 13:49:12.686354353 -0600
> > @@ -234,11 +234,29 @@ static int gpr_get(struct task_struct *t
> >  	if (target->thread.regs == NULL)
> >  		return -EIO;
> >  
> > -	CHECK_FULL_REGS(target->thread.regs);
> 
> Wouldn't it be a simpler/cleaner approach to use a single function call
> here that checks if the reg set is full and if not, put poison values
> in the thread.regs structure itself ?
> 
> The resulting code would be more palatable...

That was actually the way I had done the first patch while debugging the
problem but Paul Mackerras didn't like that I changed the thread struct.

It is not clear to me which is better.  Reporting a poison value that 
isn't actually there or to change the data.  Hopefully a consensus can
be reached and then I can submit a new patch based on that.

> 
> Cheers,
> Ben.
> 
> > -	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> > -				  target->thread.regs,
> > -				  0, offsetof(struct pt_regs, msr));
> > +	if (!FULL_REGS(target->thread.regs)) {
> > +                /* Don't have the full register set. Copy out register r0-r13 */
> > +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> > +					  target->thread.regs,
> > +					  0, sizeof(long)*PT_R14);
> > +
> > +		/* Dont want to change the actual register values so rather than read the */
> > +		/* actual register copy a poison value into the buffer instead		  */
> > +		if (!ret)
> > +			ret = user_regset_copyout_poison(&pos, &count, &kbuf, &ubuf,
> > +						  sizeof(long)*PT_R14, offsetof(struct pt_regs, nip));
> > +
> > +		/* Copy out the rest of the registers as usual */
> > +		if (!ret)
> > +			ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> > +						  target->thread.regs,
> > +						  offsetof(struct pt_regs, nip), offsetof(struct pt_regs, msr));
> > +		
> > +	} else 
> > +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> > +					  target->thread.regs,
> > +					  0, offsetof(struct pt_regs, msr));
> >  	if (!ret) {
> >  		unsigned long msr = get_user_msr(target);
> >  		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &msr,
> > @@ -645,11 +663,29 @@ static int gpr32_get(struct task_struct 
> >  	if (target->thread.regs == NULL)
> >  		return -EIO;
> >  
> > -	CHECK_FULL_REGS(target->thread.regs);
> > -
> >  	pos /= sizeof(reg);
> >  	count /= sizeof(reg);
> >  
> > +	if(!FULL_REGS(target->thread.regs)) {
> > +		if (kbuf) {
> > +                	/* Don't have the full register set. Copy out register r0-r13 */
> > +			for (; count > 0 && pos < PT_R14; --count)
> > +				*k++ = regs[pos++];
> > +
> > +			/* Dont want to change the actual register values so rather than read the */
> > +			/* actual register copy a poison value into the buffer instead		  */
> > +			for (; count > 0 && pos <= PT_R31; --count,pos++)
> > +				*k++ = 0xdeadbeef;
> > +
> > +		} else { 
> > +			for (; count > 0 && pos < PT_R14; --count)
> > +				if (__put_user((compat_ulong_t) regs[pos++], u++))
> > +					return -EFAULT;
> > +			for (; count > 0 && pos <= PT_R31; --count,pos++)
> > +				if (__put_user((compat_ulong_t) 0xdeadbeef, u++))
> > +					return -EFAULT;
> > +		}
> > +	}
> >  	if (kbuf)
> >  		for (; count > 0 && pos < PT_MSR; --count)
> >  			*k++ = regs[pos++];
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
