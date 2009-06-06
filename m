Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by bilbo.ozlabs.org (Postfix) with SMTP id B1224B70AC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 07:19:19 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 06 Jun 2009 23:12:36 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090606211236.245370@gmx.net>
MIME-Version: 1.0
Subject: [PATCH] powerpc: Enable additional BAT registers in
	setup_745x_specifics()
To: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kernel expects the additional four IBAT and DBAT registers
to be available, but doesn't enable these registers on 745x CPUs, which
have them disabled after reset. Thus set the HIGH_BAT_EN bit in HID0
register, if the corresponding MMU feature is defined.

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 arch/powerpc/kernel/cpu_setup_6xx.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index 54f767e..1e9949e 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -239,6 +239,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
 	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE
 	ori	r11,r11,HID0_LRSTK | HID0_BTIC
 	oris	r11,r11,HID0_DPM@h
+BEGIN_MMU_FTR_SECTION
+	oris	r11,r11,HID0_HIGH_BAT@h
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 BEGIN_FTR_SECTION
 	xori	r11,r11,HID0_BTIC
 END_FTR_SECTION_IFSET(CPU_FTR_NO_BTIC)
-- 
1.5.6.5

-- 
GMX FreeDSL mit DSL 6.000 Flatrate und Telefonanschluss nur 17,95 Euro/mtl.!
http://dslspecial.gmx.de/freedsl-aktionspreis/?ac=OM.AD.PD003K11308T4569a
