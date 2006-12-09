Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 5E60B679E0
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 11:00:31 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Sat, 9 Dec 2006 01:00:08 +0100
References: <20061207172259.64168f8c@localhost>
	<20061208185902.GA14675@localdomain>
	<1165618236.1103.87.camel@localhost.localdomain>
In-Reply-To: <1165618236.1103.87.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612090100.09380.arnd@arndb.de>
Cc: openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 December 2006 23:50, Benjamin Herrenschmidt wrote:
>=20
> >=20
> > +=A0=A0=A0=A0=A0info->io.regsize=A0=A0=A0=A0=A0=A0=A0=A0=3D resource0.e=
nd - resource0.start + 1;
> > +=A0=A0=A0=A0=A0info->io.regspacing=A0=A0=A0=A0=A0=3D resource1.start -=
 resource0.start;
> >=20
> > Are you sure this is a reliable way to check the register spacing and
> > register size? =A0Register size means "how big is a register (8, 16, 32
> > bits)". =A0Register spacing means (how many bytes are there between
> > registers. =A0If you had two registers that were 8 bits and 4 bytes
> > apart, for instance, I don't believe the above calculations would work.
>=20
> How many registers do we expect here ? Might be better to have one
> resource represent the whole MMIO area, and have a separate property
> that indicates the stride between 2 registers.

I think the current representation is perfect. AFAICS, there are always
two registers, but depending on the HW implementation, they may be
between 1 and 4 bytes wide, and can have a different spacing.

By having two separate areas in the reg property, the driver can
easily determine both the size and the spacing. It will then do
a single ioremap that spans both anyway.

	Arnd <><
