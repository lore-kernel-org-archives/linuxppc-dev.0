Return-Path: <SRS0+1020516fb0ec803710a0+1314+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: [PATCH] Implement check_legacy_ioport() on PS3
From: David Woodhouse <dwmw2@infradead.org>
To: cbe-oss-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 30 Mar 2007 01:02:52 +0100
Message-Id: <1175212972.3122.87.camel@pmac.infradead.org>
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

It doesn't like it when we poke at legacy I/O ports like the i8042. We
should probably change the _default_ to return -ENODEV, and let any
strange platform which wants to allow unfettered access provide its own
function for that.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- linux-2.6.20.ppc64/arch/powerpc/platforms/ps3/setup.c.orig	2007-03-30 00:45:59.000000000 +0100
+++ linux-2.6.20.ppc64/arch/powerpc/platforms/ps3/setup.c	2007-03-30 00:48:29.000000000 +0100
@@ -230,6 +230,11 @@ static void ps3_machine_kexec(struct kim
 }
 #endif
 
+static int ps3_check_legacy_ioport(unsigned int baseport)
+{
+        return -ENODEV;
+}
+
 define_machine(ps3) {
 	.name				= "PS3",
 	.probe				= ps3_probe,
@@ -240,6 +245,7 @@ define_machine(ps3) {
 	.set_rtc_time			= ps3_set_rtc_time,
 	.get_rtc_time			= ps3_get_rtc_time,
 	.calibrate_decr			= ps3_calibrate_decr,
+	.check_legacy_ioport		= ps3_check_legacy_ioport,
 	.progress			= ps3_progress,
 	.restart			= ps3_restart,
 	.power_off			= ps3_power_off,

-- 
dwmw2
