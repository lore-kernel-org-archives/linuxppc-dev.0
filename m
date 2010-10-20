Return-Path: <pacman@kosh.dhis.org>
Received: from kosh.dhis.org (c-67-162-90-113.hsd1.in.comcast.net
	[67.162.90.113]) by ozlabs.org (Postfix) with SMTP id CA057B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 14:23:47 +1100 (EST)
Message-ID: <20101020032345.5240.qmail@kosh.dhis.org>
From: pacman@kosh.dhis.org
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 19 Oct 2010 22:23:45 -0500 (GMT+5)
In-Reply-To: <1287522168.2198.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org
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
> On Tue, 2010-10-19 at 22:47 +0200, Segher Boessenkool wrote:
> > 
> > It looks like it is the frame counter in an USB OHCI HCCA.
> > 16-bit, 1kHz update, offset x'80 in a page.
> > 
> > So either the kernel forgot to call quiesce on it, or the firmware
> > doesn't implement that, or the firmware messed up some other way.
> 
> I vote for the FW being on crack. Wouldn't be the first time with
> Pegasos.
> 
> It's an OHCI or an UHCI in there ?

There's one of each... UHCI on the motherboard, OHCI on a card in a PCI
expansion slot. They shipped the ODW with the extra controller on an
expansion card since the on-board UHCI doesn't do USB2.0.

And that OHCI controller does appear to be the culprit. The 2 affected
addresses tick at 1000Hz until ohci-hcd is modprobe'd, then they stop.

I think the mm people can consider this closed. 6dda9d55 didn't do anything
but expose a problem which has been here all along. Will drop them from Cc
list in any further messages.

> 
> Can you try in prom_init.c changing the prom_close_stdin() function to
> also close "stdout" ? 
> 
>          if (prom_getprop(_prom->chosen, "stdin", &val, sizeof(val)) > 0)
>                  call_prom("close", 1, 0, val);
> +        if (prom_getprop(_prom->chosen, "stdout", &val, sizeof(val)) > 0)
> +               call_prom("close", 1, 0, val);
> 
> See if that makes a difference ?

Huge difference. With no stdout to print to, the kernel seems to freeze up.
Or at least it loses the console. The last message it prints is "Device tree
struct 0x00933000 -> 0x00957000" then there's just nothing. I waited a while
for the console to come on but it didn't.

The diff fragment above applied inside prom_close_stdin, but there are some
prom_printf calls after prom_close_stdin. Calling prom_printf after closing
stdout sounds like it could be bad. If I moved it down below all the
prom_printf's, it would be after the "quiesce" call. Would that be acceptable
(or even interesting as an experiment)? Does a close need a quiesce after it?

-- 
Alan Curry
