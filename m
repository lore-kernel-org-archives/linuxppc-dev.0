Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5CBDFDDEE8
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 02:52:11 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l1QFq7KA022505
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 08:52:07 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1QFq5nu028787
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 09:52:06 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC 2/7] Unite all PCI-e on 85xx and 86xx under one codebase
Date: Mon, 26 Feb 2007 23:52:04 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5AD714@zch01exm23.fsl.freescale.net>
In-Reply-To: <ED7561C6-CCD9-4F8F-9385-23FCEF2A7722@kernel.crashing.org>
References: <Pine.LNX.4.61.0702152043270.9034@ld0175-tx32.am.freescale.net>
	<EE5E84C5-87F0-4836-AE28-1EE0E2CC556C@kernel.crashing.org>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5AD638@zch01exm23.fsl.freescale.net>
	<ED7561C6-CCD9-4F8F-9385-23FCEF2A7722@kernel.crashing.org>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> On Feb 26, 2007, at 12:41 AM, Zang Roy-r61911 wrote:
>=20
> >
> >> On Feb 15, 2007, at 8:44 PM, Andy Fleming wrote:
> >>
> >>> Add 85xx PCI express memory map register.
> >>>
> >>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> >>> Acked-by: Andy Fleming <afleming@freescale.com>
> >>> ---
> >>>  include/asm-ppc/immap_85xx.h |   75
> >> +++++++++++++++++++++++++++++++
> >>> +++++++++++
> >>>  1 files changed, 75 insertions(+), 0 deletions(-)
> >>
> >> Are the 86xx and 85xx structs the same?  If so, can we=20
> pull them out=20
> >> of immap_*.h into a sysdev/fsl_pcie.h
> >>
> >> (and lose the typedef while you're at it).
> > They have same structs. But I do not think it is proper to=20
> move them=20
> > into sysdev/fsl_pcie.h now. sysdev/fsl_pcie.c does not use  this=20
> > header file.
> > plaforms/85xx/pci.c use it to set up memory map windows.
> > In fact, there is little difference between immap_85xx.h and=20
> > immap_86xx.h.
> > After the migration from ppc to powerpc, we can unify them together.
>=20
> Why wait, I don't believe we support pcie in arch/ppc for=20
> anything fsl platform and the PCI support is different=20
> between arch/powerpc and arch/ppc.
>=20
Wait  to unify immap  together :-).
I agree to separate pcie struct for  arch/powerpc, then the code in
arch/powerpc will not depend header file include/asm-ppc.
I will provide patch to Andy and Jon tomorrow.
Roy
