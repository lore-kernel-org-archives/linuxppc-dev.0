Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74DF41A009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 12:04:14 +1100 (AEDT)
Message-ID: <1448240653.3061.3.camel@neuling.org>
Subject: Re: [PATCH 3/8] selftests/powerpc: Test FPU and VMX regs in signal
 ucontext
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, anton@samba.org, linuxppc-dev@ozlabs.org
Date: Mon, 23 Nov 2015 12:04:13 +1100
In-Reply-To: <1447817215-15804-4-git-send-email-cyrilbur@gmail.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <1447817215-15804-4-git-send-email-cyrilbur@gmail.com>
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

On Wed, 2015-11-18 at 14:26 +1100, Cyril Bur wrote:

> Load up the non volatile FPU and VMX regs and ensure that they are
> the
> expected value in a signal handler
>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  tools/testing/selftests/powerpc/math/Makefile     |   4 +-
>  tools/testing/selftests/powerpc/math/fpu_signal.c | 119
> +++++++++++++++++++++
>  tools/testing/selftests/powerpc/math/vmx_signal.c | 124
> ++++++++++++++++++++++
>  3 files changed, 246 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_signal.c
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_signal.c
>=20
> diff --git a/tools/testing/selftests/powerpc/math/Makefile
> b/tools/testing/selftests/powerpc/math/Makefile
> index 9fa690f..5ce000bf 100644
> --- a/tools/testing/selftests/powerpc/math/Makefile
> +++ b/tools/testing/selftests/powerpc/math/Makefile
> @@ -1,4 +1,4 @@
> -TEST_PROGS :=3D fpu_syscall fpu_preempt vmx_syscall vmx_preempt
> +TEST_PROGS :=3D fpu_syscall fpu_preempt fpu_signal vmx_syscall
> vmx_preempt vmx_signal


.gitignore


>  all: $(TEST_PROGS)
> =20
> @@ -7,9 +7,11 @@ $(TEST_PROGS): CFLAGS +=3D -O2 -g -pthread
> =20
>  fpu_syscall: fpu_asm.S
>  fpu_preempt: fpu_asm.S
> +fpu_signal:  fpu_asm.S
> =20
>  vmx_syscall: vmx_asm.S
>  vmx_preempt: vmx_asm.S
> +vmx_signal: vmx_asm.S
> =20
>  include ../../lib.mk
> =20
> diff --git a/tools/testing/selftests/powerpc/math/fpu_signal.c
> b/tools/testing/selftests/powerpc/math/fpu_signal.c
> new file mode 100644
> index 0000000..ca61d1f
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/fpu_signal.c
> @@ -0,0 +1,119 @@

copyright + detailed description of test here.


> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +#include <pthread.h>
> +
> +#include "utils.h"
> +
> +/* Number of times each thread should recieve the signal */

receive=20


> +#define ITERATIONS 10
> +/*
> + * Factor by which to multiply number of online CPUs for total
> number of
> + * worker threads
> + */
> +#define THREAD_FACTOR 8
> +
> +__thread double darray[] =3D {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8,
> 0.9, 1.0,
> +		     1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9,
> 2.0,
> +		     2.1};
> +
> +bool bad_context;
> +int running;
> +volatile int not_ready;

Don't use volatile...  Ready Documentation/volatile-considered
-harmful.txt


> +extern long preempt_fpu(double *darray, volatile int *not_ready, int
> *sentinal);
> +
> +void signal_fpu_sig(int sig, siginfo_t *info, void *context)
> +{
> +	int i;
> +	ucontext_t *uc =3D context;
> +	mcontext_t *mc =3D &uc->uc_mcontext;
> +
> +	/* Only the non volatiles were loaded up */
> +	for (i =3D 14; i < 32; i++) {
> +		if (mc->fp_regs[i] !=3D darray[i - 14]) {
> +			bad_context =3D true;
> +			break;
> +		}
> +	}
> +}
> +
> +void *signal_fpu_c(void *p)
> +{
> +	int i;
> +	long rc;
> +	struct sigaction act;
> +	act.sa_sigaction =3D signal_fpu_sig;
> +	act.sa_flags =3D SA_SIGINFO;
> +	rc =3D sigaction(SIGUSR1, &act, NULL);
> +	if (rc)
> +		return p;
> +
> +	srand(pthread_self());
> +	for (i =3D 0; i < 21; i++)
> +		darray[i] =3D rand();
> +
> +	rc =3D preempt_fpu(darray, &not_ready, &running);
> +
> +	return (void *) rc;
> +}
> +
> +int test_signal_fpu(void)

This is almost idential to test_signal_vmx.  Can you merge them?

> +{
> +	int i, j, rc, threads;
> +	void *rc_p;
> +	pthread_t *tids;
> +
> +	threads =3D sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
> +	tids =3D malloc(threads * sizeof(pthread_t));
> +	FAIL_IF(!tids);
> +
> +	running =3D true;
> +	not_ready =3D threads;
> +	for (i =3D 0; i < threads; i++) {
> +		rc =3D pthread_create(&tids[i], NULL, signal_fpu_c,
> NULL);
> +		FAIL_IF(rc);
> +	}
> +
> +	setbuf(stdout, NULL);
> +	printf("\tWaiting for all workers to start...");
> +	while (not_ready);

A barrier needed here.

> +	printf("done\n");
> +
> +	printf("\tSending signals to all threads %d times...",
> ITERATIONS);
> +	for (i =3D 0; i < ITERATIONS; i++) {
> +		for (j =3D 0; j < threads; j++) {
> +			pthread_kill(tids[j], SIGUSR1);
> +		}
> +		sleep(1);
> +	}
> +	printf("done\n");
> +
> +	printf("\tKilling workers...");
> +	running =3D 0;
> +	for (i =3D 0; i < threads; i++) {
> +		pthread_join(tids[i], &rc_p);
> +
> +		/*
> +		 * Harness will say the fail was here, look at why
> signal_fpu
> +		 * returned
> +		 */
> +		if ((long) rc_p || bad_context)

bad_context is set in a signal handler but is that run in another
thread (I think)?  You might have some memory barrier issues with
bad_context also.

> +			printf("oops\n");
> +		if (bad_context)
> +			fprintf(stderr, "\t!! bad_context is
> true\n");
> +		FAIL_IF((long) rc_p || bad_context);
> +	}
> +	printf("done\n");
> +
> +	free(tids);
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_signal_fpu, "fpu_signal");
> +}
> diff --git a/tools/testing/selftests/powerpc/math/vmx_signal.c
> b/tools/testing/selftests/powerpc/math/vmx_signal.c
> new file mode 100644
> index 0000000..007ac9e
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/vmx_signal.c
> @@ -0,0 +1,124 @@
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +#include "utils.h"
> +
> +/* Number of times each thread should recieve the signal */
> +#define ITERATIONS 10
> +/*
> + * Factor by which to multiply number of online CPUs for total
> number of
> + * worker threads
> + */
> +#define THREAD_FACTOR 8
> +
> +typedef int v4si __attribute__ ((vector_size (16)));
> +__thread v4si varray[] =3D {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10,11,12},
> +	{13,14,15,16},{17,18,19,20},{21,22,23,24},
> +	{25,26,27,28},{29,30,31,32},{33,34,35,36},
> +	{37,38,39,40},{41,42,43,44},{45,46,47,48}};
> +
> +bool bad_context;
> +int running;
> +volatile int not_ready;
> +
> +extern int preempt_vmx(v4si *varray, volatile int *not_ready, int
> *sentinal);
> +
> +void signal_vmx_sig(int sig, siginfo_t *info, void *context)
> +{
> +	int i;
> +	ucontext_t *uc =3D context;
> +	mcontext_t *mc =3D &uc->uc_mcontext;
> +
> +	/* Only the non volatiles were loaded up */
> +	for (i =3D 20; i < 32; i++) {
> +		if (memcmp(mc->v_regs->vrregs[i], &varray[i - 20],
> 16)) {
> +			bad_context =3D true;
> +			break;
> +		}
> +	}
> +}
> +
> +void *signal_vmx_c(void *p)
> +{
> +	int i, j;
> +	long rc;
> +	struct sigaction act;
> +	act.sa_sigaction =3D signal_vmx_sig;
> +	act.sa_flags =3D SA_SIGINFO;
> +	rc =3D sigaction(SIGUSR1, &act, NULL);
> +	if (rc)
> +		return p;
> +
> +	srand(pthread_self());
> +	for (i =3D 0; i < 12; i++)
> +		for (j =3D 0; j < 4; j++)
> +			varray[i][j] =3D rand();
> +
> +	rc =3D preempt_vmx(varray, &not_ready, &running);
> +
> +	return (void *) rc;
> +}
> +
> +int test_signal_vmx(void)
> +{
> +	int i, j, rc, threads;
> +	void *rc_p;
> +	pthread_t *tids;
> +
> +	threads =3D sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
> +	tids =3D malloc(threads * sizeof(pthread_t));
> +	FAIL_IF(!tids);
> +
> +	running =3D true;
> +	not_ready =3D threads;
> +	for (i =3D 0; i < threads; i++) {
> +		rc =3D pthread_create(&tids[i], NULL, signal_vmx_c,
> NULL);
> +		FAIL_IF(rc);
> +	}
> +
> +	setbuf(stdout, NULL);
> +	printf("\tWaiting for all workers to start...");
> +	while (not_ready);
> +	printf("done\n");
> +
> +	printf("\tSending signals to all threads %d times...",
> ITERATIONS);
> +	for (i =3D 0; i < ITERATIONS; i++) {
> +		for (j =3D 0; j < threads; j++) {
> +			pthread_kill(tids[j], SIGUSR1);
> +		}
> +		sleep(1);
> +	}
> +	printf("done\n");
> +
> +	printf("\tKilling workers...");
> +	running =3D 0;
> +	for (i =3D 0; i < threads; i++) {
> +		pthread_join(tids[i], &rc_p);
> +
> +		/*
> +		 * Harness will say the fail was here, look at why
> signal_vmx
> +		 * returned
> +		 */
> +		if ((long) rc_p || bad_context)
> +			printf("oops\n");
> +		if (bad_context)
> +			fprintf(stderr, "\t!! bad_context is
> true\n");
> +		FAIL_IF((long) rc_p || bad_context);
> +	}
> +	printf("done\n");
> +
> +	free(tids);
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_signal_vmx, "vmx_signal");
> +}
