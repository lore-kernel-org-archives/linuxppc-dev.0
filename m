Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED040B7F3D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 19:54:50 +1100 (EST)
Message-Id: <20091015085329.210995619@linutronix.de>
Date: Thu, 15 Oct 2009 08:54:40 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 2/3] powerpc: Check nvram_error_log_index in
	nvram_clear_error_log()
References: <20091015085253.295880694@linutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

nvram_clear_error_log() calls ppc_md.nvram_write() even when
nvram_error_log_index is -1 (invalid). The nvram_write() function does
not check for a negative offset. 

Check nvram_error_log_index as the other nvram log functions do.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org

---
 arch/powerpc/kernel/nvram_64.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6-tip/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/nvram_64.c
+++ linux-2.6-tip/arch/powerpc/kernel/nvram_64.c
@@ -681,6 +681,9 @@ int nvram_clear_error_log(void)
 	int clear_word = ERR_FLAG_ALREADY_LOGGED;
 	int rc;
 
+	if (nvram_error_log_index == -1)
+		return -1;
+
 	tmp_index = nvram_error_log_index;
 	
 	rc = ppc_md.nvram_write((char *)&clear_word, sizeof(int), &tmp_index);
