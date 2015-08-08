Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C7751A0667
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:14 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D7804C90042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:14 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t9A760031056
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t8iP012219
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:09 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 09/16] Add support for a TPM menu to control the state of the
 TPM
Date: Fri,  7 Aug 2015 21:54:58 -0400
Message-Id: <1438998905-4085665-10-git-send-email-stefanb@linux.vnet.ibm.com>
In-Reply-To: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides an addtional menu that enables the user to control
certain aspects of the TPM's state.

If a working TPM has been detected, the menu will look like this:

The TPM is enabled, active, does not have an owner but one can be installed.

To configure the TPM, choose one of the following actions:

d. Disable the TPM
v. Deactivate the TPM
p. Prevent installation of an owner


Note: To fully use the TPM it must be enabled and activated.

Press escape to continue boot.


This menu can be access by pressing the 't' key during boot. The menu will not
be shown if no TPM is available.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/OF.fs     |   2 +-
 lib/libtpm/tcgbios.c      |  33 ++++++++
 lib/libtpm/tcgbios.h      |   9 +++
 lib/libtpm/tpm.code       |  20 +++++
 lib/libtpm/tpm.in         |   2 +
 slof/fs/start-up.fs       |   9 +++
 slof/fs/tpm/tpm-static.fs | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 267 insertions(+), 1 deletion(-)

diff --git a/board-qemu/slof/OF.fs b/board-qemu/slof/OF.fs
index 1306371..cb63455 100644
--- a/board-qemu/slof/OF.fs
+++ b/board-qemu/slof/OF.fs
@@ -180,6 +180,7 @@ CREATE version-str 10 ALLOT
     version-str 8 + @               \ end
     over - terminal-write drop
     " Press 's' to enter Open Firmware." terminal-write drop
+    vtpm-available? IF "  Press 't' to enter TPM menu." terminal-write drop THEN
     cr cr
     temp-ptr disp-size > IF
 	temp-ptr disp-size MOD
@@ -305,7 +306,6 @@ cr
 cr cr
 
 vtpm-add-event-separators
-vtpm-unassert-pp
 
 \ this CATCH is to ensure the code bellow always executes:  boot may ABORT!
 ' start-it CATCH drop
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index cabd980..40557d6 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -1350,3 +1350,36 @@ uint32_t tpm_process_opcode(uint8_t op, bool verbose)
 
 	return tpm_process_cfg(&cfg, verbose, &returnCode);
 }
+
+int tpm_get_state(void)
+{
+	int state = 0;
+	struct tpm_permanent_flags pf;
+	bool has_owner;
+
+	if (read_permanent_flags((char *)&pf, sizeof(pf)) ||
+	    read_has_owner(&has_owner))
+		return ~0;
+
+	if (!pf.flags[PERM_FLAG_IDX_DISABLE])
+		state |= TPM_STATE_ENABLED; /* enabled */
+
+	if (!pf.flags[PERM_FLAG_IDX_DEACTIVATED])
+		state |= TPM_STATE_ACTIVE; /* active */
+
+	if (has_owner) {
+		state |= TPM_STATE_OWNED; /* has owner */
+	} else {
+		if (pf.flags[PERM_FLAG_IDX_OWNERSHIP])
+			state |= TPM_STATE_OWNERINSTALL; /* owner can be installed */
+	}
+
+	dprintf("TPM state flags = 0x%x\n", state);
+
+	return state;
+}
+
+bool tpm_is_working(void)
+{
+	return has_working_tpm();
+}
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index e0a7045..902ea1f 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -31,4 +31,13 @@ uint32_t tpm_add_bcv(uint32_t bootdrv, const uint8_t *addr, uint32_t length);
 uint32_t tpm_add_event_separators(void);
 uint32_t tpm_process_opcode(uint8_t op, bool verbose);
 
+/* flags returned by tpm_get_state */
+#define TPM_STATE_ENABLED        1
+#define TPM_STATE_ACTIVE         2
+#define TPM_STATE_OWNED          4
+#define TPM_STATE_OWNERINSTALL   8
+
+int tpm_get_state(void);
+bool tpm_is_working(void);
+
 #endif /* TCGBIOS_H */
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index 7728317..66250d5 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -102,3 +102,23 @@ PRIM(tpm_X2d_process_X2d_opcode)
 	bool verbose = TOS.u;
 	TOS.n = tpm_process_opcode(opcode, verbose);
 MIRP
+
+/************************************************/
+/* Get state of the TPM in form of flags        */
+/* SLOF:   tpm-get-state  ( -- flags )          */
+/* LIBTPM: state = tpm_get_state()              */
+/************************************************/
+PRIM(tpm_X2d_get_X2d_state)
+	PUSH;
+	TOS.n = tpm_get_state();
+MIRP
+
+/************************************************/
+/* Check whether the TPM is working             */
+/* SLOF:   tpm-is-working  ( -- true | false )  */
+/* LIBTPM: bool = tpm_is_working()              */
+/************************************************/
+PRIM(tpm_X2d_is_X2d_working)
+	PUSH;
+	TOS.n = tpm_is_working();
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index e5dbc25..f2cc81e 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -21,3 +21,5 @@ cod(tpm-add-event-separators)
 cod(tpm-ipl)
 cod(tpm-add-bcv)
 cod(tpm-process-opcode)
+cod(tpm-get-state)
+cod(tpm-is-working)
diff --git a/slof/fs/start-up.fs b/slof/fs/start-up.fs
index f1488fa..015e6c1 100644
--- a/slof/fs/start-up.fs
+++ b/slof/fs/start-up.fs
@@ -55,7 +55,15 @@
    nvramlog-write-string-cr
 ;
 
+: (t-pressed) ( -- )
+   vtpm-menu
+;
+
 : (boot?) ( -- )
+   \ before we boot (and after the TPM menu) make sure we give up
+   \ physical presence on the TPM and lock it -> call vtpm-unassert-pp
+   vtpm-unassert-pp
+
    of-prompt? not auto-boot? and IF
       (boot)
    THEN
@@ -147,6 +155,7 @@ TRUE VALUE use-load-watchdog?
    key? IF
       key CASE
 	 [char] s  OF (s-pressed) ENDOF
+	 [char] t  OF (t-pressed) (boot?) ENDOF
 	 1b        OF
 	     (esc-sequence) CASE
 		 1   OF
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index d425693..7954be2 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -43,3 +43,196 @@ false VALUE vtpm-debug?
         THEN
     THEN
 ;
+
+1 CONSTANT TPM_ST_ENABLED
+2 CONSTANT TPM_ST_ACTIVE
+4 CONSTANT TPM_ST_OWNED
+8 CONSTANT TPM_ST_OWNERINSTALL
+
+\ helper to test whether the TPM is enabled and active
+: vtpm-enabled-active ( state -- ok? )
+    TPM_ST_ENABLED TPM_ST_ACTIVE OR AND TPM_ST_ENABLED TPM_ST_ACTIVE OR =
+;
+
+\ display the menu for manipulating TPM state; we get
+\ the state of the TPM in form of flags from the C-driver
+\
+\ Some info about the TPM's states:
+\ - enabling/disabling can be done at any time
+\ - activating/deactivating the TPM requires an enabled TPM
+\ - clearing ownership can be done even if the TPM is deactivated and disabled
+\ - allowing/preventing owner installation requires an enabled and active TPM
+\
+: vtpm-menu-show ( -- )
+    tpm-is-working IF
+        ." The TPM is "
+
+        tpm-get-state                   ( -- flags )
+
+        dup TPM_ST_ENABLED AND TPM_ST_ENABLED <> IF
+            ." disabled"
+        ELSE
+            ." enabled"
+        THEN
+
+        dup TPM_ST_ACTIVE AND TPM_ST_ACTIVE <> IF
+            ." , deactivated"
+        ELSE
+            ." , active"
+        THEN
+
+        dup TPM_ST_OWNED AND TPM_ST_OWNED <> IF
+            ." , does not have an owner "
+            dup TPM_ST_OWNERINSTALL AND TPM_ST_OWNERINSTALL <> IF
+                ." and an owner cannot be installed."
+            ELSE
+                ." but one can be installed."
+            THEN
+        ELSE
+            ." , and has an owner."
+        THEN
+
+        cr cr
+        ." To configure the TPM, choose one of the following actions:"
+        cr cr
+
+        dup TPM_ST_ENABLED AND TPM_ST_ENABLED <> IF
+            ." e. Enable the TPM" cr
+        ELSE
+            ." d. Disable the TPM" cr
+
+            dup TPM_ST_ACTIVE AND TPM_ST_ACTIVE <> IF
+                ." a. Activate the TPM" cr
+            ELSE
+                ." v. Deactivate the TPM" cr
+
+                dup TPM_ST_OWNERINSTALL AND TPM_ST_OWNERINSTALL <> IF
+                    ." s. Allow installation of an owner" cr
+                ELSE
+                    ." p. Prevent installation of an owner" cr
+                THEN
+            THEN
+
+        THEN
+
+        dup TPM_ST_OWNED AND TPM_ST_OWNED = IF
+           ." c. Clear ownership" cr
+        THEN
+
+        cr
+        \ If the TPM is either disabled or deactivated, show message
+        vtpm-enabled-active 0= IF
+            ." Note: To be able to use all features of the TPM, it must be enabled and active."
+            cr cr
+        THEN
+
+    ELSE
+       ." The TPM is not working correctly." cr
+    THEN
+
+    ." Press escape to continue boot." cr cr
+;
+
+\ wait for keyboard input
+: vtpm-menu-key-get
+    0 0 DO
+       key? IF
+           key
+           UNLOOP EXIT
+       THEN
+       100 MS
+    LOOP
+    1b
+;
+
+\ Send a code to the C-driver to change the state of the vTPM
+: vtpm-process-opcode ( verbose? opcode -- )
+    tpm-process-opcode
+    vtpm-debug? IF
+        ." VTPM: Error code from tpm-process-opcode: " . cr
+    ELSE
+        drop
+    THEN
+;
+
+
+1  CONSTANT PPI_OP_ENABLE
+2  CONSTANT PPI_OP_DISABLE
+3  CONSTANT PPI_OP_ACTIVATE
+4  CONSTANT PPI_OP_DEACTIVATE
+5  CONSTANT PPI_OP_CLEAR
+8  CONSTANT PPI_OP_SETOWNERINSTALL_TRUE
+9  CONSTANT PPI_OP_SETOWNERINSTALL_FALSE
+
+\ if there's a vtpm available, display the menu
+\ wait for keyboard input and have the C-driver
+\ process opcodes we derive from the chosen menu
+\ item
+: vtpm-menu
+    vtpm-available? IF
+        tpm-is-working IF
+            \ vtpm-empty-keybuffer
+            vtpm-menu-show
+            0 0  DO
+                CASE vtpm-menu-key-get
+                [char] e OF  tpm-get-state                                  ( -- flags )
+                             TPM_ST_ENABLED AND TPM_ST_ENABLED <> IF
+                                 0 PPI_OP_ENABLE     vtpm-process-opcode
+                                 vtpm-menu-show
+                             THEN
+                         ENDOF
+                [char] d OF  tpm-get-state                                  ( -- flags )
+                             TPM_ST_ENABLED AND TPM_ST_ENABLED = IF
+                                 0 PPI_OP_DISABLE    vtpm-process-opcode
+                                 vtpm-menu-show
+                             THEN
+                         ENDOF
+                [char] a OF  tpm-get-state                                  ( -- flags )
+                             TPM_ST_ACTIVE AND TPM_ST_ACTIVE <> IF
+                                 0 PPI_OP_ACTIVATE   vtpm-process-opcode
+                                 tpm-get-state
+                                 TPM_ST_ACTIVE AND TPM_ST_ACTIVE = IF
+                                     ." The system needs to reboot to activate the TPM."
+                                     100 MS \ so the message shows
+                                     reset-all
+                                 THEN
+                             THEN
+                         ENDOF
+                [char] v OF  tpm-get-state                                  ( -- flags )
+                             TPM_ST_ACTIVE AND TPM_ST_ACTIVE = IF
+                                 0 PPI_OP_DEACTIVATE vtpm-process-opcode
+                                 vtpm-menu-show
+                             THEN
+                         ENDOF
+                [char] c OF  tpm-get-state                                  ( -- flags )
+                             TPM_ST_OWNED AND TPM_ST_OWNED = IF
+                                 0 PPI_OP_CLEAR      vtpm-process-opcode
+                                 vtpm-menu-show
+                             THEN
+                         ENDOF
+                [char] s OF  tpm-get-state
+                             \ The TPM must be enabled and active to allow
+                             \ owner installation mods
+                             dup vtpm-enabled-active IF
+                                 TPM_ST_OWNERINSTALL AND TPM_ST_OWNERINSTALL <> IF
+                                     0 PPI_OP_SETOWNERINSTALL_TRUE  vtpm-process-opcode
+                                     vtpm-menu-show
+                                 THEN
+                             THEN
+                         ENDOF
+                [char] p OF  tpm-get-state
+                             \ The TPM must be enabled and active to allow
+                             \ owner installation mods
+                             dup vtpm-enabled-active IF
+                                 TPM_ST_OWNERINSTALL AND TPM_ST_OWNERINSTALL = IF
+                                     0 PPI_OP_SETOWNERINSTALL_FALSE vtpm-process-opcode
+                                     vtpm-menu-show
+                                 THEN
+                             THEN
+                         ENDOF
+                1b OF UNLOOP EXIT ENDOF
+                ENDCASE
+            LOOP
+        THEN
+    THEN
+;
-- 
1.9.3
