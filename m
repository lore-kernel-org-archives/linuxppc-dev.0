Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:52:06 +1000
Subject: [PATCH 3/7] iseries: Cleanup e2a() and strne2a()
In-Reply-To: <1152777121.430402.3949688126.qpush@concordia>
Message-Id: <20060713075208.44F1367B88@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

e2a() was formally used by lparcfg, and so had to be exported, but isn't
anymore, so don't.

e2a() and strne2a() can both be static, and __init.

And e2a can be made much more concise if we use x ... y case labels, while
we're there add support for lower case letters.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/dt.c |   92 ++++++------------------------------
 1 file changed, 17 insertions(+), 75 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/dt.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/dt.c
+++ to-merge/arch/powerpc/platforms/iseries/dt.c
@@ -80,87 +80,29 @@ static char __initdata device_type_vscsi
 
 /* EBCDIC to ASCII conversion routines */
 
-unsigned char e2a(unsigned char x)
+static unsigned char __init e2a(unsigned char x)
 {
 	switch (x) {
-	case 0xF0:
-		return '0';
-	case 0xF1:
-		return '1';
-	case 0xF2:
-		return '2';
-	case 0xF3:
-		return '3';
-	case 0xF4:
-		return '4';
-	case 0xF5:
-		return '5';
-	case 0xF6:
-		return '6';
-	case 0xF7:
-		return '7';
-	case 0xF8:
-		return '8';
-	case 0xF9:
-		return '9';
-	case 0xC1:
-		return 'A';
-	case 0xC2:
-		return 'B';
-	case 0xC3:
-		return 'C';
-	case 0xC4:
-		return 'D';
-	case 0xC5:
-		return 'E';
-	case 0xC6:
-		return 'F';
-	case 0xC7:
-		return 'G';
-	case 0xC8:
-		return 'H';
-	case 0xC9:
-		return 'I';
-	case 0xD1:
-		return 'J';
-	case 0xD2:
-		return 'K';
-	case 0xD3:
-		return 'L';
-	case 0xD4:
-		return 'M';
-	case 0xD5:
-		return 'N';
-	case 0xD6:
-		return 'O';
-	case 0xD7:
-		return 'P';
-	case 0xD8:
-		return 'Q';
-	case 0xD9:
-		return 'R';
-	case 0xE2:
-		return 'S';
-	case 0xE3:
-		return 'T';
-	case 0xE4:
-		return 'U';
-	case 0xE5:
-		return 'V';
-	case 0xE6:
-		return 'W';
-	case 0xE7:
-		return 'X';
-	case 0xE8:
-		return 'Y';
-	case 0xE9:
-		return 'Z';
+	case 0x81 ... 0x89:
+		return x - 0x81 + 'a';
+	case 0x91 ... 0x99:
+		return x - 0x91 + 'j';
+	case 0xA2 ... 0xA9:
+		return x - 0xA2 + 's';
+	case 0xC1 ... 0xC9:
+		return x - 0xC1 + 'A';
+	case 0xD1 ... 0xD9:
+		return x - 0xD1 + 'J';
+	case 0xE2 ... 0xE9:
+		return x - 0xE2 + 'S';
+	case 0xF0 ... 0xF9:
+		return x - 0xF0 + '0';
 	}
 	return ' ';
 }
-EXPORT_SYMBOL(e2a);
 
-unsigned char* strne2a(unsigned char *dest, const unsigned char *src, size_t n)
+static unsigned char * __init strne2a(unsigned char *dest,
+		const unsigned char *src, size_t n)
 {
 	int i;
 
