Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77BA367A64
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 20:42:28 +1100 (EST)
Date: Tue, 18 Jan 2005 10:42:16 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050118094216.GB25470@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

after looking at the ide driver (see previous post) and with references
to my good old A4000, I felt inspired to do this little hack.

It is in works-for-me state (iBook G4), but as the actual code is
shamelessly taken from the ide driver, I suppose it to work on all the
machines where the IDE driver can blink the led.

You can use it together with the ide blinking option, although the
heartbeat will look bumpy when the hd is active (don't worry, no heart
attack ;-)

There is further optimization possible on the ppc_md.heartbeat_count
and the cnt variables.

Oh, this patch is against vanilla 2.6.10.

Bye,

Joerg

--- ./arch/ppc/platforms/pmac_setup.c.hb	2005-01-17 22:39:08.000000000 +0100
+++ ./arch/ppc/platforms/pmac_setup.c	2005-01-18 01:09:08.325332888 +0100
@@ -240,6 +240,37 @@
=20
 static volatile u32 *sysctrl_regs;
=20
+#ifdef CONFIG_HEARTBEAT
+static struct adb_request pmu_blink_on, pmu_blink_off;
+
+/* adapted from arch_m68k */
+static void pb_heartbeat(void)
+{
+	static unsigned cnt =3D 0, period =3D 0, dist =3D 0;
+
+	if (cnt =3D=3D 0 || cnt =3D=3D dist) {
+		if (pmu_blink_on.complete)
+			pmu_request(&pmu_blink_on, NULL, 4, 0xee, 4, 0, 1);
+	} else if (cnt =3D=3D 7 || cnt =3D=3D dist + 7 ) {
+		if (pmu_blink_off.complete)
+			pmu_request(&pmu_blink_off, NULL, 4, 0xee, 4, 0, 0);
+	}
+
+	if (++cnt > period) {
+                cnt =3D 0;
+                /* The hyperbolic function below modifies the heartbeat pe=
riod
+                 * length in dependency of the current (5min) load. It goes
+                 * through the points f(0)=3D126, f(1)=3D86, f(5)=3D51,
+                 * f(inf)->30. */
+                period =3D ((672<<FSHIFT)/(5*avenrun[0]+(7<<FSHIFT))) + 30;
+                dist =3D period / 4;
+	}
+
+	/* keep on going on ppc and account for HZ value */
+	ppc_md.heartbeat_count =3D HZ/100;
+}
+#endif /* CONFIG_HEARTBEAT */
+
 void __init
 pmac_setup_arch(void)
 {
@@ -333,6 +364,26 @@
 		ppc_md.smp_ops =3D &psurge_smp_ops;
 #endif /* CONFIG_SMP */
=20
+#ifdef CONFIG_HEARTBEAT
+	/* Copied from the IDE blinking code */
+	if (pmu_get_model() =3D=3D PMU_KEYLARGO_BASED) {
+		struct device_node *dt;
+		const char *model;
+
+		if ((dt =3D find_devices("device-tree")) !=3D NULL) {
+			if ((model =3D (const char *)get_property(dt, "model", NULL)) !=3D NULL=
) {
+				if (!strncmp(model, "PowerBook", strlen("PowerBook")) ||
+				    !strncmp(model, "iBook", strlen("iBook")) ) {
+					pmu_blink_on.complete =3D 1;
+					pmu_blink_off.complete =3D 1;
+					ppc_md.heartbeat =3D pb_heartbeat;
+					ppc_md.heartbeat_count =3D 1;
+				}
+			}
+		}
+	}
+#endif /* CONFIG_HEARTBEAT */
+
 	pci_create_OF_bus_map();
 }
=20
--- ./arch/ppc/Kconfig.hb	2005-01-17 23:57:40.000000000 +0100
+++ ./arch/ppc/Kconfig	2005-01-18 00:09:14.000000000 +0100
@@ -954,7 +954,7 @@
=20
 config HEARTBEAT
 	bool "Use power LED as a heartbeat"
-	depends on APUS
+	depends on APUS || (PPC_PMAC && ADB_PMU)
 	help
 	  Use the power-on LED on your machine as a load meter.  The exact
 	  behavior is platform-dependent, but normally the flash frequency is

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB7Nn4jY4+4PdzvOARAj8DAJ9GCuLw9i0l2xSdI4T87l0BgepvDQCfTM9f
D1pvWaHZxvQjvSaUmpVCQJg=
=dfis
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
