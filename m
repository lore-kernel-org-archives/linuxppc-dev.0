Return-Path: <krafft@de.ibm.com>
Date: Thu, 21 Jun 2007 13:26:41 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: [patch 4/5] cell: cpufreq and pmi patches
Message-ID: <20070621132641.53e23557@localhost>
In-Reply-To: <20070621130944.083f8fa5@localhost>
References: <20070621130944.083f8fa5@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_J=y7Jir98FC78FALFqwAAm0";
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

--Sig_J=y7Jir98FC78FALFqwAAm0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Subject: cbe_cpufreq: fix minor issues

From: Christian Krafft <krafft@de.ibm.com>

Minor issues have been fixed:
* added a missing call to of_node_put()
* signedness of a function parameter
* added some line breaks
* changed global pmi_frequency_limit to a
  per node pmi_slow_mode_limit array

Signed-off-by: Christian Krafft <krafft@de.ibm.com>


Index: linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc5.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux-2.6.22-rc5/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -67,7 +67,7 @@ static u64 MIC_Slow_Next_Timer_table[] =3D
 	0x00003FC000000000ull,
 };
=20
-static unsigned int pmi_frequency_limit =3D 0;
+static u8 pmi_slow_mode_limit[MAX_BE];
=20
 /*
  * hardware specific functions
@@ -169,35 +169,50 @@ static int set_pmode_reg(int cpu, unsign
=20
 static int set_pmode(int cpu, unsigned int slow_mode)
 {
+	int rc;
 #ifdef CONFIG_PPC_PMI
 	if (cbe_cpufreq_has_pmi)
-		return set_pmode_pmi(cpu, slow_mode);
+		rc =3D set_pmode_pmi(cpu, slow_mode);
+	else
 #endif
-	return set_pmode_reg(cpu, slow_mode);
+		rc =3D set_pmode_reg(cpu, slow_mode);
+
+	pr_debug("register contains slow mode %d\n", get_pmode(cpu));
+
+	return rc;
 }
=20
 static void cbe_cpufreq_handle_pmi(pmi_message_t pmi_msg)
 {
-	u8 cpu;
-	u8 cbe_pmode_new;
+	u8 node; slow_mode;
=20
 	BUG_ON(pmi_msg.type !=3D PMI_TYPE_FREQ_CHANGE);
=20
-	cpu =3D cbe_node_to_cpu(pmi_msg.data1);
-	cbe_pmode_new =3D pmi_msg.data2;
+	node =3D pmi_msg.data1;
+	slow_mode =3D pmi_msg.data2;
=20
-	pmi_frequency_limit =3D cbe_freqs[cbe_pmode_new].frequency;
+	pmi_slow_mode_limit[node] =3D slow_mode;
=20
-	pr_debug("cbe_handle_pmi: max freq=3D%d\n", pmi_frequency_limit);
+	pr_debug("cbe_handle_pmi: node: %d, max slow_mode=3D%d\n", slow_mode);
 }
=20
 static int pmi_notifier(struct notifier_block *nb,
 				       unsigned long event, void *data)
 {
 	struct cpufreq_policy *policy =3D data;
+	u8 node;
+
+	node =3D cbe_cpu_to_node(policy->cpu);
+
+	pr_debug("got notified, event=3D%lu, node=3D%u\n", event, node);
=20
-	if (pmi_frequency_limit)
-		cpufreq_verify_within_limits(policy, 0, pmi_frequency_limit);
+	if (pmi_slow_mode_limit[node] !=3D 0) {
+		pr_debug("limiting node %d to slow mode %d\n",
+			 node, pmi_slow_mode_limit[node]);
+
+		cpufreq_verify_within_limits(policy, 0,
+			 cbe_freqs[pmi_slow_mode_limit[node]].frequency);
+	}
=20
 	return 0;
 }
@@ -232,6 +247,8 @@ static int cbe_cpufreq_cpu_init(struct c
=20
 	max_freqp =3D of_get_property(cpu, "clock-frequency", NULL);
=20
+	of_node_put(cpu);
+
 	if (!max_freqp)
 		return -EINVAL;
=20
@@ -248,7 +265,9 @@ static int cbe_cpufreq_cpu_init(struct c
 	}
=20
 	policy->governor =3D CPUFREQ_DEFAULT_GOVERNOR;
-	/* if DEBUG is enabled set_pmode() measures the correct latency of a tran=
sition */
+
+	/* if DEBUG is enabled set_pmode() measures the latency
+	 * of a transition */
 	policy->cpuinfo.transition_latency =3D 25000;
=20
 	cur_pmode =3D get_pmode(policy->cpu);
@@ -262,8 +281,8 @@ static int cbe_cpufreq_cpu_init(struct c
=20
 	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
=20
-
-	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max are set =
correctly */
+	/* this ensures that policy->cpuinfo_min
+	 * and policy->cpuinfo_max are set correctly */
 	return cpufreq_frequency_table_cpuinfo(policy, cbe_freqs);
 }
=20
@@ -279,12 +298,13 @@ static int cbe_cpufreq_verify(struct cpu
 }
=20
=20
-static int cbe_cpufreq_target(struct cpufreq_policy *policy, unsigned int =
target_freq,
-			    unsigned int relation)
+static int cbe_cpufreq_target(struct cpufreq_policy *policy,
+			      unsigned int target_freq,
+			      unsigned int relation)
 {
 	int rc;
 	struct cpufreq_freqs freqs;
-	int cbe_pmode_new;
+	unsigned int cbe_pmode_new;
=20
 	cpufreq_frequency_table_target(policy,
 				       cbe_freqs,
@@ -299,12 +319,14 @@ static int cbe_cpufreq_target(struct cpu
 	mutex_lock(&cbe_switch_mutex);
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
=20
-	pr_debug("setting frequency for cpu %d to %d kHz, 1/%d of max frequency\n=
",
+	pr_debug("setting frequency for cpu %d to %d kHz, " \
+		 "1/%d of max frequency\n",
 		 policy->cpu,
 		 cbe_freqs[cbe_pmode_new].frequency,
 		 cbe_freqs[cbe_pmode_new].index);
=20
 	rc =3D set_pmode(policy->cpu, cbe_pmode_new);
+
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	mutex_unlock(&cbe_switch_mutex);
=20


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


--Sig_J=y7Jir98FC78FALFqwAAm0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGemBy6rqK4qDx+dcRAq1YAKC59sJKiv6o3C5ruIf3by0gB2qsXACfem54
1n4MvNxnnc27Tguu3AhrLtg=
=hD4q
-----END PGP SIGNATURE-----

--Sig_J=y7Jir98FC78FALFqwAAm0--
