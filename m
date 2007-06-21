Return-Path: <krafft@de.ibm.com>
Date: Thu, 21 Jun 2007 13:20:52 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: [patch 2/5] cell: cbe_cpufreq fix latency measurement
Message-ID: <20070621132052.3048e0ec@localhost>
In-Reply-To: <20070621130944.083f8fa5@localhost>
References: <20070621130944.083f8fa5@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_wX+hhnyJfU+EiU+4r1sXyHr;
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

--Sig_wX+hhnyJfU+EiU+4r1sXyHr
Content-Type: multipart/mixed; boundary="MP_eD8T7A=EHrZz8xbwNEjkdvC"

--MP_eD8T7A=EHrZz8xbwNEjkdvC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

From: Christian Krafft <krafft@de.ibm.com>

This patch fixes the debug code that calculates the transition time when
changing the slow modes on a Cell BE cpu.

Singed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -81,7 +81,7 @@ static int set_pmode_pmi(int cpu, unsign
 	int ret;
 	pmi_message_t pmi_msg;
 #ifdef DEBUG
-	u64 time;
+	long time;
 #endif
=20
 	pmi_msg.type =3D PMI_TYPE_FREQ_CHANGE;
@@ -89,7 +89,7 @@ static int set_pmode_pmi(int cpu, unsign
 	pmi_msg.data2 =3D pmode;
=20
 #ifdef DEBUG
-	time =3D (u64) get_cycles();
+	time =3D jiffies;
 #endif
=20
 	pmi_send_message(pmi_msg);
@@ -98,9 +98,9 @@ static int set_pmode_pmi(int cpu, unsign
 	pr_debug("PMI returned slow mode %d\n", ret);
=20
 #ifdef DEBUG
-	time =3D (u64) get_cycles() - time; /* actual cycles (not cpu cycles!) */
-	time =3D 1000000000 * time / CLOCK_TICK_RATE; /* time in ns (10^-9) */
-	pr_debug("had to wait %lu ns for a transition\n", time);
+	time =3D jiffies - time; /* actual cycles (not cpu cycles!) */
+	time =3D jiffies_to_msecs(time);
+	pr_debug("had to wait %lu ms for a transition using PMI.\n", time);
 #endif
 	return ret;
 }
@@ -123,15 +123,18 @@ static int set_pmode_reg(int cpu, unsign
 	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
 	u64 flags;
 	u64 value;
+#ifdef DEBUG
+	long time;
+#endif
=20
 	local_irq_save(flags);
=20
 	mic_tm_regs =3D cbe_get_cpu_mic_tm_regs(cpu);
 	pmd_regs =3D cbe_get_cpu_pmd_regs(cpu);
=20
-	pr_debug("pm register is mapped at %p\n", &pmd_regs->pmcr);
-	pr_debug("mic register is mapped at %p\n", &mic_tm_regs->slow_fast_timer_=
0);
-
+#ifdef DEBUG
+	time =3D jiffies;
+#endif
 	out_be64(&mic_tm_regs->slow_fast_timer_0, MIC_Slow_Fast_Timer_table[pmode=
]);
 	out_be64(&mic_tm_regs->slow_fast_timer_1, MIC_Slow_Fast_Timer_table[pmode=
]);
=20
@@ -146,6 +149,7 @@ static int set_pmode_reg(int cpu, unsign
=20
 	out_be64(&pmd_regs->pmcr, value);
=20
+#ifdef DEBUG
 	/* wait until new pmode appears in status register */
 	value =3D in_be64(&pmd_regs->pmsr) & 0x07;
 	while(value !=3D pmode) {
@@ -153,6 +157,11 @@ static int set_pmode_reg(int cpu, unsign
 		value =3D in_be64(&pmd_regs->pmsr) & 0x07;
 	}
=20
+	time =3D jiffies - time;
+	time =3D jiffies_to_msecs(time);
+	pr_debug("had to wait %lu ms for a transition using " \
+		 "the pervasive unit.\n", time);
+#endif
 	local_irq_restore(flags);
=20
 	return 0;


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


--MP_eD8T7A=EHrZz8xbwNEjkdvC
Content-Type: text/x-patch; name=cbe_cpufreq-fix-latency-measurement.diff
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=cbe_cpufreq-fix-latency-measurement.diff

Subject: cell: cbe_cpufreq fix latency measurement

From: Christian Krafft <krafft@de.ibm.com>

This patch fixes the debug code that calculates the transition time when
changing the slow modes on a Cell BE cpu.

Singed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -81,7 +81,7 @@ static int set_pmode_pmi(int cpu, unsign
 	int ret;
 	pmi_message_t pmi_msg;
 #ifdef DEBUG
-	u64 time;
+	long time;
 #endif
=20
 	pmi_msg.type =3D PMI_TYPE_FREQ_CHANGE;
@@ -89,7 +89,7 @@ static int set_pmode_pmi(int cpu, unsign
 	pmi_msg.data2 =3D pmode;
=20
 #ifdef DEBUG
-	time =3D (u64) get_cycles();
+	time =3D jiffies;
 #endif
=20
 	pmi_send_message(pmi_msg);
@@ -98,9 +98,9 @@ static int set_pmode_pmi(int cpu, unsign
 	pr_debug("PMI returned slow mode %d\n", ret);
=20
 #ifdef DEBUG
-	time =3D (u64) get_cycles() - time; /* actual cycles (not cpu cycles!) */
-	time =3D 1000000000 * time / CLOCK_TICK_RATE; /* time in ns (10^-9) */
-	pr_debug("had to wait %lu ns for a transition\n", time);
+	time =3D jiffies - time; /* actual cycles (not cpu cycles!) */
+	time =3D jiffies_to_msecs(time);
+	pr_debug("had to wait %lu ms for a transition using PMI.\n", time);
 #endif
 	return ret;
 }
@@ -123,15 +123,18 @@ static int set_pmode_reg(int cpu, unsign
 	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
 	u64 flags;
 	u64 value;
+#ifdef DEBUG
+	long time;
+#endif
=20
 	local_irq_save(flags);
=20
 	mic_tm_regs =3D cbe_get_cpu_mic_tm_regs(cpu);
 	pmd_regs =3D cbe_get_cpu_pmd_regs(cpu);
=20
-	pr_debug("pm register is mapped at %p\n", &pmd_regs->pmcr);
-	pr_debug("mic register is mapped at %p\n", &mic_tm_regs->slow_fast_timer_=
0);
-
+#ifdef DEBUG
+	time =3D jiffies;
+#endif
 	out_be64(&mic_tm_regs->slow_fast_timer_0, MIC_Slow_Fast_Timer_table[pmode=
]);
 	out_be64(&mic_tm_regs->slow_fast_timer_1, MIC_Slow_Fast_Timer_table[pmode=
]);
=20
@@ -146,6 +149,7 @@ static int set_pmode_reg(int cpu, unsign
=20
 	out_be64(&pmd_regs->pmcr, value);
=20
+#ifdef DEBUG
 	/* wait until new pmode appears in status register */
 	value =3D in_be64(&pmd_regs->pmsr) & 0x07;
 	while(value !=3D pmode) {
@@ -153,6 +157,11 @@ static int set_pmode_reg(int cpu, unsign
 		value =3D in_be64(&pmd_regs->pmsr) & 0x07;
 	}
=20
+	time =3D jiffies - time;
+	time =3D jiffies_to_msecs(time);
+	pr_debug("had to wait %lu ms for a transition using " \
+		 "the pervasive unit.\n", time);
+#endif
 	local_irq_restore(flags);
=20
 	return 0;

--MP_eD8T7A=EHrZz8xbwNEjkdvC--

--Sig_wX+hhnyJfU+EiU+4r1sXyHr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGel8U6rqK4qDx+dcRAmc5AKCNJlmraWqcW+hrMLE5mD8FZl+XTwCg1g92
PixDlhUlK7PSmanMJtoI40M=
=iAxt
-----END PGP SIGNATURE-----

--Sig_wX+hhnyJfU+EiU+4r1sXyHr--
