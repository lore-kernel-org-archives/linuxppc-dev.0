Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 15797DDF77
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 15:20:27 +1100 (EST)
Date: Thu, 12 Feb 2009 23:20:25 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/7][RFC] powerpc64, tracing: add function graph tracer
	with dynamic tracing
In-Reply-To: <1234498509.26036.35.camel@pasglop>
Message-ID: <alpine.DEB.1.10.0902122319300.15469@gandalf.stny.rr.com>
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
> 
> > 	new = ftrace_call_replace(ip, stub, 0);
> > +	memcpy(old, new, MCOUNT_INSN_SIZE);
> > +	new = ftrace_call_replace(ip, addr, 0);
> > +
> > +	return ftrace_modify_code(ip, old, new);
> > +}
> 
> Heh, memcpy of 4 bytes :-) I hope gcc is smart enough to turn that into
> a simple load/store ..

hehe, I hated writing that. I just did not want to touch the (already 
working code) of the dynamic ftrace. I guess I could still use longs and 
then typecast them to char pointers for the ftrace_modify_code.

Thanks,

-- Steve
