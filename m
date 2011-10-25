Return-Path: <B34182@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DC5AF1007D9
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2011 21:40:10 +1100 (EST)
From: Liu Gang-B34182 <B34182@freescale.com>
To: "'Bounine, Alexandre'" <Alexandre.Bounine@idt.com>, 'Kumar Gala'
 <galak@kernel.crashing.org>, "'linuxppc-dev@ozlabs.org'"
 <linuxppc-dev@ozlabs.org>, Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 3/5][v2] fsl-rio: Add two ports and rapidio message
 units support
Date: Tue, 25 Oct 2011 10:39:59 +0000
Message-ID: <9A1C2A9ACC704641BC472A1588CE164713112C@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1318514922-12672-1-git-send-email-galak@kernel.crashing.org>
 <1318514922-12672-2-git-send-email-galak@kernel.crashing.org>
 <1318514922-12672-3-git-send-email-galak@kernel.crashing.org>
 <0CE8B6BE3C4AD74AB97D9D29BD24E55202367762@CORPEXCH1.na.ads.idt.com>
 <9A1C2A9ACC704641BC472A1588CE164712E48E@039-SN1MPN1-005.039d.mgd.msft.net>
 <0CE8B6BE3C4AD74AB97D9D29BD24E55202368098@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E55202368098@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: 'Andrew Morton' <akpm@osdl.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]=20
Sent: Monday, October 24, 2011 9:51 PM
To: Liu Gang-B34182; Kumar Gala; linuxppc-dev@ozlabs.org; Zang Roy-R61911
Cc: Andrew Morton; linux-kernel@vger.kernel.org
Subject: RE: [PATCH 3/5][v2] fsl-rio: Add two ports and rapidio message uni=
ts support

On Sat, Oct 22, 2011 at 1:15 AM, Liu Gang-B34182 <B34182@freescale.com>
wrote:
>=20
> From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]
> Sent: Thursday, October 20, 2011 3:54 AM
> To: Kumar Gala; linuxppc-dev@ozlabs.org
> Cc: Andrew Morton; Liu Gang-B34182; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 3/5][v2] fsl-rio: Add two ports and rapidio
message
> units support
>=20
> On Thu, Oct 13, 2011 at 10:09 AM, Kumar Gala wrote:
> >
> > From: Liu Gang <Gang.Liu@freescale.com>
> >
> > Usually, freescale rapidio endpoint can support one 1X or two 4X LP-=20
> > Serial link interfaces, and rapidio message transactions can be=20
> > implemented
> by
> > two
>=20
> Is the number of 1x ports described correctly?
> Can we have two 1x ports as well?
> [Liu Gang-B34182] Yes you are right. endpoint can also have two 1x=20
> ports. I'll correct it.
>=20
> > message units. This patch adds the support of two rapidio ports and=20
> > initializes message unit 0 and message unit 1. And these ports and=20
> > message
> ... skip ...
> > +
> > +  /* Probe the master port phy type */  ccsr =3D=20
> > + in_be32(priv->regs_win + RIO_CCSR + i*0x20);  port->phy_type =3D=20
> > + (ccsr & 1) ? RIO_PHY_SERIAL :
> > RIO_PHY_PARALLEL;
> > +  dev_info(&dev->dev, "RapidIO PHY type: %s\n",
> > +    (port->phy_type =3D=3D RIO_PHY_PARALLEL) ?
> > +    "parallel" :
> > +    ((port->phy_type =3D=3D RIO_PHY_SERIAL) ?
> "serial"
> > :
> > +     "unknown"));
> > +  /* Checking the port training status */  if=20
> > + (in_be32((priv->regs_win + RIO_ESCSR + i*0x20)) & 1)
> {
> > +   dev_err(&dev->dev, "Port %d is not ready. "
> > +    "Try to restart connection...\n", i);
> > +   switch (port->phy_type) {
> > +   case RIO_PHY_SERIAL:
> > +    /* Disable ports */
> > +    out_be32(priv->regs_win
> > +     + RIO_CCSR + i*0x20, 0);
> > +    /* Set 1x lane */
> > +    setbits32(priv->regs_win
> > +     + RIO_CCSR + i*0x20,
> 0x02000000);
> > +    /* Enable ports */
> > +    setbits32(priv->regs_win
> > +     + RIO_CCSR + i*0x20,
> 0x00600000);
> > +    break;
> > +   case RIO_PHY_PARALLEL:
> > +    /* Disable ports */
> > +    out_be32(priv->regs_win
> > +     + RIO_CCSR + i*0x20,
> 0x22000000);
> > +    /* Enable ports */
> > +    out_be32(priv->regs_win
> > +     + RIO_CCSR + i*0x20,
> 0x44000000);
> > +    break;
> > +   }
>=20
> Probably this may be a good moment to drop the support for parallel=20
> link.
> Especially after you renamed controller to "srio" in the device tree.
> [Liu Gang-B34182] I'm also considering if we should drop the parallel=20
> link support and doorbell outbound ATMU configuration.
> I found some older powerpc chips support parallel link, like mpc8540=20
> and so on. But DTS files of these chips do not support Rapidio nodes.=20
> For example we can't find rapidio node in=20
> arch/powerpc/boot/dts/mpc8540ads.dts file. So can we conclude that=20
> these chips with parallel rapidio link do not need the support for=20
> rapidio module and the code for parallel link can be removed?

We are not aware about any use of tsi500 P-RIO switches.
[Liu Gang-B34182] Yes perhaps no one uses the P-RIO switches now. I have us=
ed the tsi578 and remembered that this switch supports only 1x and 4x srio =
ports.
I would consider parallel implementation as an early stage of RapidIO devel=
opment which may be safely dropped.
[Liu Gang-B34182] Yeah, I agree with you.
I will keep P-RIO related definitions only because they are part of the spe=
c. I consider removing tsi500 switch driver as well.
[Liu Gang-B34182] I'll remove the support for P-RIO in fsl-rio driver. I th=
ink it's better to keep clear code than keep a rarely used function.
Moreover, we can provide separate patches if P-RIO needed again.

>=20
> > +   msleep(100);
... skip ...

>=20
> >
> > @@ -340,35 +327,45 @@ fsl_rio_dbell_handler(int irq, void
> > *dev_instance)
> >     " sid %2.2x tid %2.2x info %4.4x\n",
> >     DBELL_SID(dmsg), DBELL_TID(dmsg),
> DBELL_INF(dmsg));
> >
> > -  list_for_each_entry(dbell, &port->dbells, node) {
> > -   if ((dbell->res->start <=3D DBELL_INF(dmsg)) &&
> > -    (dbell->res->end >=3D DBELL_INF(dmsg))) {
> > -    found =3D 1;
> > -    break;
> > +  for (i =3D 0; i < MAX_PORT_NUM; i++) {
> > +   if (fsl_dbell->mport[i]) {
> > +    list_for_each_entry(dbell,
> > +     &fsl_dbell->mport[i]->dbells,
> node) {
> > +     if ((dbell->res->start
> > +      <=3D DBELL_INF(dmsg))
> > +      && (dbell->res->end
> > +      >=3D DBELL_INF(dmsg))) {
> > +      found =3D 1;
> > +      break;
> > +     }
> > +    }
> > +    if (found && dbell->dinb) {
> > +     dbell->dinb(fsl_dbell->mport[i],
> > +      dbell->dev_id,
> DBELL_SID(dmsg),
> > +      DBELL_TID(dmsg),
> > +      DBELL_INF(dmsg));
> > +     break;
> > +    }
> >     }
> >    }
>=20
> Do we need to check for matching DBELL_TID and mport destID here and=20
> scan only doorbell list attached to the right port? Otherwise this may=20
> call service routine associated with doorbell on a wrong port.
> [Liu Gang-B34182] Do you mean to match DBELL_TID and mport DevID?


Yes.

> Usually this is a reliable method, but for the rapidio module of=20
> powerpc, will encounter some problem. We set the port's DevID by the=20
> register "Base Device ID CSR" defined in Rapidio Specification.
The
> rapidio module of powerpc can support two ports but have only one the=20
> Base Device ID CSR. So these two ports will have the same DevID.=20
> Although there are two registers "Alternate Device ID CSR" to separate=20
> deviceIDs for each port, they are specific registers of the freescale=20
> rapidio and can't be accessed by getting the extended
feature
> space block offset. For this doobell issue, in order to call a right=20
> service routine, perhaps we should ensure that different ports in=20
> different "res->start and res->end" configurations.

This gives us an issue that has to be solved at some point.
Splitting doorbell resources may be a way in this case but should be consid=
ered in context of RIO network with different endpoints and therefore it wi=
ll be some device-specific quirk.

Probably the best approach in this case is to keep doorbell handler as it i=
s now (for purpose of this patchset) and address doorbell resource assignme=
nt during enumeration/discovery. At least this has to be well commented.=20
[Liu Gang-B34182] I think this is a very complex issue, and could be very d=
ifficult to be resolved if we can't separate DevIDs for each port.
Based on the current architecture of the RIO driver, the doorbell resource =
will be assigned by the application. For example, RIONET will assign the do=
orbell resource like this:
	if ((rc =3D rio_request_inb_dbell(rnet->mport,
					(void *)ndev,
					RIONET_DOORBELL_JOIN,
					RIONET_DOORBELL_LEAVE,
					rionet_dbell_event)) < 0)
		goto out;
The res->start and res->end were defined by RIONET to RIONET_DOORBELL_JOIN =
(0x1000) and RIONET_DOORBELL_LEAVE (0x1001). And RIONET will send a doorbel=
l
package like this:
	rio_send_doorbell(peer->rdev, RIONET_DOORBELL_JOIN);=20
When the destination port of this doorbell package has been assigned the sa=
me res->start and res->end, it can work well. But when we try to address do=
orbell resource assignment during enumeration/discovery, and give the diffe=
rent doorbell resource to different port, how an endpoint to get the destin=
ation port resource it wants to send to a doorbell package?

In fact, I also encountered some other issues due to the two ports sharing =
one CSR. For example the "Host base device ID lock command and status regis=
ter" and "Port General control command and status register", these caused s=
ome issues when enumeration/discovery, and very difficult to be resolved
based on current RIO architecture.

>=20
> > -  if (found) {
> > -   dbell->dinb(port, dbell->dev_id,
> > -     DBELL_SID(dmsg),
> > -     DBELL_TID(dmsg),
> DBELL_INF(dmsg));
> > -  } else {
> > +
> > +  if (!found) {
> >     pr_debug
> >      ("RIO: spurious doorbell,"
> >      " sid %2.2x tid %2.2x info %4.4x\n",
> >      DBELL_SID(dmsg), DBELL_TID(dmsg),
> >      DBELL_INF(dmsg));
> >    }
> > -  setbits32(&rmu->msg_regs->dmr, DOORBELL_DMR_DI);
> > -  out_be32(&rmu->msg_regs->dsr, DOORBELL_DSR_DIQI);
> > +  setbits32(&fsl_dbell->dbell_regs->dmr, DOORBELL_DMR_DI); =20
> > + out_be32(&fsl_dbell->dbell_regs->dsr,
> DOORBELL_DSR_DIQI);
> >   }
> >
> >  out:
> >   return IRQ_HANDLED;
> >  }
> >
... skip ...
=20
Regards,

Alex.
