Subject: linuxppc-2.5 fixlets
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-Vn0DCccqSx6BKU4xEbyv"
Message-Id: <1061487408.1862.10.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 21 Aug 2003 19:36:49 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-Vn0DCccqSx6BKU4xEbyv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


First of all, export flush_tlb_page, which is needed by ext3 and SCSI
modules.

Then, thanks to the great new build system, some warnings stood out:

Fix 'comparison is always false due to limited range of data type' in
net/sched/estimator.c by changing char to signed char.

I'm not sure how to fix the same warning in drivers/ide/ppc/pmac.c
though:

if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {

DMA_WAIT_TIMEOUT is 500, but drive->waiting_for_dma is a u8.

Finally, fix

drivers/usb/misc/usbtest.c:438: warning: passing arg 1 of `__swab32s'
from incompatible pointer type

by using le16_to_cpus instead of le32_to_cpus .


PS: I guess Ben's PM fixes haven't made it into linuxppc-2.5 yet? The
display is garbled after sleep.

--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

--=-Vn0DCccqSx6BKU4xEbyv
Content-Disposition: attachment; filename=linuxppc-2.5.diff
Content-Type: text/plain; name=linuxppc-2.5.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linuxppc-2.6.0-test3/arch/ppc/kernel/ppc_ksyms.c	2003-08-20 10:27:35.000000000 +0200
+++ linuxppc-2.6.0-test3-md/arch/ppc/kernel/ppc_ksyms.c	2003-08-21 13:16:55.000000000 +0200
@@ -204,6 +204,7 @@ EXPORT_SYMBOL(flush_dcache_range);
 EXPORT_SYMBOL(flush_icache_user_range);
 EXPORT_SYMBOL(flush_dcache_page);
 EXPORT_SYMBOL(flush_tlb_kernel_range);
+EXPORT_SYMBOL(flush_tlb_page);
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(last_task_used_altivec);
 EXPORT_SYMBOL(giveup_altivec);
--- linuxppc-2.6.0-test3/drivers/usb/misc/usbtest.c	2003-08-20 10:27:43.000000000 +0200
+++ linuxppc-2.6.0-test3-md/drivers/usb/misc/usbtest.c	2003-08-21 17:34:01.000000000 +0200
@@ -435,7 +435,7 @@ static int is_good_config (char *buf, in
 		return 0;
 	}

-	le32_to_cpus (&config->wTotalLength);
+	le16_to_cpus (&config->wTotalLength);
 	if (config->wTotalLength == len)		/* read it all */
 		return 1;
 	return config->wTotalLength >= TBUF_SIZE;	/* max partial read */
--- linuxppc-2.6.0-test3/include/linux/pkt_sched.h	2003-08-20 10:26:48.000000000 +0200
+++ linuxppc-2.6.0-test3-md/include/linux/pkt_sched.h	2003-08-21 17:02:55.000000000 +0200
@@ -45,7 +45,7 @@ struct tc_stats

 struct tc_estimator
 {
-	char		interval;
+	signed char	interval;
 	unsigned char	ewma_log;
 };


--=-Vn0DCccqSx6BKU4xEbyv--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
