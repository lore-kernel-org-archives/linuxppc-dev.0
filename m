Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C109DDDFB4
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2007 15:48:49 +1000 (EST)
Date: Sat, 9 Jun 2007 23:21:31 -0500
From: Milton Miller <miltonm@bga.com>
To: jdl@jdl.com,
Subject: [PATCH] dtc: parse NOP in dtb input
Message-Id: <311814492916b8b45674.846930886.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Version 16 and later of the flat device tree format allow NOPs
to be placed in the tree.  When processing dtb input, dtc must
recognise them.

Previously it would produce the error message
FATAL ERROR: Invalid opcode word 00000004 in device tree blob

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 

I was trying to look at the output of convert_flattree_inplace
when I found this.  ftdump.c was able to process the input,
producing // [NOP] comments when encountered.


--- dtc/flattree.c.orig	2007-06-07 15:23:53.000000000 -0500
+++ dtc/flattree.c	2007-06-07 15:32:01.000000000 -0500
@@ -27,6 +27,7 @@
 #define FTF_BOOTCPUID	0x8
 #define FTF_STRTABSIZE	0x10
 #define FTF_STRUCTSIZE	0x20
+#define FTF_NOPS	0x40
 
 static struct version_info {
 	int version;
@@ -41,9 +42,9 @@ static struct version_info {
 	{3, 1, BPH_V3_SIZE,
 	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS|FTF_BOOTCPUID|FTF_STRTABSIZE},
 	{16, 16, BPH_V3_SIZE,
-	 FTF_BOOTCPUID|FTF_STRTABSIZE},
+	 FTF_BOOTCPUID|FTF_STRTABSIZE|FTF_NOPS},
 	{17, 16, BPH_V17_SIZE,
-	 FTF_BOOTCPUID|FTF_STRTABSIZE|FTF_STRUCTSIZE},
+	 FTF_BOOTCPUID|FTF_STRTABSIZE|FTF_STRUCTSIZE|FTF_NOPS},
 };
 
 struct emitter {
@@ -774,6 +775,13 @@ static struct node *unflatten_tree(struc
 			die("Premature OF_DT_END in device tree blob\n");
 			break;
 
+		case OF_DT_NOP:
+			if (flags & FTF_NOPS)
+				break;
+
+			die("OF_DT_NOP in device tree blob\n");
+			break;
+
 		default:
 			die("Invalid opcode word %08x in device tree blob\n",
 			    val);
@@ -895,6 +903,8 @@ struct boot_info *dt_from_blob(FILE *f)
 			
 	if (version < 16) {
 		flags |= FTF_FULLPATH | FTF_NAMEPROPS | FTF_VARALIGN;
+	} else {
+		flags |= FTF_NOPS;
 	}
 
 	inbuf_init(&memresvbuf,
