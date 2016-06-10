Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQsHJ16N4zDqHd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:10:52 +1000 (AEST)
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rQsHH23q0z9sBc
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jun 2016 16:10:51 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id fg1so4368613pad.3
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Jun 2016 23:10:51 -0700 (PDT)
Date: Fri, 10 Jun 2016 16:10:40 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] selftests/powerpc: Check for VSX preservation
 across userspace preemption
Message-ID: <20160610161040.1ea9d4d7@camb691>
In-Reply-To: <87mvmvqh38.fsf@possimpible.ozlabs.ibm.com>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-2-cyrilbur@gmail.com>
 <87mvmvqh38.fsf@possimpible.ozlabs.ibm.com>
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

On Thu, 09 Jun 2016 11:35:55 +1000
Daniel Axtens <dja@axtens.net> wrote:

> Yay for tests!
> 
> I have a few minor nits, and one more major one (rc == 2 below).
> 
> > +/*
> > + * Copyright 2015, Cyril Bur, IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */  
> I realise this is well past a lost cause by now, but isn't the idea to
> be version 2, not version 2 or later?
> 
> > +
> > +#include "../basic_asm.h"
> > +#include "../vsx_asm.h"
> > +  
> 
> Some of your other functions start with a comment. That would be super
> helpful here - I'm still not super comfortable I understand the calling
> convention. 
> > +FUNC_START(check_vsx)
> > +	PUSH_BASIC_STACK(32)
> > +	std	r3,STACK_FRAME_PARAM(0)(sp)
> > +	addi r3, r3, 16 * 12 #Second half of array
> > +	bl store_vsx
> > +	ld r3,STACK_FRAME_PARAM(0)(sp)
> > +	bl vsx_memcmp
> > +	POP_BASIC_STACK(32)
> > +	blr
> > +FUNC_END(check_vsx)
> > +  
> 
> 
> 
> > +long vsx_memcmp(vector int *a) {
> > +	vector int zero = {0,0,0,0};
> > +	int i;
> > +
> > +	FAIL_IF(a != varray);
> > +
> > +	for(i = 0; i < 12; i++) {
> > +		if (memcmp(&a[i + 12], &zero, 16) == 0) {
> > +			fprintf(stderr, "Detected zero from the VSX reg %d\n", i + 12);
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	if (memcmp(a, &a[12], 12 * 16)) {  
> I'm somewhat confused as to how this comparison works. You're comparing
> the new saved ones to the old saved ones, yes?

check_vmx() has put the live registers on the end of the array... so the first
12 in 'a' are the known values and the next 12 are the live values... they
should match.

> > +		long *p = (long *)a;
> > +		fprintf(stderr, "VSX mismatch\n");
> > +		for (i = 0; i < 24; i=i+2)
> > +			fprintf(stderr, "%d: 0x%08lx%08lx | 0x%08lx%08lx\n",
> > +					i/2 + i%2 + 20, p[i], p[i + 1], p[i + 24], p[i + 25]);
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> > +void *preempt_vsx_c(void *p)
> > +{
> > +	int i, j;
> > +	long rc;
> > +	srand(pthread_self());
> > +	for (i = 0; i < 12; i++)
> > +		for (j = 0; j < 4; j++) {
> > +			varray[i][j] = rand();
> > +			/* Don't want zero because it hides kernel problems */
> > +			if (varray[i][j] == 0)
> > +				j--;
> > +		}
> > +	rc = preempt_vsx(varray, &threads_starting, &running);
> > +	if (rc == 2)  
> How would rc == 2? AIUI, preempt_vsx returns the value of check_vsx,
> which in turn returns the value of vsx_memcmp, which returns 1 or 0.
> 
> > +		fprintf(stderr, "Caught zeros in VSX compares\n");  
> Isn't it zeros or a mismatched value?

I think that patch went through too many iterations and no enough cleanups.
Fixed

> > +	return (void *)rc;
> > +}
> > +
> > +int test_preempt_vsx(void)
> > +{
> > +	int i, rc, threads;
> > +	pthread_t *tids;
> > +
> > +	threads = sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
> > +	tids = malloc(threads * sizeof(pthread_t));
> > +	FAIL_IF(!tids);
> > +
> > +	running = true;
> > +	threads_starting = threads;
> > +	for (i = 0; i < threads; i++) {
> > +		rc = pthread_create(&tids[i], NULL, preempt_vsx_c, NULL);
> > +		FAIL_IF(rc);
> > +	}
> > +
> > +	setbuf(stdout, NULL);
> > +	/* Not really nessesary but nice to wait for every thread to start */
> > +	printf("\tWaiting for %d workers to start...", threads_starting);
> > +	while(threads_starting)
> > +		asm volatile("": : :"memory");  
> I think __sync_synchronise() might be ... more idiomatic or something?
> Not super fussy.
> 

Best to be consistent with how all the other powerpc/math tests do it, which
was initially an MPE recommendation.

> > +	printf("done\n");
> > +
> > +	printf("\tWaiting for %d seconds to let some workers get preempted...", PREEMPT_TIME);
> > +	sleep(PREEMPT_TIME);
> > +	printf("done\n");
> > +
> > +	printf("\tStopping workers...");
> > +	/*
> > +	 * Working are checking this value every loop. In preempt_vsx 'cmpwi r5,0; bne 2b'.
> > +	 * r5 will have loaded the value of running.
> > +	 */
> > +	running = 0;  
> Do you need some sort of synchronisation here? You're assuming it
> eventually gets to the threads, which is of course true, but maybe it
> would be a good idea to synchronise it more explicitly? Again, not super
> fussy.

Why bother? A barrier might 'nice' it really buys us nothing. Also that's how
all the other powerpc/math tests currently kill workers.

> > +	for (i = 0; i < threads; i++) {
> > +		void *rc_p;
> > +		pthread_join(tids[i], &rc_p);
> > +
> > +		/*
> > +		 * Harness will say the fail was here, look at why preempt_vsx
> > +		 * returned
> > +		 */
> > +		if ((long) rc_p)
> > +			printf("oops\n");
> > +		FAIL_IF((long) rc_p);
> > +	}
> > +	printf("done\n");
> > +
> > +	return 0;
> > +}
> > +  
> Regards,
> Daniel
