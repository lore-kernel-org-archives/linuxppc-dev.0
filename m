Subject: 405LP - Beech with SSX firmware
From: Hollis Blanchard <hollis@austin.ibm.com>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
Cc: Bishop Brock <bcbrock@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-A9S+ux9kGTgoaiL9VuN+"
Date: 20 Dec 2002 17:36:00 -0600
Message-Id: <1040427361.1096.27.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-A9S+ux9kGTgoaiL9VuN+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, this patch (copied from Arctic) allows Beech to boot with SSX
firmware. If there's a way to detect OpenBIOS vs PIBS (I've asked for
confirmation) then I think the Beech and Arctic ifdefs could be combined
in the file. There may not be though, and in the meantime this works.

Please apply to _2_4_devel.

-Hollis
--
PowerPC Linux
IBM Linux Technology Center

--=-A9S+ux9kGTgoaiL9VuN+
Content-Disposition: attachment; filename=405LP-beech-ssx.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=405LP-beech-ssx.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D arch/ppc/boot/simple/embed_config.c 1.20 vs edited =3D=3D=
=3D=3D=3D
--- 1.20/arch/ppc/boot/simple/embed_config.c	Sun Dec 15 20:02:08 2002
+++ edited/arch/ppc/boot/simple/embed_config.c	Wed Dec 18 15:53:18 2002
@@ -868,12 +868,33 @@
 #endif
=20
 #ifdef CONFIG_BEECH
-static void
-get_board_info(bd_t **bdp)
+/* Several bootloaders have been used on Beech. We assume either
+ * SSX or OpenBIOS */
+
+#define SSX_BIOS_ADDR 		0xFFFF0000
+#define SSX_BIOS_GET_BOARD_INFO 0
+
+struct ssx_bios_id {
+	unsigned int boot_branch;	/* Branch to bootcode */
+	char ssx_bios[8];		/* "SSX BIOS" (no \0) */
+	void (*bios_entry_point)(unsigned int, bd_t *); /* Call bios_entry_point(=
cmd, &data) */
+};
+
+extern int memcmp(const void *s1, const void *s2, size_t n);
+
+static void get_board_info(bd_t **bdp)
 {
-	typedef void (*PFV)(bd_t *bd);
-	((PFV)(*(unsigned long *)BOARD_INFO_VECTOR))(*bdp);
-	return;
+	struct ssx_bios_id *ssx =3D (struct ssx_bios_id *)SSX_BIOS_ADDR;
+
+	/* Check for SSX signature */
+
+	if (memcmp(&ssx->ssx_bios, "SSX BIOS", 8) =3D=3D 0) {
+		ssx->bios_entry_point(SSX_BIOS_GET_BOARD_INFO, *bdp);
+	} else {
+		/* It's not SSX, so assume OpenBIOS */
+		typedef void (*PFV)(bd_t *bd);
+		((PFV)(*(unsigned long *)BOARD_INFO_VECTOR))(*bdp);
+	}
 }
=20
 void

--=-A9S+ux9kGTgoaiL9VuN+--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
