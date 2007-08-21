Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4DD3DDE3E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 07:42:22 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7LLgJ6b000739
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 17:42:19 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7LLgJvO503064
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 17:42:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7LLgJNl032654
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 17:42:19 -0400
Date: Tue, 21 Aug 2007 16:42:18 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Message-ID: <20070821214218.GS4261@austin.ibm.com>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
	<d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Nick Piggin <npiggin@suse.de>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 09:43:17PM +0200, Segher Boessenkool wrote:
> >>  #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
> >> -#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : 
> >> "memory")
> >> +#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
> >>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
> >>  #define read_barrier_depends()  do { } while(0)
> >>
> >> @@ -42,7 +42,7 @@
> >>  #ifdef __KERNEL__
> >>  #ifdef CONFIG_SMP
> >>  #define smp_mb()	mb()
> >> -#define smp_rmb()	rmb()
> >> +#define smp_rmb()	__asm__ __volatile__ (__stringify(LWSYNC) : : : 
> >> "memory")
> >>  #define smp_wmb()	eieio()
> >>  #define smp_read_barrier_depends()	read_barrier_depends()
> >>  #else
> >
> > I had to think about this one for awhile.  It looks at first glance to 
> > be the right
> > thing to do.  But I do wonder how long rmb() has been lwsync
> 
> Since the {ppc,ppc64} -> powerpc merge.
> 
> > and if as a practical matter that has caused any problems?
> 
> It has not as far as I know.
> 
> > If this isn't causing any problems maybe there
> > is some loigic we are overlooking?
> 
> The I/O accessor functions enforce the necessary ordering
> already I believe.

So, is this patch desirable? 

--linas
