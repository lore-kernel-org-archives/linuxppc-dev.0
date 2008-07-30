Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CB1EDE19F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 22:33:36 +1000 (EST)
Message-Id: <C8EC8414-A033-46FE-AFEC-8C2A6AB5B4F7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1217389038.11188.285.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc/mm: Lockless get_user_pages_fast()
Date: Wed, 30 Jul 2008 07:33:26 -0500
References: <1217389038.11188.285.camel@pasglop>
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 29, 2008, at 10:37 PM, Benjamin Herrenschmidt wrote:

> From: Nick Piggin <npiggin@suse.de>
>
> Implement lockless get_user_pages_fast for powerpc.  Page table  
> existence
> is guaranteed with RCU, and speculative page references are used to  
> take a
> reference to the pages without having a prior existence guarantee on  
> them.
>
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Hugh Dickins <hugh@veritas.com>
> Cc: "Paul E. McKenney" <paulmck@us.ibm.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> I'm going to merge this, sending it to the list for reference, it was
> in -mm for some time , minus some changes/fixes I did to solve  
> conflicts
> with the new multiple huge page sizes.
>
> Index: linux-work/arch/powerpc/Kconfig
> ===================================================================
> --- linux-work.orig/arch/powerpc/Kconfig	2008-07-30  
> 13:17:06.000000000 +1000
> +++ linux-work/arch/powerpc/Kconfig	2008-07-30 13:27:40.000000000  
> +1000
> @@ -42,6 +42,9 @@ config GENERIC_HARDIRQS
> 	bool
> 	default y
>
> +config HAVE_GET_USER_PAGES_FAST
> +	def_bool PPC64
> +
> config HAVE_SETUP_PER_CPU_AREA
> 	def_bool PPC64

what's ppc64 specific here?

- k
