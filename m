Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 494B6DDF2D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 04:44:10 +1100 (EST)
Message-ID: <478507E9.1060508@pikatech.com>
Date: Wed, 09 Jan 2008 12:44:09 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: langa2@kph.uni-mainz.de
Subject: [PATCH] Kconfig scsi_wait_scan 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael,

I find I need to add a string to the SCSI_WAIT_SCAN tristate in order to 
be able to turn the module off. See the patch below. On our embedded 
appliance the only use for SCSI is for the usb_storage driver.

Cheers,
   Sean MacLennan

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a6676be..960dc78 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -248,7 +248,7 @@ config SCSI_SCAN_ASYNC
          or async on the kernel's command line.
 
 config SCSI_WAIT_SCAN
-       tristate
+       tristate "SCSI wait scan"
        default m
        depends on SCSI
        depends on MODULES
