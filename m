Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xmm15w4dzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 02:22:57 +1000 (AEST)
Subject: Re: MPC83xx reset status register (RSR, offset 0x910)
To: Radu Rendec <radu.rendec@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>
References: <CAD5jUk_e3LwPZGN7G3ZGHx=zdQBZSdAeoKWjxwE7Ei2=LtXQTg@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e6b9f0f0-1cd9-c183-eff4-bec1ca18a373@c-s.fr>
Date: Fri, 24 Aug 2018 16:20:32 +0000
MIME-Version: 1.0
In-Reply-To: <CAD5jUk_e3LwPZGN7G3ZGHx=zdQBZSdAeoKWjxwE7Ei2=LtXQTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

On 08/03/2018 04:36 PM, Radu Rendec wrote:
> Hi Everyone,
> 
> Is there any kernel code that handles the "reset status register" (RSR)
> on MPC83xx? I looked at arch/powerpc/platforms/83xx/misc.c, but it seems
> to only map the reset register area and it's static. The watchdog driver
> (drivers/watchdog/mpc8xxx_wdt.c) doesn't seem to look at it either (for
> the bootstatus flags).

How do you boot your Linux kernel ?

My 832x board boots using U-boot, and U-boot reads the RSR then clears 
it. So when Linux kernel reads it, it is just 0.

> 
> Basically I need to check the CPU reset reason and I thought I would ask
> first, before starting to write any code of my own.

Anyway, find below a set of two patches I used for testing. Feel free to 
use them if you bootloader doesn't clear the register

Christophe

commit f5171b463b149d6d60816fd9673e0367c0d6a90c
Author: Christophe Leroy <christophe.leroy@c-s.fr>
Date:   Wed Aug 22 12:49:42 2018 +0000

     powerpc/83xx: Show reset status at startup

     The 83xx has a register called Reset Status Register that
     shows the reason of the last reset.

     Print this reason at startup.

     Suggested-by: Radu Rendec <radu.rendec@gmail.com>

diff --git a/arch/powerpc/platforms/83xx/misc.c 
b/arch/powerpc/platforms/83xx/misc.c
index 773559431459..a3dbc22088d9 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -24,6 +24,16 @@
  #include "mpc83xx.h"

  #define RST_OFFSET	0x00000900
+#define RST_STAT_REG	0x00000010
+#define RSR_BSF		BIT(15)
+#define RSR_SWSR	BIT(18)
+#define RSR_SWHR	BIT(19)
+#define RSR_JSRS	BIT(23)
+#define RSR_CSHR	BIT(27)
+#define RSR_SWRS	BIT(28)
+#define RSR_BMRS	BIT(29)
+#define RSR_SRS		BIT(30)
+#define RSR_HRS		BIT(31)
  #define RST_PROT_REG	0x00000018
  #define RST_CTRL_REG	0x0000001c

@@ -34,6 +44,32 @@ static int __init mpc83xx_restart_init(void)
  	/* map reset restart_reg_baseister space */
  	restart_reg_base = ioremap(get_immrbase() + RST_OFFSET, 0xff);

+	if (restart_reg_base) {
+		u32 status = in_be32(restart_reg_base + (RST_STAT_REG >> 2));
+
+		if (status & RSR_BSF)
+			pr_info("Reset Status: Boot Sequencer Fail\n");
+		if (status & RSR_SWSR)
+			pr_info("Reset Status: Software soft reset\n");
+		if (status & RSR_SWHR)
+			pr_info("Reset Status: Software hard reset\n");
+		if (status & RSR_JSRS)
+			pr_info("Reset Status: JTAG soft reset\n");
+		if (status & RSR_CSHR)
+			pr_info("Reset Status: Checkstop reset\n");
+		if (status & RSR_SWRS)
+			pr_info("Reset Status: Software watchdog reset\n");
+		if (status & RSR_BMRS)
+			pr_info("Reset Status: Bus monitor reset\n");
+		if (status & RSR_SRS)
+			pr_info("Reset Status: Soft reset\n");
+		if (status & RSR_HRS)
+			pr_info("Reset Status: Hard reset\n");
+
+		/* clear reset statuses */
+		out_be32(restart_reg_base + (RST_STAT_REG >> 2), status);
+	}
+
  	return 0;
  }


commit c1ef17dd9c736c5e1b94da68852ae761a193090f
Author: Christophe Leroy <christophe.leroy@c-s.fr>
Date:   Wed Aug 22 12:19:02 2018 +0000

     powerpc/83xx: Move reset registers defines before functions

     Move the registers defines before/out of the functions.
     Reuse in another function.

diff --git a/arch/powerpc/platforms/83xx/misc.c 
b/arch/powerpc/platforms/83xx/misc.c
index d75c9816a5c9..773559431459 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -23,12 +23,16 @@

  #include "mpc83xx.h"

+#define RST_OFFSET	0x00000900
+#define RST_PROT_REG	0x00000018
+#define RST_CTRL_REG	0x0000001c
+
  static __be32 __iomem *restart_reg_base;

  static int __init mpc83xx_restart_init(void)
  {
  	/* map reset restart_reg_baseister space */
-	restart_reg_base = ioremap(get_immrbase() + 0x900, 0xff);
+	restart_reg_base = ioremap(get_immrbase() + RST_OFFSET, 0xff);

  	return 0;
  }
@@ -37,10 +41,6 @@ arch_initcall(mpc83xx_restart_init);

  void __noreturn mpc83xx_restart(char *cmd)
  {
-#define RST_OFFSET	0x00000900
-#define RST_PROT_REG	0x00000018
-#define RST_CTRL_REG	0x0000001c
-
  	local_irq_disable();

  	if (restart_reg_base) {
