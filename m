Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 19057B7C34
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 03:46:55 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Micha Nelissen <micha@neli.hopto.org>, Michael Buesch <mb@bu3sch.de>
Date: Fri, 30 Oct 2009 10:46:46 -0600
Subject: RE: Accessing flash directly from User Space [SOLVED]
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330EE1316@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<200910301556.11349.mb@bu3sch.de>	<20091030150855.GA15046@mail.gnudd.com>
	<200910301624.03989.mb@bu3sch.de> <4AEB0ABB.8070605@neli.hopto.org>
In-Reply-To: <4AEB0ABB.8070605@neli.hopto.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
	Alessandro Rubini <rubini@gnudd.com>,
	"bgat@billgatliff.com" <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Michael Buesch wrote:
> > Yes, I think the barrier is wrong.
> > Please try with
> >
> > #define mb()	__asm__ __volatile__("eieio\n sync\n" : : :
> "memory")
>=20
>=20
> For uncached memory, eieio should be enough.

I tried eieio alone and it did not work.  It needed the above command to ta=
ke care of it all.
