Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id BD99FDDF29
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2007 06:00:00 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/6] [POWERPC] allow pSeries to build without CONFIG_PCI
Date: Sun, 4 Mar 2007 19:59:46 +0100
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<200703041507.06307.arnd@arndb.de>
	<1173033826.8184.68.camel@localhost.localdomain>
In-Reply-To: <1173033826.8184.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200703041959.46872.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 04 March 2007, Benjamin Herrenschmidt wrote:
> On Sun, 2007-03-04 at 15:07 +0100, Arnd Bergmann wrote:
> > On Sunday 04 March 2007 07:04:44 Stephen Rothwell wrote:
> > > =A0config PCI
> > > =A0 =A0 =A0 =A0 bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_=
85xx || PPC_86xx \=20
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 || PPC_MPC52xx || (EMBEDDED && PPC_ISER=
IES) || MPC7448HPC2 || PPC_PS3=20
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 || PPC_MPC52xx || (EMBEDDED && =A0(PPC_=
PSERIES || PPC_ISERIES)) \=20
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 || MPC7448HPC2 || PPC_PS3=20
> >=20
> I dislike the giant conditional though.

How about changing it to

config PCI_ENABLE
	bool

config PCI
	bool "PCI support" if PCI_ENABLE

config PPC_PSERIES
	select PCI_ENABLE
	select PCI if !EMBEDDED

config PPC_PS3
	select PCI_ENABLE

config PPC_PMAC
	select PCI

	Arnd <><
