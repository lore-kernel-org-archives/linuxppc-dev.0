Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2B393DDDE3
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 07:10:28 +1100 (EST)
Date: Fri, 5 Dec 2008 23:10:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 1/7] powerpc: Implement get_brgfreq() and get_baudrate() stubs
Message-ID: <20081205201026.GA19758@oksana.dev.rtsoft.ru>
References: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is needed to not bother with ugly #ifdefs in the drivers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_soc.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 60f7f22..9c744e4 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -5,8 +5,13 @@
 #include <asm/mmu.h>
 
 extern phys_addr_t get_immrbase(void);
+#if defined(CONFIG_CPM2) || defined(CONFIG_QUICC_ENGINE) || defined(CONFIG_8xx)
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
+#else
+static inline u32 get_brgfreq(void) { return -1; }
+static inline u32 get_baudrate(void) { return -1; }
+#endif
 extern u32 fsl_get_sys_freq(void);
 
 struct spi_board_info;
-- 
1.5.6.5
