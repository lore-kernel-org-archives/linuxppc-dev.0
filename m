Return-Path: <stern@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 3F149DDECD
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 07:40:58 +1100 (EST)
Date: Mon, 12 Nov 2007 15:40:58 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] Re: [RFC] powermac: proper sleep management
In-Reply-To: <1194899041.18185.55.camel@pasglop>
Message-ID: <Pine.LNX.4.44L0.0711121534070.3128-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 13 Nov 2007, Benjamin Herrenschmidt wrote:

> 
> On Mon, 2007-11-12 at 17:32 +0100, Johannes Berg wrote:
> > > Looks good to me, +/- a couple of things:
> > > 
> > >  - We _REALLY_ want the freezer to be optional and not enabled by
> > > default on PowerPC. Maybe make it a compile option ?
> > 
> > Well, Alan is going to tell you that USB will break. If we need
> > confirmation for that I can do the test he suggested to you or Paul a
> > while ago.
> 
> Then USB is broken today on powermacs and need to be fixed. We had a
> clear agreement at KS this year that the freezer was at best a band-aid
> and that drivers -had- to be fixed to cope regardless.

More accurately, freezing user tasks is at best a band-aid.  However 
some kernel threads do need to be frozen, and keeping the freezer 
around for their use makes sense.  It has less overhead -- I think 
-- than adding new code to do the freezing in each of these threads.

(It's true that USB drivers in general aren't written to operate in a
freezerless system-suspend environment.  That's a harder problem and
it will have to be fixed driver-by-driver, over time.  The same may be
true for lots of non-USB char device drivers as well.  Pick your 
favorite char device driver: How will it behave if a user task submits 
an I/O request after the device has been suspended?)

Alan Stern
