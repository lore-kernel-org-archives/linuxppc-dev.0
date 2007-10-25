Return-Path: <mgreer@mvista.com>
Date: Thu, 25 Oct 2007 16:42:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: prpmc2800 - Don't overwrite user FLASH size
Message-ID: <20071025234235.GA22913@mag.az.mvista.com>
References: <20071025233948.GA22703@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071025233948.GA22703@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

The prpmc2800 bootwrapper code currently overwrites the DTS' user FLASH
size with a predetermined value.  Intead make it use whatever is specified
in the DTS unless the prpmc2800 variant the bootwrapper is running on has
no user FLASH.  In that case, set the user FLASH size to 0.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/prpmc2800.c |   54 ++++++++++++++++----------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/boot/prpmc2800.c b/arch/powerpc/boot/prpmc2800.c
index 9614e1d..a8b3213 100644
--- a/arch/powerpc/boot/prpmc2800.c
+++ b/arch/powerpc/boot/prpmc2800.c
@@ -58,7 +58,7 @@ struct prpmc2800_board_info {
 	u32 core_speed;
 	u32 mem_size;
 	u32 boot_flash;
-	u32 user_flash;
+	u8 has_user_flash;
 };
 
 static struct prpmc2800_board_info prpmc2800_board_info[] = {
@@ -73,7 +73,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 512*MB,
 		.boot_flash	= 1*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC280,
@@ -86,7 +86,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 512*MB,
 		.boot_flash	= 0,
-		.user_flash	= 0,
+		.has_user_flash	= 0,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC280,
@@ -99,7 +99,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 733*MHz,
 		.mem_size	= 512*MB,
 		.boot_flash	= 1*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC280,
@@ -112,7 +112,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 1*GB,
 		.boot_flash	= 1*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC280,
@@ -125,7 +125,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 512*MB,
 		.boot_flash	= 1*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC280,
@@ -138,7 +138,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 733*MHz,
 		.mem_size	= 128*MB,
 		.boot_flash	= 1*MB,
-		.user_flash	= 0,
+		.has_user_flash	= 0,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC280,
@@ -151,7 +151,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 256*MB,
 		.boot_flash	= 1*MB,
-		.user_flash	= 0,
+		.has_user_flash	= 0,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC280,
@@ -164,7 +164,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 1*GB,
 		.boot_flash	= 1*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC2800,
@@ -177,7 +177,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 512*MB,
 		.boot_flash	= 2*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC2800,
@@ -190,7 +190,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 512*MB,
 		.boot_flash	= 0,
-		.user_flash	= 0,
+		.has_user_flash	= 0,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC2800,
@@ -203,7 +203,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 733*MHz,
 		.mem_size	= 512*MB,
 		.boot_flash	= 2*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC2800,
@@ -216,7 +216,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 1*GB,
 		.boot_flash	= 2*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC2800,
@@ -229,7 +229,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 512*MB,
 		.boot_flash	= 2*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC2800,
@@ -242,7 +242,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 733*MHz,
 		.mem_size	= 128*MB,
 		.boot_flash	= 2*MB,
-		.user_flash	= 0,
+		.has_user_flash	= 0,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC2800,
@@ -255,7 +255,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 1*GHz,
 		.mem_size	= 2*GB,
 		.boot_flash	= 2*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 	{
 		.model		= BOARD_MODEL_PRPMC2800,
@@ -268,7 +268,7 @@ static struct prpmc2800_board_info prpmc2800_board_info[] = {
 		.core_speed	= 733*MHz,
 		.mem_size	= 1*GB,
 		.boot_flash	= 2*MB,
-		.user_flash	= 64*MB,
+		.has_user_flash	= 1,
 	},
 };
 
@@ -451,15 +451,17 @@ static void prpmc2800_fixups(void)
 		setprop(devp, "model", "mv64362", strlen("mv64362") + 1);
 	}
 
-	/* Set User FLASH size */
-	devp = finddevice("/mv64x60/flash@a0000000");
-	if (devp == NULL)
-		fatal("Error: Missing User FLASH device tree node\n\r");
-	rc = getprop(devp, "reg", v, sizeof(v));
-	if (rc != sizeof(v))
-		fatal("Error: Can't find User FLASH reg property\n\r");
-	v[1] = bip->user_flash;
-	setprop(devp, "reg", v, sizeof(v));
+	/* Some PrPMC2800 variants have no User FLASH */
+	if (!bip->has_user_flash) {
+		devp = finddevice("/mv64x60/flash@a0000000");
+		if (devp != NULL) {
+			rc = getprop(devp, "reg", v, sizeof(v));
+			if (rc == sizeof(v)) {
+				v[1] = 0;
+				setprop(devp, "reg", v, sizeof(v));
+			}
+		}
+	}
 }
 
 #define MV64x60_MPP_CNTL_0	0xf000
