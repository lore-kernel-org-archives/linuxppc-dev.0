Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQ7Gk757FzDqHQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 11:37:50 +1000 (AEST)
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rQ7Gk0Xclz9sdn
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2016 11:37:49 +1000 (AEST)
Received: by mail-pf0-f196.google.com with SMTP id c74so1658793pfb.0
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Jun 2016 18:37:49 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Cyril Bur <cyrilbur@gmail.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/5] selftests/powerpc: Check for VSX preservation across
 userspace preemption
In-Reply-To: <20160608040036.13064-2-cyrilbur@gmail.com>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-2-cyrilbur@gmail.com>
Date: Thu, 09 Jun 2016 11:35:55 +1000
Message-ID: <87mvmvqh38.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Yay for tests!

I have a few minor nits, and one more major one (rc =3D=3D 2 below).

> +/*
> + * Copyright 2015, Cyril Bur, IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
I realise this is well past a lost cause by now, but isn't the idea to
be version 2, not version 2 or later?

> +
> +#include "../basic_asm.h"
> +#include "../vsx_asm.h"
> +

Some of your other functions start with a comment. That would be super
helpful here - I'm still not super comfortable I understand the calling
convention.=20
> +FUNC_START(check_vsx)
> +	PUSH_BASIC_STACK(32)
> +	std	r3,STACK_FRAME_PARAM(0)(sp)
> +	addi r3, r3, 16 * 12 #Second half of array
> +	bl store_vsx
> +	ld r3,STACK_FRAME_PARAM(0)(sp)
> +	bl vsx_memcmp
> +	POP_BASIC_STACK(32)
> +	blr
> +FUNC_END(check_vsx)
> +



> +long vsx_memcmp(vector int *a) {
> +	vector int zero =3D {0,0,0,0};
> +	int i;
> +
> +	FAIL_IF(a !=3D varray);
> +
> +	for(i =3D 0; i < 12; i++) {
> +		if (memcmp(&a[i + 12], &zero, 16) =3D=3D 0) {
> +			fprintf(stderr, "Detected zero from the VSX reg %d\n", i + 12);
> +			return 1;
> +		}
> +	}
> +
> +	if (memcmp(a, &a[12], 12 * 16)) {
I'm somewhat confused as to how this comparison works. You're comparing
the new saved ones to the old saved ones, yes?
> +		long *p =3D (long *)a;
> +		fprintf(stderr, "VSX mismatch\n");
> +		for (i =3D 0; i < 24; i=3Di+2)
> +			fprintf(stderr, "%d: 0x%08lx%08lx | 0x%08lx%08lx\n",
> +					i/2 + i%2 + 20, p[i], p[i + 1], p[i + 24], p[i + 25]);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +void *preempt_vsx_c(void *p)
> +{
> +	int i, j;
> +	long rc;
> +	srand(pthread_self());
> +	for (i =3D 0; i < 12; i++)
> +		for (j =3D 0; j < 4; j++) {
> +			varray[i][j] =3D rand();
> +			/* Don't want zero because it hides kernel problems */
> +			if (varray[i][j] =3D=3D 0)
> +				j--;
> +		}
> +	rc =3D preempt_vsx(varray, &threads_starting, &running);
> +	if (rc =3D=3D 2)
How would rc =3D=3D 2? AIUI, preempt_vsx returns the value of check_vsx,
which in turn returns the value of vsx_memcmp, which returns 1 or 0.

> +		fprintf(stderr, "Caught zeros in VSX compares\n");
Isn't it zeros or a mismatched value?
> +	return (void *)rc;
> +}
> +
> +int test_preempt_vsx(void)
> +{
> +	int i, rc, threads;
> +	pthread_t *tids;
> +
> +	threads =3D sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
> +	tids =3D malloc(threads * sizeof(pthread_t));
> +	FAIL_IF(!tids);
> +
> +	running =3D true;
> +	threads_starting =3D threads;
> +	for (i =3D 0; i < threads; i++) {
> +		rc =3D pthread_create(&tids[i], NULL, preempt_vsx_c, NULL);
> +		FAIL_IF(rc);
> +	}
> +
> +	setbuf(stdout, NULL);
> +	/* Not really nessesary but nice to wait for every thread to start */
> +	printf("\tWaiting for %d workers to start...", threads_starting);
> +	while(threads_starting)
> +		asm volatile("": : :"memory");
I think __sync_synchronise() might be ... more idiomatic or something?
Not super fussy.

> +	printf("done\n");
> +
> +	printf("\tWaiting for %d seconds to let some workers get preempted...",=
 PREEMPT_TIME);
> +	sleep(PREEMPT_TIME);
> +	printf("done\n");
> +
> +	printf("\tStopping workers...");
> +	/*
> +	 * Working are checking this value every loop. In preempt_vsx 'cmpwi r5=
,0; bne 2b'.
> +	 * r5 will have loaded the value of running.
> +	 */
> +	running =3D 0;
Do you need some sort of synchronisation here? You're assuming it
eventually gets to the threads, which is of course true, but maybe it
would be a good idea to synchronise it more explicitly? Again, not super
fussy.
> +	for (i =3D 0; i < threads; i++) {
> +		void *rc_p;
> +		pthread_join(tids[i], &rc_p);
> +
> +		/*
> +		 * Harness will say the fail was here, look at why preempt_vsx
> +		 * returned
> +		 */
> +		if ((long) rc_p)
> +			printf("oops\n");
> +		FAIL_IF((long) rc_p);
> +	}
> +	printf("done\n");
> +
> +	return 0;
> +}
> +
Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXWMf9AAoJEPC3R3P2I92F3EwP/iWpPUTz6moiOXpkGseQOXqu
lkF2INja8MTyYcHtUIxfC/x6DfWTcXJ+lc5bNwA02K3Ozf7Br8KoRkJcuFG62N6E
/1qQcXICPWX0JwSzAq6+Sb+cLlGxEUcgXyoK42b2AIllqXtJ0Hznw2BG2rOKBuSw
ZGes415G36DSbqM87QZlFtf+lpL3URiDiciOtE5zomG3kFfULRk82qlvxhtnIgV7
DPH3s7jOrVJrOSrykEzWob4WB8TZRCMmy0YSgoA5m7O8wI65V9mloIzJWJ646ta7
Twdh4xrQLb0xT/GLYanNM+7kAjZGOQc87qcIdMZENa4/riB43lX31S5Pn80NFa8y
UZouFgEfSuLElkxDQlU+SvFotQH5sJ1Cs/zR8mSp4o5heZ7li+M/XZPcK/wHqO/Z
86KGzmyJ49LaVMwpcQMyv/sNuUyg01NpJPMkbLZZiQkNc2kKhiQYheWM8DML/c9w
BPcRZNJLrlaSu2R+ilKr9FzXtQ9a/XDtYq+3pg6n4QwZ3hcNmOoJ+dd+6DATjYNp
D2CdEQIwR9aR3LPFpon3yNm4NG22bE1w2YdVLxC9aDSKQkEFE7CgqFn/s9FwsdMA
qEsA9KNa+Eu/QVHRsP52YhKx+/8elDvnu8JL09o3HaCbiG8FTjMjo4L7mAeVxniN
tB5L/mP6nMYbLJwCsMIG
=nGAr
-----END PGP SIGNATURE-----
--=-=-=--
