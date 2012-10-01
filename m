Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 913E72C0128
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 02:25:52 +1000 (EST)
Date: Mon, 1 Oct 2012 10:25:47 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] PPC: Enable the Watchdog vector for 405
Message-ID: <20121001162547.GD31620@obsidianresearch.com>
References: <20120930232723.GF30637@obsidianresearch.com>
 <CA+5PVA767HNZUoFNj=UubLCdh91EtWiuK2JaY2qarMn=oCCB+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+5PVA767HNZUoFNj=UubLCdh91EtWiuK2JaY2qarMn=oCCB+A@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 01, 2012 at 08:16:29AM -0400, Josh Boyer wrote:
> On Sun, Sep 30, 2012 at 7:27 PM, Jason Gunthorpe
> <jgunthorpe@obsidianresearch.com> wrote:
> > Move the body of the PIT exception out of line to make room.
> 
> What boards did you test this on?  What driver are you using for the
> watchdog?

Tested on a 405F6 core (Xilinx's variant), the board is custom, and
the control for the watchdog SPRs was bundled into a watchdog driver
for the board's watchdog controller.

> >  /* 0x1010 - Fixed Interval Timer (FIT) Exception
> >  */
> > -       STND_EXCEPTION(0x1010,  FITException,           unknown_exception)
> > +//     STND_EXCEPTION(0x1010,  FITException,           unknown_exception)
> 
> Please just move the #endif for the #if 0 up instead of putting a C++
> style comment here.

Sure
 
> >  /* 0x1020 - Watchdog Timer (WDT) Exception
> >  */
> > -#ifdef CONFIG_BOOKE_WDT
> >         CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
> > -#else
> > -       CRITICAL_EXCEPTION(0x1020, WDTException, unknown_exception)
> > -#endif
> > -#endif
> 
> Please leave this wrapped in CONFIG_BOOKE_WDT.  I don't agree with
> unconditionally enabling this for every 405 chip out there.

What are you concerned with? If some core varient does not put a
watchdog there, then you still get a panic from the default watchdog
exception handler..

> > -#ifdef CONFIG_BOOKE_WDT
> > +#if defined(CONFIG_BOOKE_WDT) | defined(CONFIG_40x)
> 
> Pretty sure you meant || here?  Thought if you just enable the existing
> config option, I don't think you'd need to edit this file at all.

Yes, I didn't want to use BOOKE_WDT because I have not tested that
driver, nor do I want that driver included in my kernel.. I think the
watchdog driver in use should be orthogonal to having the exception
wired in?

Jason
