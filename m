Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C97A71A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 18:54:06 +1000 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 24 Jun 2014 09:54:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D69292190056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:53:48 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5O8s0Zg29491396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 08:54:00 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5O8s085012732
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 02:54:00 -0600
Subject: [PATCH V2] powerpc: module: fix TOC symbol CRC
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 24 Jun 2014 10:53:59 +0200
Message-ID: <20140624085359.11554.3723.stgit@nimbus>
In-Reply-To: <1403582770.4587.150.camel@pasglop>
References: <1403582770.4587.150.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rusty@rustcorp.com.au, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 71ec7c55ed91 introduced the magic symbol ".TOC." for ELFv2 ABI.
This symbol is built manually and has no CRC value computed. A zero value
is put in the CRC section to avoid modpost complaining about a missing CRC.
Unfortunately, this breaks the kernel module loading when the kernel is
relocated (kdump case for instance) because of the relocation applied to
the kcrctab values.

This patch compute a CRC value for the TOC symbol which will match the one
compute by the kernel when it is relocated - aka '0 - relocate_start' done in
maybe_relocated called by check_version (module.c).

Changes in V2:
 - fix only when relocation is applied to kcrctab.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/module_64.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 077d2ce..d807ee6 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -315,8 +315,17 @@ static void dedotify_versions(struct modversion_info *vers,
 	struct modversion_info *end;
 
 	for (end = (void *)vers + size; vers < end; vers++)
-		if (vers->name[0] == '.')
+		if (vers->name[0] == '.') {
 			memmove(vers->name, vers->name+1, strlen(vers->name));
+#ifdef ARCH_RELOCATES_KCRCTAB
+			/* The TOC symbol has no CRC computed. To avoid CRC
+			 * check failing, we must force it to the expected
+			 * value (see CRC check in module.c).
+			 */
+			if (!strcmp(vers->name, "TOC."))
+				vers->crc = -(unsigned long)reloc_start;
+#endif
+		}
 }
 
 /* Undefined symbols which refer to .funcname, hack to funcname (or .TOC.) */
