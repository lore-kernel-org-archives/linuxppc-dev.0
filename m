Return-Path: <B34182@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 418511007D3
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2011 16:16:07 +1100 (EST)
From: Liu Gang-B34182 <B34182@freescale.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>, Kumar Gala
 <galak@kernel.crashing.org>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 3/5][v2] fsl-rio: Add two ports and rapidio message
 units support
Date: Sat, 22 Oct 2011 05:15:13 +0000
Message-ID: <9A1C2A9ACC704641BC472A1588CE164712E48E@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1318514922-12672-1-git-send-email-galak@kernel.crashing.org>
 <1318514922-12672-2-git-send-email-galak@kernel.crashing.org>
 <1318514922-12672-3-git-send-email-galak@kernel.crashing.org>
 <0CE8B6BE3C4AD74AB97D9D29BD24E55202367762@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E55202367762@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Alex,

Thanks for your comments, please find my replies inlines.

-----Original Message-----
From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]=20
Sent: Thursday, October 20, 2011 3:54 AM
To: Kumar Gala; linuxppc-dev@ozlabs.org
Cc: Andrew Morton; Liu Gang-B34182; linux-kernel@vger.kernel.org
Subject: RE: [PATCH 3/5][v2] fsl-rio: Add two ports and rapidio message uni=
ts support

On Thu, Oct 13, 2011 at 10:09 AM, Kumar Gala wrote:
>=20
> From: Liu Gang <Gang.Liu@freescale.com>
>=20
> Usually, freescale rapidio endpoint can support one 1X or two 4X LP-=20
> Serial link interfaces, and rapidio message transactions can be=20
> implemented
by
> two

Is the number of 1x ports described correctly?
Can we have two 1x ports as well?=20
[Liu Gang-B34182] Yes you are right. endpoint can also have two 1x ports. I=
'll correct it.

> message units. This patch adds the support of two rapidio ports and=20
> initializes message unit 0 and message unit 1. And these ports and=20
> message
... skip ...
> +
> +  /* Probe the master port phy type */
> +  ccsr =3D in_be32(priv->regs_win + RIO_CCSR + i*0x20);
> +  port->phy_type =3D (ccsr & 1) ? RIO_PHY_SERIAL :
> RIO_PHY_PARALLEL;
> +  dev_info(&dev->dev, "RapidIO PHY type: %s\n",
> +    (port->phy_type =3D=3D RIO_PHY_PARALLEL) ?
> +    "parallel" :
> +    ((port->phy_type =3D=3D RIO_PHY_SERIAL) ?
"serial"
> :
> +     "unknown"));
> +  /* Checking the port training status */
> +  if (in_be32((priv->regs_win + RIO_ESCSR + i*0x20)) & 1)
{
> +   dev_err(&dev->dev, "Port %d is not ready. "
> +    "Try to restart connection...\n", i);
> +   switch (port->phy_type) {
> +   case RIO_PHY_SERIAL:
> +    /* Disable ports */
> +    out_be32(priv->regs_win
> +     + RIO_CCSR + i*0x20, 0);
> +    /* Set 1x lane */
> +    setbits32(priv->regs_win
> +     + RIO_CCSR + i*0x20,
0x02000000);
> +    /* Enable ports */
> +    setbits32(priv->regs_win
> +     + RIO_CCSR + i*0x20,
0x00600000);
> +    break;
> +   case RIO_PHY_PARALLEL:
> +    /* Disable ports */
> +    out_be32(priv->regs_win
> +     + RIO_CCSR + i*0x20,
0x22000000);
> +    /* Enable ports */
> +    out_be32(priv->regs_win
> +     + RIO_CCSR + i*0x20,
0x44000000);
> +    break;
> +   }

Probably this may be a good moment to drop the support for parallel link.
Especially after you renamed controller to "srio" in the device tree.
[Liu Gang-B34182] I'm also considering if we should drop the parallel link =
support and doorbell outbound ATMU configuration.
I found some older powerpc chips support parallel link, like mpc8540 and so=
 on. But DTS files of these chips do not support
Rapidio nodes. For example we can't find rapidio node in arch/powerpc/boot/=
dts/mpc8540ads.dts file. So can we conclude that
these chips with parallel rapidio link do not need the support for rapidio =
module and the code for parallel link can be removed?=20

> +   msleep(100);
> +   if (in_be32((priv->regs_win
> +     + RIO_ESCSR + i*0x20)) & 1) {
> +    dev_err(&dev->dev,
> +     "Port %d restart failed.\n", i);
> +    release_resource(&port->iores);
> +    kfree(priv);
> +    kfree(port);
> +    continue;
> +   }
> +   dev_info(&dev->dev, "Port %d restart
success!\n", i);
> +  }
> +  fsl_rio_info(&dev->dev, ccsr);
> +
... skip ...
>=20
>  struct rio_msg_regs {
> - u32 omr; /* 0xD_3000 - Outbound message 0 mode register
*/
> - u32 osr; /* 0xD_3004 - Outbound message 0 status register
*/
> + u32 omr;
> + u32 osr;
>   u32 pad1;
> - u32 odqdpar; /* 0xD_300C - Outbound message 0 descriptor
> queue
> -      dequeue pointer address register */
> + u32 odqdpar;
>   u32 pad2;
> - u32 osar; /* 0xD_3014 - Outbound message 0 source address
> -      register */
> - u32 odpr; /* 0xD_3018 - Outbound message 0 destination
port
> -      register */
> - u32 odatr; /* 0xD_301C - Outbound message 0 destination
> attributes
> -      Register*/
> - u32 odcr; /* 0xD_3020 - Outbound message 0 double-word
count
> -      register */
> + u32 osar;
> + u32 odpr;
> + u32 odatr;
> + u32 odcr;
>   u32 pad3;
> - u32 odqepar; /* 0xD_3028 - Outbound message 0 descriptor
> queue
> -      enqueue pointer address register */
> + u32 odqepar;
>   u32 pad4[13];
> - u32 imr; /* 0xD_3060 - Inbound message 0 mode register */
> - u32 isr; /* 0xD_3064 - Inbound message 0 status register
*/
> + u32 imr;
> + u32 isr;
>   u32 pad5;
> - u32 ifqdpar; /* 0xD_306C - Inbound message 0 frame queue
> dequeue
> -      pointer address register*/
> + u32 ifqdpar;
>   u32 pad6;
> - u32 ifqepar; /* 0xD_3074 - Inbound message 0 frame queue
> enqueue
> -      pointer address register */
> - u32 pad7[226];
> - u32 odmr; /* 0xD_3400 - Outbound doorbell mode register */
> - u32 odsr; /* 0xD_3404 - Outbound doorbell status register
*/
> + u32 ifqepar;
> + u32 pad7;

Do we need pad7 here?
[Liu Gang-B34182] Yeah, it's not required here. Forgot to remove it when re=
-wrote this struct.

> +};
> +
> +struct rio_dbell_regs {
> + u32 odmr;
> + u32 odsr;
>   u32 res0[4];
> - u32 oddpr; /* 0xD_3418 - Outbound doorbell destination port
> -      register */

... skip ...

>=20
> @@ -340,35 +327,45 @@ fsl_rio_dbell_handler(int irq, void
> *dev_instance)
>     " sid %2.2x tid %2.2x info %4.4x\n",
>     DBELL_SID(dmsg), DBELL_TID(dmsg),
DBELL_INF(dmsg));
>=20
> -  list_for_each_entry(dbell, &port->dbells, node) {
> -   if ((dbell->res->start <=3D DBELL_INF(dmsg)) &&
> -    (dbell->res->end >=3D DBELL_INF(dmsg))) {
> -    found =3D 1;
> -    break;
> +  for (i =3D 0; i < MAX_PORT_NUM; i++) {
> +   if (fsl_dbell->mport[i]) {
> +    list_for_each_entry(dbell,
> +     &fsl_dbell->mport[i]->dbells,
node) {
> +     if ((dbell->res->start
> +      <=3D DBELL_INF(dmsg))
> +      && (dbell->res->end
> +      >=3D DBELL_INF(dmsg))) {
> +      found =3D 1;
> +      break;
> +     }
> +    }
> +    if (found && dbell->dinb) {
> +     dbell->dinb(fsl_dbell->mport[i],
> +      dbell->dev_id,
DBELL_SID(dmsg),
> +      DBELL_TID(dmsg),
> +      DBELL_INF(dmsg));
> +     break;
> +    }
>     }
>    }

Do we need to check for matching DBELL_TID and mport destID here and scan o=
nly doorbell list attached to the right port? Otherwise this may call servi=
ce routine associated with doorbell on a wrong port.
[Liu Gang-B34182] Do you mean to match DBELL_TID and mport DevID? Usually t=
his is a reliable method, but for the rapidio module of powerpc, will encou=
nter some problem. We set the port's DevID by
the register "Base Device ID CSR" defined in Rapidio Specification. The rap=
idio module of powerpc can support two ports but have only one the Base Dev=
ice ID CSR. So these two ports will have the same
DevID. Although there are two registers "Alternate Device ID CSR" to separa=
te deviceIDs for each port, they are specific registers of the freescale ra=
pidio and can't be accessed by getting the extended feature
space block offset. For this doobell issue, in order to call a right servic=
e routine, perhaps we should ensure that different ports in different "res-=
>start and res->end" configurations.

> -  if (found) {
> -   dbell->dinb(port, dbell->dev_id,
> -     DBELL_SID(dmsg),
> -     DBELL_TID(dmsg),
DBELL_INF(dmsg));
> -  } else {
> +
> +  if (!found) {
>     pr_debug
>      ("RIO: spurious doorbell,"
>      " sid %2.2x tid %2.2x info %4.4x\n",
>      DBELL_SID(dmsg), DBELL_TID(dmsg),
>      DBELL_INF(dmsg));
>    }
> -  setbits32(&rmu->msg_regs->dmr, DOORBELL_DMR_DI);
> -  out_be32(&rmu->msg_regs->dsr, DOORBELL_DSR_DIQI);
> +  setbits32(&fsl_dbell->dbell_regs->dmr, DOORBELL_DMR_DI);
> +  out_be32(&fsl_dbell->dbell_regs->dsr,
DOORBELL_DSR_DIQI);
>   }
>=20
>  out:
>   return IRQ_HANDLED;
>  }
>=20
... skip ...

> @@ -1114,50 +1104,48 @@ int fsl_rio_setup_rmu(struct rio_mport *mport,=20
> struct device_node *node)  {
>   struct rio_priv *priv;
>   struct fsl_rmu *rmu;
> - struct rio_ops *ops;
> + u64 msg_start;
> + const u32 *msg_addr;
> + int mlen;
> + int aw;
>=20
> - if (!mport || !mport->priv || !node)
> -  return -1;
> + if (!mport || !mport->priv)
> +  return -EFAULT;
EINVAL may be better here?
[Liu Gang-B34182] Yes EINVAL will be better and I'll correct. Thanks!

> +
> + priv =3D mport->priv;
> +
> + if (!node) {
> +  dev_warn(priv->dev, "Can't get %s property 'fsl,rmu'\n",
> +   priv->dev->of_node->full_name);
> +  return -EFAULT;
EINVAL as well?
[Liu Gang-B34182] Ditto.

> + }

Regards,

Alex.=
