Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 293C2681C2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 01:07:43 +1100 (EST)
Message-ID: <4380829E.7040804@compulab.co.il>
Date: Sun, 20 Nov 2005 16:05:18 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Content-Type: multipart/mixed; boundary="------------030601010503040100000305"
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: smc1_lineif fix for mpc8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030601010503040100000305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the pin assignment of SMC1 for MPC8272 family

Signed-off-by: Mike Rapoport <mike@compulab.co.il>


-- 
Sincerely yours,
Mike Rapoport



--------------030601010503040100000305
Content-Type: text/x-diff;
 name="smc_8272.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smc_8272.patch"

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -89,11 +89,19 @@ void smc1_lineif(struct uart_cpm_port *p
 {
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
 
+#ifdef CONFIG_8272
+	/* SMC1 is only on port C on 8272 */
+	io->iop_pparc |= 0x0c000000;
+	io->iop_pdirc |= 0x04000000;
+	io->iop_pdirc &= ~0x08000000;
+	io->iop_psorc &= ~0x0c000000;
+#else
 	/* SMC1 is only on port D */
 	io->iop_ppard |= 0x00c00000;
 	io->iop_pdird |= 0x00400000;
 	io->iop_pdird &= ~0x00800000;
 	io->iop_psord &= ~0x00c00000;
+#endif
 
 	/* Wire BRG1 to SMC1 */
 	cpm2_immr->im_cpmux.cmx_smr &= 0x0f;

--------------030601010503040100000305--
