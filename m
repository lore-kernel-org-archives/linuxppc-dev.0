Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78E671A029E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 01:59:14 +1000 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 16:59:09 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1464C17D86F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:58:24 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5HFuxYt29294728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:57:00 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5HFuwZj028869
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 09:56:59 -0600
Subject: [PATCH] powerpc: module: fix TOC symbol CRC
To: linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 17:56:58 +0200
Message-ID: <20140617155658.30560.578.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>
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

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/module_64.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 077d2ce..a80c933 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -315,8 +315,15 @@ static void dedotify_versions(struct modversion_info *vers,
 	struct modversion_info *end;
 
 	for (end = (void *)vers + size; vers < end; vers++)
-		if (vers->name[0] == '.')
+		if (vers->name[0] == '.') {
 			memmove(vers->name, vers->name+1, strlen(vers->name));
+			/* The TOC symbol has no CRC computed. To avoid CRC
+			 * check failing, we must force it to the expected
+			 * value (see CRC check in module.c).
+			 */
+			if (!strcmp(vers->name, "TOC."))
+				vers->crc = -(unsigned long)reloc_start;
+		}
 }
 
 /* Undefined symbols which refer to .funcname, hack to funcname (or .TOC.) */
