Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] powerpc: 64K page support for kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <c08e2dc179070866364d96a7b5ade65b@kernel.crashing.org>
References: <1177626236.24866.99.camel@luke-laptop>
	<1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
	<1177690940.24866.124.camel@luke-laptop>
	<c21def285f4ad2e13914af73f7610c0b@bga.com>
	<1177695045.24866.135.camel@luke-laptop>
	<17972.22463.103425.51542@cargo.ozlabs.ibm.com>
	<c08e2dc179070866364d96a7b5ade65b@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 08:49:51 +1000
Message-Id: <1177886991.14873.368.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-04-29 at 15:27 +0200, Segher Boessenkool wrote:
> >>   BUG_ON((hpte_v & 0x4000000000000000UL) && (crashing_cpus == -1));
> >>   BUG_ON((size == MMU_PAGE_16G) && (crashing_cpus == -1));
> >>   BUG_ON((size == MMU_PAGE_64K_AP) && (crashing_cpus == -1));
> >
> > How much effort would it be to add the code to cope with those
> > conditions and give the correct answers?  I'd much prefer that to
> > these BUG_ONs.
> 
> The test "& 0x400..." should be "& 0xc00..." since the
> "B" filed in a page table entry is the top _two_ bits.

Yup, we need to put some symbolic constants too. We can dig them from
the old never-applied 1T segment patch I did a while ago.

> Not sure what that tells us about the work involved in
> making this code do the right thing under all conditions,
> but it would seem to indicate trouble ahead.  Also, the
> encodings with bit 0 = 1 are reserved (says arch v2.03),
> so there would probably still be a BUG_ON() here.

Ben.
