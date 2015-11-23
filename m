Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC9D91A0272
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:34:31 +1100 (AEDT)
Message-ID: <1448238870.3483.107.camel@neuling.org>
Subject: Re: [PATCH 2/8] selftests/powerpc: Test preservation of FPU and VMX
 regs across preemption
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, anton@samba.org, linuxppc-dev@ozlabs.org
Date: Mon, 23 Nov 2015 11:34:30 +1100
In-Reply-To: <1447817215-15804-3-git-send-email-cyrilbur@gmail.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <1447817215-15804-3-git-send-email-cyrilbur@gmail.com>
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

> Loop in assembly checking the registers with many threads.
>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  tools/testing/selftests/powerpc/math/Makefile      |  7 +-
>  tools/testing/selftests/powerpc/math/fpu_asm.S     | 34 ++++++++
>  tools/testing/selftests/powerpc/math/fpu_preempt.c | 92 ++++++++++++++++=
++++++
>  tools/testing/selftests/powerpc/math/vmx_asm.S     | 44 ++++++++++-
>  tools/testing/selftests/powerpc/math/vmx_preempt.c | 92 ++++++++++++++++=
++++++
>  5 files changed, 263 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_preempt.c
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_preempt.c
>=20
> diff --git a/tools/testing/selftests/powerpc/math/Makefile
b/tools/testing/selftests/powerpc/math/Makefile
> index 896d9e2..9fa690f 100644
> --- a/tools/testing/selftests/powerpc/math/Makefile
> +++ b/tools/testing/selftests/powerpc/math/Makefile
> @@ -1,12 +1,15 @@
> -TEST_PROGS :=3D fpu_syscall vmx_syscall
> +TEST_PROGS :=3D fpu_syscall fpu_preempt vmx_syscall vmx_preempt

.gitignore for this new build object


>  all: $(TEST_PROGS)
> =20
>  $(TEST_PROGS): ../harness.c
> -$(TEST_PROGS): CFLAGS +=3D -O2 -g
> +$(TEST_PROGS): CFLAGS +=3D -O2 -g -pthread
> =20
>  fpu_syscall: fpu_asm.S
> +fpu_preempt: fpu_asm.S
> +
>  vmx_syscall: vmx_asm.S
> +vmx_preempt: vmx_asm.S
> =20
>  include ../../lib.mk
> =20
> diff --git a/tools/testing/selftests/powerpc/math/fpu_asm.S b/tools/testi=
ng/selftests/powerpc/math/fpu_asm.S
> index d5412c1..5ff0adc 100644
> --- a/tools/testing/selftests/powerpc/math/fpu_asm.S
> +++ b/tools/testing/selftests/powerpc/math/fpu_asm.S
> @@ -149,3 +149,37 @@ FUNC_START(test_fpu)
>  > 	> POP_BASIC_STACK(256)
>  > 	> blr
>  FUNC_END(test_fpu)
> +
> +#int preempt_fpu(double *darray, volatile int *not_ready, int *sentinal)
> +#On starting will (atomically) decrement not_ready as a signal that the =
FPU
> +#has been loaded with darray. Will proceed to check the validity of the =
FPU
> +#registers while sentinal is not zero.
> +FUNC_START(preempt_fpu)
> +> 	> PUSH_BASIC_STACK(256)
> +> 	> std r3,32(sp) #double *darray
> +> 	> std r4,40(sp) #volatile int *not_ready
> +> 	> std r5,48(sp) #int *sentinal
> +> 	> PUSH_FPU(56)
> +
> +> 	> bl load_fpu
> +

Memory barrier here.

> +> 	> #Atomic DEC
> +> 	> ld r3,40(sp)
> +1:> 	> lwarx r4,0,r3
> +> 	> addi r4,r4,-1
> +> 	> stwcx. r4,0,r3
> +> 	> bne- 1b
> +
> +2:> 	> ld r3, 32(sp)
> +> 	> bl check_fpu
> +> 	> cmpdi r3,0
> +> 	> bne 3f
> +> 	> ld r4, 48(sp)
> +> 	> ld r5, 0(r4)
> +> 	> cmpwi r5,0
> +> 	> bne 2b
> +
> +3:> 	> POP_FPU(56)
> +> 	> POP_BASIC_STACK(256)
> +> 	> blr
> +FUNC_END(preempt_fpu)
> diff --git a/tools/testing/selftests/powerpc/math/fpu_preempt.c b/tools/t=
esting/selftests/powerpc/math/fpu_preempt.c
> new file mode 100644
> index 0000000..e24cf9b
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/fpu_preempt.c

Needs a copyright and a description of the test here.

Same in patch 1.

> @@ -0,0 +1,92 @@
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
> +/* Time to wait for workers to get preempted (seconds) */
> +#define PREEMPT_TIME 20
> +/*
> + * Factor by which to multiply number of online CPUs for total number of
> + * worker threads
> + */
> +#define THREAD_FACTOR 8
> +
> +
> +__thread double darray[] =3D {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.=
9, 1.0,
> +> 	> 	>      1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0,
> +> 	> 	>      2.1};
> +
> +volatile int not_ready;
> +int running;
> +
> +extern void preempt_fpu(double *darray, volatile int *not_ready, int *se=
ntinal);
> +
> +void *preempt_fpu_c(void *p)
> +{
> +> 	> int i;
> +> 	> srand(pthread_self());
> +> 	> for (i =3D 0; i < 21; i++)
> +> 	> 	> darray[i] =3D rand();
> +
> +> 	> /* Test failed if it ever returns */
> +> 	> preempt_fpu(darray, &not_ready, &running);
> +
> +> 	> return p;
> +}
> +
> +int test_preempt_fpu(void)
> +{
> +> 	> int i, rc, threads;
> +> 	> pthread_t *tids;
> +
> +> 	> threads =3D sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
> +> 	> tids =3D malloc((threads) * sizeof(pthread_t));
> +> 	> FAIL_IF(!tids);
> +
> +> 	> running =3D true;
> +> 	> not_ready =3D threads;
> +> 	> for (i =3D 0; i < threads; i++) {
> +> 	> 	> rc =3D pthread_create(&tids[i], NULL, preempt_fpu_c, NULL);
> +> 	> 	> FAIL_IF(rc);
> +> 	> }
> +
> +> 	> setbuf(stdout, NULL);
> +> 	> /* Not really nessesary but nice to wait for every thread to start =
*/
> +> 	> printf("\tWaiting for all workers to start...");
> +> 	> while(not_ready);

You need a memory barrier here and a matching one in the asm which is
derementing it.  Same in the VSX test.

> +> 	> printf("done\n");
> +
> +> 	> printf("\tWaiting for %d seconds to let some workers get preempted.=
..", PREEMPT_TIME);
> +> 	> sleep(PREEMPT_TIME);
> +> 	> printf("done\n");
> +
> +> 	> printf("\tKilling workers...");
> +> 	> running =3D 0;
> +> 	> for (i =3D 0; i < threads; i++) {
> +> 	> 	> void *rc_p;
> +> 	> 	> pthread_join(tids[i], &rc_p);
> +
> +> 	> 	> /*
> +> 	> 	>  * Harness will say the fail was here, look at why preempt_fpu
> +> 	> 	>  * returned
> +> 	> 	>  */
> +> 	> 	> if ((long) rc_p)
> +> 	> 	> 	> printf("oops\n");
> +> 	> 	> FAIL_IF((long) rc_p);
> +> 	> }
> +> 	> printf("done\n");
> +
> +> 	> free(tids);
> +> 	> return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +> 	> return test_harness(test_preempt_fpu, "fpu_preempt");
> +}
> diff --git a/tools/testing/selftests/powerpc/math/vmx_asm.S b/tools/testi=
ng/selftests/powerpc/math/vmx_asm.S
> index e642e67..23db4b3 100644
> --- a/tools/testing/selftests/powerpc/math/vmx_asm.S
> +++ b/tools/testing/selftests/powerpc/math/vmx_asm.S
> @@ -1,5 +1,6 @@
>  #include "basic_asm.h"
> =20
> +#POS MUST BE 16 ALIGNED!
>  #define PUSH_VMX(pos,reg) \
>  > 	> li> 	> reg,pos; \
>  > 	> stvx> 	> v20,reg,sp; \
> @@ -26,6 +27,7 @@
>  > 	> addi> 	> reg,reg,16; \
>  > 	> stvx> 	> v31,reg,sp;
> =20
> +#POS MUST BE 16 ALIGNED!
>  #define POP_VMX(pos,reg) \
>  > 	> li> 	> reg,pos; \
>  > 	> lvx> 	> v20,reg,sp; \
> @@ -84,7 +86,7 @@ FUNC_END(load_vmx)
> =20
>  #Should be safe from C, only touches r4, r5 and v0,v1,v2
>  FUNC_START(check_vmx)
> -> 	> PUSH_BASIC_STACK(16)
> +> 	> PUSH_BASIC_STACK(32)
>  > 	> mr r4,r3
>  > 	> li> 	> r3,1 #assume a bad result
>  > 	> li> 	> r5,0
> @@ -153,7 +155,7 @@ FUNC_START(check_vmx)
>  > 	> cmpdi> 	> r0,0xffffffff
>  > 	> bne> 	> 1f
>  > 	> li> 	> r3,0
> -1:> 	> POP_BASIC_STACK(16)
> +1:> 	> POP_BASIC_STACK(32)
>  > 	> blr
>  FUNC_END(check_vmx)
> =20
> @@ -164,7 +166,7 @@ FUNC_START(test_vmx)
>  > 	> PUSH_BASIC_STACK(512)
>  > 	> std> 	> r3,40(sp) #Address of varray
>  > 	> std r4,48(sp) #address of pid
> -> 	> PUSH_VMX(56, r4)
> +> 	> PUSH_VMX(64, r4)
> =20
>  > 	> bl load_vmx
> =20
> @@ -177,7 +179,41 @@ FUNC_START(test_vmx)
>  > 	> ld r3,40(sp)
>  > 	> bl check_vmx
> =20
> -> 	> POP_VMX(56,r4)
> +> 	> POP_VMX(64,r4)
>  > 	> POP_BASIC_STACK(512)
>  > 	> blr
>  FUNC_END(test_vmx)
> +
> +#int preempt_vmx(v4si *varray, volatile int *not_ready, int *sentinal)
> +#On starting will (atomically) decrement not_ready as a signal that the =
FPU
> +#has been loaded with varray. Will proceed to check the validity of the =
FPU
> +#registers while sentinal is not zero.
> +FUNC_START(preempt_vmx)
> +> 	> PUSH_BASIC_STACK(512)
> +> 	> std r3,32(sp) #v4si *varray
> +> 	> std r4,40(sp) #volatile int *not_ready
> +> 	> std r5,48(sp) #int *sentinal
> +> 	> PUSH_VMX(64,r4)
> +
> +> 	> bl load_vmx
> +

Memory barrier here

> +> 	> #Atomic DEC
> +> 	> ld r3,40(sp)
> +1:> 	> lwarx r4,0,r3
> +> 	> addi r4,r4,-1
> +> 	> stwcx. r4,0,r3
> +> 	> bne- 1b
> +
> +2:> 	> ld r3,32(sp)
> +> 	> bl check_vmx
> +> 	> cmpdi r3,0
> +> 	> bne 3f
> +> 	> ld r4,48(sp)
> +> 	> ld r5,0(r4)
> +> 	> cmpwi r5,0
> +> 	> bne 2b
> +
> +3:> 	> POP_VMX(64,r4)
> +> 	> POP_BASIC_STACK(512)
> +> 	> blr
> +FUNC_END(preempt_vmx)
> diff --git a/tools/testing/selftests/powerpc/math/vmx_preempt.c b/tools/t=
esting/selftests/powerpc/math/vmx_preempt.c
> new file mode 100644
> index 0000000..342db15
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/vmx_preempt.c

Needs a copyright and a description of the test here. =20

> @@ -0,0 +1,92 @@
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
> +/* Time to wait for workers to get preempted (seconds) */
> +#define PREEMPT_TIME 20
> +/*
> + * Factor by which to multiply number of online CPUs for total number of
> + * worker threads
> + */
> +#define THREAD_FACTOR 8
> +
> +typedef int v4si __attribute__ ((vector_size (16)));
> +__thread v4si varray[] =3D {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10,11,12},
> +> 	> {13,14,15,16},{17,18,19,20},{21,22,23,24},
> +> 	> {25,26,27,28},{29,30,31,32},{33,34,35,36},
> +> 	> {37,38,39,40},{41,42,43,44},{45,46,47,48}};
> +
> +volatile int not_ready;

I really hate this name.  How about just "ready" and you negate the
code.

> +int running;

Now about not_running ;-P

> +
> +extern void preempt_vmx(v4si *varray, volatile int *not_ready, int *sent=
inal);
> +
> +void *preempt_vmx_c(void *p)
> +{
> +> 	> int i, j;
> +> 	> srand(pthread_self());
> +> 	> for (i =3D 0; i < 12; i++)
> +> 	> 	> for (j =3D 0; j < 4; j++)
> +> 	> 	> 	> varray[i][j] =3D rand();
> +
> +> 	> /* Test fails if it ever returns */
> +> 	> preempt_vmx(varray, &not_ready, &running);
> +> 	> return p;
> +}
> +
> +int test_preempt_vmx(void)
> +{
> +> 	> int i, rc, threads;
> +> 	> pthread_t *tids;
> +
> +> 	> threads =3D sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
> +> 	> tids =3D malloc(threads * sizeof(pthread_t));
> +> 	> FAIL_IF(!tids);
> +
> +> 	> running =3D true;
> +> 	> not_ready =3D threads;
> +> 	> for (i =3D 0; i < threads; i++) {
> +> 	> 	> rc =3D pthread_create(&tids[i], NULL, preempt_vmx_c, NULL);
> +> 	> 	> FAIL_IF(rc);
> +> 	> }
> +
> +> 	> setbuf(stdout, NULL);
> +> 	> /* Not really nessesary but nice to wait for every thread to start =
*/
> +> 	> printf("\tWaiting for all workers to start...");
> +> 	> while(not_ready);

Again, a memory barrier here.

> +> 	> printf("done\n");
> +
> +> 	> printf("\tWaiting for %d seconds to let some workers get preempted.=
..", PREEMPT_TIME);
> +> 	> sleep(PREEMPT_TIME);
> +> 	> printf("done\n");
> +
> +> 	> printf("\tKilling workers...");
> +> 	> running =3D 0;
> +> 	> for (i =3D 0; i < threads; i++) {
> +> 	> 	> void *rc_p;
> +> 	> 	> pthread_join(tids[i], &rc_p);
> +
> +> 	> 	> /*
> +> 	> 	>  * Harness will say the fail was here, look at why preempt_vmx
> +> 	> 	>  * returned
> +> 	> 	>  */
> +> 	> 	> if ((long) rc_p)
> +> 	> 	> 	> printf("oops\n");
> +> 	> 	> FAIL_IF((long) rc_p);
> +> 	> }
> +> 	> printf("done\n");
> +
> +> 	> return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +> 	> return test_harness(test_preempt_vmx, "vmx_preempt");
> +}
