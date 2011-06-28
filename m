Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A66FB6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 09:25:18 +1000 (EST)
Subject: Re: [PATCH] powerpc/timebase_read: don't return time older than
	cycle_last
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110628111420.15052d9f@schlenkerla.am.freescale.net>
References: <20110627215613.GA13676@schlenkerla.am.freescale.net>
	<1309221943.32158.412.camel@pasglop>
	<20110628111420.15052d9f@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 09:25:08 +1000
Message-ID: <1309303508.32158.473.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-06-28 at 11:14 -0500, Scott Wood wrote:
> > You are applying a bandage on a wooden leg here .... userspace (vDSO)
> > will see the time going backward if you aren't well synchronized as
> > well, so you're stuffed anyways.
> 
> Sure -- but we should avoid turning a slight backwards drift into a huge
> positive offset in the kernel's calculations.  One way to do that is for
> the generic timekeeping code to be robust against this, for all time
> sources.  The other is to apply this sort of hack on time sources that are
> known to possibly go backwards.  The former is the better fix IMHO, but the
> latter is what was already done for TSC on x86, so I went with the less
> intrusive change.

Ok two things. One is first fix the comments then to stop mentioning
"TSC" :-)

Second is, I still don't think it's right. There's an expectation on
powerpc that the timebase works properly. If not, you have a userspace
visible breakage. There's no such thing as "a small drift". We assume no
difference is visible to software, period. We make hard assumptions here
and in various places actually.

So if you want to do that test, I would require that you also add a
warning, of the _rate_limited or _once, kind, indicating to the user
that something's badly wrong.

Cheers,
Ben.
