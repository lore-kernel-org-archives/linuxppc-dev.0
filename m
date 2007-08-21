Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50B5BDDE9D
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 05:43:26 +1000 (EST)
In-Reply-To: <46CB37D4.2080609@austin.ibm.com>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Date: Tue, 21 Aug 2007 21:43:17 +0200
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
>> -#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : 
>> "memory")
>> +#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
>>  #define read_barrier_depends()  do { } while(0)
>>
>> @@ -42,7 +42,7 @@
>>  #ifdef __KERNEL__
>>  #ifdef CONFIG_SMP
>>  #define smp_mb()	mb()
>> -#define smp_rmb()	rmb()
>> +#define smp_rmb()	__asm__ __volatile__ (__stringify(LWSYNC) : : : 
>> "memory")
>>  #define smp_wmb()	eieio()
>>  #define smp_read_barrier_depends()	read_barrier_depends()
>>  #else
>
> I had to think about this one for awhile.  It looks at first glance to 
> be the right
> thing to do.  But I do wonder how long rmb() has been lwsync

Since the {ppc,ppc64} -> powerpc merge.

> and if as a practical matter that has caused any problems?

It has not as far as I know.

> If this isn't causing any problems maybe there
> is some loigic we are overlooking?

The I/O accessor functions enforce the necessary ordering
already I believe.


Segher
