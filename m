Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id 1C28F67EC9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 02:45:22 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i30so436715wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 Aug 2005 09:45:21 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Date: Thu, 4 Aug 2005 22:03:55 +0300
References: <42F23913.7020905@ru.mvista.com>
In-Reply-To: <42F23913.7020905@ru.mvista.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bam8C1+lUWSuDEH"
Message-Id: <200508042203.55491.pantelis.antoniou@gmail.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] cpm_uart: Make non-console uart work (rev 1)
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_bam8C1+lUWSuDEH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 04 August 2005 18:49, Vitaly Bordug wrote:
> Kumar, Pantelis,
>
> This patch makes non-console UART work on both 8xx and 82xx. dpram
> allocation fix by Pantelis included, almost all mentioned issues fixed.
>
> Tested on 8272ADS development board, but as far as there are no major
> modifications comparing to previous revision (excluding Pantelis change
> which has been tested independently), 8xx should work as well.
> ---------------------------------
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

Hi all,

Please apply the following patch over the previous one.

It's minor cosmetic & warning fixes.

Regards

Pantelis

--Boundary-00=_bam8C1+lUWSuDEH
Content-Type: text/x-diff;
  charset="utf-8";
  name="cpm-uart-nag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpm-uart-nag.patch"

--- linux-2.6-panto.git/drivers/serial/cpm_uart/cpm_uart_core.c	2005-08-04 21:59:50.998040784 +0300
+++ linux-2.6-panto-test.git/drivers/serial/cpm_uart/cpm_uart_core.c	2005-08-04 21:48:19.087227216 +0300
@@ -261,7 +261,7 @@
 		}
 
 		/* get pointer */
-		cp = (unsigned char *)cpm2cpu_addr(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
@@ -606,6 +606,7 @@
 		bdp = pinfo->tx_cur;
 
 		p = cpm2cpu_addr(bdp->cbd_bufaddr);
+
 		*p++ = xmit->buf[xmit->tail];
 		bdp->cbd_datlen = 1;
 		bdp->cbd_sc |= BD_SC_READY;
@@ -1030,10 +1031,7 @@
 		 * If the buffer address is in the CPM DPRAM, don't
 		 * convert it.
 		 */
-		if ((uint) (bdp->cbd_bufaddr) > (uint) CPM_ADDR)
-			cp = (unsigned char *) (bdp->cbd_bufaddr);
-		else
-			cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 		
 		*cp = *s;
 
@@ -1050,10 +1048,7 @@
 			while ((bdp->cbd_sc & BD_SC_READY) != 0)
 				;
 
-			if ((uint) (bdp->cbd_bufaddr) > (uint) CPM_ADDR)
-				cp = (unsigned char *) (bdp->cbd_bufaddr);
-			else
-				cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+			cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 
 			*cp = 13;
 			bdp->cbd_datlen = 1;
--- linux-2.6-panto.git/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2005-08-04 21:59:51.003040024 +0300
+++ linux-2.6-panto-test.git/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2005-08-04 21:50:24.744124464 +0300
@@ -83,6 +83,7 @@
 {
 	volatile cpm8xx_t *cp = cpmp;
 
+	(void)cp;	/* fix warning */
 #if defined (CONFIG_MPC885ADS)
 	/* Enable SMC1 transceivers */
 	{
@@ -110,6 +111,8 @@
 void smc2_lineif(struct uart_cpm_port *pinfo)
 {
 	volatile cpm8xx_t *cp = cpmp;
+
+	(void)cp;	/* fix warning */
 #if defined (CONFIG_MPC885ADS)
 	cp->cp_pepar |= 0x00000c00;
 	cp->cp_pedir &= ~0x00000c00;
@@ -185,6 +188,8 @@
 	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
 	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
 	if (is_con) {
+		/* was hostalloc but changed cause it blows away the */
+		/* large tlb mapping when pinning the kernel area    */
 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
 		dma_addr = 0;
 	} else

--Boundary-00=_bam8C1+lUWSuDEH--
