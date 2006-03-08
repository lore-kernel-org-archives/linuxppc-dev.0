Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4120A679E2
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Mar 2006 06:40:36 +1100 (EST)
Date: Wed, 8 Mar 2006 20:40:28 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] add a raw dump command to xmon
Message-ID: <20060308194028.GA21615@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Dump a stream of rawbytes with a new 'dr' command.
Produces less output and it is simpler to feed the output to scripts.
Also, dr has no dumpsize limits.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/xmon/xmon.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+)

Index: linux-2.6.16-rc5-olh/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.16-rc5-olh.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6.16-rc5-olh/arch/powerpc/xmon/xmon.c
@@ -191,6 +191,7 @@ Commands:\n\
   di	dump instructions\n\
   df	dump float values\n\
   dd	dump double values\n\
+  dr	dump stream of raw bytes\n\
   e	print exception information\n\
   f	flush cache\n\
   la	lookup symbol+offset of specified address\n\
@@ -1938,6 +1939,28 @@ bsesc(void)
 	return c;
 }
 
+static void xmon_rawdump (unsigned long adrs, long ndump)
+{
+	long n, m, r, nr;
+	unsigned char temp[16];
+
+	for (n = ndump; n > 0;) {
+		r = n < 16? n: 16;
+		nr = mread(adrs, temp, r);
+		adrs += nr;
+		for (m = 0; m < r; ++m) {
+			if (m < nr)
+				printf("%.2x", temp[m]);
+			else
+				printf("%s", fault_chars[fault_type]);
+		}
+		n -= r;
+		if (nr < r)
+			break;
+	}
+	printf("\n");
+}
+
 #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
 			 || ('a' <= (c) && (c) <= 'f') \
 			 || ('A' <= (c) && (c) <= 'F'))
@@ -1960,6 +1983,13 @@ dump(void)
 			nidump = MAX_DUMP;
 		adrs += ppc_inst_dump(adrs, nidump, 1);
 		last_cmd = "di\n";
+	} else if (c == 'r') {
+		scanhex(&ndump);
+		if (ndump == 0)
+			ndump = 64;
+		xmon_rawdump(adrs, ndump);
+		adrs += ndump;
+		last_cmd = "dr\n";
 	} else {
 		scanhex(&ndump);
 		if (ndump == 0)
