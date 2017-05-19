Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTcfW04qCzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 15:53:07 +1000 (AEST)
Message-ID: <1495173186.8495.46.camel@neuling.org>
Subject: Re: [PATCH] selftests/powerpc: Fix TM resched DSCR test with some
 compilers
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: sam.bobroff@au1.ibm.com
Date: Fri, 19 May 2017 15:53:06 +1000
In-Reply-To: <1495157865-12924-1-git-send-email-mpe@ellerman.id.au>
References: <1495157865-12924-1-git-send-email-mpe@ellerman.id.au>
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

On Fri, 2017-05-19 at 11:37 +1000, Michael Ellerman wrote:
> The tm-resched-dscr test has started failing sometimes, depending on
> what compiler it's built with, eg:
>=20
> =C2=A0 test: tm_resched_dscr
> =C2=A0 Check DSCR TM context switch: tm-resched-dscr: tm-resched-dscr.c:7=
6:
> test_body: Assertion `rv' failed.
> =C2=A0 !! child died by signal 6
>=20
> When it fails we see that the compiler doesn't initialise rv to 1 before
> entering the inline asm block. Although that's counter intuitive, it
> is allowed because we tell the compiler that the inline asm will write
> to rv (using "=3Dr"), meaning the original value is irrelevant.
>=20
> Marking it as a read/write parameter would presumably work, but it seems
> simpler to fix it by setting the initial value of rv in the inline asm.
>=20
> Fixes: 96d016108640 ("powerpc: Correct DSCR during TM context switch")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks.

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
> b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
> index d9c49f41515e..e79ccd6aada1 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
> @@ -42,12 +42,12 @@ int test_body(void)
> =C2=A0	printf("Check DSCR TM context switch: ");
> =C2=A0	fflush(stdout);
> =C2=A0	for (;;) {
> -		rv =3D 1;
> =C2=A0		asm __volatile__ (
> =C2=A0			/* set a known value into the DSCR */
> =C2=A0			"ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03, %[dscr1];"
> =C2=A0			"mtspr=C2=A0=C2=A0=C2=A0%[sprn_dscr], 3;"
> =C2=A0
> +			"li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0%[rv], 1;"
> =C2=A0			/* start and suspend a transaction */
> =C2=A0			"tbegin.;"
> =C2=A0			"beq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01f;"
