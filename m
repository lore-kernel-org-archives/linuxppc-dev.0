Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.206])
	by ozlabs.org (Postfix) with ESMTP id 6578C68898
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 08:50:21 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id m18so54714nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Dec 2005 13:50:20 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dan Malek <dan@embeddededge.com>, linuxppc-embedded@ozlabs.org
Date: Tue, 6 Dec 2005 23:58:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512062358.40123.pantelis.antoniou@gmail.com>
Subject: [PATCH] ppc32-8xx: Skip OF tree if present.
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Skip OF tree if present. We will deal with it properly soon.

---
commit 83f5e0be8db948f28442dd279f6472bd3367ea45
tree 493c111da8b8b210ea3987e29c0dfaff78129d76
parent e4f5c82a92c2a546a16af1614114eec19120e40a
author Pantelis Antoniou <pantelis.antoniou@gmail.com> Tue, 06 Dec 2005 23:15:29 +0200
committer Pantelis Antoniou <pantelis.antoniou@gmail.com> Tue, 06 Dec 2005 23:15:29 +0200

 arch/ppc/syslib/m8xx_setup.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -376,10 +376,17 @@ void __init
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 		unsigned long r6, unsigned long r7)
 {
+	bd_t *bd;
+
 	parse_bootinfo(find_bootinfo());
 
-	if ( r3 )
-		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+	if ( r3 ) {
+		bd = (bd_t *)(r3+KERNELBASE);
+		/* skip OF tree if present */
+		if (*(u32 *)bd == 0xd00dfeed)
+			bd = (bd_t *)((char *)bd + ((u32 *)bd)[1]);
+		memcpy(__res, bd, sizeof(bd_t));
+	}
 
 #ifdef CONFIG_PCI
 	m8xx_setup_pci_ptrs();
