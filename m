Return-Path: <roland@redhat.com>
Received: from QMTA02.westchester.pa.mail.comcast.net
	(qmta02.westchester.pa.mail.comcast.net [76.96.62.24])
	by ozlabs.org (Postfix) with ESMTP id BB90CDDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 12:48:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: PPC upstream kernel ignored DABR bug
In-Reply-To: Jens Osterkamp's message of  Wednesday,
	12 March 2008 23:30:36 +0100 <200803122330.36905.jens@de.ibm.com>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
Message-Id: <20080313014745.DE97826F992@magilla.localdomain>
Date: Wed, 12 Mar 2008 18:47:45 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Jan Kratochvil <jan.kratochvil@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

AFAICT the DABRX register just has two global bits that enable paying
attention to the DABR register.  It only needs to be set once at boot time
(as the cell code does).  I don't see how missing that initialization could
ever have explained the behavior we see where DABR matches are intermittent.
If those DABRX bits weren't set then no DABR match would have happened.
(Apparently they are set before boot on an Apple G5.)

What we actually see is that DABR matches seem to be reliable when things
are slow, and get intermittent when there are enough threads with DABR set.

I searched the web trying to figure out what a DABRX register does so I
could just go try it myself rather than waiting another n months for powerpc
folks to forget about it again.  (I did try it, and 
	mtspr(SPRN_DABRX, DABRX_KERNEL | DABRX_USER);
makes no difference to the test on my machine, even done in set_dabr every
time we set SPRN_DABR.)

I happened across:

http://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/79B6E24422AA101287256E93006C957E/$file/PowerPC_970FX_errata_DD3.X_V1.7.pdf

which is "IBM PowerPC 970FX RISC Microprocessor Errata List for DD3.X"
and contains "Erratum #8: DABRX register might not always be updated correctly":

	Projected Impact
	      The data address breakpoint function might not always work.
	Workaround
	      None.
	Status
	      A fix is not planned at this time for the PowerPC 970FX.

The only machine I have at home for testing powerpc is an Apple G5,
supplied to me by IBM.  It says:
	cpu             : PPC970FX, altivec supported
	revision        : 3.0 (pvr 003c 0300)
so I am guessing this document applies to the chips I have.  Since I can't
test on other chips myself, it is plausible from what I've seen that there
is no mysterious kernel problem and only this hardware problem.  The
description of the hardware problem would not make me think that it would
behave this way, but it is not very detailed or precise, or at least does
not seem so to a reader not expert on powerpc.

So, uh, go IBM!

I'm in the minority in this conversation as someone not expert on powerpc,
and as someone not employed by IBM.  (I don't really mind finding public IBM
documents about powerpc on the web and telling IBM powerpc folks about them.
But, well.)

I don't know what I can do next to tell whether this processor erratum is in
fact what's happening in the test case.  If it is, I don't know if there
might be some arcane way to work around it despite "None" cited above.


Thanks,
Roland
