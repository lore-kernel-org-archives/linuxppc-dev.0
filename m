Return-Path: <mcgrof@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVzGh3xVdzDqmd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 08:54:35 +1000 (AEST)
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: ming.lei@canonical.com, akpm@linux-foundation.org, mmarek@suse.com,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, markivx@codeaurora.org,
 stephen.boyd@linaro.org, zohar@linux.vnet.ibm.com, broonie@kernel.org,
 tiwai@suse.de, johannes@sipsolutions.net, chunkeey@googlemail.com,
 hauke@hauke-m.de, jwboyer@fedoraproject.org, dmitry.torokhov@gmail.com,
 dwmw2@infradead.org, jslaby@suse.com, torvalds@linux-foundation.org,
 luto@amacapital.net, fengguang.wu@intel.com, rpurdie@rpsys.net,
 j.anaszewski@samsung.com, Abhay_Salunke@dell.com, Julia.Lawall@lip6.fr,
 Gilles.Muller@lip6.fr, nicolas.palix@imag.fr, teg@jklm.no,
 dhowells@redhat.com, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Thierry Martinez <martinez@nsup.org>,
 cocci@systeme.lip6.fr, linux-serial@vger.kernel.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/5] firmware: annotate thou shalt not request fw on init
 or probe
Date: Thu, 16 Jun 2016 15:54:18 -0700
Message-Id: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thou shalt not make firmware calls early on init or probe.

systemd already ripped support out for the usermode helper
a while ago, there are still users that require the usermode helper,
however systemd's use of the usermode helper exacerbated a long
lasting issue of the fact that we have many drivers that load
firmware on init or probe. Independent of the usermode helper
loading firmware on init or probe is a bad idea for a few reasons.

When the firmware is read directly from the filesystem by the kernel,
if the driver is built-in to the kernel the firmware may not yet be
available, for such uses one could use initramfs and stuff the firmware
inside, or one also use CONFIG_EXTRA_FIRMWARE; however not all distributions
use this, as such generally one cannot count on this. There is another
corner cases to consider, since we are accessing the firmware directly folks
cannot expect new found firmware on a filesystem after we switch off from
an initramfs with pivot_root().

Supporting such situations is possible today but fixing it for good is
really complex due to the large amount of variablity in the boot up
process.

Instead just document the expectations properly and add a grammar rule to
enable folks to check / validate / police if drivers are using the request
firmware API early on init or probe.

The SmPL rule used to check for the probe routine is loose and is
currently defined through a regexp, that can easily be extended to any
other known bus probe routine names. It also uses the new Python
iteration support which allows us to backtrack from a request_firmware*()
call back to a possible probe or init, iteratively. Without iteration
we would only be able to get reports for callers who directly use the
request_firmware*() API on the initial probe or init routine.

There are 4 offenders at this time:

mcgrof@ergon ~/linux-next (git::20160609)$ export COCCI=scripts/coccinelle/api/request_firmware.cocci
mcgrof@ergon ~/linux-next (git::20160609)$ make coccicheck MODE=report

drivers/fmc/fmc-fakedev.c: ERROR: driver call request firmware call on its init routine on line 321.
drivers/fmc/fmc-write-eeprom.c: ERROR: driver call request firmware call on its probe routine on line 136.
drivers/tty/serial/rp2.c: ERROR: driver call request firmware call on its probe routine on line 796.
drivers/tty/serial/ucc_uart.c: ERROR: driver call request firmware call on its probe routine on line 1246.

I checked and verified all these are valid reports. This list also matches
the same list as in 20150805, so we have fortunately not gotten worse.
Let's keep it that way and also fix these drivers.

v2: changes from v1 [0]:

o This now supports iteration, this extends our coverage on the report

o Update documentation and commit log to accept the fate of not being
  able to remove the usermode helper.

[0] https://lkml.kernel.org/r/1440811107-861-1-git-send-email-mcgrof@do-not-panic.com

Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Thierry Martinez <martinez@nsup.org>
Cc: Michal Marek <mmarek@suse.com>
Cc: cocci@systeme.lip6.fr
Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/firmware_class/README                |  20 ++++
 drivers/base/Kconfig                               |   2 +-
 .../request_firmware-avoid-init-probe-init.cocci   | 130 +++++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci

diff --git a/Documentation/firmware_class/README b/Documentation/firmware_class/README
index cafdca8b3b15..056d1cb9d365 100644
--- a/Documentation/firmware_class/README
+++ b/Documentation/firmware_class/README
@@ -93,6 +93,26 @@
    user contexts to request firmware asynchronously, but can't be called
    in atomic contexts.
 
+Requirements:
+=============
+
+You should avoid at all costs requesting firmware on both init and probe paths
+of your device driver. Reason for this is the complexity needed to ensure a
+firmware will be available for a driver early in boot through different
+build configurations. Consider built-in drivers needing firmware early, or
+consider a driver assuming it will only get firmware after pivot_root().
+
+Drivers that really need firmware early should use stuff the firmware in
+initramfs or consider using CONFIG_EXTRA_FIRMWARE. Using initramfs is much
+more portable to more distributions as not all distributions wish to enable
+CONFIG_EXTRA_FIRMWARE. Should a driver require the firmware being built-in
+it should depend on CONFIG_EXTRA_FIRMWARE. There is no current annotation for
+requiring a firmware on initramfs.
+
+If you're a maintainer you can help police this with:
+
+$ export COCCI=scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
+$ make coccicheck MODE=report
 
  about in-kernel persistence:
  ---------------------------
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 98504ec99c7d..12b4f5551501 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -152,7 +152,7 @@ config FW_LOADER_USER_HELPER
 	bool
 
 config FW_LOADER_USER_HELPER_FALLBACK
-	bool "Fallback user-helper invocation for firmware loading"
+	bool "Fallback user-helper invocation for firmware loading (avoid)"
 	depends on FW_LOADER
 	select FW_LOADER_USER_HELPER
 	help
diff --git a/scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci b/scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
new file mode 100644
index 000000000000..cf180c59e042
--- /dev/null
+++ b/scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
@@ -0,0 +1,130 @@
+///
+/// Thou shalt not request firmware on init or probe
+///
+// Confidence: High
+// Copyright: (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+// Copyright: (C) 2015 Julia Lawall, Inria/LIP6.
+//
+// GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --no-includes --include-headers --no-show-diff
+// Requires: 1.0.5
+//
+// Coccinelle 1.0.5 is required given that this uses the shiny new
+// python iteration feature.
+
+virtual report
+virtual after_start
+
+// -------------------------------------------------------------------------
+
+@initialize:python@
+@@
+
+seen = set()
+
+def add_if_not_present(f, file, starter_var):
+    if (f, file, starter_var) not in seen:
+        seen.add((f, file, starter_var))
+        it = Iteration()
+        if file != None:
+            it.set_files([file])
+    it.add_virtual_rule(after_start)
+    it.add_virtual_rule(report)
+    it.add_virtual_identifier(fn, f)
+    it.add_virtual_identifier(starter, starter_var)
+    it.register()
+
+reported = set()
+
+def print_err(str, file, line):
+    if (file, line) not in reported:
+        reported.add((file, line))
+	print "%s: ERROR: driver call request firmware call on its %s routine on line %d." % (file, str, line)
+
+@ defines_module_init@
+declarer name module_init;
+identifier init;
+@@
+
+module_init(init);
+
+@ has_probe depends on defines_module_init@
+identifier drv_calls, drv_probe;
+type bus_driver;
+identifier probe_op =~ "(probe)";
+@@
+
+bus_driver drv_calls = {
+	.probe_op = drv_probe,
+};
+
+@hascall depends on !after_start && defines_module_init@
+position p;
+@@
+
+(
+request_firmware@p(...)
+|
+request_firmware_nowait@p(...)
+|
+request_firmware_direct@p(...)
+)
+
+@script:python@
+init << defines_module_init.init;
+p << hascall.p;
+@@
+
+if p[0].current_element == init:
+    print_err("init", p[0].file, int(p[0].line))
+    cocci.include_match(False)
+
+@script:python@
+drv_probe << has_probe.drv_probe;
+p << hascall.p;
+@@
+
+if p[0].current_element == drv_probe:
+    print_err("probe", p[0].file, int(p[0].line))
+    cocci.include_match(False)
+
+@script:python@
+p << hascall.p;
+@@
+
+add_if_not_present(p[0].current_element, p[0].file, p[0].line)
+
+@hasrecall depends on after_start@
+position p;
+identifier virtual.fn;
+@@
+
+fn@p(...)
+
+@script:python@
+init << defines_module_init.init;
+p << hasrecall.p;
+starter << virtual.starter;
+@@
+
+if p[0].current_element == init:
+    print_err("init", p[0].file, int(starter))
+    cocci.include_match(False)
+
+@script:python@
+drv_probe << has_probe.drv_probe;
+p << hasrecall.p;
+starter << virtual.starter;
+@@
+
+if p[0].current_element == drv_probe:
+    print_err("probe", p[0].file, int(starter))
+    cocci.include_match(False)
+
+@script:python@
+p << hasrecall.p;
+starter << virtual.starter;
+@@
+
+add_if_not_present(p[0].current_element, p[0].file, starter)
-- 
2.8.2
