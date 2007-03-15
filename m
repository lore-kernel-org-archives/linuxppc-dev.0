Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id DD38EDDD09
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 17:27:47 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2F6RhQP019739
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 23:27:43 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2F6RfQM001682
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 01:27:42 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
Date: Thu, 15 Mar 2007 14:29:09 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DB124@zch01exm26.fsl.freescale.net>
In-Reply-To: <656DBF73-C99B-4C86-9C86-763744FB4C5C@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >>>>>>  arch/powerpc/Kconfig                |    8 --------
> >>>>>>  arch/powerpc/platforms/83xx/Kconfig |   12 ++++++++++--
> >>>>>>  2 files changed, 10 insertions(+), 10 deletions(-)
> >>>>>
> >>>>> What about 85xx QE support?
> >>>>
> >>>> Kumar and I talked about it.  85xx support will be added when QE
> >>>> works
> >>> on 85xx.
> >>>> However,
> >>>> the patch still needs changes.  To allow each CPU family to have
> > its
> >>> own QE option,
> >>>> we'll
> >>>> need to define something like QUICC_ENGINE_83xx and
> >>>> QUICC_ENGINE_85xx,
> >>> and then
> >>>> have
> >>>> something like this:
> >>>>
> >>>> config QUICC_ENGINE
> >>>> 	bool
> >>>> 	default y if QUICC_ENGINE_83xx || QUICC_ENGINE_85xx
> >>>
> >>> I don't think we need these new options.  If there are differences
> >>> between the two SOC versions, presumably not too many, we can
> > address
> >>> them in device tree.  It's better to leave the QUICC_ENGINE option
> > at
> >>> arch/powerpc/Kconfig level, IMHO.
> >>
> >>
> >> The issue isn't dealing with differences between 83xx/85xx.  Its
> >> allowing the choice for only those two subarchs.
> >
> > If you want to make it configurable, I suggest we put it under the
> > "Processor Support" menu in arch/powerpc/Kconfig like Altivec and
SPE.
> > It is a chip feature rather than board.  And we won't need the two
> > redundant options then.
>=20
> Both of those are features of the Core processor, not the platform.
>=20
> I'd prefer this be a platform option.  (I'm not a fan of the
> duplication, but its minor)

Well, that depends on how we define processor.  Is co-processor also a
processor? =20

QE is so generic that can be used across different sub-archs maybe even
archs.  Why doesn't it deserve a place out of "platform support" menu?
An option in the top menu is another choice.

On another thought, it is very unlikely that user chooses a more
expensive chip with QE and won't use it.  So make it non-configurable
and be selected automatically is not a bad idea for me.

- Leo
