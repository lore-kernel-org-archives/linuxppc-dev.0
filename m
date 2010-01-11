Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 9E8BFB7C27
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:21:43 +1100 (EST)
Received: by ywh39 with SMTP id 39so20241669ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 11:21:42 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220800.54373.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220800.54373.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 12:21:22 -0700
Message-ID: <fa686aa41001111121u5c943fc7p789c0ec0b41af883@mail.gmail.com>
Subject: Re: [PATCH 03/13] mpc52xx: add SCLPC register bit definitions
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 22, 2009 at 12:00 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>

This should probably be merged with the first patch to actually use
the bit definitions.  More comments below.

> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/include/asm/mpc52xx.h | =A0 40 ++++++++++++++++++++++++++=
+--------
> =A01 files changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index 57f8335..c659d1d 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -17,6 +17,7 @@
> =A0#include <asm/types.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/mpc5xxx.h>
> +#include <linux/bitops.h>
> =A0#endif /* __ASSEMBLY__ */
>
> =A0#include <linux/suspend.h>
> @@ -212,11 +213,34 @@ struct mpc52xx_sclpc {
>
> =A0 =A0 =A0 =A0u32 fifo_data; =A0 =A0 =A0 =A0 =A0/* 0x40 FIFO data word r=
egister */
> =A0 =A0 =A0 =A0u32 fifo_status; =A0 =A0 =A0 =A0/* 0x44 FIFO status regist=
er */
> - =A0 =A0 =A0 u8 fifo_control; =A0 =A0 =A0 =A0/* 0x48 FIFO control regist=
er */
> - =A0 =A0 =A0 u8 reserved2[3];
> + =A0 =A0 =A0 u32 fifo_control; =A0 =A0 =A0 /* 0x48 FIFO control register=
 */
> =A0 =A0 =A0 =A0u32 fifo_alarm; =A0 =A0 =A0 =A0 /* 0x4C FIFO alarm registe=
r */
> =A0};
>
> +#define MPC52xx_SCLPC_FIFO_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(0x200) =A0 =A0 =A0 =A0 /* FIFO size 512 bytes */
> +
> +#define MPC52xx_SCLPC_CONTROL_CS(cs) =A0 =A0 =A0 =A0 =A0 ((uint32_t)(cs)=
 << 24) =A0/* CSX bits */
> +#define MPC52xx_SCLPC_CONTROL_FLUSH =A0 =A0 =A0 =A0 =A0 =A0BIT(17) =A0 =
=A0 =A0 =A0 /* flush, used in last packet =A0*/
> +#define MPC52xx_SCLPC_CONTROL_RWB_RECEIVE =A0 =A0 =A0BIT(16) =A0 =A0 =A0=
 =A0 /* RWb bit, 1 =3D receive */
> +#define MPC52xx_SCLPC_CONTROL_DAI =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(8)
> +
> +#define MPC52xx_SCLPC_ENABLE_RC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0BIT(24) =A0 =A0 =A0 =A0 /* reset controller bit */
> +#define MPC52xx_SCLPC_ENABLE_RF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0BIT(16) =A0 =A0 =A0 =A0 /* reset FIFO bit */
> +#define MPC52xx_SCLPC_ENABLE_AIE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(9) =A0 =
=A0 =A0 =A0 =A0/* abort interrupt enable bit */
> +#define MPC52xx_SCLPC_ENABLE_NIE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(8) =A0 =
=A0 =A0 =A0 =A0/* normal interrupt enable bit */
> +#define MPC52xx_SCLPC_ENABLE_ME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0BIT(0) =A0 =A0 =A0 =A0 =A0/* master enable bit */
> +
> +#define MPC52xx_SCLPC_PACKET_SIZE_RESTART =A0 =A0 =A0BIT(24)
> +
> +#define MPC52xx_SCLPC_STATUS_AT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0BIT(28) =A0 =A0 =A0 =A0 /* abort termination */
> +#define MPC52xx_SCLPC_STATUS_NT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0BIT(24) =A0 =A0 =A0 =A0 /* normal termination */
> +#define MPC52xx_SCLPC_STATUS_BYTES_DONE_MASK =A0 (0x00FFFFFFU) =A0 /* by=
tes done bit mask */
> +
> +#define MPC52xx_SLPC_FIFO_STATUS_ERR =A0 =A0 =A0 =A0 =A0 BIT(22) /* erro=
r bit */
> +
> +#define MPC52xx_SLPC_FIFO_CONTROL_GR(gr) =A0 =A0 =A0 ((gr) << 24) =A0 =
=A0/* granularity bits */
> +
> +
> =A0/* Clock Distribution control */
> =A0struct mpc52xx_cdm {
> =A0 =A0 =A0 =A0u32 jtag_id; =A0 =A0 =A0 =A0 =A0 =A0/* CDM + 0x00 =A0reg0 =
read only */
> @@ -304,19 +328,18 @@ extern void mpc52xx_restart(char *cmd);
> =A0struct mpc52xx_gpt_priv;
> =A0extern struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq);
> =A0extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 p=
eriod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int continuous);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =
continuous);

Unrelated whitespace change?

> =A0extern u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt);
> =A0extern int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
>
> =A0/* mpc52xx_lpbfifo.c */
> =A0#define MPC52XX_LPBFIFO_FLAG_READ =A0 =A0 =A0 =A0 =A0 =A0 =A0(0)
> -#define MPC52XX_LPBFIFO_FLAG_WRITE =A0 =A0 =A0 =A0 =A0 =A0 (1<<0)
> -#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT =A0 =A0 =A0(1<<1)
> -#define MPC52XX_LPBFIFO_FLAG_NO_DMA =A0 =A0 =A0 =A0 =A0 =A0(1<<2)
> -#define MPC52XX_LPBFIFO_FLAG_POLL_DMA =A0 =A0 =A0 =A0 =A0(1<<3)
> +#define MPC52XX_LPBFIFO_FLAG_WRITE =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> +#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT =A0 =A0 =A0BIT(1)
> +#define MPC52XX_LPBFIFO_FLAG_NO_DMA =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
> +#define MPC52XX_LPBFIFO_FLAG_POLL_DMA =A0 =A0 =A0 =A0 =A0BIT(3)

I prefer the (1<<n) style myself.

>
> =A0struct mpc52xx_lpbfifo_request {
> - =A0 =A0 =A0 struct list_head list;

Why is the list head being removed?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
