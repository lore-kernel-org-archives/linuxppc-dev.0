Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 40ED9B71E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 00:04:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93462DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 00:04:58 +1000 (EST)
Message-Id: <55D4E406-B6C5-471F-B7FF-86106CCC0ABF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18994.17381.129339.162342@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH RFC] powerpc: Implement atomic64_t for 32-bit processors
Date: Fri, 12 Jun 2009 09:04:52 -0500
References: <18994.17381.129339.162342@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 12, 2009, at 7:02 AM, Paul Mackerras wrote:

> 32-bit powerpc processors have no 64-bit atomic instructions, but we  
> will
> need atomic64_t in order to support the perf_counter subsystem on 32- 
> bit
> processors.
>
> This adds an implementation of 64-bit atomic operations using hashed
> spinlocks to provide atomicity.  For each atomic operation, the  
> address
> of the atomic64_t variable is hashed to an index into an array of 16
> spinlocks.  That spinlock is taken (with interrupts disabled) around  
> the
> operation, which can then be coded non-atomically within the lock.
>
> On UP, all the spinlock manipulation goes away and we simply disable
> interrupts around each operation.  In fact gcc eliminates the whole
> atomic64_lock variable as well.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> Compile-tested only at this stage, which is why it's [RFC].

any reason not to make this lib/asm generic?  Seems like it isn't ppc  
specific.

- k
