Return-Path: <vanbaren@cideas.com>
Received: from rwcrmhc13.comcast.net (rwcrmhc13.comcast.net [204.127.192.83])
	by ozlabs.org (Postfix) with ESMTP id 7345FDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 08:19:47 +1000 (EST)
Date: Tue, 17 Apr 2007 18:14:41 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: linuxppc-dev@ozlabs.org, jdl@jdl.com
Subject: [PATCH dtc take 3] Fix reserve map output for asm format.
Message-ID: <20070417221441.GA13090@dellserver.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add extra reserve map slots output for asm format (previously done for dtb
  output).

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---

Hi Jon, David, Milton,

Here is a patch just to fix the asm output for reserved slots for the
-R parameter.

Best regards,
gvb

 flattree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/flattree.c b/flattree.c
index 151d16e..8159848 100644
--- a/flattree.c
+++ b/flattree.c
@@ -490,6 +490,9 @@ void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
 			(unsigned int)(re->re.size >> 32),
 			(unsigned int)(re->re.size & 0xffffffff));
 	}
+	for (i = 0; i < reservenum; i++) {
+		fprintf(f, "\t.long\t0, 0\n\t.long\t0, 0\n");
+	}
 
 	fprintf(f, "\t.long\t0, 0\n\t.long\t0, 0\n");
 
-- 
1.4.4.4
