Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29199DDF0B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 23:17:46 +1000 (EST)
Date: Wed, 30 Jul 2008 15:17:40 +0200
From: Nick Piggin <npiggin@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Lockless get_user_pages_fast()
Message-ID: <20080730131739.GA28814@wotan.suse.de>
References: <1217389038.11188.285.camel@pasglop>
	<C8EC8414-A033-46FE-AFEC-8C2A6AB5B4F7@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C8EC8414-A033-46FE-AFEC-8C2A6AB5B4F7@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2008 at 07:33:26AM -0500, Kumar Gala wrote:
> 
> On Jul 29, 2008, at 10:37 PM, Benjamin Herrenschmidt wrote:
> 
> >From: Nick Piggin <npiggin@suse.de>
> >
> >Implement lockless get_user_pages_fast for powerpc.  Page table  
> >existence
> >is guaranteed with RCU, and speculative page references are used to  
> >take a
> >reference to the pages without having a prior existence guarantee on  
> >them.
> >
> >Signed-off-by: Nick Piggin <npiggin@suse.de>
> >Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> >Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >Cc: Paul Mackerras <paulus@samba.org>
> >Cc: Hugh Dickins <hugh@veritas.com>
> >Cc: "Paul E. McKenney" <paulmck@us.ibm.com>
> >Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> >Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >---
> >
> >I'm going to merge this, sending it to the list for reference, it was
> >in -mm for some time , minus some changes/fixes I did to solve  
> >conflicts
> >with the new multiple huge page sizes.
> >
> >Index: linux-work/arch/powerpc/Kconfig
> >===================================================================
> >--- linux-work.orig/arch/powerpc/Kconfig	2008-07-30  
> >13:17:06.000000000 +1000
> >+++ linux-work/arch/powerpc/Kconfig	2008-07-30 13:27:40.000000000  
> >+1000
> >@@ -42,6 +42,9 @@ config GENERIC_HARDIRQS
> >	bool
> >	default y
> >
> >+config HAVE_GET_USER_PAGES_FAST
> >+	def_bool PPC64
> >+
> >config HAVE_SETUP_PER_CPU_AREA
> >	def_bool PPC64
> 
> what's ppc64 specific here?

I didn't look how 32-bit powerpc does its TLB shootdown and page table
walking, so I don't know if it will work...
