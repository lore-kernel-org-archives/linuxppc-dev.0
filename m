Return-Path: <anton@samba.org>
Date: Thu, 22 Mar 2012 12:47:07 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/6] powerpc: Make function that parses RTAS error logs global
Message-ID: <20120322124707.3cd3037f@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The IO event interrupt code has a function that finds specific
sections in an RTAS error log. We want to use it in the EPOW
code so make it global.

Rename things to make it less cryptic:

find_xelog_section() -> get_pseries_errorlog()
struct pseries_elog_section -> struct pseries_errorlog

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/rtas.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/rtas.h	2012-03-22 11:46:57.408187770 +1100
+++ linux-build/arch/powerpc/include/asm/rtas.h	2012-03-22 11:48:25.221771962 +1100
@@ -204,6 +203,39 @@ struct rtas_ext_event_log_v6 {
 					/* Variable length.		*/
 };
 
+/* pSeries event log format */
+
+/* Two bytes ASCII section IDs */
+#define PSERIES_ELOG_SECT_ID_PRIV_HDR		(('P' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_USER_HDR		(('U' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_PRIMARY_SRC	(('P' << 8) | 'S')
+#define PSERIES_ELOG_SECT_ID_EXTENDED_UH	(('E' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_FAILING_MTMS	(('M' << 8) | 'T')
+#define PSERIES_ELOG_SECT_ID_SECONDARY_SRC	(('S' << 8) | 'S')
+#define PSERIES_ELOG_SECT_ID_DUMP_LOCATOR	(('D' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_FW_ERROR		(('S' << 8) | 'W')
+#define PSERIES_ELOG_SECT_ID_IMPACT_PART_ID	(('L' << 8) | 'P')
+#define PSERIES_ELOG_SECT_ID_LOGIC_RESOURCE_ID	(('L' << 8) | 'R')
+#define PSERIES_ELOG_SECT_ID_HMC_ID		(('H' << 8) | 'M')
+#define PSERIES_ELOG_SECT_ID_EPOW		(('E' << 8) | 'P')
+#define PSERIES_ELOG_SECT_ID_IO_EVENT		(('I' << 8) | 'E')
+#define PSERIES_ELOG_SECT_ID_MANUFACT_INFO	(('M' << 8) | 'I')
+#define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
+
+/* Vendor specific Platform Event Log Format, Version 6, section header */
+struct pseries_errorlog {
+	uint16_t id;			/* 0x00 2-byte ASCII section ID	*/
+	uint16_t length;		/* 0x02 Section length in bytes	*/
+	uint8_t version;		/* 0x04 Section version		*/
+	uint8_t subtype;		/* 0x05 Section subtype		*/
+	uint16_t creator_component;	/* 0x06 Creator component ID	*/
+	uint8_t data[];			/* 0x08 Start of section data	*/
+};
+
+struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
+					      uint16_t section_id);
+
 /*
  * This can be set by the rtas_flash module so that it can get called
  * as the absolutely last thing before the kernel terminates.
Index: linux-build/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/rtas.c	2012-03-22 11:46:57.424188057 +1100
+++ linux-build/arch/powerpc/kernel/rtas.c	2012-03-22 11:48:25.221771962 +1100
@@ -868,6 +868,40 @@ int rtas_ibm_suspend_me(struct rtas_args
 }
 #endif
 
+/**
+ * Find a specific pseries error log in an RTAS extended event log.
+ * @log: RTAS error/event log
+ * @section_id: two character section identifier
+ *
+ * Returns a pointer to the specified errorlog or NULL if not found.
+ */
+struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
+					      uint16_t section_id)
+{
+	struct rtas_ext_event_log_v6 *ext_log =
+		(struct rtas_ext_event_log_v6 *)log->buffer;
+	struct pseries_errorlog *sect;
+	unsigned char *p, *log_end;
+
+	/* Check that we understand the format */
+	if (log->extended_log_length < sizeof(struct rtas_ext_event_log_v6) ||
+	    ext_log->log_format != RTAS_V6EXT_LOG_FORMAT_EVENT_LOG ||
+	    ext_log->company_id != RTAS_V6EXT_COMPANY_ID_IBM)
+		return NULL;
+
+	log_end = log->buffer + log->extended_log_length;
+	p = ext_log->vendor_log;
+
+	while (p < log_end) {
+		sect = (struct pseries_errorlog *)p;
+		if (sect->id == section_id)
+			return sect;
+		p += sect->length;
+	}
+
+	return NULL;
+}
+
 asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 {
 	struct rtas_args args;
Index: linux-build/arch/powerpc/platforms/pseries/io_event_irq.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/io_event_irq.c	2012-03-22 11:46:57.444188419 +1100
+++ linux-build/arch/powerpc/platforms/pseries/io_event_irq.c	2012-03-22 11:48:25.221771962 +1100
@@ -63,73 +63,9 @@ EXPORT_SYMBOL_GPL(pseries_ioei_notifier_
 
 static int ioei_check_exception_token;
 
-/* pSeries event log format */
-
-/* Two bytes ASCII section IDs */
-#define PSERIES_ELOG_SECT_ID_PRIV_HDR		(('P' << 8) | 'H')
-#define PSERIES_ELOG_SECT_ID_USER_HDR		(('U' << 8) | 'H')
-#define PSERIES_ELOG_SECT_ID_PRIMARY_SRC	(('P' << 8) | 'S')
-#define PSERIES_ELOG_SECT_ID_EXTENDED_UH	(('E' << 8) | 'H')
-#define PSERIES_ELOG_SECT_ID_FAILING_MTMS	(('M' << 8) | 'T')
-#define PSERIES_ELOG_SECT_ID_SECONDARY_SRC	(('S' << 8) | 'S')
-#define PSERIES_ELOG_SECT_ID_DUMP_LOCATOR	(('D' << 8) | 'H')
-#define PSERIES_ELOG_SECT_ID_FW_ERROR		(('S' << 8) | 'W')
-#define PSERIES_ELOG_SECT_ID_IMPACT_PART_ID	(('L' << 8) | 'P')
-#define PSERIES_ELOG_SECT_ID_LOGIC_RESOURCE_ID	(('L' << 8) | 'R')
-#define PSERIES_ELOG_SECT_ID_HMC_ID		(('H' << 8) | 'M')
-#define PSERIES_ELOG_SECT_ID_EPOW		(('E' << 8) | 'P')
-#define PSERIES_ELOG_SECT_ID_IO_EVENT		(('I' << 8) | 'E')
-#define PSERIES_ELOG_SECT_ID_MANUFACT_INFO	(('M' << 8) | 'I')
-#define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
-#define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
-
-/* Vendor specific Platform Event Log Format, Version 6, section header */
-struct pseries_elog_section {
-	uint16_t id;			/* 0x00 2-byte ASCII section ID	*/
-	uint16_t length;		/* 0x02 Section length in bytes	*/
-	uint8_t version;		/* 0x04 Section version		*/
-	uint8_t subtype;		/* 0x05 Section subtype		*/
-	uint16_t creator_component;	/* 0x06 Creator component ID	*/
-	uint8_t data[];			/* 0x08 Start of section data	*/
-};
-
 static char ioei_rtas_buf[RTAS_DATA_BUF_SIZE] __cacheline_aligned;
 
 /**
- * Find data portion of a specific section in RTAS extended event log.
- * @elog: RTAS error/event log.
- * @sect_id: secsion ID.
- *
- * Return:
- *	pointer to the section data of the specified section
- *	NULL if not found
- */
-static struct pseries_elog_section *find_xelog_section(struct rtas_error_log *elog,
-						       uint16_t sect_id)
-{
-	struct rtas_ext_event_log_v6 *xelog =
-		(struct rtas_ext_event_log_v6 *) elog->buffer;
-	struct pseries_elog_section *sect;
-	unsigned char *p, *log_end;
-
-	/* Check that we understand the format */
-	if (elog->extended_log_length < sizeof(struct rtas_ext_event_log_v6) ||
-	    xelog->log_format != RTAS_V6EXT_LOG_FORMAT_EVENT_LOG ||
-	    xelog->company_id != RTAS_V6EXT_COMPANY_ID_IBM)
-		return NULL;
-
-	log_end = elog->buffer + elog->extended_log_length;
-	p = xelog->vendor_log;
-	while (p < log_end) {
-		sect = (struct pseries_elog_section *)p;
-		if (sect->id == sect_id)
-			return sect;
-		p += sect->length;
-	}
-	return NULL;
-}
-
-/**
  * Find the data portion of an IO Event section from event log.
  * @elog: RTAS error/event log.
  *
@@ -138,7 +74,7 @@ static struct pseries_elog_section *find
  */
 static struct pseries_io_event * ioei_find_event(struct rtas_error_log *elog)
 {
-	struct pseries_elog_section *sect;
+	struct pseries_errorlog *sect;
 
 	/* We should only ever get called for io-event interrupts, but if
 	 * we do get called for another type then something went wrong so
@@ -152,7 +88,7 @@ static struct pseries_io_event * ioei_fi
 		return NULL;
 	}
 
-	sect = find_xelog_section(elog, PSERIES_ELOG_SECT_ID_IO_EVENT);
+	sect = get_pseries_errorlog(elog, PSERIES_ELOG_SECT_ID_IO_EVENT);
 	if (unlikely(!sect)) {
 		printk_once(KERN_WARNING "io_event_irq: RTAS extended event "
 			    "log does not contain an IO Event section. "
