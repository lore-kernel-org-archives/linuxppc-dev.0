Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] powerpc: 64K page support for kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17972.22463.103425.51542@cargo.ozlabs.ibm.com>
References: <1177626236.24866.99.camel@luke-laptop>
	<1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
	<1177690940.24866.124.camel@luke-laptop>
	<c21def285f4ad2e13914af73f7610c0b@bga.com>
	<1177695045.24866.135.camel@luke-laptop>
	<17972.22463.103425.51542@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 29 Apr 2007 19:31:01 +1000
Message-Id: <1177839061.14873.352.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-04-29 at 18:30 +1000, Paul Mackerras wrote:
> Luke Browning writes:
> 
> > How about the following as an alternative. 
> > 
> >   BUG_ON((hpte_v & 0x4000000000000000UL) && (crashing_cpus == -1));
> >   BUG_ON((size == MMU_PAGE_16G) && (crashing_cpus == -1));
> >   BUG_ON((size == MMU_PAGE_64K_AP) && (crashing_cpus == -1));
> 
> How much effort would it be to add the code to cope with those
> conditions and give the correct answers?  I'd much prefer that to
> these BUG_ONs.

hrm...

1T segments shouldn't be too hard... 16G pages goes with it pretty much,
and AP ... well... do they work on any implementation anyway ?

Ben.
