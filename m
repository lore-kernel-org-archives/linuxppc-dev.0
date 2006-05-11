Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8C5D0679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 15:12:06 +1000 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 3890F72835
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 07:12:04 +0200 (CEST)
Received: from 213-163-21-73.vnet.hu (213-163-21-73.vnet.hu [213.163.21.73])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 00D1C93EC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 07:12:03 +0200 (CEST)
Subject: mpc8270 : i2c support
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: 
Content-Type: text/plain
Date: Thu, 11 May 2006 07:12:14 +0200
Message-Id: <1147324334.5912.15.camel@Zeus.EmbLux>
Mime-Version: 1.0
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

on Thu May 4 06:11:17 2006 i wrote:
> Hmmm.... I think there are differences in the memory map between
> MPC826x and MPC827x ... can you try following Hack in
> include/asm-ppc/cpm_8260.h?
> 
> -#define PROFF_I2C       ((16 * 1024) - 64)
> +#define PROFF_I2C       ((8 * 1024) - 64)
> 
> [If it solves the problem, we must do this on a better way ;-)]

I don t know, if this was necessary to solve the problem, but i think
the follwing patch is useful, but I have no Hardware to try it out.

Any comments?

Best regards
Heiko

diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index 6197986..738259c 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -181,7 +181,11 @@ #define PROFF_IDMA4_BASE	((uint)0x8afe)
  */
 #define PROFF_SMC1	(0)
 #define PROFF_SMC2	(64)
+#if defined(CONFIG_8272) || defined(CONFIG_MPC8555)
+#define PROFF_I2C	((8 * 1024) - 64)
+#else
 #define PROFF_I2C	((16 * 1024) - 64)
+#endif
 
 /* Define enough so I can at least use the serial port as a UART.
  */
