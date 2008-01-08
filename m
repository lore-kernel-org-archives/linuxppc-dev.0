Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id C76E8DDF07
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:13:28 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
Date: Tue, 8 Jan 2008 19:13:22 +0100
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<20080108174038.GA20819@lixom.net>
In-Reply-To: <20080108174038.GA20819@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801081913.23475.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 January 2008, Olof Johansson wrote:
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 66a3d8c..81c3f05 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -470,7 +470,7 @@ config PCI
> > =A0=A0=A0=A0=A0=A0bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_=
85xx || PPC_86xx \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|| PPC_MPC52xx || (EMBEDDED &=
& (PPC_PSERIES || PPC_ISERIES)) \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|| PPC_PS3
> > -=A0=A0=A0=A0=A0default y if !40x && !CPM2 && !8xx && !PPC_83xx \
> > +=A0=A0=A0=A0=A0default y if !40x && !CPM2 && !8xx && !PPC_512x && !PPC=
_83xx \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&& !PPC_85xx && !PPC_86xx
>=20
> This is getting out of control. Not a comment to this specific patch,
> but it's getting silly.
>=20
> Btw, why no PCI by default on this platform when it seemingly is default
> on 5200? I thought they were fairly similar.
>=20

Just an idea how to restructure this, you could have

config PCI_POSSIBLE
	bool
	help
	  select this from your platform if it can support PCI.

config PCI_DEFAULT
	bool
	select
	help
	  select this from your platform if you want PCI on by default

config PCI
	bool "PCI support"
	depends on PCI_POSSIBLE || PCI_DEFAULT
	default PCI_DEFAULT

config 40x
	# there could be PCI, but normally there isn't
	select PCI_POSSIBLE
=09
config PPC_83xx=20
	# PCI is normally wanted on 83xx, but you can disable it
	select PCI_DEFAULT

config CHRP
	# CHRP can only be built correctly when PCI is enabled
	select PCI

	Arnd <><
