Date: Tue, 16 Sep 2003 14:25:48 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
In-reply-to: <000f01c37bc4$56829230$020120b0@jockeXP>
To: Dan Malek <dan@embeddededge.com>,
	Jean-Denis Boyer <jdboyer@m5t.com>
Cc: Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEEFHFPAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Jean-Denis Boyer wrote:
> >
> > > I have just tested your patch on 8260 and it fixes the problem when printk is called ...
> >
> > The use of printk is strictly a debug function.  If it is necessary to see
> > it print out pretty, then use a different I/O path for the application or
> > dump out the log buffer separately.  Serial ports don't guarantee any
> > transactional operation with multiple users, printk isn't any different
> > although it does the bad thing of blocking interrupts while it processes
> > the message.
> hmm, it does not block interrupts as is, does it? Only if you apply the patch?
>
> >
> > Adding this patch adds lots of interrupt latency and I would recommend
> > against it.  It appears there is a bug that should be fixed to ensure
> > the proper synchronization of the BDs, but not with such large scale
> > blocking of interrupts.
> Agreed, but is there another mechanism but to disable interrupts? I can't think of any.
> It is possible to shrink the window with interrupts off dramatically.
>
>    Jocke
> >
> > Thanks.
> >
> >
> > -- Dan

OK, here is my attempt to fix the 8xx uart driver. With this
patch I can no longer break the console from user space. Against fairly recent
linuxppc_devel snapshot. Please comment/apply.

Summary:

 - uses local_irq_save()/local_irq_restore() around tx_cur accesses.
   I haved tried to minimize the time between local_irq_save() and local_irq_restore()

 - Fixed a bug around copy_from_user() in rs_8xx_write().

 - my_console_write() is still buggy. It takes a little more effort to fix
   this function. It should be fixed since a spurious printk can screw/lock your console.

 - fixed 4 trivial warnings as well.

  Jocke
Index: arch/ppc/8xx_io/uart.c
===================================================================
RCS file: /home/cvsadmin/cvsroot/kernel/linuxppc/arch/ppc/8xx_io/uart.c,v
retrieving revision 1.7
diff -u -r1.7 uart.c
--- arch/ppc/8xx_io/uart.c	13 Jun 2003 09:04:43 -0000	1.7
+++ arch/ppc/8xx_io/uart.c	16 Sep 2003 12:17:01 -0000
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
@@ -3073,10 +3082,10 @@
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
