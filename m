Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E075DDDEF
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Nov 2008 12:42:30 +1100 (EST)
Date: Sun, 2 Nov 2008 02:42:21 +0100
From: Nick Piggin <npiggin@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch] powerpc: smp_wmb lwsync optimisation fix
Message-ID: <20081102014221.GA13758@wotan.suse.de>
References: <20081101123339.GA32055@wotan.suse.de>
	<02812037-F4FA-4257-8A8A-5D0E400D1FF1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <02812037-F4FA-4257-8A8A-5D0E400D1FF1@kernel.crashing.org>
Cc: paulus@samba.org, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 01, 2008 at 11:47:58AM -0500, Kumar Gala wrote:
> 
> On Nov 1, 2008, at 7:33 AM, Nick Piggin wrote:
> 
> >A previous change removed __SUBARCH_HAS_LWSYNC define, and replaced it
> >with __powerpc64__. smp_wmb() seems to be the last place not updated.
> 
> Uugh... no.. I missed the patch that removed __SUBARCH_HAS_LWSYNC, but  
> thats no good.  We have LWSYNC on non-powerpc64 machines.  Will go  
> figure out who forgets we have ppc32 machines :)

I think it may have been you :)

But actually, SMPWMB would need more massaging before it is suitable,
by the looks of your LWSYNC define in synch.h.

I don't mind, so much, about how this gets fixed. But it would be
nice to fix it somehow. After the smp_rmb and smp_wmb patches, there
are practically no sync instructions left in mm/ :)

> 
> - k
> 
> >
> >
> >Signed-off-by: Nick Piggin <npiggin@suse.de>
> >---
> >Index: linux-2.6/arch/powerpc/include/asm/system.h
> >===================================================================
> >--- linux-2.6.orig/arch/powerpc/include/asm/system.h	2008-11-01  
> >20:31:51.000000000 +1100
> >+++ linux-2.6/arch/powerpc/include/asm/system.h	2008-11-01  
> >20:32:33.000000000 +1100
> >@@ -44,7 +44,7 @@
> >#define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
> >#ifdef CONFIG_SMP
> >
> >-#ifdef __SUBARCH_HAS_LWSYNC
> >+#if defined(__powerpc64__)
> >#    define SMPWMB      lwsync
> >#else
> >#    define SMPWMB      eieio
> >_______________________________________________
> >Linuxppc-dev mailing list
> >Linuxppc-dev@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-dev
