Return-Path: <geert@sonycom.com>
Message-Id: <20070926164030.799122000@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be>
Date: Wed, 26 Sep 2007 18:33:09 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 1/8] ps3av: eliminate unneeded temporary variables
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ps3av: eliminate unneeded temporary variables

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av_cmd.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

--- a/drivers/ps3/ps3av_cmd.c
+++ b/drivers/ps3/ps3av_cmd.c
@@ -512,7 +512,6 @@ static const u32 ps3av_ns_table[][5] = {
 static void ps3av_cnv_ns(u8 *ns, u32 fs, u32 video_vid)
 {
 	u32 av_vid, ns_val;
-	u8 *p = ns;
 	int d;
 
 	d = ns_val = 0;
@@ -551,24 +550,22 @@ static void ps3av_cnv_ns(u8 *ns, u32 fs,
 	else
 		ns_val = ps3av_ns_table[PS3AV_CMD_AUDIO_FS_44K-BASE][d];
 
-	*p++ = ns_val & 0x000000FF;
-	*p++ = (ns_val & 0x0000FF00) >> 8;
-	*p = (ns_val & 0x00FF0000) >> 16;
+	*ns++ = ns_val & 0x000000FF;
+	*ns++ = (ns_val & 0x0000FF00) >> 8;
+	*ns = (ns_val & 0x00FF0000) >> 16;
 }
 
 #undef BASE
 
 static u8 ps3av_cnv_enable(u32 source, const u8 *enable)
 {
-	const u8 *p;
 	u8 ret = 0;
 
 	if (source == PS3AV_CMD_AUDIO_SOURCE_SPDIF) {
 		ret = 0x03;
 	} else if (source == PS3AV_CMD_AUDIO_SOURCE_SERIAL) {
-		p = enable;
-		ret = ((p[0] << 4) + (p[1] << 5) + (p[2] << 6) + (p[3] << 7)) |
-		      0x01;
+		ret = ((enable[0] << 4) + (enable[1] << 5) + (enable[2] << 6) +
+		       (enable[3] << 7)) | 0x01;
 	} else
 		printk(KERN_ERR "%s failed, source:%x\n", __func__, source);
 	return ret;
@@ -576,11 +573,9 @@ static u8 ps3av_cnv_enable(u32 source, c
 
 static u8 ps3av_cnv_fifomap(const u8 *map)
 {
-	const u8 *p;
 	u8 ret = 0;
 
-	p = map;
-	ret = p[0] + (p[1] << 2) + (p[2] << 4) + (p[3] << 6);
+	ret = map[0] + (map[1] << 2) + (map[2] << 4) + (map[3] << 6);
 	return ret;
 }
 

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
