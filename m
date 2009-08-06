Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 166D0B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 01:02:25 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 76872DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 01:02:23 +1000 (EST)
Date: Thu, 6 Aug 2009 11:02:20 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: ftrace scripts and make V=1
In-Reply-To: <20090806034325.GA8861@elte.hu>
Message-ID: <alpine.DEB.2.00.0908061100580.22376@gandalf.stny.rr.com>
References: <21d7e9970908050023j2807ef3bi1321ac2a1fd9a743@mail.gmail.com>
	<20090805072952.GC19322@elte.hu>
	<alpine.DEB.2.00.0908052011590.5010@gandalf.stny.rr.com>
	<20090806034325.GA8861@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, 6 Aug 2009, Ingo Molnar wrote:
> > diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> > index d29baa2..4889c44 100755
> > --- a/scripts/recordmcount.pl
> > +++ b/scripts/recordmcount.pl
> > @@ -414,7 +414,10 @@ while (<IN>) {
> >  	    $offset = hex $1;
> >  	} else {
> >  	    # if we already have a function, and this is weak, skip it
> > -	    if (!defined($ref_func) && !defined($weak{$text})) {
> > +	    if (!defined($ref_func) && !defined($weak{$text}) &&
> > +		 # PPC64 can have symbols that start with .L and
> > +		 # gcc considers these special. Don't use them!
> > +		 $text !~ /^\.L/) {
> >  		$ref_func = $text;
> >  		$offset = hex $1;
> >  	    }
> 
> Ah, indeed. I'm wondering whether also emitting a build warning 
> would be useful - just in the (admittedly unlikely) case of someone 
> wondering about why LM93_IN_FROM_REG does not show up in function 
> traces.

Actually, it just skips it as the function to use as the reference point. 
It should still record the mcount for that function. Now we may have an 
issues if all functions in a section start with .L

-- Steve
