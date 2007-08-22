Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB465DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:15:12 +1000 (EST)
Date: Wed, 22 Aug 2007 05:15:06 +0200
From: Nick Piggin <npiggin@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Message-ID: <20070822031506.GA26374@wotan.suse.de>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
	<d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 09:43:17PM +0200, Segher Boessenkool wrote:
> >> #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
> >>-#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : 
> >>"memory")
> >>+#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
> >> #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
> >> #define read_barrier_depends()  do { } while(0)
> >>
> >>@@ -42,7 +42,7 @@
> >> #ifdef __KERNEL__
> >> #ifdef CONFIG_SMP
> >> #define smp_mb()	mb()
> >>-#define smp_rmb()	rmb()
> >>+#define smp_rmb()	__asm__ __volatile__ (__stringify(LWSYNC) : : : 
> >>"memory")
> >> #define smp_wmb()	eieio()
> >> #define smp_read_barrier_depends()	read_barrier_depends()
> >> #else
> >
> >I had to think about this one for awhile.  It looks at first glance to 
> >be the right
> >thing to do.  But I do wonder how long rmb() has been lwsync
> 
> Since the {ppc,ppc64} -> powerpc merge.
> 
> >and if as a practical matter that has caused any problems?
> 
> It has not as far as I know.
> 
> >If this isn't causing any problems maybe there
> >is some loigic we are overlooking?
> 
> The I/O accessor functions enforce the necessary ordering
> already I believe.

Hmm, I never followed those discussions last year about IO ordering, and
I can't see where (if) it was documented anywhere :(

It appears that legacy code is handled by defining the old IO accessors to
be completely ordered, and introducing new __raw_ variants that are not
(OTOH, it seems like other architectures are implementing __raw prefix as
inorder unless there is a _relaxed postfix).

Drivers are definitely using these __raw_ accessors, and from a quick
look, they do appear to be hoping that *mb() is going to order access for
them.
