Return-Path: <B21989@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 835692C02AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 17:32:42 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Anthony Foiani <tkil@scrye.com>
Subject: RE: SATA hang on 8315E triggered by heavy flash write?
Date: Thu, 30 May 2013 07:32:10 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C90B1E8E68@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1369172643.1374.15@scott-Lenovo-G560>
 <gppwj3ayu.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1DFA93@039-SN2MPN1-013.039d.mgd.msft.net>
 <g8v362qg8.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E0FFA@039-SN2MPN1-013.039d.mgd.msft.net>
 <g4ndt3f5q.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E567D@039-SN2MPN1-013.039d.mgd.msft.net>
 <g7gik2bga.fsf@dworkin.scrye.com>
In-Reply-To: <g7gik2bga.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Anthony Foiani,

I found a MPC8315ERDB rev1.0 board and did some tests.
First there is no limit speed issue on the board, so it seems it may only h=
appen on the MPC8315DS board.
Second, the SATA can work well with NOR write operation on the ERDB board.=
=20
So the two issues happened to you should be board issues.


Best Regards,=20
Shaohui Xie
> -----Original Message-----
> From: Anthony Foiani [mailto:tkil@scrye.com]
> Sent: Tuesday, May 28, 2013 8:30 AM
> To: Xie Shaohui-B21989
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> Subject: Re: SATA hang on 8315E triggered by heavy flash write?
>=20
> Shaohio --
>=20
> Once again, thanks for the reply.
>=20
> Xie Shaohui-B21989 <B21989@freescale.com> writes:
>=20
> > it seems [recovery or lack of recovery is] not due to speed limiting
> > code, 1.5Gbps is still used to recover link.
>=20
> Right, I noticed this in my later email on this topic.
>=20
> > for the speed limit issue, I checked 3.4.rc7 kernel, there seems a
> > place can be used to limit the speed for 8315:
> >
> > 	if (!of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc8315-
> sata")) {
> > 		temp =3D ioread32(csr_base + TRANSCFG);
> > 		temp =3D temp & 0xffffffe0;
> > 		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
> > 	} else {
> > 		/* the speed limitation code for 8315 may can be put here.
> > 		* just move the original code which wrapped by "#ifdef
> CONFIG_MPC8315_DS" here.
> > 		* please let me know if you will give a try. */
> > 	}
>=20
> It's not clear that all uses of the MPC8315 SATA controller have this
> problem.  It obviously occured on the 8315DS, but apparently that board
> never made it to production; it might or might not happen on the 8315ERDB=
;
> and it clearly happens on my vendor's board.
>=20
> Given this lack of knowledge, Scott Wood was very hesitant to implement
> any far-reaching changes, because we could not pin down exactly what had
> to be tested.
>=20
> My original patch:
>=20
>   http://article.gmane.org/gmane.linux.ports.ppc.embedded/58710
>=20
> did the speed limiting directly in the sata_fsl code; Jeff Garzik
> mentioned that there was some existing infrastructure for this, and I
> inferred that he would prefer that I use it.
>=20
> So that's what my final patch does, and it's keyed off a single OF value.
>=20
> There's a small chance that I'll have the opportunity to move the project
> to 3.9 (especially if that release gets declared long-term-stable).  Even
> then, I unfortunately won't have the bandwidth to pursue getting any of
> these approaches into mainline.
> The best I can do is get them onto the lists so that others might be able
> to benefit later.
>=20
> Either way, thanks again.  I'll try to put together a package for my
> vendor to test with; once I have demonstrated that there is a problem
> with their hardware, they have been gracious about accepting that result
> and pursuing it with Freescale if necessary.
>=20
> Thanks again for your help!
>=20
> Best regards,
> Anthony Foiani
