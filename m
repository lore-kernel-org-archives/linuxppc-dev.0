Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id E00B1B7C0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:16:22 +1100 (EST)
Received: by gxk28 with SMTP id 28so14779633gxk.9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 11:16:20 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220759.23453.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220759.23453.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 12:15:58 -0700
Message-ID: <fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
Subject: Re: [PATCH 02/13] powerpc/5200: LocalPlus driver: use SCLPC register
	structure
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

On Mon, Dec 21, 2009 at 11:59 PM, Roman Fietze
<roman.fietze@telemotive.de> wrote:

No patch description?  Very few patches are sufficiently described by
the subject line alone.  Tell me what the problem is, what the patch
changes, and why.

> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 24 +++=
+++++
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 79 +++++++++++----=
----------
> =A02 files changed, 59 insertions(+), 44 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index b664ce7..57f8335 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -193,6 +193,30 @@ struct mpc52xx_xlb {
> =A0#define MPC52xx_XLB_CFG_PLDIS =A0 =A0 =A0 =A0 =A0(1 << 31)
> =A0#define MPC52xx_XLB_CFG_SNOOP =A0 =A0 =A0 =A0 =A0(1 << 15)
>
> +/* SCLPC */
> +struct mpc52xx_sclpc {
> + =A0 =A0 =A0 union {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 restart; =A0 =A0 /* 0x00 restart bit */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 packet_size; /* 0x00 packet size regist=
er */
> + =A0 =A0 =A0 } packet_size;
> + =A0 =A0 =A0 u32 start_address; =A0 =A0 =A0/* 0x04 start Address registe=
r */
> + =A0 =A0 =A0 u32 control; =A0 =A0 =A0 =A0 =A0 =A0/* 0x08 control registe=
r */
> + =A0 =A0 =A0 u32 enable; =A0 =A0 =A0 =A0 =A0 =A0 /* 0x0C enable register=
 */
> + =A0 =A0 =A0 u32 unused0; =A0 =A0 =A0 =A0 =A0 =A0/* 0x10 */
> + =A0 =A0 =A0 union {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 status; =A0 =A0 =A0/* 0x14 status regist=
er bits */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 bytes_done; /* 0x14 bytes done register=
 bits, read only */
> + =A0 =A0 =A0 } bytes_done_status;
> +
> + =A0 =A0 =A0 u32 reserved1[(0x40-0x18) / sizeof(u32)]; =A0 =A0 =A0 /* 0x=
18 .. 0x3c */
> +
> + =A0 =A0 =A0 u32 fifo_data; =A0 =A0 =A0 =A0 =A0/* 0x40 FIFO data word re=
gister */
> + =A0 =A0 =A0 u32 fifo_status; =A0 =A0 =A0 =A0/* 0x44 FIFO status registe=
r */
> + =A0 =A0 =A0 u8 fifo_control; =A0 =A0 =A0 =A0/* 0x48 FIFO control regist=
er */
> + =A0 =A0 =A0 u8 reserved2[3];
> + =A0 =A0 =A0 u32 fifo_alarm; =A0 =A0 =A0 =A0 /* 0x4C FIFO alarm register=
 */
> +};

Please don't.  I know that a lot of other 5200 code uses register map
structures in this way, but I consider it bad practice.  I coded this
driver without a structure for a reason.  The reason I haven't removed
the other 5200 register map structures is the code impact would be
huge, it would probably cause breakage, and it would break all
out-of-tree patches touching the same code for no measurable
advantage.

For this code, there is no advantage to changing the register access
method, and it generates more work in other areas.  Even if I
preferred register map structures I would resist applying this patch.

Please drop from your series.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
