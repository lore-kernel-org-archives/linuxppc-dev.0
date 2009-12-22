Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A56CCB7BC8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:01:00 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 65F0ABADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:00:55 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/13] mpc52xx: add SCLPC register bit definitions
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220800.54373.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:00:54 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 arch/powerpc/include/asm/mpc52xx.h |   40 +++++++++++++++++++++++++++-----=
=2D--
 1 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index 57f8335..c659d1d 100644
=2D-- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -17,6 +17,7 @@
 #include <asm/types.h>
 #include <asm/prom.h>
 #include <asm/mpc5xxx.h>
+#include <linux/bitops.h>
 #endif /* __ASSEMBLY__ */
=20
 #include <linux/suspend.h>
@@ -212,11 +213,34 @@ struct mpc52xx_sclpc {
=20
 	u32 fifo_data;		/* 0x40	FIFO data word register */
 	u32 fifo_status;	/* 0x44	FIFO status register */
=2D	u8 fifo_control;	/* 0x48	FIFO control register */
=2D	u8 reserved2[3];
+	u32 fifo_control;	/* 0x48	FIFO control register */
 	u32 fifo_alarm;		/* 0x4C	FIFO alarm register */
 };
=20
+#define MPC52xx_SCLPC_FIFO_SIZE			(0x200)		/* FIFO size 512 bytes */
+
+#define MPC52xx_SCLPC_CONTROL_CS(cs)		((uint32_t)(cs) << 24)	/* CSX bits */
+#define MPC52xx_SCLPC_CONTROL_FLUSH		BIT(17)		/* flush, used in last packe=
t  */
+#define MPC52xx_SCLPC_CONTROL_RWB_RECEIVE	BIT(16)		/* RWb bit, 1 =3D recei=
ve */
+#define MPC52xx_SCLPC_CONTROL_DAI		BIT(8)
+
+#define MPC52xx_SCLPC_ENABLE_RC			BIT(24)		/* reset controller bit */
+#define MPC52xx_SCLPC_ENABLE_RF			BIT(16)		/* reset FIFO bit */
+#define MPC52xx_SCLPC_ENABLE_AIE		BIT(9)		/* abort interrupt enable bit */
+#define MPC52xx_SCLPC_ENABLE_NIE		BIT(8)		/* normal interrupt enable bit */
+#define MPC52xx_SCLPC_ENABLE_ME			BIT(0)		/* master enable bit */
+
+#define MPC52xx_SCLPC_PACKET_SIZE_RESTART	BIT(24)
+
+#define MPC52xx_SCLPC_STATUS_AT			BIT(28)		/* abort termination */
+#define MPC52xx_SCLPC_STATUS_NT			BIT(24)		/* normal termination */
+#define MPC52xx_SCLPC_STATUS_BYTES_DONE_MASK	(0x00FFFFFFU)	/* bytes done b=
it mask */
+
+#define MPC52xx_SLPC_FIFO_STATUS_ERR		BIT(22)	/* error bit */
+
+#define MPC52xx_SLPC_FIFO_CONTROL_GR(gr)	((gr) << 24)	/* granularity bits =
*/
+
+
 /* Clock Distribution control */
 struct mpc52xx_cdm {
 	u32 jtag_id;		/* CDM + 0x00  reg0 read only */
@@ -304,19 +328,18 @@ extern void mpc52xx_restart(char *cmd);
 struct mpc52xx_gpt_priv;
 extern struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq);
 extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 perio=
d,
=2D                            int continuous);
+				   int continuous);
 extern u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt);
 extern int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
=20
 /* mpc52xx_lpbfifo.c */
 #define MPC52XX_LPBFIFO_FLAG_READ		(0)
=2D#define MPC52XX_LPBFIFO_FLAG_WRITE		(1<<0)
=2D#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT	(1<<1)
=2D#define MPC52XX_LPBFIFO_FLAG_NO_DMA		(1<<2)
=2D#define MPC52XX_LPBFIFO_FLAG_POLL_DMA		(1<<3)
+#define MPC52XX_LPBFIFO_FLAG_WRITE		BIT(0)
+#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT	BIT(1)
+#define MPC52XX_LPBFIFO_FLAG_NO_DMA		BIT(2)
+#define MPC52XX_LPBFIFO_FLAG_POLL_DMA		BIT(3)
=20
 struct mpc52xx_lpbfifo_request {
=2D	struct list_head list;
=20
 	/* localplus bus address */
 	unsigned int cs;
@@ -383,4 +406,3 @@ extern char saved_sram[0x4000]; /* reuse buffer from mp=
c52xx suspend */
 #endif /* CONFIG_PM */
=20
 #endif /* __ASM_POWERPC_MPC52xx_H__ */
=2D
=2D-=20
1.6.5.5


=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
