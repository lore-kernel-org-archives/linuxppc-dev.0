Subject: Re: New 745x errata
From: Adrian Cox <adrian@humboldt.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20031117150409.GA30251@ip68-0-152-218.tc.ph.cox.net>
References: <1068721518.23764.84.camel@newt>
	<20031114162414.GD13003@ip68-0-152-218.tc.ph.cox.net>
	<1069081074.10537.16.camel@newt>
	<20031117150409.GA30251@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Date: 17 Nov 2003 15:34:05 +0000
Message-Id: <1069083245.10537.58.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-11-17 at 15:04, Tom Rini wrote:
> On Mon, Nov 17, 2003 at 02:57:53PM +0000, Adrian Cox wrote:

> > Any opinion on the dcbt issue?  It looks like it could provide a way for
> > a malicious userspace application to crash the machine, though it needs
> > a combination of:
> > 1) good timing
> > 2) a peripheral that would be confused by an extra read cycle

> It depends on what the fix is.  For example, Linus just fixed a
> theoretical race that has a 1-3 cycle (depending on x86 cpu I think he
> said) race because he happened to be in there anyhow (and it turns out
> the fix is easy).

The fix is simple, but carries a performance cost: set the HID0_NOPTI
bit and disable all dcbt instructions. The kernel uses dcbt instructions
in a lot of places, but copy_page is what matters the most.

A copy_page routine using dst instructions might be faster anyway, and
would be immune to this problem.

On closer reading, I now think this problem may be harmless - see my
explanation to Gabriel Paubert for more details.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
