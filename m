Return-Path: <pacman@kosh.dhis.org>
Received: from kosh.dhis.org (c-67-162-90-113.hsd1.in.comcast.net
	[67.162.90.113]) by ozlabs.org (Postfix) with SMTP id CAC4CB70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Oct 2010 05:33:38 +1100 (EST)
Message-ID: <20101020183336.1714.qmail@kosh.dhis.org>
From: pacman@kosh.dhis.org
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 20 Oct 2010 13:33:36 -0500 (GMT+5)
In-Reply-To: <1287570736.2198.19.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
> 
> On Tue, 2010-10-19 at 22:23 -0500, pacman@kosh.dhis.org wrote:
> > The diff fragment above applied inside prom_close_stdin, but there are
> > some
> > prom_printf calls after prom_close_stdin. Calling prom_printf after
> > closing
> > stdout sounds like it could be bad. If I moved it down below all the
> > prom_printf's, it would be after the "quiesce" call. Would that be
> > acceptable
> > (or even interesting as an experiment)? Does a close need a quiesce
> > after it?
> 
> Just try :-) "quiesce" is something that afaik only apple ever
> implemented anyways. It uses hooks inside their OF to shut down all
> drivers that do bus master (among other HW sanitization tasks).

I booted a version with a prom_close_stdout after the last prom_debug. It
didn't have any effect. That 1000Hz clock was still ticking.

-- 
Alan Curry
