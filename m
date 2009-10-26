Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193]) by ozlabs.org (Postfix) with ESMTP id 01D90B7BE2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Oct 2009 18:58:41 +1100 (EST)
Date: Mon, 26 Oct 2009 08:58:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v9 PATCH 4/9]: x86: refactor x86 idle power management code
	and remove all instances of pm_idle.
Message-ID: <20091026075831.GB22625@elf.ucw.cz>
References: <20091016093850.GB27350@linux.vnet.ibm.com>
	<20091016094308.GF27350@linux.vnet.ibm.com>
	<20091023160711.GB1431@ucw.cz>
	<20091026075550.GB17689@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091026075550.GB17689@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > > +static int local_idle_loop(struct cpuidle_device *dev, struct cpuidle_state *st)
> > > +{
> > > +	ktime_t t1, t2;
> > > +	s64 diff;
> > > +	int ret;
> > > +
> > > +	t1 = ktime_get();
> > > +	local_idle();
> > > +	t2 = ktime_get();
> > > +
> > > +	diff = ktime_to_us(ktime_sub(t2, t1));
> > > +	if (diff > INT_MAX)
> > > +		diff = INT_MAX;
> > > +	ret = (int) diff;
> > > +
> > > +	return ret;
> > > +}
> > 
> > So we get this routine essentially 3 times. Is there no way to share
> > the code?
> > 
> 
> We can move this code to a common place, but that would mean exporting
> the idle function pointer to be called from within this routine, which
> is exactly what we wanted to avoid.
> 
> Any suggestions are welcome.

You can just pass idle routine as a parameter...?

int common_idle_loop(struct cpuidle_device *dev, struct cpuidle_state
*st, void *idle(void))

...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
