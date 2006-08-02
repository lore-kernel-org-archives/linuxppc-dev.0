Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF72467A3F
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 22:41:35 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k72CfO5g032035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 08:41:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k72CfOSQ256954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 08:41:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k72CfNGa011250
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 08:41:24 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Date: Wed, 2 Aug 2006 14:41:23 +0200
References: <20060719230014.GB3887@mag.az.mvista.com>
	<17616.12251.339657.215571@cargo.ozlabs.ibm.com>
In-Reply-To: <17616.12251.339657.215571@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608021441.23429.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 August 2006 06:53, Paul Mackerras wrote:
> > +#ifdef __powerpc64__
> > +typedef unsigned long=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u=
64;
> > +#else
> > +typedef unsigned long long=A0=A0=A0u64;
> > +#endif
>=20
> This is potentially confusing, because the __powerpc64__ relates to
> the boot wrapper not the kernel, and we don't build a 64-bit boot
> wrapper on any platform (not yet anyway). =A0Maybe this needs a comment.
>=20
Moreover, even if we ever build this on __powerpc64__, the=20
typedef unsigned long long u64 would still do the right thing.
It only ever becomes a problem when mixing with u64 the c99 uint64_t,
which is defined the other way.

	Arnd <><
