Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AA46DDFC7
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 08:39:15 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 2/2] POWERPC: Remove global CPM mappings
Date: Tue, 24 Apr 2007 02:39:10 +0400
Message-ID: <20070423223910.4955.18106.stgit@localhost.localdomain>
In-Reply-To: <20070423223649.4955.77579.stgit@localhost.localdomain>
References: <20070423223649.4955.77579.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Gets rid or direct IMMR accesses/dereferences for PQ SoC targets and
relevant drivers.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/sysdev/commproc.c          |   13 +++----------
 drivers/net/fs_enet/fs_enet-main.c      |    7 +------
 drivers/net/fs_enet/mac-scc.c           |    2 +-
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    6 +++++-
 drivers/serial/cpm_uart/cpm_uart_cpm1.h |    2 +-
 include/asm-powerpc/fs_pd.h             |    9 ++++++---
 include/asm-ppc/fs_pd.h                 |    8 ++++++++
 7 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 9b4fafd..44e63e8 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -39,15 +39,11 @@
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
 #include <asm/prom.h>
-
 #include <asm/fs_pd.h>
 
-#define CPM_MAP_SIZE    (0x4000)
-
 static void m8xx_cpm_dpinit(void);
 static	uint	host_buffer;	/* One page of host buffer */
 static	uint	host_end;	/* end + 1 */
-cpm8xx_t	*cpmp;		/* Pointer to comm processor space */
 cpic8xx_t	*cpic_reg;
 
 static struct device_node *cpm_pic_node;
@@ -200,7 +196,7 @@ void cpm_reset(void)
 	cpm8xx_t	*commproc;
 	sysconf8xx_t    *siu_conf;
 
-	commproc = (cpm8xx_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
+	commproc = (cpm8xx_t *)immr_map(im_cpm);
 
 #ifdef CONFIG_UCODE_PATCH
 	/* Perform a reset.
@@ -213,6 +209,7 @@ void cpm_reset(void)
 
 	cpm_load_patch(commproc);
 #endif
+	immr_unmap(commproc);
 
 	/* Set SDMA Bus Request priority 5.
 	 * On 860T, this also enables FEC priority 6.  I am not sure
@@ -226,10 +223,6 @@ void cpm_reset(void)
 
 	/* Reclaim the DP memory for our use. */
 	m8xx_cpm_dpinit();
-
-	/* Tell everyone where the comm processor resides.
-	*/
-	cpmp = commproc;
 }
 
 /* We used to do this earlier, but have to postpone as long as possible
@@ -283,7 +276,7 @@ cpm_setbrg(uint brg, uint rate)
 
 	/* This is good enough to get SMCs running.....
 	*/
-	bp = (uint *)&cpmp->cp_brgc1;
+	bp = immr_map_size(im_cpm.cp_brgc1, 16);
 	bp += brg;
 	/* The BRG has a 12-bit counter.  For really slow baud rates (or
 	 * really fast processors), we may have to further divide by 16.
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 5bd99c6..ddf4570 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -1131,13 +1131,8 @@ void *fs_enet_immap = NULL;
 
 static int setup_immap(void)
 {
-	phys_addr_t paddr = 0;
-	unsigned long size = 0;
-
 #ifdef CONFIG_CPM1
-	paddr = IMAP_ADDR;
-	size = 0x10000; /* map 64K */
-	fs_enet_immap = ioremap(paddr, size);
+	fs_enet_immap = immr_map(im_cpm);
 #endif
 
 #ifdef CONFIG_CPM2
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 65925b5..775f92f 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -90,7 +90,7 @@
 
 static inline int scc_cr_cmd(struct fs_enet_private *fep, u32 op)
 {
-	cpm8xx_t *cpmp = &((immap_t *)fs_enet_immap)->im_cpm;
+	cpm8xx_t *cpmp = fs_enet_immap;
 	u32 v, ch;
 	int i = 0;
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 925fb60..64a52c5 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -52,7 +52,9 @@
 void cpm_line_cr_cmd(int line, int cmd)
 {
 	ushort val;
-	volatile cpm8xx_t *cp = cpmp;
+	volatile cpm8xx_t *cp;
+	
+	cp = (cpm8xx_t *)immr_map(im_cpm);
 
 	switch (line) {
 	case UART_SMC1:
@@ -187,6 +189,8 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 /* Setup any dynamic params in the uart desc */
 int __init cpm_uart_init_portdesc(void)
 {
+	cpm8xx_t *cpmp = (cpm8xx_t *)immr_map(im_cpm);
+
 	pr_debug("CPM uart[-]:init portdesc\n");
 
 	cpm_uart_nr = 0;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index a99e45e..2a64778 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -37,6 +37,6 @@ static inline void cpm_set_smc_fcr(volatile smc_uart_t * up)
 	up->smc_tfcr = SMC_EB;
 }
 
-#define DPRAM_BASE	((unsigned char *)&cpmp->cp_dpmem[0])
+#define DPRAM_BASE	((unsigned char *)cpm_dpram_addr(0))
 
 #endif
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index 77a44f9..bc75442 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -37,12 +37,11 @@
 
 #ifdef CONFIG_8xx
 #include <asm/8xx_immap.h>
-#include <asm/mpc8xx.h>
 
 #define immr_map(member)						\
 ({									\
 	u32 offset = offsetof(immap_t, member);				\
-	void *addr = ioremap (IMAP_ADDR + offset,			\
+	void *addr = ioremap (get_immrbase() + offset,			\
 			      sizeof( ((immap_t*)0)->member));		\
 	addr;								\
 })
@@ -50,13 +49,17 @@
 #define immr_map_size(member, size)					\
 ({									\
 	u32 offset = offsetof(immap_t, member);				\
-	void *addr = ioremap (IMAP_ADDR + offset, size);		\
+	void *addr = ioremap (get_immrbase() + offset, size);		\
 	addr;								\
 })
 
 #define immr_unmap(addr)		iounmap(addr)
 #endif
 
+#ifndef CPM_IRQ_OFFSET
+#define CPM_IRQ_OFFSET	0	/* Backword-compatibility stuff for the drivers */
+#endif
+
 static inline int uart_baudrate(void)
 {
         return get_baudrate();
diff --git a/include/asm-ppc/fs_pd.h b/include/asm-ppc/fs_pd.h
index 8691327..b3ec063 100644
--- a/include/asm-ppc/fs_pd.h
+++ b/include/asm-ppc/fs_pd.h
@@ -29,8 +29,16 @@ static inline int uart_clock(void)
 	return (((bd_t *) __res)->bi_intfreq);
 }
 
+#ifdef CONFIG_CPM2
 #define cpm2_map(member)	(&cpm2_immr->member)
 #define cpm2_map_size(member, size)	(&cpm2_immr->member)
 #define cpm2_unmap(addr)        do {} while(0)
+#endif
+
+#ifdef CONFIG_8xx
+#define immr_map(member)	(&((immap_t *)IMAP_ADDR)->member)
+#define immr_map_size(member, size)	(&((immap_t *)IMAP_ADDR)->member)
+#define immr_unmap(addr)        do {} while(0)
+#endif
 
 #endif
