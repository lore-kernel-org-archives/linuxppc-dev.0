Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from VA3EHSOBE002.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 345B0DE255
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 02:32:05 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca, paulus@samba.org,
	benh@kernel.crashing.org, dwg@au1.ibm.com, jwboyer@linux.vnet.ibm.com,
	stephen.neuendorffer@xilinx.com
Subject: [PATCH] powerpc: legacy_serial: reg-offset & shift aren't used
Date: Tue, 1 Jul 2008 09:31:54 -0700
Message-ID: <20080701163159.8B56512C8077@mail203-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The legacy serial driver does not work with an 8250
type UART that uses reg-offset and reg-shift. This
change updates the driver so it doesn't find the UART
when those properties are present on the UART in the
device tree for soc devices.

Signed-off-by: John Linn <john.linn@xilinx.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/kernel/legacy_serial.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 61dd174..b43235f 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -136,6 +136,11 @@ static int __init add_legacy_soc_port(struct device_node *np,
 	if (of_get_property(np, "clock-frequency", NULL) == NULL)
 		return -1;
 
+	/* if reg-shift and offset, don't try to use it */
+	if ((of_get_property(np, "reg-shift", NULL) != NULL) &&
+		(of_get_property(np, "reg-offset", NULL) != NULL))
+		return -1;
+
 	/* if rtas uses this device, don't try to use it as well */
 	if (of_get_property(np, "used-by-rtas", NULL) != NULL)
 		return -1;
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
