Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE4C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 02:16:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9CB2081C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 02:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="I/jBwq1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9CB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4351Nm1BkNzDr1Q
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 13:16:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="I/jBwq1x";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4351H75vxdzDqyk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 13:11:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="I/jBwq1x"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 4351H62Gcbz9s9J;
 Thu, 29 Nov 2018 13:11:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1543457506;
 bh=2UItOKoc95+O4CRInKas5Emn3ZR5zaywxBbgN8/Znw4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=I/jBwq1x4LH34S0S02/m9dY9ROQrfLej6IuVLsqvJfF0iSQky0Gbzf7HVesJLJ8Jk
 vu+RGTX7nodDn56PhIppJw+0JphWr53kRmsM3wXY/f7071ddiX1l2LcU7WtliCHhnW
 rbxiJykTONo05hj+EAx0c8OvqiC7yC9cFWR/NwwQ/fOAKgrmy+h7MB4eejf5/diMXP
 RaXVl3qBAggLAkLCObXqsZAXPBC0AOlhOv1ACOerME6gR1cqjkC6APbFR2V/a6sQPt
 oG0tu//v+Cc5bkfKkKLSxx7QvkvrVC6r5Bzr5q86Grf7SQ/uv2YG/TyY3wrjjh475K
 Iw/sXhVEuPk0Q==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 4511E2A006A; Thu, 29 Nov 2018 13:11:46 +1100 (AEDT)
Message-ID: <25051cb7a66f59beca598cbbef6f7eb92d654772.camel@neuling.org>
Subject: Re: [PATCH] selftests/powerpc: New TM signal self test
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 29 Nov 2018 13:11:46 +1100
In-Reply-To: <1543411413-23863-1-git-send-email-leitao@debian.org>
References: <1542828069-29100-1-git-send-email-leitao@debian.org>
 <1543411413-23863-1-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-28 at 11:23 -0200, Breno Leitao wrote:
> A new self test that forces MSR[TS] to be set without calling any TM
> instruction. This test also tries to cause a page fault at a signal
> handler, exactly between MSR[TS] set and tm_recheckpoint(), forcing
> thread->texasr to be rewritten with TEXASR[FS] =3D 0, which will cause a =
BUG
> when tm_recheckpoint() is called.
>=20
> This test is not deterministic since it is hard to guarantee that the pag=
e
> access will cause a page fault. Tests have shown that the bug could be
> exposed with few interactions in a buggy kernel. This test is configured =
to
> loop 5000x, having a good chance to hit the kernel issue in just one run.
> This self test takes less than two seconds to run.

You could try using sigaltstack() to put the ucontext somewhere else. Then =
you
could play tricks with that memory to try to force a fault.
madvise()+MADV_DONTNEED or fadvise()+POSIX_FADV_DONTNEED might do the trick=
.

This is more extra credit to make it more reliable. Not a requirement.


> This test uses set/getcontext because the kernel will recheckpoint
> zeroed structures, causing the test to segfault, which is undesired becau=
se
> the test needs to rerun, so, there is a signal handler for SIGSEGV which
> will restart the test.

Please put this description at the top of the test also.

Other than that, it looks good.

Mikey

>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/powerpc/tm/.gitignore |   1 +
>  tools/testing/selftests/powerpc/tm/Makefile   |   3 +-
>  .../powerpc/tm/tm-signal-force-msr.c          | 115 ++++++++++++++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-force-ms=
r.c
>=20
> diff --git a/tools/testing/selftests/powerpc/tm/.gitignore
> b/tools/testing/selftests/powerpc/tm/.gitignore
> index c3ee8393dae8..89679822ebc9 100644
> --- a/tools/testing/selftests/powerpc/tm/.gitignore
> +++ b/tools/testing/selftests/powerpc/tm/.gitignore
> @@ -11,6 +11,7 @@ tm-signal-context-chk-fpu
>  tm-signal-context-chk-gpr
>  tm-signal-context-chk-vmx
>  tm-signal-context-chk-vsx
> +tm-signal-force-msr
>  tm-vmx-unavail
>  tm-unavailable
>  tm-trap
> diff --git a/tools/testing/selftests/powerpc/tm/Makefile
> b/tools/testing/selftests/powerpc/tm/Makefile
> index 9fc2cf6fbc92..58a2ebd13958 100644
> --- a/tools/testing/selftests/powerpc/tm/Makefile
> +++ b/tools/testing/selftests/powerpc/tm/Makefile
> @@ -4,7 +4,7 @@ SIGNAL_CONTEXT_CHK_TESTS :=3D tm-signal-context-chk-gpr t=
m-
> signal-context-chk-fpu
> =20
>  TEST_GEN_PROGS :=3D tm-resched-dscr tm-syscall tm-signal-msr-resv tm-sig=
nal-
> stack \
>  	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-unavailable tm-tra=
p=20
> \
> -	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn
> +	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-force-msr
> =20
>  top_srcdir =3D ../../../../..
>  include ../../lib.mk
> @@ -20,6 +20,7 @@ $(OUTPUT)/tm-vmx-unavail: CFLAGS +=3D -pthread -m64
>  $(OUTPUT)/tm-resched-dscr: ../pmu/lib.c
>  $(OUTPUT)/tm-unavailable: CFLAGS +=3D -O0 -pthread -m64 -Wno-
> error=3Duninitialized -mvsx
>  $(OUTPUT)/tm-trap: CFLAGS +=3D -O0 -pthread -m64
> +$(OUTPUT)/tm-signal-force-msr: CFLAGS +=3D -pthread
> =20
>  SIGNAL_CONTEXT_CHK_TESTS :=3D $(patsubst
> %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
>  $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
> diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c
> b/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c
> new file mode 100644
> index 000000000000..4441d61c2328
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018, Breno Leitao, Gustavo Romero, IBM Corp.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <ucontext.h>
> +#include <unistd.h>
> +
> +#include "tm.h"
> +#include "utils.h"
> +
> +#define __MASK(X)       (1UL<<(X))
> +#define MSR_TS_S_LG     33                  /* Trans Mem state: Suspende=
d */
> +#define MSR_TM          __MASK(MSR_TM_LG)   /* Transactional Mem Availab=
le */
> +#define MSR_TS_S        __MASK(MSR_TS_S_LG) /* Transaction Suspended */

Surely we have these defined somewhere else in selftests?=20

> +
> +#define COUNT_MAX       5000                /* Number of interactions */
> +
> +/* Setting contexts because the test will crash and we want to recover *=
/
> +ucontext_t init_context, main_context;
> +
> +static int count, first_time;
> +
> +void trap_signal_handler(int signo, siginfo_t *si, void *uc)
> +{
> +	ucontext_t *ucp =3D uc;
> +
> +	/*
> +	 * Allocating memory in a signal handler, and never freeing it on
> +	 * purpose, forcing the heap increase, so, the memory leak is what
> +	 * we want here.
> +	 */
> +	ucp->uc_link =3D malloc(sizeof(ucontext_t));
> +	memcpy(&ucp->uc_link, &ucp->uc_mcontext, sizeof(ucp->uc_mcontext));
> +
> +	/* Forcing to enable MSR[TM] */
> +	ucp->uc_mcontext.gp_regs[PT_MSR] |=3D MSR_TS_S;
> +
> +	/*
> +	 * A fork inside a signal handler seems to be more efficient than a
> +	 * fork() prior to the signal being raised.
> +	 */
> +	if (fork() =3D=3D 0) {
> +		/*
> +		 * Both child and parent will return, but, child returns
> +		 * with count set so it will exit in the next segfault.
> +		 * Parent will continue to loop.
> +		 */
> +		count =3D COUNT_MAX;
> +	}
> +
> +	/*
> +	 * If the change above does not hit the bug, it will cause a
> +	 * segmentation fault, since the ck structures are NULL.
> +	 */
> +}
> +
> +void seg_signal_handler(int signo, siginfo_t *si, void *uc)
> +{
> +	if (count =3D=3D COUNT_MAX) {
> +		/* Return to tm_signal_force_msr() and exit */
> +		setcontext(&main_context);
> +	}
> +
> +	count++;
> +	/* Reexecute the test */
> +	setcontext(&init_context);
> +}
> +
> +void tm_trap_test(void)
> +{
> +	struct sigaction trap_sa, seg_sa;
> +
> +	trap_sa.sa_flags =3D SA_SIGINFO;
> +	trap_sa.sa_sigaction =3D trap_signal_handler;
> +
> +	seg_sa.sa_flags =3D SA_SIGINFO;
> +	seg_sa.sa_sigaction =3D seg_signal_handler;
> +
> +	/*
> +	 * Set initial context. Will get back here from
> +	 * seg_signal_handler()
> +	 */
> +	getcontext(&init_context);
> +
> +	/* The signal handler will enable MSR_TS */
> +	sigaction(SIGUSR1, &trap_sa, NULL);
> +	/* If it does not crash, it will segfault, avoid it to retest */
> +	sigaction(SIGSEGV, &seg_sa, NULL);
> +
> +	raise(SIGUSR1);
> +}
> +
> +int tm_signal_force_msr(void)
> +{
> +	SKIP_IF(!have_htm());
> +
> +	/* Will get back here after COUNT_MAX interactions */
> +	getcontext(&main_context);
> +
> +	if (!first_time++)
> +		tm_trap_test();
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	test_harness(tm_signal_force_msr, "tm_signal_force_msr");
> +}

