Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 514D5B7BE2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Oct 2009 19:25:37 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id n9Q8MUuV017967
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2009 19:22:30 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9Q8PXfn1265816
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2009 19:25:33 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9Q8PWEC028741
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2009 19:25:33 +1100
Date: Mon, 26 Oct 2009 13:55:25 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [v9 PATCH 4/9]: x86: refactor x86 idle power management code
	and remove all instances of pm_idle.
Message-ID: <20091026082524.GC17689@linux.vnet.ibm.com>
References: <20091016093850.GB27350@linux.vnet.ibm.com>
	<20091016094308.GF27350@linux.vnet.ibm.com>
	<20091023160711.GB1431@ucw.cz>
	<20091026075550.GB17689@linux.vnet.ibm.com>
	<20091026075831.GB22625@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20091026075831.GB22625@elf.ucw.cz>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Andi Kleen <andi@firstfloor.org>, Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Pavel Machek <pavel@ucw.cz> [2009-10-26 08:58:31]:

> 
> > > > +static int local_idle_loop(struct cpuidle_device *dev, struct cpuidle_state *st)
> > > > +{
> > > > +	ktime_t t1, t2;
> > > > +	s64 diff;
> > > > +	int ret;
> > > > +
> > > > +	t1 = ktime_get();
> > > > +	local_idle();
> > > > +	t2 = ktime_get();
> > > > +
> > > > +	diff = ktime_to_us(ktime_sub(t2, t1));
> > > > +	if (diff > INT_MAX)
> > > > +		diff = INT_MAX;
> > > > +	ret = (int) diff;
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > So we get this routine essentially 3 times. Is there no way to share
> > > the code?
> > > 
> > 
> > We can move this code to a common place, but that would mean exporting
> > the idle function pointer to be called from within this routine, which
> > is exactly what we wanted to avoid.
> > 
> > Any suggestions are welcome.
> 
> You can just pass idle routine as a parameter...?
> 
> int common_idle_loop(struct cpuidle_device *dev, struct cpuidle_state
> *st, void *idle(void))
> 
> ...?
> 									Pavel

Yes, this should be fine. I was trying to avoid passing the void
function pointer around but i guess this reduces considerable code
size.

thanks!
arun
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
