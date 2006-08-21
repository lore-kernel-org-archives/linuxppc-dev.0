Return-Path: <olaf@ibook.aepfle.de>
Received: from natreg.rzone.de (natreg.rzone.de [81.169.145.183])
	by ozlabs.org (Postfix) with ESMTP id DD82967C2E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 02:11:48 +1000 (EST)
Date: Mon, 21 Aug 2006 18:11:32 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
Subject: [PATCH] reboot when panic_timout is set
Message-ID: <20060821161132.GA31085@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Only call into RTAS when booted with panic=0 because the RTAS call does not return.
The system has to be rebooted via the HMC or via the management console right now.
This is cumbersome and not what the default panic=180 is supposed to do.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 arch/powerpc/kernel/rtas.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.18-rc4/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/powerpc/kernel/rtas.c
+++ linux-2.6.18-rc4/arch/powerpc/kernel/rtas.c
@@ -628,6 +628,9 @@ void rtas_os_term(char *str)
 {
 	int status;
 
+	if (panic_timeout)
+		return;
+
 	if (RTAS_UNKNOWN_SERVICE == rtas_token("ibm,os-term"))
 		return;
 
