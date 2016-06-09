Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQH185ry8zDq68
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 17:26:36 +1000 (AEST)
Message-ID: <1465457196.14163.3.camel@neuling.org>
Subject: Re: [PATCH 2/2] selftests/powerpc: Test unaligned copy and paste
From: Michael Neuling <mikey@neuling.org>
To: Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 09 Jun 2016 17:26:36 +1000
In-Reply-To: <20160609060223.GA26308@distroguy.com>
References: <db3d861c85eb7c49362eec1a973ad023cfff82df.1465451957.git.chris@distroguy.com>
 <20160609060223.GA26308@distroguy.com>
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

On Thu, 2016-06-09 at 16:02 +1000, Chris Smart wrote:
> Test that an ISA 3.0 compliant machine performing an unaligned copy,
> copy_first, paste or paste_last is sent a SIGBUS.

It's probably overkill but we could check in the signal handler that the
sigbus was on the instruction we actually cared about. =C2=A0ie something l=
ike
this in the sig handler for copy first.

static void sig_handler(int signr, siginfo_t *info, void *ucontext)
{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ucontext_t *ctx =3D ucontex=
t;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int *pc =3D ctx->u=
c_mcontext.gp_regs[PT_NIP];

=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*pc !=3D=C2=A0COPY(0, buf+1, 1))
	=C2=A0 =C2=A0 exit(0); /* we hit the right instruction */


=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
}


>=20
> Signed-off-by: Chris Smart <chris@distroguy.com>
> ---
> =C2=A0tools/testing/selftests/powerpc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A03 +-
> =C2=A0.../testing/selftests/powerpc/alignment/.gitignore |=C2=A0=C2=A04 +=
+
> =C2=A0tools/testing/selftests/powerpc/alignment/Makefile | 11 +++++
> =C2=A0.../powerpc/alignment/copy_first_unaligned.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 46
> ++++++++++++++++++
> =C2=A0.../selftests/powerpc/alignment/copy_unaligned.c=C2=A0=C2=A0=C2=A0|=
 46
> ++++++++++++++++++
> =C2=A0.../powerpc/alignment/paste_last_unaligned.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 47
> ++++++++++++++++++
> =C2=A0.../selftests/powerpc/alignment/paste_unaligned.c=C2=A0=C2=A0| 47
> ++++++++++++++++++
> =C2=A0tools/testing/selftests/powerpc/instructions.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 55
> ++++++++++++++++++++++
> =C2=A08 files changed, 258 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/alignment/.gitig=
nore
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/alignment/Makefi=
le
> =C2=A0create mode 100644
> tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
> =C2=A0create mode 100644
> tools/testing/selftests/powerpc/alignment/copy_unaligned.c
> =C2=A0create mode 100644
> tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
> =C2=A0create mode 100644
> tools/testing/selftests/powerpc/alignment/paste_unaligned.c
> =C2=A0create mode 100644 tools/testing/selftests/powerpc/instructions.h
>=20
> diff --git a/tools/testing/selftests/powerpc/Makefile
> b/tools/testing/selftests/powerpc/Makefile
> index 4ca83fe80654..3c40c9d0e6c7 100644
> --- a/tools/testing/selftests/powerpc/Makefile
> +++ b/tools/testing/selftests/powerpc/Makefile
> @@ -12,7 +12,8 @@ CFLAGS :=3D -Wall -O2 -Wall -Werror
> -DGIT_VERSION=3D'"$(GIT_VERSION)"' -I$(CURDIR) $
> =C2=A0
> =C2=A0export CFLAGS
> =C2=A0
> -SUB_DIRS =3D benchmarks=C2=A0		\
> +SUB_DIRS =3D alignment		\
> +	=C2=A0=C2=A0=C2=A0benchmarks		\
> =C2=A0	=C2=A0=C2=A0=C2=A0copyloops		\
> =C2=A0	=C2=A0=C2=A0=C2=A0context_switch	\
> =C2=A0	=C2=A0=C2=A0=C2=A0dscr			\
> diff --git a/tools/testing/selftests/powerpc/alignment/.gitignore
> b/tools/testing/selftests/powerpc/alignment/.gitignore
> new file mode 100644
> index 000000000000..147d7cc3c71c
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/alignment/.gitignore
> @@ -0,0 +1,4 @@
> +copy_unaligned
> +copy_first_unaligned
> +paste_unaligned
> +paste_last_unaligned
> diff --git a/tools/testing/selftests/powerpc/alignment/Makefile
> b/tools/testing/selftests/powerpc/alignment/Makefile
> new file mode 100644
> index 000000000000..7f91a5e6ab79
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/alignment/Makefile
> @@ -0,0 +1,11 @@
> +TEST_PROGS :=3D copy_unaligned copy_first_unaligned paste_unaligned
> paste_last_unaligned
> +
> +all: $(TEST_PROGS)
> +
> +$(TEST_PROGS): ../harness.c ../utils.c
> +
> +include ../../lib.mk
> +
> +clean:
> +	rm -f $(TEST_PROGS)
> +
> diff --git
> a/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
> b/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
> new file mode 100644
> index 000000000000..48e4f9ab6137
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright 2016, Chris Smart, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * Calls to copy_first which are not 128-byte aligned should be
> + * caught and sent a SIGBUS.
> + *
> + */
> +
> +#include <signal.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "utils.h"
> +#include "instructions.h"
> +
> +static void signal_handler(int signal)
> +{
> +	_exit(0);
> +}
> +
> +int test_copy_first_unaligned(void)
> +{
> +	/* 128 bytes for a full cache line */
> +	char buf[128] __cacheline_aligned;
> +
> +	/* Only run this test on a P9 or later */
> +	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
> +
> +	/* Register our signal handler with SIGBUS */
> +	signal(SIGBUS, signal_handler);
> +
> +	/* +1 makes buf unaligned */
> +	copy_first(buf+1);
> +
> +	/* We should not get here */
> +	return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_copy_first_unaligned,
> "test_copy_first_unaligned");
> +}
> diff --git a/tools/testing/selftests/powerpc/alignment/copy_unaligned.c
> b/tools/testing/selftests/powerpc/alignment/copy_unaligned.c
> new file mode 100644
> index 000000000000..0945d50ea0aa
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/alignment/copy_unaligned.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright 2016, Chris Smart, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * Calls to copy which are not 128-byte aligned should be caught
> + * and sent a SIGBUS.
> + *
> + */
> +
> +#include <signal.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "utils.h"
> +#include "instructions.h"
> +
> +static void signal_handler(int signal)
> +{
> +	_exit(0);
> +}
> +
> +int test_copy_unaligned(void)
> +{
> +	/* 128 bytes for a full cache line */
> +	char buf[128] __cacheline_aligned;
> +
> +	/* Only run this test on a P9 or later */
> +	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
> +
> +	/* Register our signal handler with SIGBUS */
> +	signal(SIGBUS, signal_handler);
> +
> +	/* +1 makes buf unaligned */
> +	copy(buf+1);
> +
> +	/* We should not get here */
> +	return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_copy_unaligned, "test_copy_unaligned");
> +}
> diff --git
> a/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
> b/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
> new file mode 100644
> index 000000000000..b951ff471b81
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
> @@ -0,0 +1,47 @@
> +/*
> + * Copyright 2016, Chris Smart, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * Calls to paste_last which are not 128-byte aligned should be
> + * caught and sent a SIGBUS.
> + *
> + */
> +
> +#include <signal.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "utils.h"
> +#include "instructions.h"
> +
> +static void signal_handler(int signal)
> +{
> +	_exit(0);
> +}
> +
> +int test_paste_last_unaligned(void)
> +{
> +	/* 128 bytes for a full cache line */
> +	char buf[128] __cacheline_aligned;
> +
> +	/* Only run this test on a P9 or later */
> +	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
> +
> +	/* Register our signal handler with SIGBUS */
> +	signal(SIGBUS, signal_handler);
> +
> +	copy(buf);
> +	/* +1 makes buf unaligned */
> +	paste_last(buf+1);
> +
> +	/* We should not get here */
> +	return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_paste_last_unaligned,
> "test_paste_last_unaligned");
> +}
> diff --git a/tools/testing/selftests/powerpc/alignment/paste_unaligned.c
> b/tools/testing/selftests/powerpc/alignment/paste_unaligned.c
> new file mode 100644
> index 000000000000..803d892951b9
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/alignment/paste_unaligned.c
> @@ -0,0 +1,47 @@
> +/*
> + * Copyright 2016, Chris Smart, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * Calls to paste which are not 128-byte aligned should be caught
> + * and sent a SIGBUS.
> + *
> + */
> +
> +#include <signal.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "utils.h"
> +#include "instructions.h"
> +
> +static void signal_handler(int signal)
> +{
> +	_exit(0);
> +}
> +
> +int test_paste_unaligned(void)
> +{
> +	/* 128 bytes for a full cache line */
> +	char buf[128] __cacheline_aligned;
> +
> +	/* Only run this test on a P9 or later */
> +	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
> +
> +	/* Register our signal handler with SIGBUS */
> +	signal(SIGBUS, signal_handler);
> +
> +	copy(buf);
> +	/* +1 makes buf unaligned */
> +	paste(buf+1);
> +
> +	/* We should not get here */
> +	return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_paste_unaligned,
> "test_paste_unaligned");
> +}
> diff --git a/tools/testing/selftests/powerpc/instructions.h
> b/tools/testing/selftests/powerpc/instructions.h
> new file mode 100644
> index 000000000000..54ceafce4fa0
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/instructions.h
> @@ -0,0 +1,55 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +/* This defines the "copy" instruction from Power ISA 3.0 Book II,
> section 4.4. */
> +#define COPY(RA, RB, L) \
> +	.long (0x7c00060c | (RA) << (31-15) | (RB) << (31-20) | (L) <<
> (31-10))
> +
> +void copy(void *i)
> +{
> +	asm volatile(str(COPY(0, %0, 0))";"
> +			:
> +			: "b" (i)
> +			: "memory"
> +		=C2=A0=C2=A0=C2=A0=C2=A0);
> +}
> +
> +void copy_first(void *i)
> +{
> +	asm volatile(str(COPY(0, %0, 1))";"
> +			:
> +			: "b" (i)
> +			: "memory"
> +		=C2=A0=C2=A0=C2=A0=C2=A0);
> +}
> +
> +/* This defines the "paste" instruction from Power ISA 3.0 Book II,
> section 4.4. */
> +#define PASTE(RA, RB, L, RC) \
> +	.long (0x7c00070c | (RA) << (31-15) | (RB) << (31-20) | (L) <<
> (31-10) | (RC) << (31-31))
> +
> +int paste(void *i)
> +{
> +	int cr;
> +
> +	asm volatile(str(PASTE(0, %1, 0, 0))";"
> +			"mfcr %0;"
> +			: "=3Dr" (cr)
> +			: "b" (i)
> +			: "memory"
> +		=C2=A0=C2=A0=C2=A0=C2=A0);
> +	return cr;
> +}
> +
> +int paste_last(void *i)
> +{
> +	int cr;
> +
> +	asm volatile(str(PASTE(0, %1, 1, 1))";"
> +			"mfcr %0;"
> +			: "=3Dr" (cr)
> +			: "b" (i)
> +			: "memory"
> +		=C2=A0=C2=A0=C2=A0=C2=A0);
> +	return cr;
> +}
> +
