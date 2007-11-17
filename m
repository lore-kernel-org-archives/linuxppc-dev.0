Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 67508DDE1B
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 04:09:50 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so142789wri
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 09:09:49 -0800 (PST)
Date: Sat, 17 Nov 2007 11:09:40 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix 44x Machine Check handling
Message-ID: <20071117110940.5bd93e6a@vader.jdub.homelinux.org>
In-Reply-To: <BC413657-C715-44E3-B5B5-D173E33E862F@kernel.crashing.org>
References: <20071116072149.350ADDDDF4@ozlabs.org>
	<20071116074025.GA4741@lixom.net>
	<1195198868.28865.142.camel@pasglop>
	<1195199141.28865.144.camel@pasglop>
	<BC413657-C715-44E3-B5B5-D173E33E862F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 Nov 2007 15:55:25 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Nov 16, 2007, at 1:45 AM, Benjamin Herrenschmidt wrote:
> 
> >
> > On Fri, 2007-11-16 at 18:41 +1100, Benjamin Herrenschmidt wrote:
> >> On Fri, 2007-11-16 at 01:40 -0600, Olof Johansson wrote:
> >>> I'm not sure I like this. It introduces another cpu feature flag,
> >>> that we'll soon run out of if it's used to signify version info per
> >>> implementation like this.
> >>>
> >>> 1) The SET_IVOR could be done from the cpu_setups for 440A instead
> >>> (i.e. introduce one).
> >>>
> >>> 2) Please just move the machine check handlers out to individual  
> >>> ones
> >>> instead of using the generic one. That way you don't need runtime  
> >>> checks
> >>> between the two (they don't seem to share much of it as-is anyway).
> >>>
> >>> With the above two changes, you shouldn't need the feature bit any  
> >>> more.
> >>
> >> We can easily make the cpu features bigger ... But ok, I'll have a  
> >> look
> >> at doing it the way you suggest.
> >
> > Note that first, I'd like to figure out if there are other relevant
> > differences with 440A ... arch/ppc didn't list any and diff'ing PDFs  
> > is
> > not fun but if people around here know, please speak up
> 
> 
> I think it added isel support.

I'm not entirely sure about that, but I'll check.  440x4 cores lack
isel, 440x5, 440x6 have it.  I don't think it was tied to the 'A'
moniker.

josh
