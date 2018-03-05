Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwGqG4r5CzF19S
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:50:02 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id a16so7959565pfn.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 15:50:02 -0800 (PST)
Message-ID: <1520293795.5421.1.camel@gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Skip tm-unavailable if TM is not
 enabled
From: Cyril Bur <cyrilbur@gmail.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 10:49:55 +1100
In-Reply-To: <1520282935-20111-2-git-send-email-gromero@linux.vnet.ibm.com>
References: <1520282935-20111-1-git-send-email-gromero@linux.vnet.ibm.com>
 <1520282935-20111-2-git-send-email-gromero@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-05 at 15:48 -0500, Gustavo Romero wrote:
> Some processor revisions do not support transactional memory, and
> additionally kernel support can be disabled. In either case the
> tm-unavailable test should be skipped, otherwise it will fail with
> a SIGILL.
> 
> That commit also sets this selftest to be called through the test
> harness as it's done for other TM selftests.
> 
> Finally, it avoids using "ping" as a thread name since it's
> ambiguous and can be confusing when shown, for instance,
> in a kernel backtrace log.
> 

I spent more time than I care to admit looking at backtraces wondering
how "ping" got in the mix ;).


> Fixes: 77fad8bfb1d2 ("selftests/powerpc: Check FP/VEC on exception in TM")
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
>  .../testing/selftests/powerpc/tm/tm-unavailable.c  | 24 ++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> index e6a0fad..156c8e7 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> @@ -80,7 +80,7 @@ bool is_failure(uint64_t condition_reg)
>  	return ((condition_reg >> 28) & 0xa) == 0xa;
>  }
>  
> -void *ping(void *input)
> +void *tm_una_ping(void *input)
>  {
>  
>  	/*
> @@ -280,7 +280,7 @@ void *ping(void *input)
>  }
>  
>  /* Thread to force context switch */
> -void *pong(void *not_used)
> +void *tm_una_pong(void *not_used)
>  {
>  	/* Wait thread get its name "pong". */
>  	if (DEBUG)
> @@ -311,11 +311,11 @@ void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
>  	do {
>  		int rc;
>  
> -		/* Bind 'ping' to CPU 0, as specified in 'attr'. */
> -		rc = pthread_create(&t0, attr, ping, (void *) &flags);
> +		/* Bind to CPU 0, as specified in 'attr'. */
> +		rc = pthread_create(&t0, attr, tm_una_ping, (void *) &flags);
>  		if (rc)
>  			pr_err(rc, "pthread_create()");
> -		rc = pthread_setname_np(t0, "ping");
> +		rc = pthread_setname_np(t0, "tm_una_ping");
>  		if (rc)
>  			pr_warn(rc, "pthread_setname_np");
>  		rc = pthread_join(t0, &ret_value);
> @@ -333,13 +333,15 @@ void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
>  	}
>  }
>  
> -int main(int argc, char **argv)
> +int tm_unavailable_test(void)
>  {
>  	int rc, exception; /* FP = 0, VEC = 1, VSX = 2 */
>  	pthread_t t1;
>  	pthread_attr_t attr;
>  	cpu_set_t cpuset;
>  
> +	SKIP_IF(!have_htm());
> +
>  	/* Set only CPU 0 in the mask. Both threads will be bound to CPU 0. */
>  	CPU_ZERO(&cpuset);
>  	CPU_SET(0, &cpuset);
> @@ -354,12 +356,12 @@ int main(int argc, char **argv)
>  	if (rc)
>  		pr_err(rc, "pthread_attr_setaffinity_np()");
>  
> -	rc = pthread_create(&t1, &attr /* Bind 'pong' to CPU 0 */, pong, NULL);
> +	rc = pthread_create(&t1, &attr /* Bind to CPU 0 */, tm_una_pong, NULL);
>  	if (rc)
>  		pr_err(rc, "pthread_create()");
>  
>  	/* Name it for systemtap convenience */
> -	rc = pthread_setname_np(t1, "pong");
> +	rc = pthread_setname_np(t1, "tm_una_pong");
>  	if (rc)
>  		pr_warn(rc, "pthread_create()");
>  
> @@ -394,3 +396,9 @@ int main(int argc, char **argv)
>  		exit(0);
>  	}
>  }
> +
> +int main(int argc, char **argv)
> +{
> +	test_harness_set_timeout(220);
> +	return test_harness(tm_unavailable_test, "tm_unavailable_test");
> +}
