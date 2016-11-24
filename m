Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPPPQ5GZ5zDw8n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 14:11:37 +1100 (AEDT)
Date: Wed, 23 Nov 2016 19:11:29 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Locking API testsuite output mangled
In-Reply-To: <87zikqu5nm.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.DEB.2.20.16.1611231907260.7542@trent.utfs.org>
References: <alpine.DEB.2.20.16.1611221606290.7542@trent.utfs.org>
 <87zikqu5nm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 23 Nov 2016, Michael Ellerman wrote:
> That's nothing powerpc specific AFAICS, does this fix it?

Hm, so s/printk/pr_cont/ - but not in all places? But yeah, this fixes it 
for me, at least on x86.

 Tested-by: Christian Kujau <lists@nerdbynature.de>

Thank you!
Christian.

> 
> cheers
> 
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index 872a15a2a637..f3a217ea0388 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -980,23 +980,23 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
>  #ifndef CONFIG_PROVE_LOCKING
>  	if (expected == FAILURE && debug_locks) {
>  		expected_testcase_failures++;
> -		printk("failed|");
> +		pr_cont("failed|");
>  	}
>  	else
>  #endif
>  	if (debug_locks != expected) {
>  		unexpected_testcase_failures++;
> -		printk("FAILED|");
> +		pr_cont("FAILED|");
>  
>  		dump_stack();
>  	} else {
>  		testcase_successes++;
> -		printk("  ok  |");
> +		pr_cont("  ok  |");
>  	}
>  	testcase_total++;
>  
>  	if (debug_locks_verbose)
> -		printk(" lockclass mask: %x, debug_locks: %d, expected: %d\n",
> +		pr_cont(" lockclass mask: %x, debug_locks: %d, expected: %d\n",
>  			lockclass_mask, debug_locks, expected);
>  	/*
>  	 * Some tests (e.g. double-unlock) might corrupt the preemption
> @@ -1021,26 +1021,26 @@ static inline void print_testname(const char *testname)
>  #define DO_TESTCASE_1(desc, name, nr)				\
>  	print_testname(desc"/"#nr);				\
>  	dotest(name##_##nr, SUCCESS, LOCKTYPE_RWLOCK);		\
> -	printk("\n");
> +	pr_cont("\n");
>  
>  #define DO_TESTCASE_1B(desc, name, nr)				\
>  	print_testname(desc"/"#nr);				\
>  	dotest(name##_##nr, FAILURE, LOCKTYPE_RWLOCK);		\
> -	printk("\n");
> +	pr_cont("\n");
>  
>  #define DO_TESTCASE_3(desc, name, nr)				\
>  	print_testname(desc"/"#nr);				\
>  	dotest(name##_spin_##nr, FAILURE, LOCKTYPE_SPIN);	\
>  	dotest(name##_wlock_##nr, FAILURE, LOCKTYPE_RWLOCK);	\
>  	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
> -	printk("\n");
> +	pr_cont("\n");
>  
>  #define DO_TESTCASE_3RW(desc, name, nr)				\
>  	print_testname(desc"/"#nr);				\
>  	dotest(name##_spin_##nr, FAILURE, LOCKTYPE_SPIN|LOCKTYPE_RWLOCK);\
>  	dotest(name##_wlock_##nr, FAILURE, LOCKTYPE_RWLOCK);	\
>  	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
> -	printk("\n");
> +	pr_cont("\n");
>  
>  #define DO_TESTCASE_6(desc, name)				\
>  	print_testname(desc);					\
> @@ -1050,7 +1050,7 @@ static inline void print_testname(const char *testname)
>  	dotest(name##_mutex, FAILURE, LOCKTYPE_MUTEX);		\
>  	dotest(name##_wsem, FAILURE, LOCKTYPE_RWSEM);		\
>  	dotest(name##_rsem, FAILURE, LOCKTYPE_RWSEM);		\
> -	printk("\n");
> +	pr_cont("\n");
>  
>  #define DO_TESTCASE_6_SUCCESS(desc, name)			\
>  	print_testname(desc);					\
> @@ -1060,7 +1060,7 @@ static inline void print_testname(const char *testname)
>  	dotest(name##_mutex, SUCCESS, LOCKTYPE_MUTEX);		\
>  	dotest(name##_wsem, SUCCESS, LOCKTYPE_RWSEM);		\
>  	dotest(name##_rsem, SUCCESS, LOCKTYPE_RWSEM);		\
> -	printk("\n");
> +	pr_cont("\n");
>  
>  /*
>   * 'read' variant: rlocks must not trigger.
> @@ -1073,7 +1073,7 @@ static inline void print_testname(const char *testname)
>  	dotest(name##_mutex, FAILURE, LOCKTYPE_MUTEX);		\
>  	dotest(name##_wsem, FAILURE, LOCKTYPE_RWSEM);		\
>  	dotest(name##_rsem, FAILURE, LOCKTYPE_RWSEM);		\
> -	printk("\n");
> +	pr_cont("\n");
>  
>  #define DO_TESTCASE_2I(desc, name, nr)				\
>  	DO_TESTCASE_1("hard-"desc, name##_hard, nr);		\
> @@ -1726,25 +1726,25 @@ static void ww_tests(void)
>  	dotest(ww_test_fail_acquire, SUCCESS, LOCKTYPE_WW);
>  	dotest(ww_test_normal, SUCCESS, LOCKTYPE_WW);
>  	dotest(ww_test_unneeded_slow, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("ww contexts mixing");
>  	dotest(ww_test_two_contexts, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_diff_class, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("finishing ww context");
>  	dotest(ww_test_context_done_twice, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_context_unlock_twice, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_context_fini_early, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_context_lock_after_done, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("locking mismatches");
>  	dotest(ww_test_object_unlock_twice, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_object_lock_unbalanced, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_object_lock_stale_context, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("EDEADLK handling");
>  	dotest(ww_test_edeadlk_normal, SUCCESS, LOCKTYPE_WW);
> @@ -1757,11 +1757,11 @@ static void ww_tests(void)
>  	dotest(ww_test_edeadlk_acquire_more_edeadlk_slow, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_edeadlk_acquire_wrong, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_edeadlk_acquire_wrong_slow, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("spinlock nest unlocked");
>  	dotest(ww_test_spin_nest_unlocked, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	printk("  -----------------------------------------------------\n");
>  	printk("                                 |block | try  |context|\n");
> @@ -1771,25 +1771,25 @@ static void ww_tests(void)
>  	dotest(ww_test_context_block, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_context_try, SUCCESS, LOCKTYPE_WW);
>  	dotest(ww_test_context_context, SUCCESS, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("try");
>  	dotest(ww_test_try_block, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_try_try, SUCCESS, LOCKTYPE_WW);
>  	dotest(ww_test_try_context, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("block");
>  	dotest(ww_test_block_block, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_block_try, SUCCESS, LOCKTYPE_WW);
>  	dotest(ww_test_block_context, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("spinlock");
>  	dotest(ww_test_spin_block, FAILURE, LOCKTYPE_WW);
>  	dotest(ww_test_spin_try, SUCCESS, LOCKTYPE_WW);
>  	dotest(ww_test_spin_context, FAILURE, LOCKTYPE_WW);
> -	printk("\n");
> +	pr_cont("\n");
>  }
>  
>  void locking_selftest(void)
> @@ -1829,32 +1829,32 @@ void locking_selftest(void)
>  
>  	printk("  --------------------------------------------------------------------------\n");
>  	print_testname("recursive read-lock");
> -	printk("             |");
> +	pr_cont("             |");
>  	dotest(rlock_AA1, SUCCESS, LOCKTYPE_RWLOCK);
> -	printk("             |");
> +	pr_cont("             |");
>  	dotest(rsem_AA1, FAILURE, LOCKTYPE_RWSEM);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("recursive read-lock #2");
> -	printk("             |");
> +	pr_cont("             |");
>  	dotest(rlock_AA1B, SUCCESS, LOCKTYPE_RWLOCK);
> -	printk("             |");
> +	pr_cont("             |");
>  	dotest(rsem_AA1B, FAILURE, LOCKTYPE_RWSEM);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("mixed read-write-lock");
> -	printk("             |");
> +	pr_cont("             |");
>  	dotest(rlock_AA2, FAILURE, LOCKTYPE_RWLOCK);
> -	printk("             |");
> +	pr_cont("             |");
>  	dotest(rsem_AA2, FAILURE, LOCKTYPE_RWSEM);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	print_testname("mixed write-read-lock");
> -	printk("             |");
> +	pr_cont("             |");
>  	dotest(rlock_AA3, FAILURE, LOCKTYPE_RWLOCK);
> -	printk("             |");
> +	pr_cont("             |");
>  	dotest(rsem_AA3, FAILURE, LOCKTYPE_RWSEM);
> -	printk("\n");
> +	pr_cont("\n");
>  
>  	printk("  --------------------------------------------------------------------------\n");
>  
> 

-- 
BOFH excuse #71:

The file system is full of it
