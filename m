Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B788DE098
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 01:36:06 +1100 (EST)
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1169620444.18754.66.camel@localhost.localdomain>
References: <20061213123819.403286000@sipsolutions.net> >
	<20061213123945.386891000@sipsolutions.net> >
	<1169620444.18754.66.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-f8ylI10ilHbuXU/fKURL"
Date: Fri, 26 Jan 2007 15:35:04 +0100
Message-Id: <1169822104.15413.13.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-f8ylI10ilHbuXU/fKURL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-01-24 at 17:34 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2006-12-13 at 13:38 +0100, Johannes Berg wrote:
> > plain text document attachment (time-resume.patch)
> > This patch converts the time restore code from a PMU notifier to a regu=
lar
> > sys device so I can profit from it even when I don't suspend through th=
e
> > PMU, i.e. suspend to disk.
> >=20
> > Also another step towards dropping pmu_sleep_notifier completely.
>=20
> I'd rather do it differently: On suspend, read the RTC and save the
> value. On resume, read it again, diff the values, and add that to the
> current time.

Alright, how about something like this? I still need to fill in the
actual calculations of course :)

--- mb-wireless.orig/arch/powerpc/platforms/powermac/time.c	2007-01-25 14:0=
9:12.288927117 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/time.c	2007-01-26 14:16:18.=
598954773 +0100
@@ -297,49 +297,11 @@ int __init via_calibrate_decr(void)
 }
 #endif
=20
-#ifdef CONFIG_PM
-/*
- * Reset the time after a sleep.
- */
-static int
-time_sleep_notify(struct pmu_sleep_notifier *self, int when)
-{
-	static unsigned long time_diff;
-	unsigned long flags;
-	unsigned long seq;
-	struct timespec tv;
-
-	switch (when) {
-	case PBOOK_SLEEP_NOW:
-		do {
-			seq =3D read_seqbegin_irqsave(&xtime_lock, flags);
-			time_diff =3D xtime.tv_sec - pmac_get_boot_time();
-		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-		break;
-	case PBOOK_WAKE:
-		tv.tv_sec =3D pmac_get_boot_time() + time_diff;
-		tv.tv_nsec =3D 0;
-		do_settimeofday(&tv);
-		break;
-	}
-	return PBOOK_SLEEP_OK;
-}
-
-static struct pmu_sleep_notifier time_sleep_notifier =3D {
-	time_sleep_notify, SLEEP_LEVEL_MISC,
-};
-#endif /* CONFIG_PM */
-
 /*
  * Query the OF and get the decr frequency.
  */
 void __init pmac_calibrate_decr(void)
 {
-#if defined(CONFIG_PM) && defined(CONFIG_ADB_PMU)
-	/* XXX why here? */
-	pmu_register_sleep_notifier(&time_sleep_notifier);
-#endif
-
 	generic_calibrate_decr();
=20
 #ifdef CONFIG_PPC32
--- mb-wireless.orig/arch/powerpc/kernel/Makefile	2007-01-26 14:16:35.83895=
4773 +0100
+++ mb-wireless/arch/powerpc/kernel/Makefile	2007-01-26 14:16:47.918954773 =
+0100
@@ -50,6 +50,7 @@ extra-y				+=3D vmlinux.lds
=20
 obj-y				+=3D time.o prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o
+obj-$(CONFIG_PM)		+=3D time_suspend.o
 obj-$(CONFIG_PPC32)		+=3D entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+=3D misc_64.o dma_64.o iommu.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+=3D prom_init.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mb-wireless/arch/powerpc/kernel/time_suspend.c	2007-01-26 15:33:55.8790=
25345 +0100
@@ -0,0 +1,62 @@
+/*
+ * Common code to keep time when machine suspends.
+ *
+ * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <linux/time.h>
+#include <asm/rtc.h>
+
+static struct rtc_time suspend_rtc_time;
+
+/*
+ * Reset the time after a sleep.
+ */
+static int timer_resume(struct sys_device *dev)
+{
+	struct timespec tv;
+	struct rtc_time cur_rtc_time;
+
+
+	get_rtc_time(&suspend_rtc_time);
+
+	do_gettimeofday(&tv);
+
+	/* FIXME: do something with tv here */
+
+	do_settimeofday(&tv);
+
+	return 0;
+}
+
+static int timer_suspend(struct sys_device *dev, pm_message_t state)
+{
+	WARN_ON(!ppc_md.get_rtc_time);
+
+	get_rtc_time(&suspend_rtc_time);
+
+	return 0;
+}
+
+static struct sysdev_class timer_sysclass =3D {
+	.resume =3D timer_resume,
+	.suspend =3D timer_suspend,
+	set_kset_name("timer"),
+};
+
+static struct sys_device device_timer =3D {
+	.id =3D 0,
+	.cls =3D &timer_sysclass,
+};
+
+static int time_init_device(void)
+{
+	int error =3D sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error =3D sysdev_register(&device_timer);
+	return error;
+}
+
+device_initcall(time_init_device);


--=-f8ylI10ilHbuXU/fKURL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFuhGY/ETPhpq3jKURAjr3AJ0az/liLwgjTr+B0YEa4aJ20KDiQgCgii2G
G+B7SqG6d3GYtlsbo5Iiw4w=
=q+xz
-----END PGP SIGNATURE-----

--=-f8ylI10ilHbuXU/fKURL--
