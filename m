Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 502A1B7B66
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:09:50 +1100 (EST)
Date: Tue, 10 Nov 2009 20:40:57 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH 1/3] mpc52xx/wdt: OF property to enable the WDT on boot
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, Grant Likely
	<grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>
Message-Id: <1257882057.14374.1@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the "wdt,on-boot" OF property as to reserve a GPT as WDT which may be a
requirement in safety-related (e.g. ISO 61508) applications.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
---

 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt b/Documenta=
tion/powerpc/dts-bindings/fsl/mpc5200.txt
index 8447fd7..1eecb06 100644
--- a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
@@ -103,7 +103,20 @@ fsl,mpc5200-gpt nodes
 ---------------------
 On the mpc5200 and 5200b, GPT0 has a watchdog timer function.  If the boar=
d
 design supports the internal wdt, then the device node for GPT0 should
-include the empty property 'fsl,has-wdt'.
+include the empty property 'fsl,has-wdt'.  Note that this does not activat=
e
+the watchdog.  The timer will function as a GPT if the timer api is used, =
and
+it will function as watchdog if the watchdog device is used.  The watchdog
+mode has priority over the gpt mode, i.e. if the watchdog is activated, an=
y
+gpt api call to this timer will fail with -EBUSY.
+
+If you add the property
+	wdt,on-boot =3D <n>;
+GPT0 will be marked as in-use watchdog, i.e. blocking every gpt access to =
it.
+If n>0, the watchdog is started with a timeout of n seconds.  If n=3D0, th=
e
+configuration of the watchdog is not touched.  This is useful in two cases=
:
+- just mark GPT0 as watchdog, blocking gpt accesses, and configure it late=
r;
+- do not touch a configuration assigned by the boot loader which supervise=
s
+  the boot process itself.
=20
 An mpc5200-gpt can be used as a single line GPIO controller.  To do so,
 add the following properties to the gpt node:
