Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1A96B7CF3
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 02:40:47 +1100 (EST)
Subject: Re: [PATCH] powerpc: Use lwarx hint bit in spinlocks
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100210031923.GB16178@zod.rchland.ibm.com>
Date: Wed, 10 Feb 2010 09:40:34 -0600
Message-Id: <3941DE04-15C3-4E44-9278-923E874FE23E@kernel.crashing.org>
References: <20100210025010.GC3702@kryten>
	<20100210031923.GB16178@zod.rchland.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 9, 2010, at 9:19 PM, Josh Boyer wrote:

> On Wed, Feb 10, 2010 at 01:50:11PM +1100, Anton Blanchard wrote:
>>=20
>> Recent versions of the PowerPC architecture added a hint bit to the =
larx
>> instructions to differentiate between an atomic operation and a lock =
operation:
>>=20
>>> 0 Other programs might attempt to modify the word in storage =
addressed by EA
>>> even if the subsequent Store Conditional succeeds.
>>>=20
>>> 1 Other programs will not attempt to modify the word in storage =
addressed by
>>> EA until the program that has acquired the lock performs a =
subsequent store
>>> releasing the lock.
>>=20
>> To avoid a binutils dependency this patch create macros for the =
extended lwarx
>> format and uses it in the spinlock code. To test this change I used a =
simple
>> test case that acquires and releases a global pthread mutex:
>>=20
>> 	pthread_mutex_lock(&mutex);
>> 	pthread_mutex_unlock(&mutex);
>>=20
>> On a 32 core POWER6 running 32 test threads we spend almost all our =
time in
>> the futex spinlock code (as expected):
>>=20
>>   94.37%     perf  [kernel]                     [k] ._raw_spin_lock
>>              |         =20
>>              |--99.95%-- ._raw_spin_lock
>>              |          |         =20
>>              |          |--63.29%-- .futex_wake
>>              |          |         =20
>>              |          |--36.64%-- .futex_wait_setup
>>=20
>> which is a good test for this patch. The results (in lock/unlock =
operations
>> per second) are:
>>=20
>> before: 1538203 ops/sec
>> after:  2189219 ops/sec
>>=20
>> An improvement of 42%
>>=20
>> Signed-off-by: Anton Blanchard <anton@samba.org>
>> ---
>>=20
>> We've had issues in the past with chips that do the wrong thing and =
don't
>> ignore instruction reserved bits. One option might be to limit this =
change to
>> 64bit and verify on that limited set of CPUs.
>=20
> In the off chance that someone actually does an SMP 44x, I think the =
hint bit
> here would just be ignored (I could test possibly if we want to =
verify).
> However, I thought the FSL parts didn't like toggling the reserved =
bits and
> those already are SMP in some cases.
>=20
> Kumar?
>=20
> josh

Yeah, I need to test this on some older SMP parts that didn't treated =
reserved bits being set in the opcode as ignored but illegal.

- k=
