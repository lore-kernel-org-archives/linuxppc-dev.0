Date: Mon, 15 Apr 2002 13:43:22 -0600
From: Val Henson <val@nmt.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Allow OpenPIC irq 0 to be used
Message-ID: <20020415134322.E15153@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Synergy boards do not have an i8259 hooked up to irq 0, instead we
actually use it as a normal irq line.  Yes, I know, bad idea, but
we're stuck with it.  The following patch is ugly, but illustrates the
general idea in a way which might possibly be compatible with other
OpenPIC boards.

-VAL

===== arch/ppc/kernel/open_pic.c 1.47 vs edited =====
--- 1.47/arch/ppc/kernel/open_pic.c	Tue Feb  5 03:10:24 2002
+++ edited/arch/ppc/kernel/open_pic.c	Mon Apr 15 13:42:12 2002
@@ -366,7 +366,7 @@
 	}

 	/* Init all external sources */
-	for (i = 1; i < NumSources; i++) {
+	for (i = offset ? 1 : 0; i < NumSources; i++) {
 		int pri, sense;

 		if (ISR[i] == 0)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
