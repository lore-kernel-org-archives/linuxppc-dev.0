Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 161DBB7B98
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 14:19:32 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1A3G6TQ026618
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2010 20:16:06 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o1A3JPJq178562
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2010 20:19:25 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1A3JPTL009111
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Feb 2010 20:19:25 -0700
Date: Tue, 9 Feb 2010 22:19:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Use lwarx hint bit in spinlocks
Message-ID: <20100210031923.GB16178@zod.rchland.ibm.com>
References: <20100210025010.GC3702@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210025010.GC3702@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2010 at 01:50:11PM +1100, Anton Blanchard wrote:
>
>Recent versions of the PowerPC architecture added a hint bit to the larx
>instructions to differentiate between an atomic operation and a lock operation:
>
>> 0 Other programs might attempt to modify the word in storage addressed by EA
>> even if the subsequent Store Conditional succeeds.
>> 
>> 1 Other programs will not attempt to modify the word in storage addressed by
>> EA until the program that has acquired the lock performs a subsequent store
>> releasing the lock.
>
>To avoid a binutils dependency this patch create macros for the extended lwarx
>format and uses it in the spinlock code. To test this change I used a simple
>test case that acquires and releases a global pthread mutex:
>
>	pthread_mutex_lock(&mutex);
>	pthread_mutex_unlock(&mutex);
>
>On a 32 core POWER6 running 32 test threads we spend almost all our time in
>the futex spinlock code (as expected):
>
>    94.37%     perf  [kernel]                     [k] ._raw_spin_lock
>               |          
>               |--99.95%-- ._raw_spin_lock
>               |          |          
>               |          |--63.29%-- .futex_wake
>               |          |          
>               |          |--36.64%-- .futex_wait_setup
>
>which is a good test for this patch. The results (in lock/unlock operations
>per second) are:
>
>before: 1538203 ops/sec
>after:  2189219 ops/sec
>
>An improvement of 42%
>
>Signed-off-by: Anton Blanchard <anton@samba.org>
>---
>
>We've had issues in the past with chips that do the wrong thing and don't
>ignore instruction reserved bits. One option might be to limit this change to
>64bit and verify on that limited set of CPUs.

In the off chance that someone actually does an SMP 44x, I think the hint bit
here would just be ignored (I could test possibly if we want to verify).
However, I thought the FSL parts didn't like toggling the reserved bits and
those already are SMP in some cases.

Kumar?

josh
