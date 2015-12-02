Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C47C1A04F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 09:29:20 +1100 (AEDT)
Message-ID: <1449095359.30090.117.camel@neuling.org>
Subject: Re: [PATCH] selftests/powerpc: Add test to check if TAR is corrupted
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Rashmica Gupta
 <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 03 Dec 2015 09:29:19 +1100
In-Reply-To: <565E7DC6.4080306@linux.vnet.ibm.com>
References: <1449026569-30094-1-git-send-email-rashmicy@gmail.com>
 <565E7DC6.4080306@linux.vnet.ibm.com>
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

> Re: [PATCH] selftests/powerpc: Add test to check if TAR is corrupted

The patch description should mention TM too.


On Wed, 2015-12-02 at 10:42 +0530, Anshuman Khandual wrote:
> On 12/02/2015 08:52 AM, Rashmica Gupta wrote:
> > If the transaction is aborted, the TAR should be rolled back to the
> > checkpointed value before the transaction began.
>=20
> And if it does not abort, it should continue to hold the changed
> (inside the transaction) TAR value after the transaction finishes.
> The test here does check for both these cases and hence the commit
> message should reflect that as well. This test can also accommodate
> checks for PPR and DSCR register in one go.

Good point. =20

> In the TM ptrace patch series (https://lkml.org/lkml/2015/10/8/522)
> which is still under review, there are couple of tests related
> to (TAR, PPR, DSCR) registers with (TM running & TM suspended) and
> without TM. There, the values are being checked using ptrace
> interface
> instead. Can you please check them and just make sure that we are not
> duplicating anything here.

Even if it is duplicated, I'd prefer to have this separate test as
well.  This is much simpler than that ptrace test.

Thanks for the review.

Mikey

>=20
> >=20
> > Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> > ---
> > To check this yourself, undo the changes from the patch
> > "powerpc/tm: Fix
> > context switching TAR, PPR and DSCR SPRs".
> >=20
> >  tools/testing/selftests/powerpc/tm/.gitignore |  1 +
> >  tools/testing/selftests/powerpc/tm/Makefile   |  2 +-
> >  tools/testing/selftests/powerpc/tm/tm-tar.c   | 90
> > +++++++++++++++++++++++++++
> >  3 files changed, 92 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/powerpc/tm/tm-tar.c
> >=20
> > diff --git a/tools/testing/selftests/powerpc/tm/.gitignore
> > b/tools/testing/selftests/powerpc/tm/.gitignore
> > index 76eae258feeb..9bf6749550e3 100644
> > --- a/tools/testing/selftests/powerpc/tm/.gitignore
> > +++ b/tools/testing/selftests/powerpc/tm/.gitignore
> > @@ -4,3 +4,4 @@ tm-signal-msr-resv
> >  tm-signal-stack
> >  tm-fork
> >  tm-dscr
> > +tm-tar
> > diff --git a/tools/testing/selftests/powerpc/tm/Makefile
> > b/tools/testing/selftests/powerpc/tm/Makefile
> > index 59eec240339d..ab2992f69b4c 100644
> > --- a/tools/testing/selftests/powerpc/tm/Makefile
> > +++ b/tools/testing/selftests/powerpc/tm/Makefile
> > @@ -1,4 +1,4 @@
> > -TEST_PROGS :=3D tm-resched-dscr tm-syscall tm-signal-msr-resv tm
> > -signal-stack tm-fork tm-dscr
> > +TEST_PROGS :=3D tm-resched-dscr tm-syscall tm-signal-msr-resv tm
> > -signal-stack tm-fork tm-dscr tm-tar
> > =20
> >  all: $(TEST_PROGS)
> > =20
> > diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c
> > b/tools/testing/selftests/powerpc/tm/tm-tar.c
> > new file mode 100644
> > index 000000000000..22a0c3485412
> > --- /dev/null
> > +++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
> > @@ -0,0 +1,90 @@
> > +/*=20
> > + * Copyright 2015, Michael Neuling, IBM Corp.=20
> > + * Licensed under GPLv2.
> > + * Original: Michael Neuling 19/7/2013
> > + * Edited: Rashmica Gupta 01/12/2015
> > + *
> > + * Do some transactions, see if the tar is corrupted.
>=20
> It can use a better explanation here.
>=20
> > + *
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +
> > +#include "tm.h"
> > +#include "utils.h"
> > +
> > +#define SPRN_TAR	0x32f
> > +
> > +int	num_loops	=3D 10000;
> > +
> > +int test_tar(void)
> > +{
> > +	int i;
> > +
> > +	SKIP_IF(!have_htm());
> > +
> > +	for (i =3D 0; i < num_loops; i++)
> > +	{
> > +		uint64_t result =3D 0;
> > +		asm __volatile__(
> > +			"li	7, 1;"
> > +			"mtspr	%[tar], 7;"	// tar =3D
> > 1
>=20
> Please use /* */ kind of comment sections not //.
>=20
> > +			"tbegin.;"=09
> > +			"beq	3f;"
> > +			"li	4, 0x7000;"	// Loop
> > lots, to use time
> > +			"2:;"			// Start loop
>=20
> Here as well.
>=20
> > +			"li	7, 2;"
> > +			"mtspr	%[tar], 7;"	// tar =3D
> > 2
> > +			"tsuspend.;"
> > +			"li	7, 3;"
> > +			"mtspr	%[tar], 7;"	// tar =3D
> > 3
> > +			"tresume.;"
> > +			"subi	4, 4, 1;"
> > +			"cmpdi	4, 0;"
> > +			"bne	2b;"
> > +			"tend.;"
> > +
> > +			// Transaction sucess! TAR should be 3.
> > +			"mfspr  7, %[tar];"
> > +			"ori	%[res], 7, 4;"  // res =3D 3|4 =3D
> > 7
> > +			"b	4f;"
> > +
> > +			// Abort handler. TAR should be rolled
> > back to 1.
> > +			"3:;"
> > +			"mfspr  7, %[tar];"
> > +			"ori	%[res], 7, 8;"	// res =3D
> > 1|8 =3D 9
> > +			"4:;"
> > +
> > +			: [res]"=3Dr"(result)
> > +			: [tar]"i"(SPRN_TAR)
> > +			   : "memory", "r0", "r4", "r7");
> > +
> > +		// If result is anything else other than 7 or 9,
> > the tar
> > +		// value must have been corrupted.
>=20
> Here as well.
>=20
> > +		if ((result !=3D 7) && (result !=3D 9))=20
> > +			return 1;
> > +	=09
> > +	}
> > +	return 0;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +
> > +	// A low number of iterations (eg 100) can cause a false
> > pass.
>=20
> Here as well.
>=20
> > +	if (argc > 1) {
> > +		if (strcmp(argv[1], "-h") =3D=3D 0) {
> > +			printf("Syntax:\n\t%s [<num loops>]\n",
> > +			       argv[0]);
> > +			return 0;
> > +		} else {
> > +			num_loops =3D atoi(argv[1]);
> > +		}
> > +	}
> > +
> > +	printf("Starting, %d loops\n", num_loops);
> > +
> > +	test_harness(test_tar, "tm_tar");
> > +}
> >=20
>=20
