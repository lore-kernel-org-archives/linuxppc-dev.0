Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA008B6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 02:14:36 +1000 (EST)
Date: Tue, 28 Jun 2011 11:14:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/timebase_read: don't return time older than
	cycle_last
Message-ID: <20110628111420.15052d9f@schlenkerla.am.freescale.net>
In-Reply-To: <1309221943.32158.412.camel@pasglop>
References: <20110627215613.GA13676@schlenkerla.am.freescale.net>
	<1309221943.32158.412.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jun 2011 10:45:43 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2011-06-27 at 16:56 -0500, Scott Wood wrote:
> > As is done in read_tsc() on x86, make sure that we don't return a timebase
> > value smaller than cycle_last, which can happen on SMP if the timebases are
> > not perfectly synchronized.  It is less expensive than total enforcement of
> > monotonicity, since we don't need to add another variable and update it on
> > each read, but it will prevent core timekeeping functions from translating
> > a small timebase regression into a large jump forward.
> > 
> > Based on commit d8bb6f4c1670c8324e4135c61ef07486f7f17379 for x86.
> 
> You are applying a bandage on a wooden leg here .... userspace (vDSO)
> will see the time going backward if you aren't well synchronized as
> well, so you're stuffed anyways.

Sure -- but we should avoid turning a slight backwards drift into a huge
positive offset in the kernel's calculations.  One way to do that is for
the generic timekeeping code to be robust against this, for all time
sources.  The other is to apply this sort of hack on time sources that are
known to possibly go backwards.  The former is the better fix IMHO, but the
latter is what was already done for TSC on x86, so I went with the less
intrusive change.

-Scott
