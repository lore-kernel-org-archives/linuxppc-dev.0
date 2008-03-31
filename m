Return-Path: <michael@ellerman.id.au>
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 5B88CDDEDD
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 11:07:43 +1000 (EST)
Subject: Fwd: [PATCH] Fix missed hardware breakpoints across multiple threads
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sciABiLzwTGBvkTMfrD8"
Date: Mon, 31 Mar 2008 11:07:43 +1000
Message-Id: <1206925663.7441.4.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-sciABiLzwTGBvkTMfrD8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Fix missed hardware breakpoints across multiple threads

There is a bug in the powerpc DABR (data access breakpoint) handling,
which can result in us missing breakpoints if several threads are trying
to break on the same address.

The circumstances are that do_page_fault() calls do_dabr(), this clears
the DABR (sets it to 0) and sets up the signal which will report to
userspace that the DABR was hit. The do_signal() code will restore the DABR
value on the way out to userspace.

If we reschedule before calling do_signal(), __switch_to() will check the
cached DABR value and compare it to the new thread's value, if they match
we don't set the DABR in hardware.

So if two threads have the same DABR value, and we schedule from one to
the other after taking the interrupt for the first thread hitting the DABR,
the second thread will run without the DABR set in hardware.

The cleanest fix is to move the cache update into set_dabr(), that way we
can't forget to do it.

Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/process.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


Sorry all, I forgot to CC this to the list in my rush to get out of the
office on Friday night, sorry! :)


diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 59311ec..4ec6055 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -241,8 +241,12 @@ void discard_lazy_cpu_state(void)
 }
 #endif /* CONFIG_SMP */
=20
+static DEFINE_PER_CPU(unsigned long, current_dabr);
+
 int set_dabr(unsigned long dabr)
 {
+	__get_cpu_var(current_dabr) =3D dabr;
+
 #ifdef CONFIG_PPC_MERGE		/* XXX for now */
 	if (ppc_md.set_dabr)
 		return ppc_md.set_dabr(dabr);
@@ -259,8 +263,6 @@ int set_dabr(unsigned long dabr)
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
 #endif
=20
-static DEFINE_PER_CPU(unsigned long, current_dabr);
-
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
@@ -325,10 +327,8 @@ struct task_struct *__switch_to(struct task_struct *pr=
ev,
=20
 #endif /* CONFIG_SMP */
=20
-	if (unlikely(__get_cpu_var(current_dabr) !=3D new->thread.dabr)) {
+	if (unlikely(__get_cpu_var(current_dabr) !=3D new->thread.dabr))
 		set_dabr(new->thread.dabr);
-		__get_cpu_var(current_dabr) =3D new->thread.dabr;
-	}
=20
 	new_thread =3D &new->thread;
 	old_thread =3D &current->thread;
--=20
1.5.2.rc1.1884.g59b20



--=-sciABiLzwTGBvkTMfrD8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH8DlfdSjSd0sB4dIRAoxHAJ41q+IdON8CmojXVAs7T1gP3enxbwCcD1dS
VNPxcbW0Wks+bwoNhaQOoi4=
=nuvm
-----END PGP SIGNATURE-----

--=-sciABiLzwTGBvkTMfrD8--
