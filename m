Return-Path: <benh@ozlabs.org>
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
From: Benjamin Herrenschmidt <benh@ozlabs.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080413191338.9776ebd0.akpm@linux-foundation.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	<20080413171953.bde5e9ac.akpm@linux-foundation.org>
	<1208133506.6958.82.camel@pasglop>
	<20080413191338.9776ebd0.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 13:58:06 +1000
Message-Id: <1208491086.6958.381.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-m32r@ml.linux-m32r.org,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > > otoh, if only one .c file will ever call this function then I think that
> > > all problems are solved by
> > > 
> > > a) moving the above ifdeffery into the .c file
> > > b) adding a comment explaining which arch file must provide the override
> > > c) directly including that file from within the .c file.
> > 
> > I can definitely do that. I have no problem either way. I can add to all
> > archs too, it's just that whatever way I choose, some people won't be
> > happy with it :-)
> > 
> > Anyway, I'll move the ifdeferry to init/main.c then.
> 
> Thanks ;)
> 
> I'm still wounded by my recent encounter with set_softirq_pending()
> and or_softirq_pending().

Well, looking there, I saw we already used weak symbols for that so what
about the patch below ? If you're ok, I'll re-send with appropriate sob
& adapted powerpc part.

Cheers,
Ben.

Index: linux-work/init/main.c
===================================================================
--- linux-work.orig/init/main.c	2008-03-26 10:39:25.000000000 +1100
+++ linux-work/init/main.c	2008-04-18 13:10:35.000000000 +1000
@@ -504,6 +504,10 @@ void __init __attribute__((weak)) smp_se
 {
 }
 
+void __init __attribute__((weak) thread_info_cache_init(void)
+{
+}
+
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
@@ -623,6 +627,7 @@ asmlinkage void __init start_kernel(void
 	if (efi_enabled)
 		efi_enter_virtual_mode();
 #endif
+	thread_info_cache_init();
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
Index: linux-work/include/linux/sched.h
===================================================================
--- linux-work.orig/include/linux/sched.h	2008-04-02 09:47:56.000000000 +1100
+++ linux-work/include/linux/sched.h	2008-04-18 13:11:10.000000000 +1000
@@ -1893,6 +1893,8 @@ static inline unsigned long *end_of_stac
 
 #endif
 
+extern void thread_info_cache_init(void);
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
