Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B30C51A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 12:10:22 +1000 (AEST)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 777F41402AD
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 12:10:20 +1000 (AEST)
Received: by padev16 with SMTP id ev16so44752374pad.0
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 19:10:18 -0700 (PDT)
Message-ID: <1433988561.31423.27.camel@axtens.net>
Subject: Re: [PATCH V8 10/10] selftests, powerpc: Add test for BHRB branch
 filters (HW & SW)
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Thu, 11 Jun 2015 12:09:21 +1000
In-Reply-To: <1433763511-5270-10-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-10-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-+RPbRhRcuyl+VCy0/AUe"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-+RPbRhRcuyl+VCy0/AUe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
> diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c b/to=
ols/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
> new file mode 100644
> index 0000000..13e6b72
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
> @@ -0,0 +1,513 @@
> +/*
> + * BHRB filter test (HW & SW)
> + *
> + * Copyright 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

This should also be gpl2 only.
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <poll.h>
> +#include <sys/shm.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/mman.h>
> +
> +#include "bhrb_filters.h"
> +#include "utils.h"
> +#include "../event.h"
> +#include "../lib.h"
> +
> +/* Fetched address counts */
> +#define ALL_MAX		32
> +#define CALL_MAX	12
> +#define RET_MAX		10
> +#define COND_MAX	8
> +#define IND_MAX		4
> +
> +/* Test tunables */
> +#define LOOP_COUNT	10
> +#define SAMPLE_PERIOD	10000
> +
> +static int branch_sample_type;
> +static int branch_test_set[27] =3D {
Do you need to explicitly provide the count here?
> +		PERF_SAMPLE_BRANCH_ANY_CALL,		/* Single filters */
> +		PERF_SAMPLE_BRANCH_ANY_RETURN,
> +		PERF_SAMPLE_BRANCH_COND,
> +		PERF_SAMPLE_BRANCH_IND_CALL,
> +		PERF_SAMPLE_BRANCH_ANY,
> +

> +		PERF_SAMPLE_BRANCH_ANY_CALL |		/* Tripple filters */
s/Tripple/Triple/
> +		PERF_SAMPLE_BRANCH_ANY_RETURN |
> +		PERF_SAMPLE_BRANCH_COND,
> +


> +
> +static void *ring_buffer_mask(struct ring_buffer *r, void *p)
Is this actually returning a mask? It looks more like it's calculating
an offset, and that seems to be how you use it below.
> +{
> +	unsigned long l =3D (unsigned long)p;
> +
> +	return (void *)(r->ring_base + ((l - r->ring_base) & r->mask));
> +}
That's a lot of casts, especially when you then load it into a int64_t
pointer below...
> +
> +static void dump_sample(struct perf_event_header *hdr, struct ring_buffe=
r *r)
> +{
> +	unsigned long from, to, flag;
> +	int i, nr;
> +	int64_t *v;
> +
> +	/* NR Branches */
> +	v =3D ring_buffer_mask(r, hdr + 1);
...here. (and everywhere else I can see that you're using the
ring_buffer_mask function)
> +
> +	nr =3D *v;
You are dereferencing a int64_t pointer into an int. Should nr be an
int64_t? Or should v be a different pointer type?

> +
> +	/* Branches */
> +	for (i =3D 0; i < nr; i++) {
> +		v =3D ring_buffer_mask(r, v + 1);
> +		from =3D *v;
Now you're dereferencing an *int64_t into an unsigned long.
> +
> +		v =3D ring_buffer_mask(r, v + 1);
> +		to =3D *v;
> +
> +		v =3D ring_buffer_mask(r, v + 1);
> +		flag =3D *v;
> +
> +		if (!check_branch(from, to)) {
> +			has_failed =3D true;
> +			printf("[Filter: %d] From: %lx To: %lx Flags: %lx\n",
> +					branch_sample_type, from, to, flag);
> +		}
> +	}
> +}
> +
> +static void read_ring_buffer(struct event *e)
> +{
> +	struct ring_buffer *r =3D &e->ring_buffer;
> +	struct perf_event_header *hdr;
> +	int old, head;
Why not tail and head?
> +
> +	head =3D r->page->data_head & r->mask;
> +
> +	asm volatile ("sync": : :"memory");
> +
> +	old =3D r->page->data_tail & r->mask;
> +
Can you explain the logic of syncing between reading head and tail? Is
there an expectation that head is not likely to change?

As a more general comment, what is sync trying to achieve? If you're
trying to synchronise something, what's the sync actually achieving? Is
there a corresponding memory barrier somewhere else? What race
conditions are you trying to guard against and does this actually guard
against them?

> +	while (old !=3D head) {
> +		hdr =3D (struct perf_event_header *)(r->ring_base + old);
> +
> +		if ((old & r->mask) + hdr->size !=3D
> +					((old + hdr->size) & r->mask))
> +			++record_overlap;
> +
> +		if (hdr->type =3D=3D PERF_RECORD_SAMPLE) {
> +			++record_sample;
> +			dump_sample(hdr, r);
> +		}
> +
> +		if (hdr->type =3D=3D PERF_RECORD_MMAP)
> +			++record_mmap;
> +
> +		if (hdr->type =3D=3D PERF_RECORD_LOST)
> +			++record_lost;
> +
> +		if (hdr->type =3D=3D PERF_RECORD_THROTTLE)
> +			++record_throttle;
> +
> +		if (hdr->type =3D=3D PERF_RECORD_UNTHROTTLE)
> +			++record_unthrottle;
> +
> +		old =3D (old + hdr->size) & r->mask;
> +	}
> +	r->page->data_tail =3D old;
What happens if data_tail moves while you're doing the loop?



> +static int filter_test(void)
> +{
> +	struct pollfd pollfd;
> +	struct event ebhrb;
> +	pid_t pid;
> +	int ret, loop =3D 0;
> +
> +	has_failed =3D false;
> +	pid =3D fork();
> +	if (pid =3D=3D -1) {
> +		perror("fork() failed");
> +		return 1;
> +	}
> +
> +	/* Run child */
> +	if (pid =3D=3D 0) {
> +		start_loop();
> +		exit(0);
> +	}
> +
> +	/* Prepare event */
> +	event_init_opts(&ebhrb, PERF_COUNT_HW_INSTRUCTIONS,
> +				PERF_TYPE_HARDWARE, "insturctions");
Is instructions deliberately spelled incorrectly?

> +	ebhrb.attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
> +	ebhrb.attr.disabled =3D 1;
> +	ebhrb.attr.mmap =3D 1;
> +	ebhrb.attr.mmap_data =3D 1;
> +	ebhrb.attr.sample_period =3D SAMPLE_PERIOD;
> +	ebhrb.attr.exclude_user =3D 0;
> +	ebhrb.attr.exclude_kernel =3D 1;
> +	ebhrb.attr.exclude_hv =3D 1;
> +	ebhrb.attr.branch_sample_type =3D branch_sample_type;
> +
> +	/* Open event */
> +	event_open_with_pid(&ebhrb, pid);
> +
> +	/* Mmap ring buffer and enable event */
> +	event_mmap(&ebhrb);
> +	FAIL_IF(event_enable(&ebhrb));
> +
> +	/* Prepare polling */
> +	pollfd.fd =3D ebhrb.fd;
> +	pollfd.events =3D POLLIN;
> +
> +	for (loop =3D 0; loop < LOOP_COUNT; loop++) {
> +		ret =3D poll(&pollfd, 1, -1);
> +		if (ret =3D=3D -1) {
> +			perror("poll() failed");
> +			return 1;
> +		}
> +		if (ret =3D=3D 0) {
> +			perror("poll() timeout");
> +			return 1;
> +		}
> +		read_ring_buffer(&ebhrb);
> +		if (has_failed)
> +			return 1;
1) I don't see anything that sets has_failed after it's initalised.
2) Should these error cases also explicitly terminate the child? Do you
need something like this perhaps?

		if (ret =3D=3D 0) {
			perror("poll() failed");
			goto err;
		}

		...
=09
	}

	...

	return 0;

	err:
	kill(pid, SIGTERM); // maybe even sigkill in the error case?
	return 1;

> +	}
> +
> +	/* Disable and close event */
> +	FAIL_IF(event_disable(&ebhrb));
> +	event_close(&ebhrb);
Again, do these need to be replicated in the error path?
> +
> +	/* Terminate child */
> +	kill(pid, SIGKILL);
SIGKILL seems a bit harsh: wouldn't SIGTERM work?
> +	return 0;
> +}
> +
> +static int  bhrb_filters_test(void)
> +{
> +	int i;
> +
> +	/* Fetch branches */
> +	fetch_branches();
> +	init_branch_stats();
> +	init_perf_mmap_stats();
> +
> +	for (i =3D 0; i < sizeof(branch_test_set)/sizeof(int); i++) {
> +		branch_sample_type =3D branch_test_set[i];
> +		if (filter_test())
Couldn't branch_sample_type be passed to filter_test as a parameter,
rather than as a global?
> +			return 1;
> +	}
> +


> diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h b/to=
ols/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
> new file mode 100644
> index 0000000..072375a
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
> @@ -0,0 +1,16 @@
> +/*
> + * Copyright 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
License again. (And in the other files in this patch.)


> +_GLOBAL(start_loop)
> +label:
> +	b label0			/* ANY */
> +	blr				/* ANY_RETURN */
> +label0:
> +	b label1			/* ANY */
> +
> +label1:
> +	b label2			/* ANY */
> +
> +label2:
> +	b label3			/* ANY */
> +
> +label3:
> +	mflr LR_SAVE
> +	bl label4			/* ANY | ANY_CALL */
> +	mtlr LR_SAVE
> +	b start_loop			/* ANY */
> +label4:
> +	mflr LR_SAVE
> +	li 20, 12
> +	cmpi 3, 20, 12
> +	bcl 12, 4 * cr3+2, label5	/* ANY | ANY_CALL | COND */
> +	li 20, 12
> +	cmpi 4, 20, 20
> +	bcl 12, 4 * cr4+0, label5	/* ANY | ANY_CALL | COND */
> +	LOAD_ADDR(20, label5)
> +	mtctr 20
> +	li 22, 10
> +	cmpi 0, 22, 10
> +	bcctrl 12, 4*cr0+2		/* ANY | NY_CALL | IND_CALL | COND */
> +	LOAD_ADDR(20, label5)
> +	mtlr 20
> +	li      20, 10
> +	cmpi    0, 20, 10
> +	bclrl   12, 4*cr0+2		/* ANY | ANY_CALL | IND_CALL | COND */
> +	mtlr LR_SAVE
> +	blr				/* ANY | ANY_RETURN */
> +
> +label5:
> +	blr				/* ANY | ANY_RETURN */
> +
Could these labels have more descriptive names?


Regards,
Daniel

--=-+RPbRhRcuyl+VCy0/AUe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVeO3RAAoJEPC3R3P2I92Fx9YP/jqdJHnaZVKjZSL1f2FKrR2R
vqwj5t/KXOa4gzVNOdTr/Tk7frqQ9Zcp27Knaq1XdtJONjEroRir9zARk34brbcV
tf/olsmrK5oFrJMFFfZPEecNsHveuF+bnZMlbNYAtZo+LJHUuDatO4TnysFDm5OQ
FsQmSDHRiNjwJIqozn8iTmrJUAtiZTEHVRmwA+x6veBzv3I1Np02iHJtk0qc55+r
ExtK4XXe35rJ1SANhzPpUOdD1SUsDGrFmU9YH5Hvg3IUuy8xFYqstl09rMVXjKaJ
+xpuXGOX9joC6iY5vdmvtcIFeYOExjk7QXBjucfAKHpCVPoVp5rMvPrc92RVmUF1
qOjgQAF/i6c4sOtsi1JMUIhjZqhlVAGZ0YBi6+QB3Ox6NPDRvMBWhhA1L05qfiaI
kHHXtPcOq5Ru3nj82qK6XF8FblnG3qfLh9/Msjbg9oOgCYb313+lvrrx2TzGG5mz
6sSi0dcEl3xDYhnyFsptw57GXnGMkk4hPsZ7R9Qrn4wtrPRVr8QSj33hqFNILTAO
F+EBkREhgcWN/s/bCCXZwVptoNSAhhCiGZtkrzwsN5MO0ujvzV+DLouSJ+sAESLX
lMr+TCH6T7UdgsCpLEH+1PhCwplWVb2mG4dKD5c6EPD5VJ4bTF6w0P7UfSOzz0ub
X8uf+9u8O5DAyF1NiPB6
=xO+j
-----END PGP SIGNATURE-----

--=-+RPbRhRcuyl+VCy0/AUe--
