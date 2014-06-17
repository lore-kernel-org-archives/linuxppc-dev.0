Return-Path: <wladislav.kw@gmail.com>
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com
 [IPv6:2a00:1450:400c:c05::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A32E11A02DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 23:30:16 +1000 (EST)
Received: by mail-wi0-f177.google.com with SMTP id r20so5839580wiv.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 06:30:10 -0700 (PDT)
Message-ID: <53A0430D.8000006@gmail.com>
Date: Tue, 17 Jun 2014 15:30:53 +0200
From: Wladislav Wiebe <wladislav.kw@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, scottwood@freescale.com, mikey@neuling.org,
 mahesh@linux.vnet.ibm.com, michael@ellerman.id.au, anton@samba.org,
 r65777@freescale.com, haokexin@gmail.com
Subject: [PATCH 1/1] powerpc/traps/e500: fix misleading error output
Content-Type: text/plain; charset=ISO-8859-1
Cc: wladislav.kw@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In machine_check_e500 exception handler is a wrong indication
in case of MCSR_BUS_WBERR - so print "Write" instead of "Read".

Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
---
 arch/powerpc/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 239f1cd..cb9cfe4 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -609,7 +609,7 @@ int machine_check_e500(struct pt_regs *regs)
 	if (reason & MCSR_BUS_RBERR)
 		printk("Bus - Read Data Bus Error\n");
 	if (reason & MCSR_BUS_WBERR)
-		printk("Bus - Read Data Bus Error\n");
+		printk("Bus - Write Data Bus Error\n");
 	if (reason & MCSR_BUS_IPERR)
 		printk("Bus - Instruction Parity Error\n");
 	if (reason & MCSR_BUS_RPERR)
-- 
1.7.1
