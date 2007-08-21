Return-Path: <jschopp@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F7FBDDEBB
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 05:07:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7LJ7Ihn031461
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 15:07:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7LJ76Hu201304
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 13:07:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7LJ74nt008910
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 13:07:05 -0600
Message-ID: <46CB37D4.2080609@austin.ibm.com>
Date: Tue, 21 Aug 2007 14:07:00 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/2] powerpc: rmb fix
References: <20070821021143.GB2909@wotan.suse.de>
In-Reply-To: <20070821021143.GB2909@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
> -#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
> +#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define read_barrier_depends()  do { } while(0)
>  
> @@ -42,7 +42,7 @@
>  #ifdef __KERNEL__
>  #ifdef CONFIG_SMP
>  #define smp_mb()	mb()
> -#define smp_rmb()	rmb()
> +#define smp_rmb()	__asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
>  #define smp_wmb()	eieio()
>  #define smp_read_barrier_depends()	read_barrier_depends()
>  #else

I had to think about this one for awhile.  It looks at first glance to be the right 
thing to do.  But I do wonder how long rmb() has been lwsync and if as a practical 
matter that has caused any problems?  If this isn't causing any problems maybe there 
is some loigic we are overlooking?
