Return-Path: <jk@ozlabs.org>
To: <cbe-oss-dev@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 13 Apr 2007 11:48:59 +1000
Subject: [PATCH 4/4] spufs: add mode= mount option
Message-Id: <1176428939.430693.221781450134.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a 'mode=' option to spufs mount arguments. This allows more
control over access to the top-level spufs directory.

Tested on Cell.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

 arch/powerpc/platforms/cell/spufs/inode.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
@@ -521,13 +521,14 @@ out:
 
 /* File system initialization */
 enum {
-	Opt_uid, Opt_gid, Opt_err,
+	Opt_uid, Opt_gid, Opt_mode, Opt_err,
 };
 
 static match_table_t spufs_tokens = {
-	{ Opt_uid, "uid=%d" },
-	{ Opt_gid, "gid=%d" },
-	{ Opt_err, NULL  },
+	{ Opt_uid,  "uid=%d" },
+	{ Opt_gid,  "gid=%d" },
+	{ Opt_mode, "mode=%o" },
+	{ Opt_err,   NULL  },
 };
 
 static int
@@ -554,6 +555,11 @@ spufs_parse_options(char *options, struc
 				return 0;
 			root->i_gid = option;
 			break;
+		case Opt_mode:
+			if (match_octal(&args[0], &option))
+				return 0;
+			root->i_mode = option | S_IFDIR;
+			break;
 		default:
 			return 0;
 		}
