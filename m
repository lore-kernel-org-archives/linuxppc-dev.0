Date: Wed, 17 Sep 2003 15:38:57 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
In-reply-to: <IGEFJKJNHJDCBKALBJLLOEFNFPAA.joakim.tjernlund@lumentis.se>
To: Dan Malek <dan@embeddededge.com>,
	Jean-Denis Boyer <jdboyer@m5t.com>
Cc: Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEGAFPAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > OK, here is my attempt to fix the 8xx uart driver. With this
> > patch I can no longer break the console from user space. Against fairly recent
> > linuxppc_devel snapshot. Please comment/apply.
> >
> > Summary:
> >
> >  - uses local_irq_save()/local_irq_restore() around tx_cur accesses.
> >    I haved tried to minimize the time between local_irq_save() and local_irq_restore()
> >
> >  - Fixed a bug around copy_from_user() in rs_8xx_write().
> >
> >  - my_console_write() is still buggy. It takes a little more effort to fix
> >    this function. It should be fixed since a spurious printk can screw/lock your console.
>
> I am taking a stab at my_console_write() as well. I have something that works well
> for me, but i am unsure if I have broken KGDB/XMON support. In my new my_console_write()
> I must know the length of the TX buffer in the TXBD. The TX buffer length when the console
> is fully operational is TX_BUF_SIZE. Before that, in serial_console_setup, the length
> is 4 bytes. But what is the TX buffer length before serial_console_setup has run(that's
> when KGB/XMON is active)?
>
>  Jocke

Here is a version that fixes my_console_write as well. The KGDB/XMON question above is still open.
Currently TX buffer length assumption is >=4
Anyone intressted?

 Jocke
Index: arch/ppc/8xx_io/uart.c
===================================================================
RCS file: /home/cvsadmin/cvsroot/kernel/linuxppc/arch/ppc/8xx_io/uart.c,v
retrieving revision 1.7
diff -u -r1.7 uart.c
--- arch/ppc/8xx_io/uart.c	13 Jun 2003 09:04:43 -0000	1.7
+++ arch/ppc/8xx_io/uart.c	17 Sep 2003 13:33:47 -0000
@@ -1068,6 +1068,7 @@
 	ser_info_t *info = (ser_info_t *)tty->driver_data;
 	volatile cbd_t	*bdp;
 	unsigned char *cp;
+	unsigned long flags;

 	if (serial_paranoia_check(info, tty->device, "rs_put_char"))
 		return;
@@ -1075,7 +1076,16 @@
 	if (!tty)
 		return;

+	local_irq_save(flags);
 	bdp = info->tx_cur;
+	/* Get next BD.
+	*/
+	if (bdp->cbd_sc & BD_SC_WRAP)
+		info->tx_cur = info->tx_bd_base;
+	else
+		info->tx_cur = (cbd_t *)bdp + 1;
+	local_irq_restore(flags);
+
 	while (bdp->cbd_sc & BD_SC_READY);

 	cp = info->tx_va_base + ((bdp - info->tx_bd_base) * TX_BUF_SIZE);
@@ -1083,14 +1093,6 @@
 	bdp->cbd_datlen = 1;
 	bdp->cbd_sc |= BD_SC_READY;

-	/* Get next BD.
-	*/
-	if (bdp->cbd_sc & BD_SC_WRAP)
-		bdp = info->tx_bd_base;
-	else
-		bdp++;
-
-	info->tx_cur = (cbd_t *)bdp;
 }

 static int rs_8xx_write(struct tty_struct * tty, int from_user,
@@ -1100,6 +1102,7 @@
 	ser_info_t *info = (ser_info_t *)tty->driver_data;
 	volatile cbd_t *bdp;
 	unsigned char	*cp;
+	unsigned long flags;

 #ifdef CONFIG_KGDB_CONSOLE
         /* Try to let stub handle output. Returns true if it did. */
@@ -1113,44 +1116,46 @@
 	if (!tty)
 		return 0;

-	bdp = info->tx_cur;
-
 	while (1) {
 		c = MIN(count, TX_BUF_SIZE);

 		if (c <= 0)
 			break;

+		local_irq_save(flags);
+		bdp = info->tx_cur;
 		if (bdp->cbd_sc & BD_SC_READY) {
 			info->flags |= TX_WAKEUP;
+			local_irq_restore(flags);
 			break;
 		}

 		cp = info->tx_va_base + ((bdp - info->tx_bd_base) * TX_BUF_SIZE);
 		if (from_user) {
-			if (copy_from_user((void *)cp, buf, c)) {
+			c -= copy_from_user((void *)cp, buf, c);
+			if (!c) {
 				if (!ret)
 					ret = -EFAULT;
+				local_irq_restore(flags);
 				break;
 			}
 		} else {
 			memcpy((void *)cp, buf, c);
 		}
-
+		/* Get next BD.
+		 */
+		if (bdp->cbd_sc & BD_SC_WRAP)
+			info->tx_cur = info->tx_bd_base;
+		else
+			info->tx_cur = (cbd_t *)bdp + 1;
+		local_irq_restore(flags);
+
 		bdp->cbd_datlen = c;
 		bdp->cbd_sc |= BD_SC_READY;

 		buf += c;
 		count -= c;
 		ret += c;
-
-		/* Get next BD.
-		*/
-		if (bdp->cbd_sc & BD_SC_WRAP)
-			bdp = info->tx_bd_base;
-		else
-			bdp++;
-		info->tx_cur = (cbd_t *)bdp;
 	}
 	return ret;
 }
@@ -1210,28 +1215,28 @@
 {
 	volatile cbd_t	*bdp;
 	unsigned char	*cp;
+	unsigned long flags;

 	ser_info_t *info = (ser_info_t *)tty->driver_data;

 	if (serial_paranoia_check(info, tty->device, "rs_send_char"))
 		return;

+	local_irq_save(flags);
 	bdp = info->tx_cur;
+	/* Get next BD.
+	*/
+	if (bdp->cbd_sc & BD_SC_WRAP)
+		info->tx_cur = info->tx_bd_base;
+	else
+		info->tx_cur = (cbd_t *)bdp + 1;
+	local_irq_restore(flags);
 	while (bdp->cbd_sc & BD_SC_READY);

 	cp = info->tx_va_base + ((bdp - info->tx_bd_base) * TX_BUF_SIZE);
 	*cp = ch;
 	bdp->cbd_datlen = 1;
 	bdp->cbd_sc |= BD_SC_READY;
-
-	/* Get next BD.
-	*/
-	if (bdp->cbd_sc & BD_SC_WRAP)
-		bdp = info->tx_bd_base;
-	else
-		bdp++;
-
-	info->tx_cur = (cbd_t *)bdp;
 }

 /*
@@ -1802,7 +1807,7 @@
 static void rs_8xx_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	ser_info_t *info = (ser_info_t *)tty->driver_data;
-	unsigned long orig_jiffies, char_time;
+	unsigned long orig_jiffies, char_time, tst_res;
 	/*int lsr;*/
 	volatile cbd_t *bdp;

@@ -1837,6 +1842,7 @@
 	 * are empty.
 	 */
 	do {
+		unsigned long flags;
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
@@ -1854,12 +1860,15 @@
 		 * is the buffer is available.  There are still characters
 		 * in the CPM FIFO.
 		 */
+		local_irq_save(flags);
 		bdp = info->tx_cur;
 		if (bdp == info->tx_bd_base)
 			bdp += (TX_NUM_FIFO-1);
 		else
 			bdp--;
-	} while (bdp->cbd_sc & BD_SC_READY);
+		tst_res = !!(bdp->cbd_sc & BD_SC_READY);
+		local_irq_restore(flags);
+	} while (tst_res);
 	current->state = TASK_RUNNING;
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
@@ -2261,10 +2270,11 @@
 {
 	struct		serial_state	*ser;
 	ser_info_t			*info;
-	unsigned			i;
+	unsigned			i, c, cr_missing, max_tx_size;
 	volatile	cbd_t		*bdp, *bdbase;
 	volatile	smc_uart_t	*up;
 	volatile	u_char		*cp;
+	unsigned long                   flags;

 	ser = rs_table + idx;

@@ -2273,40 +2283,41 @@
 	 * we simply use the single buffer allocated.
 	 */
 	if ((info = (ser_info_t *)ser->info) != NULL) {
-		bdp = info->tx_cur;
 		bdbase = info->tx_bd_base;
-	}
-	else {
-		/* Pointer to UART in parameter ram.
-		*/
+		max_tx_size = TX_BUF_SIZE;
+	} else {
+		/* Pointer to UART in parameter ram. */
 		up = (smc_uart_t *)&cpmp->cp_dparam[ser->port];
-
-		/* Get the address of the host memory buffer.
-		 */
-		bdp = bdbase = (cbd_t *)&cpmp->cp_dpmem[up->smc_tbase];

+		/* Get the address of the host memory buffer.*/
 		info = &consinfo;
+		info->tx_bd_base = (cbd_t *)bdbase = (cbd_t *)&cpmp->cp_dpmem[up->smc_tbase];
+		info->tx_cur = (cbd_t *)bdbase;
+		max_tx_size = 4; /* Early serial acces has this */
 	}

-	/*
-	 * We need to gracefully shut down the transmitter, disable
-	 * interrupts, then send our bytes out.
-	 */
+	cr_missing = 0;
+	while (1){
+		c = MIN(max_tx_size, count);
+		if (c <= 0)
+			break;

-	/*
-	 * Now, do each character.  This is not as bad as it looks
-	 * since this is a holding FIFO and not a transmitting FIFO.
-	 * We could add the complexity of filling the entire transmit
-	 * buffer, but we would just wait longer between accesses......
-	 */
-	for (i = 0; i < count; i++, s++) {
+		local_irq_save(flags);
+		bdp = info->tx_cur;
+		bdbase = info->tx_bd_base;
+		if (bdp->cbd_sc & BD_SC_WRAP)
+			info->tx_cur = (cbd_t *)bdbase;
+		else
+			info->tx_cur = (cbd_t *)(bdp+1);
+		local_irq_restore(flags);
+
 		/* Wait for transmitter fifo to empty.
 		 * Ready indicates output is ready, and xmt is doing
 		 * that, not that it is ready for us to send.
 		 */
 		while (bdp->cbd_sc & BD_SC_READY);

-		/* Send the character out.
+		/* Send the characters out.
 		 * If the buffer address is in the CPM DPRAM, don't
 		 * convert it.
 		 */
@@ -2314,55 +2325,32 @@
 			cp = (u_char *)(bdp->cbd_bufaddr);
 		else
 			cp = info->tx_va_base + ((bdp - info->tx_bd_base) * TX_BUF_SIZE);
-		*cp = *s;
-
-		bdp->cbd_datlen = 1;
-		bdp->cbd_sc |= BD_SC_READY;
-
-		if (bdp->cbd_sc & BD_SC_WRAP)
-			bdp = bdbase;
-		else
-			bdp++;
-
-		/* if a LF, also do CR... */
-		if (*s == 10) {
-			while (bdp->cbd_sc & BD_SC_READY);
-
-			/* This 'if' below will never be true, but a few
-			 * people argued with me that it was a "bug by
-			 * inspection" that is was easier to add the code
-			 * than continue the discussion.  The only time
-			 * the buffer address is in DPRAM is during early
-			 * use by kgdb/xmon, which format their own packets
-			 * and we never get here. -- Dan
-			 */
-			if ((uint)(bdp->cbd_bufaddr) > (uint)IMAP_ADDR)
-				cp = (u_char *)(bdp->cbd_bufaddr);
-			else
-				cp = info->tx_va_base + ((bdp - info->tx_bd_base) * TX_BUF_SIZE);
-			*cp = 13;
-			bdp->cbd_datlen = 1;
-			bdp->cbd_sc |= BD_SC_READY;

-			if (bdp->cbd_sc & BD_SC_WRAP) {
-				bdp = bdbase;
-			}
-			else {
-				bdp++;
-			}
+		i=1; /* Keeps track of consumed TX buffer space */
+		if (cr_missing) {
+			/* Previus loop didn't have room for the CR, insert it first in this */
+			*cp++ = '\r';
+			i++;
 		}
-	}
-
-	/*
-	 * Finally, Wait for transmitter & holding register to empty
-	 *  and restore the IER
-	 */
-	while (bdp->cbd_sc & BD_SC_READY);
+		cr_missing = 0;
+		for (; i <= c; i++) {
+			if ((*cp++ = *s++) != '\n')
+				continue; /* Copy bytes until a NewLine is found */
+			/* NewLine found, see if there is space in the TX buffer to add a CR */
+			if (i < max_tx_size) {
+				*cp++ = '\r'; /* yes, there is space to add a CR */
+				i++;
+			} else
+				cr_missing = 1; /* No space in the TX buffer,
+						   rember it so it can be inserted in the next loop */
+		}
+		count -= (c-cr_missing);
+		bdp->cbd_datlen = i-1;
+		bdp->cbd_sc |= BD_SC_READY;

-	if (info)
-		info->tx_cur = (cbd_t *)bdp;
+	}
+	/* while (bdp->cbd_sc & BD_SC_READY); is this really needed? */
 }
-
 static void serial_console_write(struct console *c, const char *s,
 				unsigned count)
 {
@@ -3073,10 +3061,10 @@
 	bdp->cbd_bufaddr = iopa(mem_addr);
 	(bdp+1)->cbd_bufaddr = iopa(mem_addr+4);

-	consinfo.rx_va_base = mem_addr;
-	consinfo.rx_bd_base = bdp;
-	consinfo.tx_va_base = mem_addr + 4;
-	consinfo.tx_bd_base = bdp+1;
+	consinfo.rx_va_base = (unsigned char *) mem_addr;
+	consinfo.rx_bd_base = (cbd_t *) bdp;
+	consinfo.tx_va_base = (unsigned char *) (mem_addr + 4);
+	consinfo.tx_bd_base = (cbd_t *) (bdp+1);

 	/* For the receive, set empty and wrap.
 	 * For transmit, set wrap.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
