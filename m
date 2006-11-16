Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B51367BD3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 08:41:22 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGLfJe3009130
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:41:19 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGLfJNJ544718
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 14:41:19 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGLfHR1014572
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 14:41:19 -0700
Date: Thu, 16 Nov 2006 15:41:15 -0600
To: Michael Ellerman <michael@ellerman.id.au>, paulus@samba.org
Subject: Re: [PATCH]: wrap cpu_die() with CONFIG_HOTPLUG_CPU
Message-ID: <20061116214114.GE23600@austin.ibm.com>
References: <20061115185743.GH8395@austin.ibm.com>
	<1163635125.8805.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163635125.8805.6.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Srinivasa Ds <srinivasa@in.ibm.com>,
	Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,

Please apply; this is an updated patch per Michael Ellerman,
below.

--linas

On Thu, Nov 16, 2006 at 10:58:45AM +1100, Michael Ellerman wrote:
> 
> Thanks for writing it up as a patch. Couple of nit-picky comments below:

Nitpicking's OK.

>   +#else
>    #define pSeries_mach_cpu_die NULL
> > +#endif
> 
> Not sure if that's a good idea, it would save the #ifdef around the
> structure assignment below.

Hmm. Personally, I find the #ifdef in the structure to be more 
readable, in the sense that one is less likely to mis-read what
the code is actually doing, when on is skimming quickly. But,
not worth arguing over. The patch below incorporates your 
suggestions.

--linas

Subject: [PATCH]: wrap cpu_die() with CONFIG_HOTPLUG_CPU

Per email discussion, it appears that rtas_stop_self()
and pSeries_mach_cpu_die() should not be compiled if 
CONFIG_HOTPLUG_CPU is not defined. This patch adds
#ifdefs around these bits of code.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/kernel/rtas.c             |    5 +++--
 arch/powerpc/platforms/pseries/setup.c |    4 ++++
 include/asm-powerpc/rtas.h             |    2 --
 3 files changed, 7 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc4-git3/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/arch/powerpc/kernel/rtas.c	2006-11-15 11:40:14.000000000 -0600
+++ linux-2.6.19-rc4-git3/arch/powerpc/kernel/rtas.c	2006-11-15 12:46:51.000000000 -0600
@@ -810,9 +810,9 @@ asmlinkage int ppc_rtas(struct rtas_args
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /* This version can't take the spinlock, because it never returns */
-
-struct rtas_args rtas_stop_self_args = {
+static struct rtas_args rtas_stop_self_args = {
 	/* The token is initialized for real in setup_system() */
 	.token = RTAS_UNKNOWN_SERVICE,
 	.nargs = 0,
@@ -834,6 +834,7 @@ void rtas_stop_self(void)
 
 	panic("Alas, I survived.\n");
 }
+#endif
 
 /*
  * Call early during boot, before mem init or bootmem, to retrieve the RTAS
Index: linux-2.6.19-rc4-git3/include/asm-powerpc/rtas.h
===================================================================
--- linux-2.6.19-rc4-git3.orig/include/asm-powerpc/rtas.h	2006-11-01 16:15:46.000000000 -0600
+++ linux-2.6.19-rc4-git3/include/asm-powerpc/rtas.h	2006-11-16 15:23:24.000000000 -0600
@@ -54,8 +54,6 @@ struct rtas_args {
 	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
 };  
 
-extern struct rtas_args rtas_stop_self_args;
-
 struct rtas_t {
 	unsigned long entry;		/* physical address pointer */
 	unsigned long base;		/* physical address pointer */
Index: linux-2.6.19-rc4-git3/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/arch/powerpc/platforms/pseries/setup.c	2006-11-01 16:15:09.000000000 -0600
+++ linux-2.6.19-rc4-git3/arch/powerpc/platforms/pseries/setup.c	2006-11-16 15:25:02.000000000 -0600
@@ -347,6 +347,7 @@ static int __init pSeries_init_panel(voi
 }
 arch_initcall(pSeries_init_panel);
 
+#ifdef CONFIG_HOTPLUG_CPU
 static void pSeries_mach_cpu_die(void)
 {
 	local_irq_disable();
@@ -357,6 +358,9 @@ static void pSeries_mach_cpu_die(void)
 	BUG();
 	for(;;);
 }
+#else
+#define pSeries_mach_cpu_die NULL
+#endif
 
 static int pseries_set_dabr(unsigned long dabr)
 {
