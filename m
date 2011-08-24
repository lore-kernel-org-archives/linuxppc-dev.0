Return-Path: <B34182@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 538B7B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 19:31:34 +1000 (EST)
From: Liu Gang-B34182 <B34182@freescale.com>
To: "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] fsl-rio: Correct IECSR register clear value
Date: Wed, 24 Aug 2011 09:31:21 +0000
Message-ID: <9A1C2A9ACC704641BC472A1588CE16470EC9C3@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1312798419-3912-1-git-send-email-b34182@freescale.com>
In-Reply-To: <1312798419-3912-1-git-send-email-b34182@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	Li Yang-R58472 <r58472@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Andrew,

Thank you for applying the patch "[PATCH] rio: Use discovered bit to test i=
f enumeration is complete "!

So far the following patch "[PATCH] fsl-rio: Correct IECSR register clear v=
alue " has no comment or response.

So could you please apply this patch into your tree?

Thanks a lot!

Regards,

Liu Gang
-----Original Message-----
From: Liu Gang-B34182=20
Sent: Monday, August 08, 2011 6:14 PM
To: linuxppc-dev@ozlabs.org
Cc: akpm@linux-foundation.org; Li Yang-R58472; Gala Kumar-B11780; Zang Roy-=
R61911; Liu Gang-B34182; Liu Gang-B34182
Subject: [PATCH] fsl-rio: Correct IECSR register clear value

The RETE bit in IECSR is cleared by writing a 1 to it.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c =
index b3fd081..cdd765b 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -54,6 +54,7 @@
 #define ODSR_CLEAR		0x1c00
 #define LTLEECSR_ENABLE_ALL	0xFFC000FC
 #define ESCSR_CLEAR		0x07120204
+#define IECSR_CLEAR		0x80000000
=20
 #define RIO_PORT1_EDCSR		0x0640
 #define RIO_PORT2_EDCSR		0x0680
@@ -1089,11 +1090,11 @@ static void port_error_handler(struct rio_mport *po=
rt, int offset)
=20
 	if (offset =3D=3D 0) {
 		out_be32((u32 *)(rio_regs_win + RIO_PORT1_EDCSR), 0);
-		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), IECSR_CLEAR);
 		out_be32((u32 *)(rio_regs_win + RIO_ESCSR), ESCSR_CLEAR);
 	} else {
 		out_be32((u32 *)(rio_regs_win + RIO_PORT2_EDCSR), 0);
-		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), IECSR_CLEAR);
 		out_be32((u32 *)(rio_regs_win + RIO_PORT2_ESCSR), ESCSR_CLEAR);
 	}
 }
--
1.7.3.1
