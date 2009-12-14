Return-Path: <dwg@au1.ibm.com>
Date: Mon, 14 Dec 2009 12:16:11 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC:PATCH 02/03] powerpc: Add definitions for Debug Registers
	on BookE Platforms
Message-ID: <20091214011611.GG4259@yookeroo>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
	<1134F495-6623-437F-AF1F-64D0A87BA112@kernel.crashing.org>
	<20091211032815.GD8852@yookeroo>
	<509EFABE-E123-48EA-9416-6FC22A00A6F5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <509EFABE-E123-48EA-9416-6FC22A00A6F5@kernel.crashing.org>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 11, 2009 at 08:35:35AM -0600, Kumar Gala wrote:
> 
> On Dec 10, 2009, at 9:28 PM, David Gibson wrote:
> 
> > On Thu, Dec 10, 2009 at 08:41:53PM -0600, Kumar Gala wrote:
> > [snip]
> >>> +#define DBCR1_USER_DEBUG	(DBCR1_IAC12M | DBCR1_IAC34M)
> >>> +#define DBCR1_BASE_REG_VALUE	(DBCR1_IAC1US | DBCR1_IAC1ER_10 | \
> >>> +				 DBCR1_IAC2US | DBCR1_IAC2ER_10 | \
> >>> +				 DBCR1_IAC3US | DBCR1_IAC3ER_10 | \
> >>> +				 DBCR1_IAC4US | DBCR1_IAC4ER_10)
> >> 
> >> We are we using MSR[IS] IS=0, why not just any Eff address?  In the
> >> future we might have user as IS = 1, and kernel as IS = 0.
> > 
> > Since the user can't control that directly, we can update this when
> > and if we change our use of address spaces.
> 
> That's such a subtle issue (easy to forgot about and miss in the
> future).  Why do we need this now?

Um.. I guess we don't really.  I was thinking of this default value a)
in the context of the old explicit register setting interface, where
we wanted to force what userspace could and could not set here and b)
half in the context of a system with real mode, in which we certainly
wouldn't want userspace to be able to set real address breakpoints.

I don't think it matters that much.  And, if we use AS1 for userspace
in the future, we arguably still want to change this to make it _01,
so that userspace can't set breakpoints in the kernel AS (although I
guess as long as we force the PR state in which the breakpoint
triggers, it doesn't really matter).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
