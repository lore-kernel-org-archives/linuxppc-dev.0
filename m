Return-Path: <jwboyer@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47CC52C013B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 03:32:50 +1000 (EST)
Received: by vbbfn1 with SMTP id fn1so5262872vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2012 10:32:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121001162547.GD31620@obsidianresearch.com>
References: <20120930232723.GF30637@obsidianresearch.com>
 <CA+5PVA767HNZUoFNj=UubLCdh91EtWiuK2JaY2qarMn=oCCB+A@mail.gmail.com>
 <20121001162547.GD31620@obsidianresearch.com>
Date: Mon, 1 Oct 2012 13:32:47 -0400
Message-ID: <CA+5PVA5qW-toX1_UA9wATy=q69_yK5RXd3cXKSy6-LohExJ3+Q@mail.gmail.com>
Subject: Re: [PATCH] PPC: Enable the Watchdog vector for 405
From: Josh Boyer <jwboyer@gmail.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 1, 2012 at 12:25 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Oct 01, 2012 at 08:16:29AM -0400, Josh Boyer wrote:
>> On Sun, Sep 30, 2012 at 7:27 PM, Jason Gunthorpe
>> <jgunthorpe@obsidianresearch.com> wrote:
>> > Move the body of the PIT exception out of line to make room.
>>
>> What boards did you test this on?  What driver are you using for the
>> watchdog?
>
> Tested on a 405F6 core (Xilinx's variant), the board is custom, and
> the control for the watchdog SPRs was bundled into a watchdog driver
> for the board's watchdog controller.
>
>> >  /* 0x1020 - Watchdog Timer (WDT) Exception
>> >  */
>> > -#ifdef CONFIG_BOOKE_WDT
>> >         CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
>> > -#else
>> > -       CRITICAL_EXCEPTION(0x1020, WDTException, unknown_exception)
>> > -#endif
>> > -#endif
>>
>> Please leave this wrapped in CONFIG_BOOKE_WDT.  I don't agree with
>> unconditionally enabling this for every 405 chip out there.
>
> What are you concerned with? If some core varient does not put a
> watchdog there, then you still get a panic from the default watchdog
> exception handler..

I'm concerned with the fact that you've moved PIT and now enabled
something that's been enabled for years.  There's no need to do it like
that.

>> > -#ifdef CONFIG_BOOKE_WDT
>> > +#if defined(CONFIG_BOOKE_WDT) | defined(CONFIG_40x)
>>
>> Pretty sure you meant || here?  Thought if you just enable the existing
>> config option, I don't think you'd need to edit this file at all.
>
> Yes, I didn't want to use BOOKE_WDT because I have not tested that
> driver, nor do I want that driver included in my kernel.. I think the
> watchdog driver in use should be orthogonal to having the exception
> wired in?

And it certainly can be.  Just make the driver a module and don't
install it or load it.  The #ifdef will still evaluate to true.

josh
