Return-Path: <mmporter@cox.net>
Date: Mon, 27 Sep 2004 22:33:18 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Adair <dadair@ariodata.com>
Message-ID: <20040927223318.B30581@home.com>
References: <F152162DB1B0D2458EA395AD074DE1C468CA04@orion.ariodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F152162DB1B0D2458EA395AD074DE1C468CA04@orion.ariodata.com>;
	from dadair@ariodata.com on Thu, Sep 23, 2004 at 10:46:51AM -0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Is anyone using Critical Interrupts on PPC440 in 2.4 ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[Followups to linuxppc-embedded]

On Thu, Sep 23, 2004 at 10:46:51AM -0700, David Adair wrote:
> Sorry if this has been covered before - I for one could make use of that
> old list tarball if it were available.
> 
> I am interested in using the interrupts controlled by MSR[CE],
> specifically to help debug Watchdog timeout and PCI hang issues and
> perhaps ultimately recover from them somehow.  While I am able to
> achieve some level of operation a quick browse of 2.6.8 makes me very
> nervous that I may be re-inventing the wheel because it now includes the
> code to properly load a 32 bit MSR_KERNEL setting but does not appear to
> actually use either of the MSR[CE] controlled vectors (Watchdog,
> CriticalInput).
> 
> - Are there patches available that somehow use either Critical Input or
> Watchdog for something other than "unknown?"  I would not want to do
> anything that conflicts too badly with some low-latency interrupt scheme
> for instance.

No publicly known patches. 
 
> - Has a back-port of the updated 32 bit MSR_KERNEL handling to 2.4 been
> done already?  I did this before realizing it was already done in 2.6.

No publicly known back-port. 

> - Is there any version that has normal IRQ handling smart enough to
> leave critical interrupts alone?  I had to resort to the rather ugly
> trick of registering a dummy handler on IRQ 31 (UIC1 CI cascade) to keep
> it from getting disabled.
 
No publicly known version with this feature. 
 
> - Has anyone ever considered a patch that replaces the normal HW
> exception handling with an immediate panic?  For an embedded system
> continuing to run after one or more user space processes has been
> terminated does not seem to be an optimal behavior.

This has never before been publicly raised as a consideration. I
assume you mean exceptions in user mode, that seems to be implied.

> - Are patches being accepted for 2.4, or is everything 2.6 now?

The usual contributors have all moved on to 2.6.  If somebody is
willing to do the work for 2.4, most things can be checked in to
the linuxppc-2.4 tree.  New features are not considered acceptable
for Marcelo's 2.4 tree.

> What I am up to:
> 
> Situation:
> 
> The board I am working on is subject to random re-boots due to Watchdog
> timeouts.  Some of these are due to driver bugs (500mS udelay's, waiting
> forever for stuff that never happens etc), and others are due to PCI
> devices that insist on claiming split transactions and then waiting
> several seconds before responding.  These situations are of course very
> rare and almost impossible to duplicate so a JTAG debugger is out of the
> question.
> 
> Proposed solution:
> 
> Install an interrupt hander that captures the register dump and stack
> trace whenever a watchdog or PCI error occurs.  Since there is no choice
> for the watchdog and the PCI errors could happen during interrupt top
> halves or with interrupts disabled both situations pretty much require
> the use of Critical Exceptions.

Since 2.6 provides proper support of critical exceptions (and is
accepting new features) it probably makes the most sense to work
this feature there. If I understand correctly, you are interested
in creating some framework for making use of the CriticalInput
exception for error reporting.  Since the manner in which the
CriticalInput vector is utilized is highly system specific, I'm
not sure what would be needed in the kernel beyond a simple
PPC-specific registration call that can be made from a board port
specific routine.

-Matt
