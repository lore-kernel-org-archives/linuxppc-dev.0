Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D5D1DDF5B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 09:21:23 +1100 (EST)
In-Reply-To: <20080313014745.DE97826F992@magilla.localdomain>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
	<20080313014745.DE97826F992@magilla.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2f8f82fe943fcd5103ec4cc39cc1bb26@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PPC upstream kernel ignored DABR bug
Date: Thu, 13 Mar 2008 23:20:47 +0100
To: Roland McGrath <roland@redhat.com>
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

> AFAICT the DABRX register just has two global bits that enable paying
> attention to the DABR register.

It has four bits:

	01	match in user mode
	02	match in supervisor mode
	04	match in hypervisor mode
	08	ignore translation field in DABR

If the kernel can write to DABRX, it is running in hypervisor mode, so
it should set 07 instead of 03 (as it currently does) if it wants to
match in kernel mode; or 01, if it doesn't.

OTOH, the Apple version of the 970 is special (it has no separate
hypervisor mode); still, 07 should always work.

> It only needs to be set once at boot time
> (as the cell code does).  I don't see how missing that initialization  
> could
> ever have explained the behavior we see where DABR matches are  
> intermittent.
> If those DABRX bits weren't set then no DABR match would have happened.
> (Apparently they are set before boot on an Apple G5.)

I don't see the Apple boot code initialising DABRX; maybe the bootup  
state
for DABRX is 07, dunno.  Either way, it would be good if the kernel set  
it
properly, esp. if it wants to enable or disable matches in the kernel  
itself.

> What we actually see is that DABR matches seem to be reliable when  
> things
> are slow, and get intermittent when there are enough threads with DABR  
> set.

> I happened across:
>
> http://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/ 
> 79B6E24422AA101287256E93006C957E/$file/ 
> PowerPC_970FX_errata_DD3.X_V1.7.pdf
>
> which is "IBM PowerPC 970FX RISC Microprocessor Errata List for DD3.X"
> and contains "Erratum #8: DABRX register might not always be updated  
> correctly":

> The only machine I have at home for testing powerpc is an Apple G5,
> supplied to me by IBM.  It says:
> 	cpu             : PPC970FX, altivec supported
> 	revision        : 3.0 (pvr 003c 0300)
> so I am guessing this document applies to the chips I have.

Indeed.

> Since I can't
> test on other chips myself, it is plausible from what I've seen that  
> there
> is no mysterious kernel problem and only this hardware problem.  The
> description of the hardware problem would not make me think that it  
> would
> behave this way, but it is not very detailed or precise, or at least  
> does
> not seem so to a reader not expert on powerpc.

Since the 970 kernel never sets DABRX currently, #8 cannot explain
_intermittent_ problems: either it always works, or never does.

You could be happening upon #5, if the non-triggering data breakpoints
are with vector loads/stores in strange code.

> I don't know what I can do next to tell whether this processor erratum  
> is in
> fact what's happening in the test case.  If it is, I don't know if  
> there
> might be some arcane way to work around it despite "None" cited above.

It would help if you could give us the disassembly of some code where  
the
breakpoint did not trigger; say, that insn and the previous 20 or so  
insns.


Segher
