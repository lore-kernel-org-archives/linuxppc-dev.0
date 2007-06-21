Return-Path: <krafft@de.ibm.com>
Date: Thu, 21 Jun 2007 13:23:30 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: [patch 3/5] cell: cbe_cpufreq: fix initialization
Message-ID: <20070621132330.1d6a31f9@localhost>
In-Reply-To: <20070621130944.083f8fa5@localhost>
References: <20070621130944.083f8fa5@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_nEN6/qcRH8J9y=ELZbisUSP";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_nEN6/qcRH8J9y=ELZbisUSP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

From: Christian Krafft <krafft@de.ibm.com>

This patch fixes the initialization of the cbe_cpufreq driver.
The code that initializes the PMI related functions was called per cpu:
* registering cpufreq notifier block
* registering a pmi handler

This ends in a bug that the notifier block gets called in an endless loop.
The initialization code is being put to the
module init code path by this patch. This way it only gets called once.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>


Index: linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -196,10 +196,9 @@ static int pmi_notifier(struct notifier_
 {
 	struct cpufreq_policy *policy =3D data;
=20
-	if (event !=3D CPUFREQ_INCOMPATIBLE)
-		return 0;
+	if (pmi_frequency_limit)
+		cpufreq_verify_within_limits(policy, 0, pmi_frequency_limit);
=20
-	cpufreq_verify_within_limits(policy, 0, pmi_frequency_limit);
 	return 0;
 }
=20
@@ -263,11 +262,6 @@ static int cbe_cpufreq_cpu_init(struct c
=20
 	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
=20
-	if (cbe_cpufreq_has_pmi) {
-		/* frequency might get limited later, initialize limit with max_freq */
-		pmi_frequency_limit =3D max_freq;
-		cpufreq_register_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
-	}
=20
 	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max are set =
correctly */
 	return cpufreq_frequency_table_cpuinfo(policy, cbe_freqs);
@@ -275,9 +269,6 @@ static int cbe_cpufreq_cpu_init(struct c
=20
 static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (cbe_cpufreq_has_pmi)
-		cpufreq_unregister_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER=
);
-
 	cpufreq_frequency_table_put_attr(policy->cpu);
 	return 0;
 }
@@ -341,6 +332,9 @@ static int __init cbe_cpufreq_init(void)
=20
 	cbe_cpufreq_has_pmi =3D pmi_register_handler(&cbe_pmi_handler) =3D=3D 0;
=20
+	if (cbe_cpufreq_has_pmi)
+		cpufreq_register_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
+
 	return cpufreq_register_driver(&cbe_cpufreq_driver);
 }
=20
@@ -348,8 +342,10 @@ static void __exit cbe_cpufreq_exit(void
 {
 	cpufreq_unregister_driver(&cbe_cpufreq_driver);
=20
-	if (cbe_cpufreq_has_pmi)
+	if (cbe_cpufreq_has_pmi) {
+		cpufreq_unregister_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER=
);
 		pmi_unregister_handler(&cbe_pmi_handler);
+	}
 }
=20
 module_init(cbe_cpufreq_init);


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_nEN6/qcRH8J9y=ELZbisUSP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGel+56rqK4qDx+dcRApueAKC93rNR32rnQj76czuDaQkma0KHtQCg0Giw
ly+/ThJsijoXDSWwi8GW4xo=
=VWrw
-----END PGP SIGNATURE-----

--Sig_nEN6/qcRH8J9y=ELZbisUSP--
