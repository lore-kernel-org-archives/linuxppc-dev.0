Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193]) by ozlabs.org (Postfix) with ESMTP id BE9B8DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 22:41:20 +1100 (EST)
Date: Wed, 25 Mar 2009 12:11:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Li Yang <leoli@freescale.com>
Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
Message-ID: <20090325111113.GG24172@elf.ucw.cz>
References: <49C3AB35.4080700@freescale.com>
	<3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
	<20090323165402.GC25217@ld0162-tx32.am.freescale.net>
	<2a27d3730903250342qc7c98abt95534372af174703@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2a27d3730903250342qc7c98abt95534372af174703@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Soohyung Cho <celius202@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed 2009-03-25 18:42:41, Li Yang wrote:
> On Tue, Mar 24, 2009 at 12:54 AM, Scott Wood <scottwood@freescale.com> wrote:
> > On Sun, Mar 22, 2009 at 10:45:23PM -0700, Li Yang-R58472 wrote:
> >> > I don't think so, in this case.  The user is not asking for
> >> > "sleep" or deep sleep"; they are asking for a power state
> >> > that meets the definition of "standby" (which sleep does) or
> >> > which meets the definition of "mem"
> >> > (which both sleep and deep sleep do).  When the user asks for
> >> > "mem", we provide the lowest power mode that qualifies.
> >>
> >> In my understanding, "mem" which is suspend-to-ram means all CPU states
> >> and registers are kept in memory and the CPU is completely off during
> >> suspension.  I don't think the sleep mode of 8349 qualifies, does it?
> >
> > Is there a difference visible to software or to the user (other than not
> > achieving power savings that the board does not support)?  It seems
> > simpler for userspace to just specify the "heaviest" sleep state it wants
> > deal with (though some feedback to an administrator of what actually
> > happens would be nice).
> 
> I agree that it's handy to have a "sleep" state in kernel to
> automatically enter the "heaviest" sleep state supported.  However it
> is also very simple for user space script or application to check the
> available states first and then enter explicitly the "heaviest" sleep
> state.
> 
> Pavel, what's the preferred way for current PM sub-system?

If you have single sleep state, use "mem" > /sys/power/state. 

If you have two, use mem and standby. Do you have more?

> >
> > And if we want to be really pedantic, neither sleep nor deep sleep meet
> > the definitions for either "standby" or "mem", because they specify
> > acceptable latency ranges in seconds, and (in the absence of a disk) we
> > are much faster than that (it doesn't say "up to 1-2 seconds"). :-)
> >
> > Are there any existing suspend drivers that suppord standby but not mem?
> > I see omap1 as a counterexample that treats them both the same.
> >
> > -Scott

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
