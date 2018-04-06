Return-Path: <dalefarns@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Hljq16GCzF1yt
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 02:37:47 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id l18so1770370qtj.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Apr 2018 09:37:47 -0700 (PDT)
MIME-Version: 1.0
Reply-To: dale@farnsworth.org
In-Reply-To: <20180406011720.7728-4-mgreer@animalcreek.com>
References: <20180406011720.7728-1-mgreer@animalcreek.com>
 <20180406011720.7728-4-mgreer@animalcreek.com>
From: Dale Farnsworth <dalefarns@gmail.com>
Date: Fri, 6 Apr 2018 09:37:04 -0700
Message-ID: <CAEy-6SbrGx_PNqmoO_G9JO=S6XFD+WNYO=Zq4Dt8j=fz=mkNeQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc/boot: Remove support for Marvell mv64x60 i2c
 controller
To: Mark Greer <mgreer@animalcreek.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Remi Machet <rmachet@nvidia.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="f403045f39e4fb069f056930ac83"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f403045f39e4fb069f056930ac83
Content-Type: text/plain; charset="UTF-8"

Acked-by: Dale Farnsworth <dale@farnsworth.org>

On Thu, Apr 5, 2018 at 6:17 PM, Mark Greer <mgreer@animalcreek.com> wrote:

> There are no longer any platforms that use Marvell's mv64x60's i2c
> controller so remove its driver.
>
> Signed-off-by: Mark Greer <mgreer@animalcreek.com>
> ---
>  arch/powerpc/boot/Makefile      |   2 +-
>  arch/powerpc/boot/mv64x60_i2c.c | 204 ------------------------------
> ----------
>  2 files changed, 1 insertion(+), 205 deletions(-)
>  delete mode 100644 arch/powerpc/boot/mv64x60_i2c.c
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 58f2dbfba275..bf6a46055ba7 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -120,7 +120,7 @@ src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
>  src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
>  src-wlib-$(CONFIG_PPC_8xx) += mpc8xx.c planetcore.c fsl-soc.c
>  src-wlib-$(CONFIG_PPC_82xx) += pq2.c fsl-soc.c planetcore.c
> -src-wlib-$(CONFIG_EMBEDDED6xx) += mv64x60.c mv64x60_i2c.c ugecon.c
> fsl-soc.c
> +src-wlib-$(CONFIG_EMBEDDED6xx) += mv64x60.c ugecon.c fsl-soc.c
>  src-wlib-$(CONFIG_XILINX_VIRTEX) += uartlite.c
>  src-wlib-$(CONFIG_CPM) += cpm-serial.c
>
> diff --git a/arch/powerpc/boot/mv64x60_i2c.c b/arch/powerpc/boot/mv64x60_
> i2c.c
> deleted file mode 100644
> index 52a3212b6638..000000000000
> --- a/arch/powerpc/boot/mv64x60_i2c.c
> +++ /dev/null
> @@ -1,204 +0,0 @@
> -/*
> - * Bootloader version of the i2c driver for the MV64x60.
> - *
> - * Author: Dale Farnsworth <dfarnsworth@mvista.com>
> - * Maintained by: Mark A. Greer <mgreer@mvista.com>
> - *
> - * 2003, 2007 (c) MontaVista, Software, Inc.  This file is licensed under
> - * the terms of the GNU General Public License version 2.  This program is
> - * licensed "as is" without any warranty of any kind, whether express or
> - * implied.
> - */
> -
> -#include <stdarg.h>
> -#include <stddef.h>
> -#include "types.h"
> -#include "elf.h"
> -#include "page.h"
> -#include "string.h"
> -#include "stdio.h"
> -#include "io.h"
> -#include "ops.h"
> -#include "mv64x60.h"
> -
> -/* Register defines */
> -#define MV64x60_I2C_REG_SLAVE_ADDR                     0x00
> -#define MV64x60_I2C_REG_DATA                           0x04
> -#define MV64x60_I2C_REG_CONTROL                                0x08
> -#define MV64x60_I2C_REG_STATUS                         0x0c
> -#define MV64x60_I2C_REG_BAUD                           0x0c
> -#define MV64x60_I2C_REG_EXT_SLAVE_ADDR                 0x10
> -#define MV64x60_I2C_REG_SOFT_RESET                     0x1c
> -
> -#define MV64x60_I2C_CONTROL_ACK                                0x04
> -#define MV64x60_I2C_CONTROL_IFLG                       0x08
> -#define MV64x60_I2C_CONTROL_STOP                       0x10
> -#define MV64x60_I2C_CONTROL_START                      0x20
> -#define MV64x60_I2C_CONTROL_TWSIEN                     0x40
> -#define MV64x60_I2C_CONTROL_INTEN                      0x80
> -
> -#define MV64x60_I2C_STATUS_BUS_ERR                     0x00
> -#define MV64x60_I2C_STATUS_MAST_START                  0x08
> -#define MV64x60_I2C_STATUS_MAST_REPEAT_START           0x10
> -#define MV64x60_I2C_STATUS_MAST_WR_ADDR_ACK            0x18
> -#define MV64x60_I2C_STATUS_MAST_WR_ADDR_NO_ACK         0x20
> -#define MV64x60_I2C_STATUS_MAST_WR_ACK                 0x28
> -#define MV64x60_I2C_STATUS_MAST_WR_NO_ACK              0x30
> -#define MV64x60_I2C_STATUS_MAST_LOST_ARB               0x38
> -#define MV64x60_I2C_STATUS_MAST_RD_ADDR_ACK            0x40
> -#define MV64x60_I2C_STATUS_MAST_RD_ADDR_NO_ACK         0x48
> -#define MV64x60_I2C_STATUS_MAST_RD_DATA_ACK            0x50
> -#define MV64x60_I2C_STATUS_MAST_RD_DATA_NO_ACK         0x58
> -#define MV64x60_I2C_STATUS_MAST_WR_ADDR_2_ACK          0xd0
> -#define MV64x60_I2C_STATUS_MAST_WR_ADDR_2_NO_ACK       0xd8
> -#define MV64x60_I2C_STATUS_MAST_RD_ADDR_2_ACK          0xe0
> -#define MV64x60_I2C_STATUS_MAST_RD_ADDR_2_NO_ACK       0xe8
> -#define MV64x60_I2C_STATUS_NO_STATUS                   0xf8
> -
> -static u8 *ctlr_base;
> -
> -static int mv64x60_i2c_wait_for_status(int wanted)
> -{
> -       int i;
> -       int status;
> -
> -       for (i=0; i<1000; i++) {
> -               udelay(10);
> -               status = in_le32((u32 *)(ctlr_base +
> MV64x60_I2C_REG_STATUS))
> -                       & 0xff;
> -               if (status == wanted)
> -                       return status;
> -       }
> -       return -status;
> -}
> -
> -static int mv64x60_i2c_control(int control, int status)
> -{
> -       out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_CONTROL), control &
> 0xff);
> -       return mv64x60_i2c_wait_for_status(status);
> -}
> -
> -static int mv64x60_i2c_read_byte(int control, int status)
> -{
> -       out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_CONTROL), control &
> 0xff);
> -       if (mv64x60_i2c_wait_for_status(status) < 0)
> -               return -1;
> -       return in_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_DATA)) & 0xff;
> -}
> -
> -static int mv64x60_i2c_write_byte(int data, int control, int status)
> -{
> -       out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_DATA), data & 0xff);
> -       out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_CONTROL), control &
> 0xff);
> -       return mv64x60_i2c_wait_for_status(status);
> -}
> -
> -int mv64x60_i2c_read(u32 devaddr, u8 *buf, u32 offset, u32 offset_size,
> -                u32 count)
> -{
> -       int i;
> -       int data;
> -       int control;
> -       int status;
> -
> -       if (ctlr_base == NULL)
> -               return -1;
> -
> -       /* send reset */
> -       out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_SOFT_RESET), 0);
> -       out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_SLAVE_ADDR), 0);
> -       out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_EXT_SLAVE_ADDR), 0);
> -       out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_BAUD), (4 << 3) |
> 0x4);
> -
> -       if (mv64x60_i2c_control(MV64x60_I2C_CONTROL_TWSIEN,
> -                               MV64x60_I2C_STATUS_NO_STATUS) < 0)
> -               return -1;
> -
> -       /* send start */
> -       control = MV64x60_I2C_CONTROL_START | MV64x60_I2C_CONTROL_TWSIEN;
> -       status = MV64x60_I2C_STATUS_MAST_START;
> -       if (mv64x60_i2c_control(control, status) < 0)
> -               return -1;
> -
> -       /* select device for writing */
> -       data = devaddr & ~0x1;
> -       control = MV64x60_I2C_CONTROL_TWSIEN;
> -       status = MV64x60_I2C_STATUS_MAST_WR_ADDR_ACK;
> -       if (mv64x60_i2c_write_byte(data, control, status) < 0)
> -               return -1;
> -
> -       /* send offset of data */
> -       control = MV64x60_I2C_CONTROL_TWSIEN;
> -       status = MV64x60_I2C_STATUS_MAST_WR_ACK;
> -       if (offset_size > 1) {
> -               if (mv64x60_i2c_write_byte(offset >> 8, control, status) <
> 0)
> -                       return -1;
> -       }
> -       if (mv64x60_i2c_write_byte(offset, control, status) < 0)
> -               return -1;
> -
> -       /* resend start */
> -       control = MV64x60_I2C_CONTROL_START | MV64x60_I2C_CONTROL_TWSIEN;
> -       status = MV64x60_I2C_STATUS_MAST_REPEAT_START;
> -       if (mv64x60_i2c_control(control, status) < 0)
> -               return -1;
> -
> -       /* select device for reading */
> -       data = devaddr | 0x1;
> -       control = MV64x60_I2C_CONTROL_TWSIEN;
> -       status = MV64x60_I2C_STATUS_MAST_RD_ADDR_ACK;
> -       if (mv64x60_i2c_write_byte(data, control, status) < 0)
> -               return -1;
> -
> -       /* read all but last byte of data */
> -       control = MV64x60_I2C_CONTROL_ACK | MV64x60_I2C_CONTROL_TWSIEN;
> -       status = MV64x60_I2C_STATUS_MAST_RD_DATA_ACK;
> -
> -       for (i=1; i<count; i++) {
> -               data = mv64x60_i2c_read_byte(control, status);
> -               if (data < 0) {
> -                       printf("errors on iteration %d\n", i);
> -                       return -1;
> -               }
> -               *buf++ = data;
> -       }
> -
> -       /* read last byte of data */
> -       control = MV64x60_I2C_CONTROL_TWSIEN;
> -       status = MV64x60_I2C_STATUS_MAST_RD_DATA_NO_ACK;
> -       data = mv64x60_i2c_read_byte(control, status);
> -       if (data < 0)
> -               return -1;
> -       *buf++ = data;
> -
> -       /* send stop */
> -       control = MV64x60_I2C_CONTROL_STOP | MV64x60_I2C_CONTROL_TWSIEN;
> -       status = MV64x60_I2C_STATUS_NO_STATUS;
> -       if (mv64x60_i2c_control(control, status) < 0)
> -               return -1;
> -
> -       return count;
> -}
> -
> -int mv64x60_i2c_open(void)
> -{
> -       u32 v;
> -       void *devp;
> -
> -       devp = find_node_by_compatible(NULL, "marvell,mv64360-i2c");
> -       if (devp == NULL)
> -               goto err_out;
> -       if (getprop(devp, "virtual-reg", &v, sizeof(v)) != sizeof(v))
> -               goto err_out;
> -
> -       ctlr_base = (u8 *)v;
> -       return 0;
> -
> -err_out:
> -       return -1;
> -}
> -
> -void mv64x60_i2c_close(void)
> -{
> -       ctlr_base = NULL;
> -}
> --
> 2.16.2
>
>

--f403045f39e4fb069f056930ac83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by: Dale Farnsworth &lt;<a href=3D"mailto:dale@farns=
worth.org">dale@farnsworth.org</a>&gt;<br><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Thu, Apr 5, 2018 at 6:17 PM, Mark Greer <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:mgreer@animalcreek.com" target=3D"_blank">=
mgreer@animalcreek.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">There are no longer any platforms that use Marvell&#39;s mv64x60&#39;s =
i2c<br>
controller so remove its driver.<br>
<br>
Signed-off-by: Mark Greer &lt;<a href=3D"mailto:mgreer@animalcreek.com">mgr=
eer@animalcreek.com</a>&gt;<br>
---<br>
=C2=A0arch/powerpc/boot/Makefile=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0arch/powerpc/boot/mv64x60_i2c.<wbr>c | 204 --------------------------=
----<wbr>----------<br>
=C2=A02 files changed, 1 insertion(+), 205 deletions(-)<br>
=C2=A0delete mode 100644 arch/powerpc/boot/mv64x60_i2c.<wbr>c<br>
<br>
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile<br>
index 58f2dbfba275..bf6a46055ba7 100644<br>
--- a/arch/powerpc/boot/Makefile<br>
+++ b/arch/powerpc/boot/Makefile<br>
@@ -120,7 +120,7 @@ src-wlib-$(CONFIG_40x) +=3D 4xx.c planetcore.c<br>
=C2=A0src-wlib-$(CONFIG_44x) +=3D 4xx.c ebony.c bamboo.c<br>
=C2=A0src-wlib-$(CONFIG_PPC_8xx) +=3D mpc8xx.c planetcore.c fsl-soc.c<br>
=C2=A0src-wlib-$(CONFIG_PPC_82xx) +=3D pq2.c fsl-soc.c planetcore.c<br>
-src-wlib-$(CONFIG_<wbr>EMBEDDED6xx) +=3D mv64x60.c mv64x60_i2c.c ugecon.c =
fsl-soc.c<br>
+src-wlib-$(CONFIG_<wbr>EMBEDDED6xx) +=3D mv64x60.c ugecon.c fsl-soc.c<br>
=C2=A0src-wlib-$(CONFIG_XILINX_<wbr>VIRTEX) +=3D uartlite.c<br>
=C2=A0src-wlib-$(CONFIG_CPM) +=3D cpm-serial.c<br>
<br>
diff --git a/arch/powerpc/boot/mv64x60_<wbr>i2c.c b/arch/powerpc/boot/mv64x=
60_<wbr>i2c.c<br>
deleted file mode 100644<br>
index 52a3212b6638..000000000000<br>
--- a/arch/powerpc/boot/mv64x60_<wbr>i2c.c<br>
+++ /dev/null<br>
@@ -1,204 +0,0 @@<br>
-/*<br>
- * Bootloader version of the i2c driver for the MV64x60.<br>
- *<br>
- * Author: Dale Farnsworth &lt;<a href=3D"mailto:dfarnsworth@mvista.com">d=
farnsworth@mvista.com</a>&gt;<br>
- * Maintained by: Mark A. Greer &lt;<a href=3D"mailto:mgreer@mvista.com">m=
greer@mvista.com</a>&gt;<br>
- *<br>
- * 2003, 2007 (c) MontaVista, Software, Inc.=C2=A0 This file is licensed u=
nder<br>
- * the terms of the GNU General Public License version 2.=C2=A0 This progr=
am is<br>
- * licensed &quot;as is&quot; without any warranty of any kind, whether ex=
press or<br>
- * implied.<br>
- */<br>
-<br>
-#include &lt;stdarg.h&gt;<br>
-#include &lt;stddef.h&gt;<br>
-#include &quot;types.h&quot;<br>
-#include &quot;elf.h&quot;<br>
-#include &quot;page.h&quot;<br>
-#include &quot;string.h&quot;<br>
-#include &quot;stdio.h&quot;<br>
-#include &quot;io.h&quot;<br>
-#include &quot;ops.h&quot;<br>
-#include &quot;mv64x60.h&quot;<br>
-<br>
-/* Register defines */<br>
-#define MV64x60_I2C_REG_SLAVE_ADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00<br>
-#define MV64x60_I2C_REG_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x04<br>
-#define MV64x60_I2C_REG_CONTROL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08<=
br>
-#define MV64x60_I2C_REG_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0c<br>
-#define MV64x60_I2C_REG_BAUD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0c<br>
-#define MV64x60_I2C_REG_EXT_SLAVE_ADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>
-#define MV64x60_I2C_REG_SOFT_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1c<br>
-<br>
-#define MV64x60_I2C_CONTROL_ACK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<=
br>
-#define MV64x60_I2C_CONTROL_IFLG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>
-#define MV64x60_I2C_CONTROL_STOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>
-#define MV64x60_I2C_CONTROL_START=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20<br>
-#define MV64x60_I2C_CONTROL_TWSIEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x40<br>
-#define MV64x60_I2C_CONTROL_INTEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80<br>
-<br>
-#define MV64x60_I2C_STATUS_BUS_ERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00<br>
-#define MV64x60_I2C_STATUS_MAST_START=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08<br>
-#define MV64x60_I2C_STATUS_MAST_<wbr>REPEAT_START=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x10<br>
-#define MV64x60_I2C_STATUS_MAST_WR_<wbr>ADDR_ACK=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x18<br>
-#define MV64x60_I2C_STATUS_MAST_WR_<wbr>ADDR_NO_ACK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x20<br>
-#define MV64x60_I2C_STATUS_MAST_WR_ACK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x28<br>
-#define MV64x60_I2C_STATUS_MAST_WR_NO_<wbr>ACK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x30<br>
-#define MV64x60_I2C_STATUS_MAST_LOST_<wbr>ARB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x38<br>
-#define MV64x60_I2C_STATUS_MAST_RD_<wbr>ADDR_ACK=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x40<br>
-#define MV64x60_I2C_STATUS_MAST_RD_<wbr>ADDR_NO_ACK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x48<br>
-#define MV64x60_I2C_STATUS_MAST_RD_<wbr>DATA_ACK=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x50<br>
-#define MV64x60_I2C_STATUS_MAST_RD_<wbr>DATA_NO_ACK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x58<br>
-#define MV64x60_I2C_STATUS_MAST_WR_<wbr>ADDR_2_ACK=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0xd0<br>
-#define MV64x60_I2C_STATUS_MAST_WR_<wbr>ADDR_2_NO_ACK=C2=A0 =C2=A0 =C2=A0 =
=C2=A00xd8<br>
-#define MV64x60_I2C_STATUS_MAST_RD_<wbr>ADDR_2_ACK=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0xe0<br>
-#define MV64x60_I2C_STATUS_MAST_RD_<wbr>ADDR_2_NO_ACK=C2=A0 =C2=A0 =C2=A0 =
=C2=A00xe8<br>
-#define MV64x60_I2C_STATUS_NO_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xf8<br>
-<br>
-static u8 *ctlr_base;<br>
-<br>
-static int mv64x60_i2c_wait_for_status(<wbr>int wanted)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i=3D0; i&lt;1000; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(10);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D in_le32(=
(u32 *)(ctlr_base + MV64x60_I2C_REG_STATUS))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp; 0xff;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D w=
anted)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return status;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return -status;<br>
-}<br>
-<br>
-static int mv64x60_i2c_control(int control, int status)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_CO=
NTROL), control &amp; 0xff);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return mv64x60_i2c_wait_for_status(<wbr>status)=
;<br>
-}<br>
-<br>
-static int mv64x60_i2c_read_byte(int control, int status)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_CO=
NTROL), control &amp; 0xff);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_wait_for_status(<wbr>status) &l=
t; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return in_le32((u32 *)(ctlr_base + MV64x60_I2C_=
REG_DATA)) &amp; 0xff;<br>
-}<br>
-<br>
-static int mv64x60_i2c_write_byte(int data, int control, int status)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_DA=
TA), data &amp; 0xff);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_CO=
NTROL), control &amp; 0xff);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return mv64x60_i2c_wait_for_status(<wbr>status)=
;<br>
-}<br>
-<br>
-int mv64x60_i2c_read(u32 devaddr, u8 *buf, u32 offset, u32 offset_size,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 count)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int control;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctlr_base =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* send reset */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_SO=
FT_RESET), 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_SL=
AVE_ADDR), 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_EX=
T_SLAVE_<wbr>ADDR), 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out_le32((u32 *)(ctlr_base + MV64x60_I2C_REG_BA=
UD), (4 &lt;&lt; 3) | 0x4);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_control(MV64x60_<wbr>I2C_CONTRO=
L_TWSIEN,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MV64x60_I2C_STATUS_NO_STATUS) &lt; 0)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* send start */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0control =3D MV64x60_I2C_CONTROL_START | MV64x60=
_I2C_CONTROL_TWSIEN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D MV64x60_I2C_STATUS_MAST_START;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_control(control, status) &lt; 0=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* select device for writing */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D devaddr &amp; ~0x1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0control =3D MV64x60_I2C_CONTROL_TWSIEN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D MV64x60_I2C_STATUS_MAST_WR_<wbr>ADDR=
_ACK;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_write_byte(data, control, statu=
s) &lt; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* send offset of data */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0control =3D MV64x60_I2C_CONTROL_TWSIEN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D MV64x60_I2C_STATUS_MAST_WR_<wbr>ACK;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (offset_size &gt; 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_wri=
te_byte(offset &gt;&gt; 8, control, status) &lt; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_write_byte(<wbr>offset, control=
, status) &lt; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* resend start */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0control =3D MV64x60_I2C_CONTROL_START | MV64x60=
_I2C_CONTROL_TWSIEN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D MV64x60_I2C_STATUS_MAST_<wbr>REPEAT_=
START;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_control(control, status) &lt; 0=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* select device for reading */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D devaddr | 0x1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0control =3D MV64x60_I2C_CONTROL_TWSIEN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D MV64x60_I2C_STATUS_MAST_RD_<wbr>ADDR=
_ACK;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_write_byte(data, control, statu=
s) &lt; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* read all but last byte of data */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0control =3D MV64x60_I2C_CONTROL_ACK | MV64x60_I=
2C_CONTROL_TWSIEN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D MV64x60_I2C_STATUS_MAST_RD_<wbr>DATA=
_ACK;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i=3D1; i&lt;count; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D mv64x60_i2=
c_read_byte(control, status);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data &lt; 0) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;errors on iteration %d\n&quot;, i);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*buf++ =3D data;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* read last byte of data */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0control =3D MV64x60_I2C_CONTROL_TWSIEN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D MV64x60_I2C_STATUS_MAST_RD_<wbr>DATA=
_NO_ACK;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D mv64x60_i2c_read_byte(control, status)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (data &lt; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*buf++ =3D data;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* send stop */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0control =3D MV64x60_I2C_CONTROL_STOP | MV64x60_=
I2C_CONTROL_TWSIEN;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D MV64x60_I2C_STATUS_NO_STATUS;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mv64x60_i2c_control(control, status) &lt; 0=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return count;<br>
-}<br>
-<br>
-int mv64x60_i2c_open(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void *devp;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0devp =3D find_node_by_compatible(NULL, &quot;ma=
rvell,mv64360-i2c&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (devp =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_out;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (getprop(devp, &quot;virtual-reg&quot;, &amp=
;v, sizeof(v)) !=3D sizeof(v))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_out;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ctlr_base =3D (u8 *)v;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-<br>
-err_out:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-}<br>
-<br>
-void mv64x60_i2c_close(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ctlr_base =3D NULL;<br>
-}<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.16.2<br>
<br>
</font></span></blockquote></div><br></div></div>

--f403045f39e4fb069f056930ac83--
