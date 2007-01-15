Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 04303DDE24
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 19:06:53 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0F86qfq029872
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 01:06:52 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0F86oMx021517
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 02:06:51 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][5/5] powerpc: Add the general support for
	EmbeddedFloating-Point instructions
Date: Mon, 15 Jan 2007 16:06:49 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816BE7@zch01exm20.fsl.freescale.net>
In-Reply-To: <1168599942.5011.21.camel@localhost.localdomain>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: 2007=C4=EA1=D4=C212=C8=D5 19:06
> To: Zhu Ebony-r57400
> Cc: Kumar Gala; linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: RE: [patch][5/5] powerpc: Add the general support=20
> for EmbeddedFloating-Point instructions
>=20
>=20
> > > Why do we need a separate ret_from_except_spe_full?
> >=20
> > I'm not sure if the kernel will return from exception in a=20
> > multi-thread way, but the truth is if restoring EVRs in exsiting=20
> > ret_from_except_full, some non-SPE exception will try to=20
> retore EVR.=20
> > At that time, the MSR[SPE] may not be enabled, which will=20
> cause error.
>=20
> Hrm... you can restore them before returning from the=20
> exception if you are careful about doing that with=20
> preempt/irqs off I suppose.
>=20
> Ben.

If so, the existing ret_from_except_full needs to be modified
since it only restores 32bit GPRs, and I'm afraid the instructions to =
operate
32bit GPRs will break the hi-words of 64bit GPRs.

Ebony
