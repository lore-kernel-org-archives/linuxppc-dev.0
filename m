Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNXCQ32f4zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 21:14:26 +1000 (AEST)
In-Reply-To: <20160603034948.17589-1-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc: spinlock: Fix spin_unlock_wait()
Message-Id: <3rNXCQ1t8Nz9t42@ozlabs.org>
Date: Mon,  6 Jun 2016 21:14:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-03-06 at 03:49:48 UTC, Boqun Feng wrote:
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 523673d7583c..2ed893662866 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -64,6 +64,25 @@ static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  }
>  
>  /*
> + * Use a ll/sc loop to read the lock value, the STORE part of this operation is
> + * used for making later lock operation observe it.
> + */
> +static inline bool arch_spin_is_locked_sync(arch_spinlock_t *lock)
> +{
> +	arch_spinlock_t tmp;
> +
> +	__asm__ __volatile__(
> +"1:	" PPC_LWARX(%0, 0, %2, 1) "\n"

As discussed offline I think we want to use EH=0 here (the final parameter).

>From the ISA:

  The value of EH provides a hint as to whether the program will perform a
  subsequent store to the word in storage addressed by EA before some other
  processor attempts to modify it.

  0 Other programs might attempt to modify the word in storage addressed by EA
    regardless of the result of the corresponding stwcx. instruction.

cheers
