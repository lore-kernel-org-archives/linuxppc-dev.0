Return-Path: <anton@samba.org>
Date: Mon, 25 Jul 2011 10:05:26 +1000
From: Anton Blanchard <anton@samba.org>
To: David Ahern <dsahern@gmail.com>
Subject: [PATCH] perf: powerpc: Disable pagefaults during callchain stack read
Message-ID: <20110725100526.4d0ee274@kryten>
In-Reply-To: <4E2C53E0.3020400@gmail.com>
References: <4E274F5F.7000604@gmail.com>
	<4E2C53E0.3020400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

> > I am hoping someone familiar with PPC can help understand a panic
> > that is generated when capturing callchains with context switch
> > events.
> > 
> > Call trace is below. The short of it is that walking the callchain
> > generates a page fault. To handle the page fault the mmap_sem is
> > needed, but it is currently held by setup_arg_pages.
> > setup_arg_pages calls shift_arg_pages with the mmap_sem held.
> > shift_arg_pages then calls move_page_tables which has a
> > cond_resched at the top of its for loop. If the cond_resched() is
> > removed from move_page_tables everything works beautifully - no
> > panics.
> > 
> > So, the question: is it normal for walking the stack to trigger a
> > page fault on PPC? The panic is not seen on x86 based systems.
> 
> Can anyone confirm whether page faults while walking the stack are
> normal for PPC? We really want to use the context switch event with
> callchains and need to understand whether this behavior is normal. Of
> course if it is normal, a way to address the problem without a panic
> will be needed.

I talked to Ben about this last week and he pointed me at
pagefault_disable/enable. Untested patch below.

Anton

--

We need to disable pagefaults when reading the stack otherwise
we can lock up trying to take the mmap_sem when the code we are
profiling already has a write lock taken.

This will not happen for hardware events, but could for software
events.

Reported-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-powerpc/arch/powerpc/kernel/perf_callchain.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/perf_callchain.c	2011-07-25 09:54:27.296757427 +1000
+++ linux-powerpc/arch/powerpc/kernel/perf_callchain.c	2011-07-25 09:56:08.828367882 +1000
@@ -154,8 +154,12 @@ static int read_user_stack_64(unsigned l
 	    ((unsigned long)ptr & 7))
 		return -EFAULT;
 
-	if (!__get_user_inatomic(*ret, ptr))
+	pagefault_disable();
+	if (!__get_user_inatomic(*ret, ptr)) {
+		pagefault_enable();
 		return 0;
+	}
+	pagefault_enable();
 
 	return read_user_stack_slow(ptr, ret, 8);
 }
@@ -166,8 +170,12 @@ static int read_user_stack_32(unsigned i
 	    ((unsigned long)ptr & 3))
 		return -EFAULT;
 
-	if (!__get_user_inatomic(*ret, ptr))
+	pagefault_disable();
+	if (!__get_user_inatomic(*ret, ptr)) {
+		pagefault_enable();
 		return 0;
+	}
+	pagefault_enable();
 
 	return read_user_stack_slow(ptr, ret, 4);
 }
