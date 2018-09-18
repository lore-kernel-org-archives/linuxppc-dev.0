Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DtYg6GdBzF0RH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 16:36:23 +1000 (AEST)
Message-ID: <b544029461059473cb7b8b6c66815a3ff31ec540.camel@neuling.org>
Subject: Re: [RFC PATCH 11/11] selftests/powerpc: Adapt the test
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com
Date: Tue, 18 Sep 2018 16:36:23 +1000
In-Reply-To: <1536781219-13938-12-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-12-git-send-email-leitao@debian.org>
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

On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> The Documentation/powerpc/transactional_memory.txt says:
>=20
>  "Syscalls made from within a suspended transaction are performed as norm=
al
>   and the transaction is not explicitly doomed by the kernel.  However,
>   what the kernel does to perform the syscall may result in the transacti=
on
>   being doomed by the hardware."
>=20
> With this new TM mechanism, the syscall will continue to be executed if t=
he
> syscall happens on a suspended syscall, but, the syscall will *fail* if t=
he
> transaction is still active during the syscall invocation.

Not sure I get this. This doesn't seem any different to before.

An active (not suspended) transaction *will* result in the syscall failing =
and
the transaction being doomed. =20

A syscall in a suspended transaction should succeed and the transaction.

You might need to clean up the language. I try to use:

   Active =3D=3D transactional but not suspended (ie MSR[TS] =3D T)
   Suspended =3D=3D suspended (ie MSR [TS] =3D S)
   Doomed =3D=3D transaction to be rolled back at next opportinity (ie tche=
ck returns doomed)

(note: the kernel MSR_TM_ACTIVE() macro is not consistent with this since i=
t's
MSR[TS] =3D=3D S or T).

> On the syscall path, if the transaction is active and not suspended, it
> will call TM_KERNEL_ENTRY which will reclaim and recheckpoint the
> transaction, thus, dooming the transaction on userspace return, with
> failure code TM_CAUSE_SYSCALL.

But the test below is on a suspend transaction?

> This new model will break part of this test, but I understand that that t=
he
> documentation above didn't guarantee that the syscall would succeed, and =
it
> will never succeed anymore now on.

The syscall should pass in suspend (modulo the normal syscall checks). The
transaction may fail as a result.

> In fact, glibc is calling 'tabort' before every syscalls, thus, any sysca=
ll
> called through glibc from inside a transaction will be doomed anyhow.
>=20
> This patch updates the test case to not assume that a syscall inside a
> active transaction will succeed, because it will not anymore.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/powerpc/tm/tm-syscall.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c
> b/tools/testing/selftests/powerpc/tm/tm-syscall.c
> index 454b965a2db3..1439a87eba3a 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
> @@ -78,12 +78,6 @@ int tm_syscall(void)
>  	timeradd(&end, &now, &end);
> =20
>  	for (count =3D 0; timercmp(&now, &end, <); count++) {
> -		/*
> -		 * Test a syscall within a suspended transaction and verify
> -		 * that it succeeds.
> -		 */
> -		FAIL_IF(getppid_tm(true) =3D=3D -1); /* Should succeed. */
> -
>  		/*
>  		 * Test a syscall within an active transaction and verify that
>  		 * it fails with the correct failure code.
