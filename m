Message-ID: <394BB209.E711286D@embeddededge.com>
Date: Sat, 17 Jun 2000 13:14:49 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: john zhan <r3587@sina.com>
CC: hugh.mcdonald@nokia.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC used for WAN connection
References: <4FC68B779807D31191B10008C7731C4D579921@meeis01nok> <023901bfd7f1$96254ba0$d0c809c0@p2kasvr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


john zhan wrote:

> me too.  in fact,   also, I need generic x.25 running on it.

So, write it.


>
> >    What is needed is a new version of 8xx_io/uart.c that sets up and drives

No, what you want is an SCC synchronous driver. Period.  Don't put
stuff like this in the uart driver, it is a big enough mess the
way it is.  I am close to having a really configurable uart driver,
so you can select what SCC/SMCs you want.  The uart driver is a uart
driver, not an SCC driver.

We will probably have to create some other functions for managing the
baud rate generators, but for synchronous I/O that clock should be
provided externally.

> > other possible solutions....
> I think we can  work together .
> If you like,let's discuss it later , privately.

I would strongly suggest not going off and making a big mess, then
sending me a patch and hope it gets applied to the kernel sources.

I have done lots of synchronous SCC, HDLC, and other things as custom
proprietary drivers for many customers.  Typically, the driver does
very little, just buffers the data for mmap()'ed applications that
do the real work.  I will see if I can provide some framework from
past work I have done, but some of these folks are quite protective
of this.

These drivers are not hard to write, and you can use examples from
Motorola's NetComm site to get started.  You may need to do some
uncached memory buffering tricks in Linux or just use cache management
functions to ensure cache coherency.

Don't use old silicon, like before Rev. C 860.  Most of these functions
don't work as advertised on SCC3 and SCC4, only on SCC1 and SCC2.  Make
sure you pay close attention to the external hardware, as clock and
data transition edges are criticaly to this working correctly.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
