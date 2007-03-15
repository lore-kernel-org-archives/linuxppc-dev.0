Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [204.127.192.82])
	by ozlabs.org (Postfix) with ESMTP id 99F6CDDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:46:55 +1100 (EST)
Message-ID: <45F9DAEC.30005@comcast.net>
Date: Thu, 15 Mar 2007 19:46:52 -0400
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Define the default version
Content-Type: multipart/mixed; boundary="------------080005090909020600030709"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080005090909020600030709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jon, David:

Thanks for updating dtc to v17.  This is a trivial patch to fix the 
usage (permanently) to show the correct version number in the usage help.

Thanks,
gvb

--------------080005090909020600030709
Content-Type: text/plain;
 name="0001-Define-the-default-version.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Define-the-default-version.txt"

The default version is used in two places (someday maybe more).  Create
a #define to set the default version in one place.

Signed-off-by: vanbaren@cideas.com <vanbaren@cideas.com>
---
 dtc.c     |    4 ++--
 flat_dt.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/dtc.c b/dtc.c
index f15d90f..61956f1 100644
--- a/dtc.c
+++ b/dtc.c
@@ -92,7 +92,7 @@ static void usage(void)
 	fprintf(stderr, "\t\t\tdtb - device tree blob\n");
 	fprintf(stderr, "\t\t\tasm - assembler source\n");
 	fprintf(stderr, "\t-V <output version>\n");
-	fprintf(stderr, "\t\tBlob version to produce, defaults to 16 (relevant for dtb\n\t\tand asm output only)\n");
+	fprintf(stderr, "\t\tBlob version to produce, defaults to %d (relevant for dtb\n\t\tand asm output only)\n", OF_DEFAULT_VERSION);
 	fprintf(stderr, "\t-R <number>\n");
 	fprintf(stderr, "\t\tMake space for <number> reserve map entries (relevant for \n\t\tdtb and asm output only)\n");
 	fprintf(stderr, "\t-b <number>\n");
@@ -113,7 +113,7 @@ int main(int argc, char *argv[])
 	int opt;
 	FILE *inf = NULL;
 	FILE *outf = NULL;
-	int outversion = 17;
+	int outversion = OF_DEFAULT_VERSION;
 	int reservenum = 1;
 	int boot_cpuid_phys = 0xfeedbeef;
 
diff --git a/flat_dt.h b/flat_dt.h
index d5abd80..a8482b4 100644
--- a/flat_dt.h
+++ b/flat_dt.h
@@ -2,6 +2,8 @@
 #define _FLAT_DT_H_
 
 
+#define OF_DEFAULT_VERSION	17
+
 #define OF_DT_HEADER            0xd00dfeed      /* 4: version, 4: total size */
 
 #define OF_DT_BEGIN_NODE	0x1             /* Start node: full name */
-- 
1.4.4.4


--------------080005090909020600030709--
