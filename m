Date: Mon, 23 Dec 2002 08:03:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: Todd Poynor <tpoynor@mvista.com>,
	devel list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RFC: 405LP sleep
Message-ID: <20021223150342.GA15397@opus.bloom.county>
References: <1040330490.29647.340.camel@granite.austin.ibm.com> <3E023BD8.8050107@mvista.com> <1040427074.1095.23.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1040427074.1095.23.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 20, 2002 at 05:31:14PM -0600, Hollis Blanchard wrote:

> On Thu, 2002-12-19 at 15:36, Todd Poynor wrote:
>
> > +       jiffies += rtc_secs_elapsed * HZ;
> >
> > If jiffies is jumped forward then can kernel events (such as those
> > waiting on a kernel timer) be missed?
>
> I certainly *hope* the check is >= rather than == ... :)

They all should in fact be using time_after(...) or so, to deal
correctly with a jiffies wrap.  But from what I recall of doing a
massive kick of the jiffies (to test some jiffies wrap thing) in early
2.4 I believe, things can become somewhat unhappy.  Think of a device
which happens to be 'sleeping' while the user is on vacation or so.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
