Date: Mon, 7 Oct 2002 22:52:03 +0100 (BST)
From: Leigh Brown <leigh@solinno.co.uk>
To: trini@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org, <hollis@austin.ibm.com>
Subject: Tiny fix to Carolina l2 reporting
Message-ID: <Pine.LNX.4.44.0210072249080.4630-100000@micro.solinno.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

This one's Hollis's.  I think someone reported that this fixes it.  It
definitely looks better.

Cheers,

Leigh.


--- linuxppc_2_4_devel/arch/ppc/platforms/prep_setup.c	Thu May 30 13:31:24 2002
+++ linuxppc_2_4_devel-local/arch/ppc/platforms/prep_setup.c	Tue Jun 11 14:47:25 2002
@@ -340,12 +340,17 @@
 		unsigned int l2_reg = inb(PREP_IBM_L2INFO);

 		/* L2 size */
-		if ((l2_reg & 0x60) == 0)
-			seq_printf(m, "256KiB");
-		else if ((l2_reg & 0x60) == 1)
-			seq_printf(m, "512KiB");
-		else
-			seq_printf(m, "unknown size");
+		switch ((l2_reg & 0x60) >> 5) {
+			case 0:
+				seq_printf(m, "256KiB");
+				break;
+			case 1:
+				seq_printf(m, "512KiB");
+				break;
+			default:
+				seq_printf(m, "unknown size");
+				break;
+		}

 		/* L2 type */
 		if ((l2_reg & 0x3) == 0)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
