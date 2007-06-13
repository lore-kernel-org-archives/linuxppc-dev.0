Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 35274DDE31
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jun 2007 01:09:27 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so281136wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 08:09:26 -0700 (PDT)
Message-ID: <fa686aa40706130809q78a875f5u45e458eaa54eae2d@mail.gmail.com>
Date: Wed, 13 Jun 2007 09:09:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [PATCH 6/6] [C67x00] Merge c67x00-hub.c into
	c67x00-hcd.c
In-Reply-To: <Pine.LNX.4.44L0.0706131033480.3467-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <fa686aa40706130554l36fefa13w4e2b1957a9fc5288@mail.gmail.com>
	<Pine.LNX.4.44L0.0706131033480.3467-100000@iolanthe.rowland.org>
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

On 6/13/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 13 Jun 2007, Grant Likely wrote:
>
> > On 6/12/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> > > >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
> > >
> > > Hi,
> > >
> > >  Grant> Rather than c67x00-hub.c being compiled seperately, the
> > >  Grant> original code had c67x00-hub.c *included* by c67x00-hcd.c.
> > >  Grant> This is a very bad idea.
>
> What's so bad about it?  It's an elegant solution to the problem of
> breaking a very long driver up into smaller, more digestible pieces
> without polluting the kernel's namespace with lots of extra global
> symbols.

Primarily because it breaks convention.  Convention is that you
#include .h files, and you compile and link .c files.  Convention is
important because it reflects the common patterns we use when reading
and writing (but mostly reading) code.

Yes there are exceptions, and yes it can be done, but there better be
a damn good reason for doing so.  In this particular case, I really
don't think it is warranted.  We're not talking about a great deal of
code, and we're *already* polluting the kernel namespace with c67x00_*
function names because the driver is already in multiple pieces.

This issue has also come up on the LKML also.  See this thread:

http://thread.gmane.org/gmane.linux.kernel/498633

> What's so ugly about breaking a driver up into pieces?  Leaving it in
> one giant piece would be much more ugly IMO.

Breaking into pieces: Good, and I fully agree.
Doing it in non-standard way: Not so good as it trades one kind of
ugliness for another.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
