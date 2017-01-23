Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6hhT57mczDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 06:48:57 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>, rtd@a-eon.com,
 Pat Wall <pjwall@mac.com>, aperez@alexperez.com
Date: Mon, 23 Jan 2017 19:42:54 +0000 (GMT)
Message-ID: <497a1d88a93.7082e0e9@auth.smtp.1and1.co.uk>
Subject: [PATCH] powerpc: Add missing error check to prom_find_boot_cpu()
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6f03750017b43ca.8c"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6f03750017b43ca.8c
Content-Type: text/plain

prom_init.c calls 'instance-to-package' twice, but the return
is not checked during prom_find_boot_cpu(). The result is then
passed to prom_getprop, which could be PROM_ERROR.
Add a return check to prevent this.

This was found on a pasemi system, where CFE doesn't have a working
'instance-to package' prom call.
Before Commit 5c0484e25ec0 ('powerpc: Endian safe trampoline') the
area around addr 0 as mostly 0's and this doesn't cause a problem.
Once the macro 'FIXUP_ENDIAN' has been added to head_64.S, the low
memory area now has non-zero values, which cause the prom_getprop
call to hang.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

----=_BOUNDARY.6f03750017b43ca.8c
Content-Type: text/plain;
	name="prom_init.patch"
Content-Disposition: attachment;
	filename="prom_init.patch";
	size=448

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index ec47a93..ac83eb0 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2834,6 +2834,9 @@ static void __init prom_find_boot_cpu(void)
 
 	cpu_pkg = call_prom("instance-to-package", 1, 1, prom_cpu);
 
+	if (!PHANDLE_VALID(cpu_pkg))
+		return;
+
 	prom_getprop(cpu_pkg, "reg", &rval, sizeof(rval));
 	prom.cpu = be32_to_cpu(rval);
 

----=_BOUNDARY.6f03750017b43ca.8c--
