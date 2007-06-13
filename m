Return-Path: <stern@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 70EE9DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jun 2007 01:43:10 +1000 (EST)
Date: Wed, 13 Jun 2007 11:43:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH 6/6] [C67x00] Merge c67x00-hub.c into
	c67x00-hcd.c
In-Reply-To: <fa686aa40706130809q78a875f5u45e458eaa54eae2d@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0706131130120.3607-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Jun 2007, Grant Likely wrote:

> On 6/13/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Wed, 13 Jun 2007, Grant Likely wrote:
> >
> > > On 6/12/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> > > > >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
> > > >
> > > > Hi,
> > > >
> > > >  Grant> Rather than c67x00-hub.c being compiled seperately, the
> > > >  Grant> original code had c67x00-hub.c *included* by c67x00-hcd.c.
> > > >  Grant> This is a very bad idea.
> >
> > What's so bad about it?  It's an elegant solution to the problem of
> > breaking a very long driver up into smaller, more digestible pieces
> > without polluting the kernel's namespace with lots of extra global
> > symbols.
> 
> Primarily because it breaks convention.  Convention is that you
> #include .h files, and you compile and link .c files.  Convention is
> important because it reflects the common patterns we use when reading
> and writing (but mostly reading) code.

The problem is that there are conflicting conventions.  You mentioned 
one.  But there's another: .h files contain declarations and things 
that should be shared among multiple source files, and .c files contain 
things that generate object code (executable routines, static 
definitions, and so on).  The idea is that sharing something which 
generates object code would be a mistake, since every source file which 
included it would generate a copy of those same objects.

So if you want to #include a file which generates object code, one 
convention says it should be named .h and the other says it should be 
named .c.  A possible solution would be to use yet a different suffix, 
but I think that would only make matters worse.

(Just to add to the confusion, some people feel that .c files shouldn't
include much that _doesn't_ generate object code.  Hence they put
top-level declarations in a .h file, even though it is #included in
only one .c file.  This is mainly a matter of taste...)

> Yes there are exceptions, and yes it can be done, but there better be
> a damn good reason for doing so.  In this particular case, I really
> don't think it is warranted.

The reason for doing it is the second convention.  IMO that's just as
good a reason for doing it as the first convention is for not doing it.

>  We're not talking about a great deal of
> code, and we're *already* polluting the kernel namespace with c67x00_*
> function names because the driver is already in multiple pieces.

Sorry, I don't know what you mean.  How does the fact that uhci-hcd is 
in multiple pieces create names like c67x00_*?  Besides, the fact that 
we are already doing it doesn't justify unnecessarily doing even more.

> This issue has also come up on the LKML also.  See this thread:
> 
> http://thread.gmane.org/gmane.linux.kernel/498633

I read that thread some time ago.  If you look at it carefully, you'll
find that Linus is arguing in favor of the second convention -- mine, 
not yours.

> > What's so ugly about breaking a driver up into pieces?  Leaving it in
> > one giant piece would be much more ugly IMO.
> 
> Breaking into pieces: Good, and I fully agree.
> Doing it in non-standard way: Not so good as it trades one kind of
> ugliness for another.

But what should one do when there are two conflicting standards?

Alan Stern
