Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -next-20080709] fixup stop_machine use cpu mask vs ftrace
Date: Fri, 11 Jul 2008 22:34:00 +1000
References: <200807081756.47140.rusty@rustcorp.com.au>
	<for-27-patch0-1@bga.com> <20080711074602.GB27849@elte.hu>
In-Reply-To: <20080711074602.GB27849@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807112234.00993.rusty@rustcorp.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 July 2008 17:46:03 Ingo Molnar wrote:
> * Milton Miller <miltonm@bga.com> wrote:
> > Hi Rusty, Ingo.
> >
> > Rusty's patch [PATCH 3/3] stop_machine: use cpu mask rather than magic
> > numbers didn't find kernel/trace/ftrace.c in -next, causing an
> > immediate almost NULL pointer dereference in ftrace_dynamic_init.
>
> Rusty - what's going on here? Please do not change APIs like that, which
> cause code to crash. Either do a compatible API change, or change it
> over in a way that causes clear build failures, not crashes.

To be fair, I did.  Unfortunately GCC only warns about passing an int to a 
pointer arg, and boom.

But compatible is even better.  Given the number of stop_machine_run users I 
thought it unlikely that a new one would be introduced during the change.  I 
was wrong, so I'll do it the Right Way.

Cheers,
Rusty.
