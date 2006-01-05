Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-02.bluehost.com (outbound-mail-02.bluehost.com
	[70.103.189.12]) by ozlabs.org (Postfix) with SMTP id CE6E46899B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 04:50:08 +1100 (EST)
Message-ID: <43BD5C0A.3080706@secretlab.ca>
Date: Thu, 05 Jan 2006 10:48:58 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: trini@kernel.crashing.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH] fix ML300 zImage in 2.6.15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

2.6.15 doesn't build a bootable zImage for the ML300 because
embed_config.o is no longer linked in.  This patch adds it back in.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index f3e9c53..5699659 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -188,6 +188,7 @@ OBJCOPY_ARGS                        := -O elf32-powerpc
 boot-y                         := head.o relocate.o $(extra.o-y) $(misc-y)
 boot-$(CONFIG_REDWOOD_5)       += embed_config.o
 boot-$(CONFIG_REDWOOD_6)       += embed_config.o
+boot-$(CONFIG_XILINX_ML300)    += embed_config.o
 boot-$(CONFIG_8xx)             += embed_config.o
 boot-$(CONFIG_8260)            += embed_config.o
 boot-$(CONFIG_BSEIP)           += iic.o

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
