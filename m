Date: Fri, 7 Feb 2003 10:12:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: was: FEC on MPC860T & race condition
Message-ID: <20030207171222.GA21351@ip68-0-152-218.tc.ph.cox.net>
References: <3E395B40.9090506@imc-berlin.de> <3E39898E.5060804@embeddededge.com> <3E3A3EE9.7000608@imc-berlin.de> <20030203210959.GA7857@ip68-0-152-218.tc.ph.cox.net> <3E3F7C29.8030807@imc-berlin.de> <20030204160401.GA30936@ip68-0-152-218.tc.ph.cox.net> <3E3FE6D0.1010600@imc-berlin.de> <20030204193224.GB3522@ip68-0-152-218.tc.ph.cox.net> <3E436221.8040903@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E436221.8040903@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 07, 2003 at 08:37:05AM +0100, Steven Scholz wrote:
> Tom Rini wrote:
> >...
> >Okay.  Moving along the process, I have a comment:
> >
> >
> >>@@ -2285,6 +2278,39 @@
> >>	fep->old_status = 0;
> >>#endif	/* CONFIG_USE_MDIO */
> >>
> >>+#ifdef CONFIG_USE_MDIO
> >>+# ifndef PHY_INTERRUPT
> >>+#  error Want to use MII, but PHY_INTERRUPT not defined!
> >>+# endif
> >>+	/* before requesting the irq, we should wait until PHY is discovered
> >>+	 * to avoid race conditions
> >>+	 */
> >>+	while (!fep->phy_id_done) {
> >>+		udelay(5);
> >>+	}
> >
> >
> >I believe this is wrong, in that trying to udelay() here is a bad idea.
> >I don't have the time right now, but I suspect google, or #kernelnewbies
> >might be able to suggest a more appropriate way of waiting here.
> >
> >Or perhaps classes have fried my mind, and this is correct.
> No. I bet you're right.
> But can you make any suggestion on how to wait for some I/O to become ready?

How about what Dan mentioned, with a function pointer and whatnot?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
