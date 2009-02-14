Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 0D443DDDA2
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2009 02:20:42 +1100 (EST)
Date: Sat, 14 Feb 2009 10:20:39 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc, ftrace: use create_branch lib function
In-Reply-To: <1234619366.10265.3.camel@localhost>
Message-ID: <alpine.DEB.1.10.0902141019200.27713@gandalf.stny.rr.com>
References: <20090213150055.947823726@goodmis.org>
	<20090213150147.180922180@goodmis.org>
	<1234619366.10265.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sun, 15 Feb 2009, Michael Ellerman wrote:
> >  
> >  	/* if (link) set op to 'bl' else 'b' */
> > -	op = 0x48000000 | (link ? 1 : 0);
> > -	op |= (ftrace_calc_offset(ip, addr) & 0x03fffffc);
> > +	op = create_branch((unsigned int *)ip, addr, link ? 1 : 0);
> 
> If I was feeling nit-picky I'd say you should use:
> 
> op = create_branch((unsigned int *)ip, addr, link ? BRANCH_SET_LINK : 0);
> 
> 
> But admittedly we're unlikely to ever change the flag handling, so it's
> probably not worth the effort of a respin (or this email :).

Not worth the effort of a respin, I agree.

But it would be worth the effort of a clean up patch ;-)

Not for "oh this flag might change", but for reviewers looking at the
code and knowing exactly what that '1' means.

-- Steve
