Return-Path: <clemens.koller@anagramm.de>
Message-ID: <47546C5C.2030907@anagramm.de>
Date: Mon, 03 Dec 2007 21:51:40 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	robert lazarski <robertlazarski@gmail.com>
Subject: [PATCH] Add abort for fsl-devices which lack an RSTCR register.
Content-Type: multipart/mixed; boundary="------------010105000402000204040709"
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
--------------010105000402000204040709
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

This adds a fallback and calls abort() (in head_fsl_booke.S) to be able
to successfully reset some older freescale devices (i.e. mpc8540)
which don't have a RSTCR register.

Robert, this should also fix your issues. Please test.

Kumar, please ACK/NACK the patch since you touched fsl_rstcr_restart()
last time (2007-10-04). Maybe the call to abort (which resets the processor via
the Debug Control Register 0) could be put somewhere else or
we create another entry for the device tree.

Otherwise, I would prefer to check the PVR/SVR registers and use
a suitable cpu_reset() call which fits to the current cpu.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com

--------------010105000402000204040709
Content-Type: text/plain;
 name="powerpc-add-abort-to-reset-systems-without-rstcr-register.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="powerpc-add-abort-to-reset-systems-without-rstcr-register.pa";
 filename*1="tch"

Add a fallback to abort() call (in head_fsl_booke.S) to be able to
successfully reset some older freescale power devices (i.e. mpc8540)
which don't have a rstcr register.

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..6fe674a 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -42,6 +42,7 @@
 extern void init_fcc_ioports(struct fs_platform_info*);
 extern void init_fec_ioports(struct fs_platform_info*);
 extern void init_smc_ioports(struct fs_uart_platform_info*);
+extern void abort(void);
 static phys_addr_t immrbase = -1;
 
 phys_addr_t get_immrbase(void)
@@ -1336,6 +1337,8 @@ void fsl_rstcr_restart(char *cmd)
 	if (rstcr)
 		/* set reset control register */
 		out_be32(rstcr, 0x2);	/* HRESET_REQ */
+	else
+		abort();
 
 	while (1) ;
 }

--------------010105000402000204040709--
