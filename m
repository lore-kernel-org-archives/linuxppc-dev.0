Date: Thu, 18 Mar 1999 21:50:08 +1100
Message-Id: <199903181050.VAA22904@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: dmalek@jlc.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <36EFDDD8.44C8F5EB@jlc.net> (message from Dan Malek on Wed, 17
	Mar 1999 11:52:40 -0500)
Subject: Re: Mac Audio
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <36EFDDD8.44C8F5EB@jlc.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following patch is the diff between dmasound.c in vger/samba and
the point that Peter Barker got up to before he ran out of time to
work on it.  I don't know if it works yet or not, I haven't had time
to look closely at it, but it is at least a start.  If someone wants
to pick it up and hack it into shape, that would be great.

Paul.

--- vger/pmac/drivers/sound/dmasound.c	Fri Feb  5 16:15:34 1999
+++ ./dmasound.c	Thu Mar 18 21:35:05 1999
@@ -131,7 +131,7 @@
 static int irq_installed = 0;
 #endif /* MODULE */
 static char **sound_buffers = NULL;
-
+static char **sound_read_buffers = NULL;
 
 #ifdef CONFIG_ATARI
 extern void atari_microwire_cmd(int cmd);
@@ -184,6 +184,9 @@
 static void *awacs_tx_cmd_space;
 static volatile struct dbdma_cmd *awacs_tx_cmds;
 
+static void *awacs_rx_cmd_space;
+static volatile struct dbdma_cmd *awacs_rx_cmds;
+
 /*
  * Cached values of AWACS registers (we can't read them).
  * Except on the burgundy. XXX
@@ -239,6 +242,7 @@
 
 static int beep_volume = BEEP_VOLUME;
 static int beep_playing = 0;
+static int awacs_beep_state = 0;
 static short *beep_buf;
 static volatile struct dbdma_cmd *beep_dbdma_cmd;
 static void (*orig_mksound)(unsigned int, unsigned int);
@@ -276,10 +280,15 @@
 #define MIN_BUFSIZE 		4
 #define MAX_BUFSIZE		128	/* Limit for Amiga */
 
-static int catchRadius = 0, numBufs = 4, bufSize = 32;
+static int catchRadius = 0;
+static int numBufs = 4, bufSize = 32;
+static int numReadBufs = 4, readbufSize = 32;
+
 MODULE_PARM(catchRadius, "i");
 MODULE_PARM(numBufs, "i");
 MODULE_PARM(bufSize, "i");
+MODULE_PARM(numreadBufs, "i");
+MODULE_PARM(readbufSize, "i");
 
 #define arraysize(x)	(sizeof(x)/sizeof(*(x)))
 #define min(x, y)	((x) < (y) ? (x) : (y))
@@ -746,9 +755,11 @@
 static void PMacSilence(void);
 static void PMacInit(void);
 static void PMacPlay(void);
+static void PMacRecord(void);
 static int PMacSetFormat(int format);
 static int PMacSetVolume(int volume);
 static void pmac_awacs_tx_intr(int irq, void *devid, struct pt_regs *regs);
+static void pmac_awacs_rx_intr(int irq, void *devid, struct pt_regs *regs);
 static void pmac_awacs_intr(int irq, void *devid, struct pt_regs *regs);
 static void awacs_write(int val);
 static int awacs_get_volume(int reg, int lshift);
@@ -808,8 +819,8 @@
 	 *	Amiga: Bit 0 is set: a frame is loaded
 	 *	       Bit 1 is set: a frame is playing
 	 */
-	int playing;
-	struct wait_queue *write_queue, *open_queue, *sync_queue;
+	int active;
+	struct wait_queue *action_queue, *open_queue, *sync_queue;
 	int open_mode;
 	int busy, syncing;
 #ifdef CONFIG_ATARI
@@ -821,6 +832,7 @@
 };
 
 static struct sound_queue sq;
+static struct sound_queue read_sq;
 
 #define sq_block_address(i)	(sq.buffers[i])
 #define SIGNAL_RECEIVED	(signal_pending(current))
@@ -2573,35 +2585,35 @@
 	/* Since only an even number of samples per frame can
 	   be played, we might lose one byte here. (TO DO) */
 	sq.front = (sq.front+1) % sq.max_count;
-	sq.playing++;
+	sq.active++;
 	tt_dmasnd.ctrl = DMASND_CTRL_ON | DMASND_CTRL_REPEAT;
 }
 
 
 static void AtaPlay(void)
 {
-	/* ++TeSche: Note that sq.playing is no longer just a flag but holds
+	/* ++TeSche: Note that sq.active is no longer just a flag but holds
 	 * the number of frames the DMA is currently programmed for instead,
 	 * may be 0, 1 (currently being played) or 2 (pre-programmed).
 	 *
-	 * Changes done to sq.count and sq.playing are a bit more subtle again
+	 * Changes done to sq.count and sq.active are a bit more subtle again
 	 * so now I must admit I also prefer disabling the irq here rather
 	 * than considering all possible situations. But the point is that
 	 * disabling the irq doesn't have any bad influence on this version of
 	 * the driver as we benefit from having pre-programmed the DMA
 	 * wherever possible: There's no need to reload the DMA at the exact
 	 * time of an interrupt but only at some time while the pre-programmed
 	 * frame is playing!
 	 */
 	atari_disable_irq(IRQ_MFP_TIMA);
 
-	if (sq.playing == 2 ||	/* DMA is 'full' */
+	if (sq.active == 2 ||	/* DMA is 'full' */
 	    sq.count <= 0) {	/* nothing to do */
 		atari_enable_irq(IRQ_MFP_TIMA);
 		return;
 	}
 
-	if (sq.playing == 0) {
+	if (sq.active == 0) {
 		/* looks like there's nothing 'in' the DMA yet, so try
 		 * to put two frames into it (at least one is available).
 		 */
@@ -2649,7 +2661,7 @@
 #if 0
 	/* ++TeSche: if you should want to test this... */
 	static int cnt = 0;
-	if (sq.playing == 2)
+	if (sq.active == 2)
 		if (++cnt == 10) {
 			/* simulate losing an interrupt */
 			cnt = 0;
@@ -2666,7 +2678,7 @@
 		return;
 	}
 
-	if (!sq.playing) {
+	if (!sq.active) {
 		/* playing was interrupted and sq_reset() has already cleared
 		 * the sq variables, so better don't do anything here.
 		 */
@@ -2682,29 +2694,29 @@
 	 * as soon as the irq gets through.
 	 */
 	sq.count--;
-	sq.playing--;
+	sq.active--;
 
-	if (!sq.playing) {
+	if (!sq.active) {
 		tt_dmasnd.ctrl = DMASND_CTRL_OFF;
 		sq.ignore_int = 1;
 	}
 
-	WAKE_UP(sq.write_queue);
+	WAKE_UP(sq.action_queue);
 	/* At least one block of the queue is free now
 	   so wake up a writing process blocked because
 	   of a full queue. */
 
-	if ((sq.playing != 1) || (sq.count != 1))
+	if ((sq.active != 1) || (sq.count != 1))
 		/* We must be a bit carefully here: sq.count indicates the
 		 * number of buffers used and not the number of frames to
-		 * be played. If sq.count==1 and sq.playing==1 that means
+		 * be played. If sq.count==1 and sq.active==1 that means
 		 * the only remaining frame was already programmed earlier
 		 * (and is currently running) so we mustn't call AtaPlay()
 		 * here, otherwise we'll play one frame too much.
 		 */
 		AtaPlay();
 
-	if (!sq.playing) WAKE_UP(sq.sync_queue);
+	if (!sq.active) WAKE_UP(sq.sync_queue);
 	/* We are not playing after AtaPlay(), so there
 	   is nothing to play any more. Wake up a process
 	   waiting for audio output to drain. */
@@ -2901,7 +2913,7 @@
 			custom.dmacon = AMI_AUDIO_8;
 	}
 	sq.front = (sq.front+1) % sq.max_count;
-	sq.playing |= AMI_PLAY_LOADED;
+	sq.active |= AMI_PLAY_LOADED;
 }
 
 
@@ -2911,13 +2923,13 @@
 
 	custom.intena = IF_AUD0;
 
-	if (sq.playing & AMI_PLAY_LOADED) {
+	if (sq.active & AMI_PLAY_LOADED) {
 		/* There's already a frame loaded */
 		custom.intena = IF_SETCLR | IF_AUD0;
 		return;
 	}
 
-	if (sq.playing & AMI_PLAY_PLAYING)
+	if (sq.active & AMI_PLAY_PLAYING)
 		/* Increase threshold: frame 1 is already being played */
 		minframes = 2;
 
@@ -2945,7 +2957,7 @@
 {
 	int minframes = 1;
 
-	if (!sq.playing) {
+	if (!sq.active) {
 		/* Playing was interrupted and sq_reset() has already cleared
 		 * the sq variables, so better don't do anything here.
 		 */
@@ -2953,20 +2965,20 @@
 		return;
 	}
 
-	if (sq.playing & AMI_PLAY_PLAYING) {
+	if (sq.active & AMI_PLAY_PLAYING) {
 		/* We've just finished a frame */
 		sq.count--;
-		WAKE_UP(sq.write_queue);
+		WAKE_UP(sq.action_queue);
 	}
 
-	if (sq.playing & AMI_PLAY_LOADED)
+	if (sq.active & AMI_PLAY_LOADED)
 		/* Increase threshold: frame 1 is already being played */
 		minframes = 2;
 
 	/* Shift the flags */
-	sq.playing = (sq.playing<<1) & AMI_PLAY_MASK;
+	sq.active = (sq.active<<1) & AMI_PLAY_MASK;
 
-	if (!sq.playing)
+	if (!sq.active)
 		/* No frame is playing, disable audio DMA */
 		custom.dmacon = AMI_AUDIO_OFF;
 
@@ -2974,7 +2986,7 @@
 		/* Try to play the next frame */
 		AmiPlay();
 
-	if (!sq.playing)
+	if (!sq.active)
 		/* Nothing to play anymore.
 		   Wake up a process waiting for audio output to drain. */
 		WAKE_UP(sq.sync_queue);
@@ -3000,7 +3012,8 @@
 static int __init PMacIrqInit(void)
 {
 	if (request_irq(awacs_irq, pmac_awacs_intr, 0, "AWACS", 0)
-	    || request_irq(awacs_tx_irq, pmac_awacs_tx_intr, 0, "AWACS out", 0))
+	    || request_irq(awacs_tx_irq, pmac_awacs_tx_intr, 0, "AWACS out", 0)
+	    || request_irq(awacs_rx_irq, pmac_awacs_rx_intr, 0, "AWACS in", 0))
 		return 0;
 	return 1;
 }
@@ -3014,7 +3027,10 @@
 	out_le32(&awacs->control, in_le32(&awacs->control) & 0xfff);
 	free_irq(awacs_irq, pmac_awacs_intr);
 	free_irq(awacs_tx_irq, pmac_awacs_tx_intr);
+	free_irq(awacs_rx_irq, pmac_awacs_rx_intr);
 	kfree(awacs_tx_cmd_space);
+	if (awacs_rx_cmd_space)
+		kfree(awacs_rx_cmd_space);
 	if (beep_buf)
 		kfree(beep_buf);
 	kd_mksound = orig_mksound;
@@ -3162,20 +3178,23 @@
 	unsigned long flags;
 
 	save_flags(flags); cli();
-	if (beep_playing) {
+	if (awacs_beep_state) {
 		/* sound takes precedence over beeps */
 		out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
 		out_le32(&awacs->control,
 			 (in_le32(&awacs->control) & ~0x1f00)
-			 || (awacs_rate_index << 8));
+			 | (awacs_rate_index << 8));
 		out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
+		out_le32(&awacs_txdma->cmdptr, virt_to_bus(&(awacs_tx_cmds[(sq.front+sq.active) % sq.max_count])));
+
 		beep_playing = 0;
+		awacs_beep_state = 0;
 	}
-	i = sq.front + sq.playing;
+	i = sq.front + sq.active;
 	if (i >= sq.max_count)
 		i -= sq.max_count;
-	while (sq.playing < 2 && sq.playing < sq.count) {
-		count = (sq.count == sq.playing + 1)? sq.rear_size: sq.block_size;
+	while (sq.active < 2 && sq.active < sq.count) {
+		count = (sq.count == sq.active + 1)?sq.rear_size:sq.block_size;
 		if (count < sq.block_size && !sq.syncing)
 			/* last block not yet filled, and we're not syncing. */
 			break;
@@ -3186,14 +3205,57 @@
 			i = 0;
 		out_le16(&awacs_tx_cmds[i].command, DBDMA_STOP);
 		out_le16(&cp->command, OUTPUT_MORE + INTR_ALWAYS);
-		if (sq.playing == 0)
+		if (sq.active == 0)
 			out_le32(&awacs_txdma->cmdptr, virt_to_bus(cp));
 		out_le32(&awacs_txdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
-		++sq.playing;
+		++sq.active;
 	}
 	restore_flags(flags);
 }
 
+
+static void PMacRecord(void)
+{
+	volatile struct dbdma_cmd *cp;
+	unsigned long flags;
+	
+	save_flags(flags); cli();
+	
+	printk("active %d, max_active %d, count %d\n", read_sq.active,read_sq.max_active,read_sq.count);
+	while ((read_sq.active < read_sq.max_active) &&
+	       (read_sq.active < read_sq.count)) {
+
+		int i = (read_sq.rear + read_sq.active + 1)
+			% read_sq.max_count;
+
+		cp = &awacs_rx_cmds[i];
+
+		st_le16(&cp->req_count, read_sq.block_size);
+		st_le16(&cp->xfer_status, 0);
+		out_le16(&cp->command, INPUT_MORE + INTR_ALWAYS);
+		
+		/* Stop the next buffer */
+		out_le16(&awacs_rx_cmds[(i+1)%read_sq.max_count].command,
+			 DBDMA_STOP);
+		
+		if (read_sq.active == 0)
+			out_le32(&awacs_rxdma->cmdptr, virt_to_bus(cp));
+		out_le32(&awacs_rxdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
+
+		printk("======\n");
+		printk("cp (%d) stuff in pmacrecord:\n", i);
+		printk("  req_count: %d\n", cp->req_count);
+		printk("    command: %08x\n", cp->command);
+/*              printk("   phy_addr: %08x\n", cp->phy_addr); */
+		printk("  res_count: %d\n", cp->res_count);
+		printk("xfer_status: %08x\n", cp->xfer_status);
+
+		read_sq.active++;
+        }
+        restore_flags(flags);
+}
+
+
 static void
 pmac_awacs_tx_intr(int irq, void *devid, struct pt_regs *regs)
 {
@@ -3201,26 +3263,83 @@
 	int stat;
 	volatile struct dbdma_cmd *cp;
 
-	while (sq.playing > 0) {
+	while (sq.active > 0) {
 		cp = &awacs_tx_cmds[i];
 		stat = ld_le16(&cp->xfer_status);
 		if ((stat & ACTIVE) == 0)
 			break;	/* this frame is still going */
 		--sq.count;
-		--sq.playing;
+		--sq.active;
 		if (++i >= sq.max_count)
 			i = 0;
 	}
 	if (i != sq.front)
-		WAKE_UP(sq.write_queue);
+		WAKE_UP(sq.action_queue);
 	sq.front = i;
 
 	PMacPlay();
 
-	if (!sq.playing)
+	if (!sq.active)
 		WAKE_UP(sq.sync_queue);
 }
 
+
+static void
+pmac_awacs_rx_intr(int irq, void *devid, struct pt_regs *regs)
+{
+	int new_rear;
+	volatile struct dbdma_cmd *cp;
+	int j,i;
+
+	/* Check which buffers have been completed */
+	printk("Received interupt\n");
+	for (i=0; i<numReadBufs; i++) {
+	  if ((awacs_rx_cmds[i].xfer_status)) {
+	    printk("Buffer %d complete (%08x)\n", i,awacs_rx_cmds[i].xfer_status);
+	    awacs_rx_cmds[i].xfer_status = 0;
+	    for (j=0; j<5; j++) {
+	      printk("%02x ",(char)(sound_read_buffers[i][j]));
+	    }
+	    printk("\n");
+	  }
+	}
+	return;
+
+	/* Copy data we just got into the user's data space */
+	/* At this stage, read_sq.front ought to point to
+	   the filled buffer, right?
+	*/
+
+	cp = &awacs_rx_cmds[read_sq.front];
+
+	printk("======\n");
+	printk("cp (%d) stuff after interrupt:\n", read_sq.front);
+	printk("  req_count: %d\n", cp->req_count);
+	printk("    command: %08x\n", cp->command);
+/*     printk("   phy_addr: %08x\n", cp->phy_addr); */
+	printk("  res_count: %d\n", cp->res_count);
+	printk("xfer_status: %08x\n", cp->xfer_status);
+
+/*     for (; (uRead < ureadCount) && (j<readbufSize); uRead++) { */
+/*             readData[uRead] = read_sq.buffers[read_sq.rear][j++]; */
+/*     } */
+
+	j=0;
+/*     for (j=0;j<readbufSize; j++) { */
+/*             printk("Char %d: %d\n", j, read_sq.buffers[read_sq.front][j]); */
+/*     } */
+
+	read_sq.front = (read_sq.front + 1) % numReadBufs;
+	
+	--read_sq.count;
+	--read_sq.active;
+	
+	WAKE_UP(read_sq.action_queue);
+	
+	PMacRecord();
+}
+
+
 static void
 pmac_awacs_intr(int irq, void *devid, struct pt_regs *regs)
 {
@@ -3293,7 +3412,7 @@
 		beep_timer.expires = jiffies + ticks;
 		add_timer(&beep_timer);
 	}
-	if (beep_playing || sq.playing || beep_buf == NULL) {
+	if (beep_playing || sq.active || beep_buf == NULL) {
 		restore_flags(flags);
 		return;		/* too hard, sorry :-( */
 	}
@@ -3323,6 +3442,7 @@
 	st_le16(&beep_dbdma_cmd->xfer_status, 0);
 	st_le32(&beep_dbdma_cmd->cmd_dep, virt_to_bus(beep_dbdma_cmd));
 	st_le32(&beep_dbdma_cmd->phy_addr, virt_to_bus(beep_buf));
+	awacs_beep_state = 1;
 
 	save_flags(flags); cli();
 	if (beep_playing) {	/* i.e. haven't been terminated already */
@@ -4295,7 +4415,64 @@
 }
 
 
-static void sq_setup(int numBufs, int bufSize, char **buffers)
+static int sq_allocate_read_buffers(void)
+{
+	int i;
+	int j;
+
+	if (sound_read_buffers)
+		return 0;
+	sound_read_buffers = kmalloc(numReadBufs * sizeof(char *), GFP_KERNEL);
+	if (!sound_read_buffers)
+		return -ENOMEM;
+	for (i = 0; i < numBufs; i++) {
+		sound_read_buffers[i] = sound.mach.dma_alloc (readbufSize<<10,
+							      GFP_KERNEL);
+		if (!sound_read_buffers[i]) {
+			while (i--)
+				sound.mach.dma_free (sound_read_buffers[i],
+						     readbufSize << 10);
+			kfree (sound_read_buffers);
+			sound_read_buffers = 0;
+			return -ENOMEM;
+		}
+		/* XXXX debugging code */
+		for (j=0; j<readbufSize; j++) {
+			sound_read_buffers[i][j] = 0xef;
+		}
+	}
+	return 0;
+}
+
+static void sq_release_read_buffers(void)
+{
+	int i;
+	volatile struct dbdma_cmd *cp;
+	
+
+	if (sound_read_buffers) {
+
+#if CONFIG_PPC
+		printk("Stoppping awacs\n");
+		cp = awacs_rx_cmds;
+		for (i = 0; i < numReadBufs; i++,cp++) {
+			st_le16(&cp->command, DBDMA_STOP);
+		}
+		/* We should probably wait for the thing to stop before we
+		   release the memory */
+#endif
+
+		printk("Releasing read buffers\n");
+		for (i = 0; i < numBufs; i++)
+			sound.mach.dma_free (sound_read_buffers[i],
+					     bufSize << 10);
+		kfree (sound_read_buffers);
+		sound_read_buffers = 0;
+	}
+}
+
+
+static void sq_setup(int numBufs, int bufSize, char **write_buffers)
 {
 #ifdef CONFIG_PPC
 	int i;
@@ -4305,12 +4482,12 @@
 	sq.max_count = numBufs;
 	sq.max_active = numBufs;
 	sq.block_size = bufSize;
-	sq.buffers = buffers;
+	sq.buffers = write_buffers;
 
 	sq.front = sq.count = 0;
 	sq.rear = -1;
 	sq.syncing = 0;
-	sq.playing = 0;
+	sq.active = 0;
 
 #ifdef CONFIG_ATARI
 	sq.ignore_int = 0;
@@ -4323,7 +4500,7 @@
 	cp = awacs_tx_cmds;
 	memset((void *) cp, 0, (numBufs + 1) * sizeof(struct dbdma_cmd));
 	for (i = 0; i < numBufs; ++i, ++cp) {
-		st_le32(&cp->phy_addr, virt_to_bus(buffers[i]));
+		st_le32(&cp->phy_addr, virt_to_bus(write_buffers[i]));
 	}
 	st_le16(&cp->command, DBDMA_NOP + BR_ALWAYS);
 	st_le32(&cp->cmd_dep, virt_to_bus(awacs_tx_cmds));
@@ -4332,6 +4509,57 @@
 #endif /* CONFIG_PPC */
 }
 
+static void read_sq_setup(int numBufs, int bufSize, char **read_buffers)
+{
+#ifdef CONFIG_PPC
+	int i;
+	volatile struct dbdma_cmd *cp;
+#endif /* CONFIG_PPC */
+
+	read_sq.max_count = numReadBufs;
+	read_sq.max_active = numReadBufs;
+	read_sq.block_size = readbufSize;
+	read_sq.buffers = read_buffers;
+
+	read_sq.front = sq.count = 0;
+	read_sq.rear = -1;
+	read_sq.syncing = 0;
+	read_sq.active = 0;
+
+#ifdef CONFIG_ATARI
+	read_sq.ignore_int = 0;
+#endif /* CONFIG_ATARI */
+#ifdef CONFIG_AMIGA
+	read_sq.block_size_half = read_sq.block_size>>1;
+	read_sq.block_size_quarter = read_sq.block_size_half>>1;
+#endif /* CONFIG_AMIGA */
+#ifdef CONFIG_PPC
+	cp = awacs_rx_cmds;
+	memset((void *) cp, 0, (numReadBufs + 1) * sizeof(struct dbdma_cmd));
+
+	/* Set dma buffers up in a loop */
+	for (i = 0; i < numReadBufs; i++,cp++) {
+		st_le32(&cp->phy_addr, virt_to_bus(read_buffers[i]));
+		st_le16(&cp->command, INPUT_MORE + INTR_ALWAYS);
+		st_le16(&cp->req_count, read_sq.block_size);
+		st_le16(&cp->xfer_status, 0);
+	}
+
+	/* The next two lines make the thing loop around? */
+	st_le16(&cp->command, INPUT_MORE + BR_ALWAYS + INTR_ALWAYS);
+	st_le32(&cp->cmd_dep, virt_to_bus(awacs_rx_cmds));
+
+	/* Tell the thing to go */
+	out_le32(&awacs_rxdma->cmdptr, virt_to_bus(awacs_rx_cmds));
+/* 	out_le32(&awacs_rxdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16); */
+
+	out_le32(&awacs_rxdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
+
+
+#endif /* CONFIG_PPC */
+}
+
+
 static void sq_play(void)
 {
 	(*sound.mach.play)();
@@ -4376,7 +4604,7 @@
 			sq_play();
 			if (NON_BLOCKING(sq.open_mode))
 				return uWritten > 0 ? uWritten : -EAGAIN;
-			SLEEP(sq.write_queue, ONE_SECOND);
+			SLEEP(sq.action_queue, ONE_SECOND);
 			if (SIGNAL_RECEIVED)
 				return uWritten > 0 ? uWritten : -EINTR;
 		}
@@ -4410,29 +4638,86 @@
 }
 
 
+/***********/
+/* Some nasty (hopefully temporary) global variables */
+ssize_t bRead = 0;
+ssize_t uRead = 0;
+ssize_t ureadLeft = 0;
+char * readdst = NULL;
+
+static ssize_t sq_read(struct file *file, char *dst, size_t uLeft,
+                       loff_t *ppos)
+{
+	int i=0;
+
+	if (uLeft == 0)
+		return 0;
+
+	PMacRecord();
+
+	/* Send the process to sleep until we get an interrupt */
+	while (bRead < uLeft) {
+		PMacRecord();
+		if (NON_BLOCKING(read_sq.open_mode))
+                       return bRead > 0 ? bRead : -EAGAIN;
+		SLEEP(read_sq.action_queue, ONE_SECOND);
+		if (SIGNAL_RECEIVED)
+			return bRead > 0 ? bRead : -EINTR;
+	}
+	return bRead;
+}
+
+
+
 static int sq_open(struct inode *inode, struct file *file)
 {
 	int rc = 0;
 
 	MOD_INC_USE_COUNT;
-	if (sq.busy) {
-		rc = -EBUSY;
-		if (NON_BLOCKING(file->f_flags))
-			goto err_out;
-		rc = -EINTR;
-		while (sq.busy) {
-			SLEEP(sq.open_queue, ONE_SECOND);
-			if (SIGNAL_RECEIVED)
+	printk("sq_open called\n");
+	if (file->f_mode & FMODE_WRITE) {
+		if (sq.busy) {
+			rc = -EBUSY;
+			if (NON_BLOCKING(file->f_flags))
 				goto err_out;
+			rc = -EINTR;
+			while (sq.busy) {
+				SLEEP(sq.open_queue, ONE_SECOND);
+				if (SIGNAL_RECEIVED)
+					goto err_out;
+			}
 		}
-		rc = 0;
+		sq.busy = 1; /* Let's play spot-the-race-condition */
+
+		if (sq_allocate_buffers()) goto err_out_nobusy;
+
+		sq_setup(numBufs, bufSize<<10,sound_buffers);
+		sq.open_mode = file->f_mode;
 	}
-	sq.busy = 1;
-	rc = sq_allocate_buffers();
-	if (rc)
-		goto err_out_nobusy;
-	sq_setup(numBufs, bufSize << 10, sound_buffers);
-	sq.open_mode = file->f_flags;
+
+
+	if (file->f_mode == FMODE_READ) {
+		if (read_sq.busy) {
+			rc = -EBUSY;
+			if (NON_BLOCKING(file->f_flags))
+				goto err_out;
+			rc = -EINTR;
+			while (read_sq.busy) {
+				SLEEP(read_sq.open_queue, ONE_SECOND);
+				if (SIGNAL_RECEIVED)
+					goto err_out;
+			}
+			rc = 0;
+		}
+		read_sq.busy = 1;
+		if (sq_allocate_read_buffers()) goto err_out_nobusy;
+
+		read_sq_setup(numReadBufs,readbufSize<<10, sound_read_buffers);
+
+		/* Start dma'ing straight away */
+		PMacRecord();
+	}                                                                      
+
 #ifdef CONFIG_ATARI
 	sq.ignore_int = 1;
 #endif /* CONFIG_ATARI */
@@ -4446,9 +4731,16 @@
 		sound_set_format(AFMT_MU_LAW);
 	}
 	return 0;
+
 err_out_nobusy:
-	sq.busy = 0;
-	WAKE_UP(sq.open_queue);
+	if (file->f_mode & FMODE_WRITE) {
+		sq.busy = 0;
+		WAKE_UP(sq.open_queue);
+	}
+	if (file->f_mode & FMODE_READ) {
+		read_sq.busy = 0;
+		WAKE_UP(read_sq.open_queue);
+	}
 err_out:
 	MOD_DEC_USE_COUNT;
 	return rc;
@@ -4458,7 +4750,7 @@
 static void sq_reset(void)
 {
 	sound_silence();
-	sq.playing = 0;
+	sq.active = 0;
 	sq.count = 0;
 	sq.front = (sq.rear+1) % sq.max_count;
 }
@@ -4471,7 +4763,7 @@
 	sq.syncing = 1;
 	sq_play();	/* there may be an incomplete frame waiting */
 
-	while (sq.playing) {
+	while (sq.active) {
 		SLEEP(sq.sync_queue, ONE_SECOND);
 		if (SIGNAL_RECEIVED) {
 			/* While waiting for audio output to drain, an
@@ -4496,11 +4788,23 @@
 	sound.soft = sound.dsp;
 	sound.hard = sound.dsp;
 	sound_silence();
+
+	sq_release_read_buffers();
 	sq_release_buffers();
 	MOD_DEC_USE_COUNT;
 
-	sq.busy = 0;
-	WAKE_UP(sq.open_queue);
+	/* There is probably a DOS atack here. They change the mode flag. */
+	/* XXX add check here */
+	if (file->f_mode & FMODE_READ) {
+		read_sq.busy = 0;
+		WAKE_UP(read_sq.open_queue);
+	}
+
+	if (file->f_mode & FMODE_WRITE) {
+		sq.busy = 0;
+		WAKE_UP(sq.open_queue);
+	}
+
 	/* Wake up a process waiting for the queue being released.
 	 * Note: There may be several processes waiting for a call
 	 * to open() returning. */
@@ -4572,7 +4876,7 @@
 	case SNDCTL_DSP_SUBDIVIDE:
 		break;
 	case SNDCTL_DSP_SETFRAGMENT:
-		if (sq.count || sq.playing || sq.syncing)
+		if (sq.count || sq.active || sq.syncing)
 			return -EINVAL;
 		IOCTL_IN(arg, size);
 		nbufs = size >> 16;
@@ -4602,7 +4906,7 @@
 static struct file_operations sq_fops =
 {
 	sound_lseek,
-	NULL,			/* sq_read */
+	sq_read,			/* sq_read */
 	sq_write,
 	NULL,			/* sq_readdir */
 	NULL,			/* sq_poll */
@@ -4623,8 +4927,9 @@
 	if (sq_unit < 0)
 		return;
 
-	sq.write_queue = sq.open_queue = sq.sync_queue = 0;
+	sq.action_queue = sq.open_queue = sq.sync_queue = 0;
 	sq.busy = 0;
+	read_sq.busy = 0;
 
 	/* whatever you like as startup mode for /dev/dsp,
 	 * (/dev/audio hasn't got a startup mode). note that
@@ -4767,8 +5072,8 @@
 		       sq.block_size, sq.max_count, sq.max_active);
 	len += sprintf(buffer+len, "\tsq.count = %d sq.rear_size = %d\n", sq.count,
 		       sq.rear_size);
-	len += sprintf(buffer+len, "\tsq.playing = %d sq.syncing = %d\n",
-		       sq.playing, sq.syncing);
+	len += sprintf(buffer+len, "\tsq.active = %d sq.syncing = %d\n",
+		       sq.active, sq.syncing);
 	state.len = len;
 	return 0;
 }
@@ -4897,15 +5202,18 @@
 		int vol;
 		sound.mach = machPMac;
 		has_sound = 1;
+
 		awacs = (volatile struct awacs_regs *)
 			ioremap(np->addrs[0].address, 0x80);
 		awacs_txdma = (volatile struct dbdma_regs *)
 			ioremap(np->addrs[1].address, 0x100);
 		awacs_rxdma = (volatile struct dbdma_regs *)
 			ioremap(np->addrs[2].address, 0x100);
+
 		awacs_irq = np->intrs[0].line;
 		awacs_tx_irq = np->intrs[1].line;
 		awacs_rx_irq = np->intrs[2].line;
+
 		awacs_tx_cmd_space = kmalloc((numBufs + 4) * sizeof(struct dbdma_cmd),
 					     GFP_KERNEL);
 		if (awacs_tx_cmd_space == NULL) {
@@ -4914,6 +5222,18 @@
 		}
 		awacs_tx_cmds = (volatile struct dbdma_cmd *)
 			DBDMA_ALIGN(awacs_tx_cmd_space);
+
+
+		awacs_rx_cmd_space = kmalloc((numReadBufs + 4) * sizeof(struct dbdma_cmd),
+					     GFP_KERNEL);
+		if (awacs_rx_cmd_space == NULL) {
+		  printk("DMA sound driver: No memory for input");
+		}
+		awacs_rx_cmds = (volatile struct dbdma_cmd *)
+		  DBDMA_ALIGN(awacs_rx_cmd_space);
+
+
+
 		awacs_reg[0] = MASK_MUX_CD;
 		awacs_reg[1] = MASK_LOOPTHRU | MASK_PAROUT;
 		/* get default volume from nvram */
@@ -5029,6 +5349,7 @@
 		sound.mach.irqcleanup();
 	}
 
+	sq_release_read_buffers();
 	sq_release_buffers();
 
 	if (mixer_unit >= 0)

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
