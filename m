Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C4071A0622
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 17:03:38 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4A97A140285
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:03:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 12 Jun 2015 17:03:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 05CCF2BB0047
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:03:35 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5C73Oql65863780
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:03:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5C7312N028298
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:03:02 +1000
Message-ID: <557A8414.8010500@linux.vnet.ibm.com>
Date: Fri, 12 Jun 2015 12:32:44 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 10/10] selftests, powerpc: Add test for BHRB branch
 filters (HW & SW)
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-10-git-send-email-khandual@linux.vnet.ibm.com>
 <1433988561.31423.27.camel@axtens.net>
In-Reply-To: <1433988561.31423.27.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2015 07:39 AM, Daniel Axtens wrote:
> Hi,
> 
> On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
>> diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
>> new file mode 100644
>> index 0000000..13e6b72
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
>> @@ -0,0 +1,513 @@
>> +/*
>> + * BHRB filter test (HW & SW)
>> + *
>> + * Copyright 2015 Anshuman Khandual, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
> 
> This should also be gpl2 only.

Why ? Any special reason ? I can see similar existing statements here
in this file as well "powerpcC/primitives/load_unaligned_zeropad.c"

>> +#include <unistd.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <signal.h>
>> +#include <poll.h>
>> +#include <sys/shm.h>
>> +#include <sys/types.h>
>> +#include <sys/wait.h>
>> +#include <sys/mman.h>
>> +
>> +#include "bhrb_filters.h"
>> +#include "utils.h"
>> +#include "../event.h"
>> +#include "../lib.h"
>> +
>> +/* Fetched address counts */
>> +#define ALL_MAX		32
>> +#define CALL_MAX	12
>> +#define RET_MAX		10
>> +#define COND_MAX	8
>> +#define IND_MAX		4
>> +
>> +/* Test tunables */
>> +#define LOOP_COUNT	10
>> +#define SAMPLE_PERIOD	10000
>> +
>> +static int branch_sample_type;
>> +static int branch_test_set[27] = {
> Do you need to explicitly provide the count here?

Not really, will fix it.

>> +		PERF_SAMPLE_BRANCH_ANY_CALL,		/* Single filters */
>> +		PERF_SAMPLE_BRANCH_ANY_RETURN,
>> +		PERF_SAMPLE_BRANCH_COND,
>> +		PERF_SAMPLE_BRANCH_IND_CALL,
>> +		PERF_SAMPLE_BRANCH_ANY,
>> +
> 
>> +		PERF_SAMPLE_BRANCH_ANY_CALL |		/* Tripple filters */
> s/Tripple/Triple/

Sure.will fix it.

>> +		PERF_SAMPLE_BRANCH_ANY_RETURN |
>> +		PERF_SAMPLE_BRANCH_COND,
>> +
> 
> 
>> +
>> +static void *ring_buffer_mask(struct ring_buffer *r, void *p)

> Is this actually returning a mask? It looks more like it's calculating
> an offset, and that seems to be how you use it below.

Yeah it does calculate an offset. Will change the function name to
ring_buffer_offset instead.

>> +{
>> +	unsigned long l = (unsigned long)p;
>> +
>> +	return (void *)(r->ring_base + ((l - r->ring_base) & r->mask));
>> +}
> That's a lot of casts, especially when you then load it into a int64_t
> pointer below...

Will it cause any problem ? I can return here int64_t * instead to void *
to match the receiving pointer.

>> +
>> +static void dump_sample(struct perf_event_header *hdr, struct ring_buffer *r)
>> +{
>> +	unsigned long from, to, flag;
>> +	int i, nr;
>> +	int64_t *v;
>> +
>> +	/* NR Branches */
>> +	v = ring_buffer_mask(r, hdr + 1);
> ...here. (and everywhere else I can see that you're using the
> ring_buffer_mask function)
>> +
>> +	nr = *v;
> You are dereferencing a int64_t pointer into an int. Should nr be an
> int64_t? Or should v be a different pointer type?

hmm, int64_t sounds good.

> 
>> +
>> +	/* Branches */
>> +	for (i = 0; i < nr; i++) {
>> +		v = ring_buffer_mask(r, v + 1);
>> +		from = *v;
> Now you're dereferencing an *int64_t into an unsigned long.

Just wanted to have 64 bits for that field. To achieve some uniformity
will change all of v, nr, from, to, flags as int64_t type variables.
Also will make ring_buffer_mask function return in64_t * pointer type
instead. Will change ring_buffer_mask into ring_buffer_offset as well. 

>> +
>> +		v = ring_buffer_mask(r, v + 1);
>> +		to = *v;
>> +
>> +		v = ring_buffer_mask(r, v + 1);
>> +		flag = *v;
>> +
>> +		if (!check_branch(from, to)) {
>> +			has_failed = true;
>> +			printf("[Filter: %d] From: %lx To: %lx Flags: %lx\n",
>> +					branch_sample_type, from, to, flag);
>> +		}
>> +	}
>> +}
>> +
>> +static void read_ring_buffer(struct event *e)
>> +{
>> +	struct ring_buffer *r = &e->ring_buffer;
>> +	struct perf_event_header *hdr;
>> +	int old, head;
> Why not tail and head?

Sure, will change it.

>> +
>> +	head = r->page->data_head & r->mask;
>> +
>> +	asm volatile ("sync": : :"memory");
>> +
>> +	old = r->page->data_tail & r->mask;
>> +
> Can you explain the logic of syncing between reading head and tail? Is
> there an expectation that head is not likely to change?
> 
> As a more general comment, what is sync trying to achieve? If you're
> trying to synchronise something, what's the sync actually achieving? Is
> there a corresponding memory barrier somewhere else? What race
> conditions are you trying to guard against and does this actually guard
> against them?

Once we wake up from poll and try to read the ring buffer, head is not
going to change. We keep increment the tail and process the record till
we dont reach the head position. Once there we just write head into the
data_tail to inform kernel that the processing is over and kernel may
start filling up the ring buffer again. For more details , please look
into this file include/uapi/linux/perf_event.h (perf_event_mmap_page).

        /*
         * Control data for the mmap() data buffer.
         *
         * User-space reading the @data_head value should issue an smp_rmb(),
         * after reading this value.
         *
         * When the mapping is PROT_WRITE the @data_tail value should be
         * written by userspace to reflect the last read data, after issueing
         * an smp_mb() to separate the data read from the ->data_tail store.
         * In this case the kernel will not over-write unread data.

> 
>> +	while (old != head) {
>> +		hdr = (struct perf_event_header *)(r->ring_base + old);
>> +
>> +		if ((old & r->mask) + hdr->size !=
>> +					((old + hdr->size) & r->mask))
>> +			++record_overlap;
>> +
>> +		if (hdr->type == PERF_RECORD_SAMPLE) {
>> +			++record_sample;
>> +			dump_sample(hdr, r);
>> +		}
>> +
>> +		if (hdr->type == PERF_RECORD_MMAP)
>> +			++record_mmap;
>> +
>> +		if (hdr->type == PERF_RECORD_LOST)
>> +			++record_lost;
>> +
>> +		if (hdr->type == PERF_RECORD_THROTTLE)
>> +			++record_throttle;
>> +
>> +		if (hdr->type == PERF_RECORD_UNTHROTTLE)
>> +			++record_unthrottle;
>> +
>> +		old = (old + hdr->size) & r->mask;
>> +	}
>> +	r->page->data_tail = old;

> What happens if data_tail moves while you're doing the loop?

I believe that is not possible. Kernel wont change it unless we
we write head position into that after processing entire data.

> 
> 
> 
>> +static int filter_test(void)
>> +{
>> +	struct pollfd pollfd;
>> +	struct event ebhrb;
>> +	pid_t pid;
>> +	int ret, loop = 0;
>> +
>> +	has_failed = false;
>> +	pid = fork();
>> +	if (pid == -1) {
>> +		perror("fork() failed");
>> +		return 1;
>> +	}
>> +
>> +	/* Run child */
>> +	if (pid == 0) {
>> +		start_loop();
>> +		exit(0);
>> +	}
>> +
>> +	/* Prepare event */
>> +	event_init_opts(&ebhrb, PERF_COUNT_HW_INSTRUCTIONS,
>> +				PERF_TYPE_HARDWARE, "insturctions");
> Is instructions deliberately spelled incorrectly?

:) No, its a mistake. Will fix it.

>> +	ebhrb.attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
>> +	ebhrb.attr.disabled = 1;
>> +	ebhrb.attr.mmap = 1;
>> +	ebhrb.attr.mmap_data = 1;
>> +	ebhrb.attr.sample_period = SAMPLE_PERIOD;
>> +	ebhrb.attr.exclude_user = 0;
>> +	ebhrb.attr.exclude_kernel = 1;
>> +	ebhrb.attr.exclude_hv = 1;
>> +	ebhrb.attr.branch_sample_type = branch_sample_type;
>> +
>> +	/* Open event */
>> +	event_open_with_pid(&ebhrb, pid);
>> +
>> +	/* Mmap ring buffer and enable event */
>> +	event_mmap(&ebhrb);
>> +	FAIL_IF(event_enable(&ebhrb));
>> +
>> +	/* Prepare polling */
>> +	pollfd.fd = ebhrb.fd;
>> +	pollfd.events = POLLIN;
>> +
>> +	for (loop = 0; loop < LOOP_COUNT; loop++) {
>> +		ret = poll(&pollfd, 1, -1);
>> +		if (ret == -1) {
>> +			perror("poll() failed");
>> +			return 1;
>> +		}
>> +		if (ret == 0) {
>> +			perror("poll() timeout");
>> +			return 1;
>> +		}
>> +		read_ring_buffer(&ebhrb);
>> +		if (has_failed)
>> +			return 1;
> 1) I don't see anything that sets has_failed after it's initalised.

Its initialized to 'false' in the beginning of each test and would be
set to 'true' inside dump_sample function if any of the captured branches
does not match the applied filter.

> 2) Should these error cases also explicitly terminate the child? Do you
> need something like this perhaps?
> 
> 		if (ret == 0) {
> 			perror("poll() failed");
> 			goto err;
> 		}
> 
> 		...
> 	
> 	}
> 
> 	...
> 
> 	return 0;
> 
> 	err:
> 	kill(pid, SIGTERM); // maybe even sigkill in the error case?
> 	return 1;

Right, will change it.

>> +	}
>> +
>> +	/* Disable and close event */
>> +	FAIL_IF(event_disable(&ebhrb));
>> +	event_close(&ebhrb);
> Again, do these need to be replicated in the error path?

Right, will change it.

>> +
>> +	/* Terminate child */
>> +	kill(pid, SIGKILL);
> SIGKILL seems a bit harsh: wouldn't SIGTERM work?
>> +	return 0;
>> +}
>> +
>> +static int  bhrb_filters_test(void)
>> +{
>> +	int i;
>> +
>> +	/* Fetch branches */
>> +	fetch_branches();
>> +	init_branch_stats();
>> +	init_perf_mmap_stats();
>> +
>> +	for (i = 0; i < sizeof(branch_test_set)/sizeof(int); i++) {
>> +		branch_sample_type = branch_test_set[i];
>> +		if (filter_test())
> Couldn't branch_sample_type be passed to filter_test as a parameter,
> rather than as a global?

Yeah it can be. Will change it.

>> +			return 1;
>> +	}
>> +
> 
> 
>> diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
>> new file mode 100644
>> index 0000000..072375a
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
>> @@ -0,0 +1,16 @@
>> +/*
>> + * Copyright 2015 Anshuman Khandual, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
> License again. (And in the other files in this patch.)
> 
> 
>> +_GLOBAL(start_loop)
>> +label:
>> +	b label0			/* ANY */
>> +	blr				/* ANY_RETURN */
>> +label0:
>> +	b label1			/* ANY */
>> +
>> +label1:
>> +	b label2			/* ANY */
>> +
>> +label2:
>> +	b label3			/* ANY */
>> +
>> +label3:
>> +	mflr LR_SAVE
>> +	bl label4			/* ANY | ANY_CALL */
>> +	mtlr LR_SAVE
>> +	b start_loop			/* ANY */
>> +label4:
>> +	mflr LR_SAVE
>> +	li 20, 12
>> +	cmpi 3, 20, 12
>> +	bcl 12, 4 * cr3+2, label5	/* ANY | ANY_CALL | COND */
>> +	li 20, 12
>> +	cmpi 4, 20, 20
>> +	bcl 12, 4 * cr4+0, label5	/* ANY | ANY_CALL | COND */
>> +	LOAD_ADDR(20, label5)
>> +	mtctr 20
>> +	li 22, 10
>> +	cmpi 0, 22, 10
>> +	bcctrl 12, 4*cr0+2		/* ANY | NY_CALL | IND_CALL | COND */
>> +	LOAD_ADDR(20, label5)
>> +	mtlr 20
>> +	li      20, 10
>> +	cmpi    0, 20, 10
>> +	bclrl   12, 4*cr0+2		/* ANY | ANY_CALL | IND_CALL | COND */
>> +	mtlr LR_SAVE
>> +	blr				/* ANY | ANY_RETURN */
>> +
>> +label5:
>> +	blr				/* ANY | ANY_RETURN */
>> +
> Could these labels have more descriptive names?

Initially I had one label with same numeric numbering for each kind of
branch instruction it was intended for but then it seemed to be overkill
for that purpose. Compacted them to accommodate more branches per label
and here we are. What kind of descriptive names will each of these
label assume when each one accommodates multiple branches now ? Any
thoughts ? Though I am willing to change them.
