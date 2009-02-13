Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id AF4A2DDF55
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 16:22:53 +1100 (EST)
Date: Fri, 13 Feb 2009 00:22:51 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/7][RFC] powerpc64, tracing: add function graph tracer
	with dynamic tracing
In-Reply-To: <1234498509.26036.35.camel@pasglop>
Message-ID: <alpine.DEB.1.10.0902130020420.15469@gandalf.stny.rr.com>
References: <20090212011051.265346435@goodmis.org>
	<20090212011343.074329920@goodmis.org>
	<1234498509.26036.35.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 13 Feb 2009, Benjamin Herrenschmidt wrote:

> 
> > @@ -55,8 +56,9 @@ static unsigned char *ftrace_call_replace(unsigned
> > long ip, unsigned long addr)
> >  	 */
> >  	addr = GET_ADDR(addr);
> >  
> > -	/* Set to "bl addr" */
> > -	op = 0x48000001 | (ftrace_calc_offset(ip, addr) & 0x03fffffc);
> > +	/* if (link) set op to 'bl' else 'b' */
> > +	op = 0x48000000 | (link ? 1 : 0);
> > +	op |= (ftrace_calc_offset(ip, addr) & 0x03fffffc);
> 
> Any reason why you aren't using the code in
> arch/powerpc/lib/code-patching.c here ?

Yes, because I did not know about it ;-)

I'll write up a patch to change this. But I'll post this series as is for 
now.

Thanks,

-- Steve
