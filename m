Date: Fri, 25 Jun 1999 09:36:38 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Daniel Jacobowitz <drow@false.org>
cc: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>, ad@MPIfR-Bonn.MPG.de
Subject: Re: Help: Porting PCI driver from Linux/Intel -> PPC
In-Reply-To: <19990624220307.A9159@drow.res.cmu.edu>
Message-ID: <Pine.LNX.3.96.990625093158.20726C-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Jun 1999, Daniel Jacobowitz wrote:

> > Caused by (from msr): regs c24d7ca0 Unknown values in msr 
> > NIP: C483CFA0 XER: 00000000 LR: C483CF54 REGS: c24d7ca0 TRAP: 0200 
> 
>                                                                 ^^^^

> What I highlighted above is your clue.  I don't remember off the top of
> my head which 0200 is, but I'm willing to bet it's Open Firmware's data
> access exception - attempting to access physical memory unmapped by the
> MMU.

Actually, 0x200 (machine check) is caused by a TEA, which is generally
caused by attempting to access physical memory that's not decoded in
hardware but _is_ mapped by the MMU (if MMU on), assuming that MSR[ME] is
set to 1 (otherwise it goes into a checkstop state, presumably for
hardware debugging).  IOW, trying to access a physical address for which
there is no device.

0x300 is the attempt to access memory that's not been mapped, IIRC.


>  Along with the other suggestion for enabling memory, be very sure
> about endianness issues - that's the major porting pitfall.  Where are
> you inl()'ing from?

It very much sounds like an endianness issue, yeah.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
