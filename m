Date: Sat, 3 Feb 2001 13:48:39 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: PATCH: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010203134838.A1365@allspice.cs.swarthmore.edu>
References: <20010130165710.B22219@allspice.cs.swarthmore.edu> <B69DFE88.9197%bootc@worldnet.fr> <20010201115015.A11149@allspice.cs.swarthmore.edu> <20010202023834.A17159@allspice.cs.swarthmore.edu> <14971.34502.222006.311092@diego.linuxcare.com.au> <20010203111427.B15855@allspice.cs.swarthmore.edu> <20010203112705.A19223@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
In-Reply-To: <20010203112705.A19223@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sat, Feb 03, 2001 at 11:27:05AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 03, 2001 at 11:27:05AM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
> On Sat, Feb 03, 2001 at 11:14:27AM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
> > On Sat, Feb 03, 2001 at 03:19:18PM +1100, Paul Mackerras <paulus@linuxcare.com.au> wrote:
> [...]
> > > Well, it could be declared in scsi.h but the actual table of values
> > > should go in a .c file.
> >
> > My current patch has a static function in the new file scsi_dataout.h,
> > which is included by all the drivers in question.   But I agree that it
> > would be cleaner to declare the function in scsi.h, change
> > scsi_dataout.h to scsi_dataout.c, make the function no longer static,
> > and tell make about the dependencies.  I'll do that.
>
> The advantage of my current approach is that there are two SCSI drivers
> (for acorn and i2o) that use copies of this table but that live outside
> of drivers/scsi.  They already include scsi.h, and it's easy to make
> them include scsi_dataout.h.  For the files inside drivers/scsi, it's
> easy to see how to make them depend on scsi_dataout.o, but it's not
> obvious to me how it should work for files that live elsewhere.  Am I
> missing something obvious?

Here's the patch aginst the 2.4 bitkeeper tree.  The only hunk that
should fail against 2.2, though, is the include/scsi/scsi.h one, which
is trivial to fix.  Please let me know if it would be better either to
put the function I've addeed in a .c file instead, or to just change all
the different drivers' tables directly.

Meanwhile, I'll start trying to get a clue about the SCSI layer's abort
handling.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=scsi-patch-2_4

diff -durpN linuxppc_2_4/drivers/acorn/scsi/acornscsi.c linuxppc_2_4-scsifix/drivers/acorn/scsi/acornscsi.c
--- linuxppc_2_4/drivers/acorn/scsi/acornscsi.c	Fri Jan 12 16:57:57 2001
+++ linuxppc_2_4-scsifix/drivers/acorn/scsi/acornscsi.c	Sat Feb  3 12:02:04 2001
@@ -152,6 +152,7 @@
 #include <asm/ecard.h>

 #include "../../scsi/scsi.h"
+#include "../../scsi/scsi_dataout.h"
 #include "../../scsi/hosts.h"
 #include "../../scsi/constants.h"
 #include "acornscsi.h"
@@ -600,34 +601,6 @@ cmdtype_t acornscsi_cmdtype(int command)
 }

 /*
- * Prototype: int acornscsi_datadirection(int command)
- * Purpose  : differentiate between commands that have a DATA IN phase
- *	      and a DATA OUT phase
- * Params   : command - command to interpret
- * Returns  : DATADIR_OUT - data out phase expected
- *	      DATADIR_IN  - data in phase expected
- */
-static
-datadir_t acornscsi_datadirection(int command)
-{
-    switch (command) {
-    case CHANGE_DEFINITION:	case COMPARE:		case COPY:
-    case COPY_VERIFY:		case LOG_SELECT:	case MODE_SELECT:
-    case MODE_SELECT_10:	case SEND_DIAGNOSTIC:	case WRITE_BUFFER:
-    case FORMAT_UNIT:		case REASSIGN_BLOCKS:	case RESERVE:
-    case SEARCH_EQUAL:		case SEARCH_HIGH:	case SEARCH_LOW:
-    case WRITE_6:		case WRITE_10:		case WRITE_VERIFY:
-    case UPDATE_BLOCK:		case WRITE_LONG:	case WRITE_SAME:
-    case SEARCH_HIGH_12:	case SEARCH_EQUAL_12:	case SEARCH_LOW_12:
-    case WRITE_12:		case WRITE_VERIFY_12:	case SET_WINDOW:
-    case MEDIUM_SCAN:		case SEND_VOLUME_TAG:	case 0xea:
-	return DATADIR_OUT;
-    default:
-	return DATADIR_IN;
-    }
-}
-
-/*
  * Purpose  : provide values for synchronous transfers with 33C93.
  * Copyright: Copyright (c) 1996 John Shifflett, GeoLog Consulting
  *	Modified by Russell King for 8MHz WD33C93A
@@ -2552,7 +2525,7 @@ int acornscsi_queuecmd(Scsi_Cmnd *SCpnt,
     SCpnt->host_scribble = NULL;
     SCpnt->result = 0;
     SCpnt->tag = 0;
-    SCpnt->SCp.phase = (int)acornscsi_datadirection(SCpnt->cmnd[0]);
+    SCpnt->SCp.phase = Scsi_data_goes_out(SCpnt);
     SCpnt->SCp.sent_command = 0;
     SCpnt->SCp.scsi_xferred = 0;
     SCpnt->SCp.Status = 0;
diff -durpN linuxppc_2_4/drivers/acorn/scsi/acornscsi.h linuxppc_2_4-scsifix/drivers/acorn/scsi/acornscsi.h
--- linuxppc_2_4/drivers/acorn/scsi/acornscsi.h	Fri Jan 12 16:57:57 2001
+++ linuxppc_2_4-scsifix/drivers/acorn/scsi/acornscsi.h	Fri Feb  2 18:36:48 2001
@@ -288,14 +288,6 @@ typedef enum {					/* command type				*/
     CMD_MISC,					/* Others				*/
 } cmdtype_t;

-/*
- * Data phase direction
- */
-typedef enum {					/* Data direction			*/
-    DATADIR_IN,					/* Data in phase expected		*/
-    DATADIR_OUT					/* Data out phase expected		*/
-} datadir_t;
-
 #include "queue.h"
 #include "msgqueue.h"

diff -durpN linuxppc_2_4/drivers/i2o/i2o_scsi.c linuxppc_2_4-scsifix/drivers/i2o/i2o_scsi.c
--- linuxppc_2_4/drivers/i2o/i2o_scsi.c	Fri Jan 12 16:58:05 2001
+++ linuxppc_2_4-scsifix/drivers/i2o/i2o_scsi.c	Fri Feb  2 18:36:48 2001
@@ -49,6 +49,7 @@
 #include <linux/version.h>
 #include <linux/i2o.h>
 #include "../scsi/scsi.h"
+#include "../scsi/scsi_dataout.h"
 #include "../scsi/hosts.h"
 #include "../scsi/sd.h"
 #include "i2o_scsi.h"
@@ -494,35 +495,6 @@ const char *i2o_scsi_info(struct Scsi_Ho
 	return(&hostdata->controller->name[0]);
 }

-
-/*
- * From the wd93 driver:
- * Returns true if there will be a DATA_OUT phase with this command,
- * false otherwise.
- * (Thanks to Joerg Dorchain for the research and suggestion.)
- *
- */
-static int is_dir_out(Scsi_Cmnd *cmd)
-{
-	switch (cmd->cmnd[0])
-	{
-     		case WRITE_6:           case WRITE_10:          case WRITE_12:
-      		case WRITE_LONG:        case WRITE_SAME:        case WRITE_BUFFER:
-      		case WRITE_VERIFY:      case WRITE_VERIFY_12:
-      		case COMPARE:           case COPY:              case COPY_VERIFY:
-      		case SEARCH_EQUAL:      case SEARCH_HIGH:       case SEARCH_LOW:
-      		case SEARCH_EQUAL_12:   case SEARCH_HIGH_12:    case SEARCH_LOW_12:
-      		case FORMAT_UNIT:       case REASSIGN_BLOCKS:   case RESERVE:
-      		case MODE_SELECT:       case MODE_SELECT_10:    case LOG_SELECT:
-      		case SEND_DIAGNOSTIC:   case CHANGE_DEFINITION: case UPDATE_BLOCK:
-      		case SET_WINDOW:        case MEDIUM_SCAN:       case SEND_VOLUME_TAG:
-      		case 0xea:
-        		return 1;
-		default:
-        		return 0;
-	}
-}
-
 int i2o_scsi_queuecommand(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
 	int i;
@@ -604,7 +576,7 @@ int i2o_scsi_queuecommand(Scsi_Cmnd * SC
 	scsidir = 0x00000000;			// DATA NO XFER
 	if(len)
 	{
-		if(is_dir_out(SCpnt))
+		if(Scsi_data_goes_out(SCpnt))
 		{
 			direction=0x04000000;	// SGL OUT  (osm-->iop)
 			scsidir  =0x80000000;	// DATA OUT (iop-->dev)
diff -durpN linuxppc_2_4/drivers/scsi/eata_dma.c linuxppc_2_4-scsifix/drivers/scsi/eata_dma.c
--- linuxppc_2_4/drivers/scsi/eata_dma.c	Fri Jan 12 16:58:28 2001
+++ linuxppc_2_4-scsifix/drivers/scsi/eata_dma.c	Fri Feb  2 18:36:48 2001
@@ -84,6 +84,7 @@
 #endif
 #include <linux/blk.h>
 #include "scsi.h"
+#include "scsi_dataout.h"
 #include "sd.h"
 #include "hosts.h"
 #include "eata_dma.h"
@@ -522,24 +523,10 @@ int eata_queue(Scsi_Cmnd * cmd, void (*

     cmd->scsi_done = (void *)done;

-    switch (cmd->cmnd[0]) {
-    case CHANGE_DEFINITION: case COMPARE:	  case COPY:
-    case COPY_VERIFY:	    case LOG_SELECT:	  case MODE_SELECT:
-    case MODE_SELECT_10:    case SEND_DIAGNOSTIC: case WRITE_BUFFER:
-    case FORMAT_UNIT:	    case REASSIGN_BLOCKS: case RESERVE:
-    case SEARCH_EQUAL:	    case SEARCH_HIGH:	  case SEARCH_LOW:
-    case WRITE_6:	    case WRITE_10:	  case WRITE_VERIFY:
-    case UPDATE_BLOCK:	    case WRITE_LONG:	  case WRITE_SAME:
-    case SEARCH_HIGH_12:    case SEARCH_EQUAL_12: case SEARCH_LOW_12:
-    case WRITE_12:	    case WRITE_VERIFY_12: case SET_WINDOW:
-    case MEDIUM_SCAN:	    case SEND_VOLUME_TAG:
-    case 0xea:	    /* alternate number for WRITE LONG */
+    if (Scsi_data_goes_out(cmd))
 	ccb->DataOut = TRUE;	/* Output mode */
-	break;
-    case TEST_UNIT_READY:
-    default:
+    else
 	ccb->DataIn = TRUE;	/* Input mode  */
-    }

     /* FIXME: This will will have to be changed once the midlevel driver
      *        allows different HBA IDs on every channel.
diff -durpN linuxppc_2_4/drivers/scsi/eata_pio.c linuxppc_2_4-scsifix/drivers/scsi/eata_pio.c
--- linuxppc_2_4/drivers/scsi/eata_pio.c	Fri Jan 12 16:58:28 2001
+++ linuxppc_2_4-scsifix/drivers/scsi/eata_pio.c	Fri Feb  2 18:36:48 2001
@@ -50,7 +50,7 @@
 #include <asm/io.h>
 #include "eata_pio.h"
 #include "eata_dma_proc.h"
-#include "scsi.h"
+#include "scsi_dataout.h"
 #include "sd.h"

 #include <linux/stat.h>
@@ -325,24 +325,10 @@ int eata_pio_queue(Scsi_Cmnd * cmd, void

     cmd->scsi_done = (void *)done;

-    switch (cmd->cmnd[0]) {
-    case CHANGE_DEFINITION: case COMPARE:         case COPY:
-    case COPY_VERIFY:       case LOG_SELECT:      case MODE_SELECT:
-    case MODE_SELECT_10:    case SEND_DIAGNOSTIC: case WRITE_BUFFER:
-    case FORMAT_UNIT:       case REASSIGN_BLOCKS: case RESERVE:
-    case SEARCH_EQUAL:      case SEARCH_HIGH:     case SEARCH_LOW:
-    case WRITE_6:           case WRITE_10:        case WRITE_VERIFY:
-    case UPDATE_BLOCK:      case WRITE_LONG:      case WRITE_SAME:
-    case SEARCH_HIGH_12:    case SEARCH_EQUAL_12: case SEARCH_LOW_12:
-    case WRITE_12:          case WRITE_VERIFY_12: case SET_WINDOW:
-    case MEDIUM_SCAN:       case SEND_VOLUME_TAG:
-    case 0xea:      /* alternate number for WRITE LONG */
+    if (Scsi_data_goes_out(cmd))
 	cp->DataOut = TRUE; /* Output mode */
-	break;
-    case TEST_UNIT_READY:
-    default:
+    else
 	cp->DataIn = TRUE;  /* Input mode  */
-    }

     cp->Interpret = (cmd->target == hd->hostid);
     cp->cp_datalen = htonl((ulong)cmd->request_bufflen);
diff -durpN linuxppc_2_4/drivers/scsi/in2000.c linuxppc_2_4-scsifix/drivers/scsi/in2000.c
--- linuxppc_2_4/drivers/scsi/in2000.c	Thu Jan 25 02:58:36 2001
+++ linuxppc_2_4-scsifix/drivers/scsi/in2000.c	Fri Feb  2 18:36:48 2001
@@ -119,6 +119,7 @@
 #include <linux/stat.h>

 #include "scsi.h"
+#include "scsi_dataout.h"
 #include "sd.h"
 #include "hosts.h"

@@ -251,34 +252,6 @@ unsigned long value;
    return value;
 }

-
-/* The 33c93 needs to be told which direction a command transfers its
- * data; we use this function to figure it out. Returns true if there
- * will be a DATA_OUT phase with this command, false otherwise.
- * (Thanks to Joerg Dorchain for the research and suggestion.)
- */
-static int is_dir_out(Scsi_Cmnd *cmd)
-{
-   switch (cmd->cmnd[0]) {
-      case WRITE_6:           case WRITE_10:          case WRITE_12:
-      case WRITE_LONG:        case WRITE_SAME:        case WRITE_BUFFER:
-      case WRITE_VERIFY:      case WRITE_VERIFY_12:
-      case COMPARE:           case COPY:              case COPY_VERIFY:
-      case SEARCH_EQUAL:      case SEARCH_HIGH:       case SEARCH_LOW:
-      case SEARCH_EQUAL_12:   case SEARCH_HIGH_12:    case SEARCH_LOW_12:
-      case FORMAT_UNIT:       case REASSIGN_BLOCKS:   case RESERVE:
-      case MODE_SELECT:       case MODE_SELECT_10:    case LOG_SELECT:
-      case SEND_DIAGNOSTIC:   case CHANGE_DEFINITION: case UPDATE_BLOCK:
-      case SET_WINDOW:        case MEDIUM_SCAN:       case SEND_VOLUME_TAG:
-      case 0xea:
-         return 1;
-      default:
-         return 0;
-      }
-}
-
-
-
 static struct sx_period sx_table[] = {
    {  1, 0x20},
    {252, 0x20},
@@ -492,7 +465,7 @@ DB(DB_EXECUTE,printk(")EX-1 "))
  * Start the selection process
  */

-   if (is_dir_out(cmd))
+   if (Scsi_data_goes_out(cmd))
       write_3393(hostdata,WD_DESTINATION_ID, cmd->target);
    else
       write_3393(hostdata,WD_DESTINATION_ID, cmd->target | DSTID_DPD);
@@ -642,7 +615,7 @@ no:
          write_3393(hostdata,WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_BUS);
          write1_io(0, IO_FIFO_WRITE);  /* clear fifo counter, write mode */

-         if (is_dir_out(cmd)) {
+         if (Scsi_data_goes_out(cmd)) {
             hostdata->fifo = FI_FIFO_WRITING;
             if ((i = cmd->SCp.this_residual) > (IN2000_FIFO_SIZE - 16) )
                i = IN2000_FIFO_SIZE - 16;
@@ -1584,7 +1557,7 @@ DB(DB_INTR,printk("RESEL"))
     * But we DO need to fix the DPD bit so it's correct for this command.
     */

-         if (is_dir_out(cmd))
+         if (Scsi_data_goes_out(cmd))
             write_3393(hostdata,WD_DESTINATION_ID,cmd->target);
          else
             write_3393(hostdata,WD_DESTINATION_ID,cmd->target | DSTID_DPD);
diff -durpN linuxppc_2_4/drivers/scsi/mac53c94.c linuxppc_2_4-scsifix/drivers/scsi/mac53c94.c
--- linuxppc_2_4/drivers/scsi/mac53c94.c	Thu Jan 25 02:58:36 2001
+++ linuxppc_2_4-scsifix/drivers/scsi/mac53c94.c	Fri Feb  2 18:36:48 2001
@@ -23,6 +23,7 @@
 #include <asm/system.h>

 #include "scsi.h"
+#include "scsi_dataout.h"
 #include "hosts.h"
 #include "mac53c94.h"

@@ -58,7 +59,6 @@ static void mac53c94_interrupt(int, void
 static void do_mac53c94_interrupt(int, void *, struct pt_regs *);
 static void cmd_done(struct fsc_state *, int result);
 static void set_dma_cmds(struct fsc_state *, Scsi_Cmnd *);
-static int data_goes_out(Scsi_Cmnd *);

 int
 mac53c94_detect(Scsi_Host_Template *tp)
@@ -154,7 +154,7 @@ mac53c94_queue(Scsi_Cmnd *cmd, void (*do
 	struct fsc_state *state;

 #if 0
-	if (data_goes_out(cmd)) {
+	if (Scsi_data_goes_out(cmd)) {
 		int i;
 		printk(KERN_DEBUG "mac53c94_queue %p: command is", cmd);
 		for (i = 0; i < cmd->cmd_len; ++i)
@@ -480,7 +480,7 @@ set_dma_cmds(struct fsc_state *state, Sc
 	struct scatterlist *scl;
 	struct dbdma_cmd *dcmds;

-	dma_cmd = data_goes_out(cmd)? OUTPUT_MORE: INPUT_MORE;
+	dma_cmd = Scsi_data_goes_out(cmd)? OUTPUT_MORE: INPUT_MORE;
 	dcmds = state->dma_cmds;
 	if (cmd->use_sg > 0) {
 		total = 0;
@@ -509,51 +509,6 @@ set_dma_cmds(struct fsc_state *state, Sc
 	st_le16(&dcmds[-1].command, dma_cmd);
 	st_le16(&dcmds->command, DBDMA_STOP);
 	cmd->SCp.this_residual = total;
-}
-
-/*
- * Work out whether data will be going out from the host adaptor or into it.
- * (If this information is available from somewhere else in the scsi
- * code, somebody please let me know :-)
- */
-static int
-data_goes_out(Scsi_Cmnd *cmd)
-{
-	switch (cmd->cmnd[0]) {
-	case CHANGE_DEFINITION:
-	case COMPARE:
-	case COPY:
-	case COPY_VERIFY:
-	case FORMAT_UNIT:
-	case LOG_SELECT:
-	case MEDIUM_SCAN:
-	case MODE_SELECT:
-	case MODE_SELECT_10:
-	case REASSIGN_BLOCKS:
-	case RESERVE:
-	case SEARCH_EQUAL:
-	case SEARCH_EQUAL_12:
-	case SEARCH_HIGH:
-	case SEARCH_HIGH_12:
-	case SEARCH_LOW:
-	case SEARCH_LOW_12:
-	case SEND_DIAGNOSTIC:
-	case SEND_VOLUME_TAG:
-	case SET_WINDOW:
-	case UPDATE_BLOCK:
-	case WRITE_BUFFER:
- 	case WRITE_6:
-	case WRITE_10:
-	case WRITE_12:
-	case WRITE_LONG:
-	case WRITE_LONG_2:      /* alternate code for WRITE_LONG */
-	case WRITE_SAME:
-	case WRITE_VERIFY:
-	case WRITE_VERIFY_12:
-		return 1;
-	default:
-		return 0;
-	}
 }

 static Scsi_Host_Template driver_template = SCSI_MAC53C94;
diff -durpN linuxppc_2_4/drivers/scsi/mesh.c linuxppc_2_4-scsifix/drivers/scsi/mesh.c
--- linuxppc_2_4/drivers/scsi/mesh.c	Fri Jan 12 16:58:29 2001
+++ linuxppc_2_4-scsifix/drivers/scsi/mesh.c	Fri Feb  2 18:36:48 2001
@@ -31,6 +31,7 @@
 #include <asm/feature.h>

 #include "scsi.h"
+#include "scsi_dataout.h"
 #include "hosts.h"
 #include "mesh.h"

@@ -208,7 +209,6 @@ static void mesh_done(struct mesh_state
 static void mesh_completed(struct mesh_state *, Scsi_Cmnd *);
 static void set_dma_cmds(struct mesh_state *, Scsi_Cmnd *);
 static void halt_dma(struct mesh_state *);
-static int data_goes_out(Scsi_Cmnd *);
 static void do_abort(struct mesh_state *ms);

 static struct notifier_block mesh_notifier = {
@@ -565,7 +565,7 @@ mesh_start_cmd(struct mesh_state *ms, Sc
 	int t;

 	ms->current_req = cmd;
-	ms->tgts[cmd->target].data_goes_out = data_goes_out(cmd);
+	ms->tgts[cmd->target].data_goes_out = Scsi_data_goes_out(cmd);
 	ms->tgts[cmd->target].current_req = cmd;

 #if 1
@@ -1794,51 +1794,6 @@ halt_dma(struct mesh_state *ms)
 		       ms->tgts[ms->conn_tgt].data_goes_out);
 	}
 	ms->dma_started = 0;
-}
-
-/*
- * Work out whether we expect data to go out from the host adaptor or into it.
- * (If this information is available from somewhere else in the scsi
- * code, somebody please let me know :-)
- */
-static int
-data_goes_out(Scsi_Cmnd *cmd)
-{
-	switch (cmd->cmnd[0]) {
-	case CHANGE_DEFINITION:
-	case COMPARE:
-	case COPY:
-	case COPY_VERIFY:
-	case FORMAT_UNIT:
-	case LOG_SELECT:
-	case MEDIUM_SCAN:
-	case MODE_SELECT:
-	case MODE_SELECT_10:
-	case REASSIGN_BLOCKS:
-	case RESERVE:
-	case SEARCH_EQUAL:
-	case SEARCH_EQUAL_12:
-	case SEARCH_HIGH:
-	case SEARCH_HIGH_12:
-	case SEARCH_LOW:
-	case SEARCH_LOW_12:
-	case SEND_DIAGNOSTIC:
-	case SEND_VOLUME_TAG:
-	case SET_WINDOW:
-	case UPDATE_BLOCK:
-	case WRITE_BUFFER:
- 	case WRITE_6:
-	case WRITE_10:
-	case WRITE_12:
-	case WRITE_LONG:
-	case WRITE_LONG_2:      /* alternate code for WRITE_LONG */
-	case WRITE_SAME:
-	case WRITE_VERIFY:
-	case WRITE_VERIFY_12:
-		return 1;
-	default:
-		return 0;
-	}
 }

 #ifdef MESH_DBG
diff -durpN linuxppc_2_4/drivers/scsi/scsi_dataout.h linuxppc_2_4-scsifix/drivers/scsi/scsi_dataout.h
--- linuxppc_2_4/drivers/scsi/scsi_dataout.h	Wed Dec 31 19:00:00 1969
+++ linuxppc_2_4-scsifix/drivers/scsi/scsi_dataout.h	Fri Feb  2 18:36:48 2001
@@ -0,0 +1,49 @@
+/*
+ * This was copied from mesh.c to keep us from needing six copies of it in
+ * different drivers.  SEND_CUE_SHEET was added to make burning CD-Rs in DAO
+ * mode work with these drivers.
+ *
+ * Work out whether data will be going out from the host adaptor or into it.
+ * (If this information is available from somewhere else in the scsi
+ * code, somebody please let me know :-)
+ */
+static int
+Scsi_data_goes_out(Scsi_Cmnd *cmd)
+{
+	switch (cmd->cmnd[0]) {
+	case CHANGE_DEFINITION:
+	case COMPARE:
+	case COPY:
+	case COPY_VERIFY:
+	case FORMAT_UNIT:
+	case LOG_SELECT:
+	case MEDIUM_SCAN:
+	case MODE_SELECT:
+	case MODE_SELECT_10:
+	case REASSIGN_BLOCKS:
+	case RESERVE:
+	case SEARCH_EQUAL:
+	case SEARCH_EQUAL_12:
+	case SEARCH_HIGH:
+	case SEARCH_HIGH_12:
+	case SEARCH_LOW:
+	case SEARCH_LOW_12:
+	case SEND_CUE_SHEET:
+	case SEND_DIAGNOSTIC:
+	case SEND_VOLUME_TAG:
+	case SET_WINDOW:
+	case UPDATE_BLOCK:
+	case WRITE_BUFFER:
+ 	case WRITE_6:
+	case WRITE_10:
+	case WRITE_12:
+	case WRITE_LONG:
+	case WRITE_LONG_2:      /* alternate code for WRITE_LONG */
+	case WRITE_SAME:
+	case WRITE_VERIFY:
+	case WRITE_VERIFY_12:
+		return 1;
+	default:
+		return 0;
+	}
+}
diff -durpN linuxppc_2_4/drivers/scsi/wd33c93.c linuxppc_2_4-scsifix/drivers/scsi/wd33c93.c
--- linuxppc_2_4/drivers/scsi/wd33c93.c	Fri Jan 12 16:58:34 2001
+++ linuxppc_2_4-scsifix/drivers/scsi/wd33c93.c	Fri Feb  2 18:36:48 2001
@@ -86,6 +86,7 @@
 #include <linux/blk.h>

 #include "scsi.h"
+#include "scsi_dataout.h"
 #include "hosts.h"


@@ -244,34 +245,6 @@ unsigned long value;
    return value;
 }

-
-/* The 33c93 needs to be told which direction a command transfers its
- * data; we use this function to figure it out. Returns true if there
- * will be a DATA_OUT phase with this command, false otherwise.
- * (Thanks to Joerg Dorchain for the research and suggestion.)
- */
-static int is_dir_out(Scsi_Cmnd *cmd)
-{
-   switch (cmd->cmnd[0]) {
-      case WRITE_6:           case WRITE_10:          case WRITE_12:
-      case WRITE_LONG:        case WRITE_SAME:        case WRITE_BUFFER:
-      case WRITE_VERIFY:      case WRITE_VERIFY_12:
-      case COMPARE:           case COPY:              case COPY_VERIFY:
-      case SEARCH_EQUAL:      case SEARCH_HIGH:       case SEARCH_LOW:
-      case SEARCH_EQUAL_12:   case SEARCH_HIGH_12:    case SEARCH_LOW_12:
-      case FORMAT_UNIT:       case REASSIGN_BLOCKS:   case RESERVE:
-      case MODE_SELECT:       case MODE_SELECT_10:    case LOG_SELECT:
-      case SEND_DIAGNOSTIC:   case CHANGE_DEFINITION: case UPDATE_BLOCK:
-      case SET_WINDOW:        case MEDIUM_SCAN:       case SEND_VOLUME_TAG:
-      case 0xea:
-         return 1;
-      default:
-         return 0;
-      }
-}
-
-
-
 static struct sx_period sx_table[] = {
    {  1, 0x20},
    {252, 0x20},
@@ -478,7 +451,7 @@ DB(DB_EXECUTE,printk(")EX-1 "))
     * Start the selection process
     */

-   if (is_dir_out(cmd))
+   if (Scsi_data_goes_out(cmd))
       write_wd33c93(regp, WD_DESTINATION_ID, cmd->target);
    else
       write_wd33c93(regp, WD_DESTINATION_ID, cmd->target | DSTID_DPD);
@@ -611,7 +584,7 @@ no:

       if ((cmd->SCp.phase == 0) && (hostdata->no_dma == 0)) {
          if (hostdata->dma_setup(cmd,
-                     (is_dir_out(cmd))?DATA_OUT_DIR:DATA_IN_DIR))
+                     (Scsi_data_goes_out(cmd))?DATA_OUT_DIR:DATA_IN_DIR))
             write_wd33c93_count(regp,0); /* guarantee a DATA_PHASE interrupt */
          else {
             write_wd33c93_count(regp, cmd->SCp.this_residual);
@@ -1385,7 +1358,7 @@ DB(DB_INTR,printk("RESEL%s", sr == CSR_R
     * But we DO need to fix the DPD bit so it's correct for this command.
     */

-         if (is_dir_out(cmd))
+         if (Scsi_data_goes_out(cmd))
             write_wd33c93(regp, WD_DESTINATION_ID, cmd->target);
          else
             write_wd33c93(regp, WD_DESTINATION_ID, cmd->target | DSTID_DPD);
diff -durpN linuxppc_2_4/include/scsi/scsi.h linuxppc_2_4-scsifix/include/scsi/scsi.h
--- linuxppc_2_4/include/scsi/scsi.h	Fri Jan 12 16:59:00 2001
+++ linuxppc_2_4-scsifix/include/scsi/scsi.h	Fri Feb  2 18:39:50 2001
@@ -76,6 +76,7 @@
 #define RESERVE_10            0x56
 #define RELEASE_10            0x57
 #define MODE_SENSE_10         0x5a
+#define SEND_CUE_SHEET	      0x5d
 #define PERSISTENT_RESERVE_IN 0x5e
 #define PERSISTENT_RESERVE_OUT 0x5f
 #define MOVE_MEDIUM           0xa5

--ew6BAiZeqk4r7MaW--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
