Return-Path: <bgat@billgatliff.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0CDD1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 03:39:08 +1100 (EST)
Received: by iabz21 with SMTP id z21so209685iab.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 08:39:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF0788007E.17A6C7B1-ON88257996.00000E0C-88257996.00009D99@selinc.com>
References: <OF2BD13139.450D178D-ON88257992.0018BB93-88257992.0018CFCA@selinc.com>
 <CADkCAusUm3_hNY3MYQOPcEnuw-91PHUMF9Yx6mwcM+WeJG50+Q@mail.gmail.com>
 <OF0788007E.17A6C7B1-ON88257996.00000E0C-88257996.00009D99@selinc.com>
Date: Tue, 31 Jan 2012 10:39:05 -0600
Message-ID: <CADkCAuvkWvBLbDwhDFBdZ0mGoPv5HyZSD-ivXPyTKbMo_9GXvg@mail.gmail.com>
Subject: Re: Question about GPIO Lib
From: Bill Gatliff <bgat@billgatliff.com>
To: Bruce_Leonard@selinc.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bruce:

On Mon, Jan 30, 2012 at 6:06 PM,  <Bruce_Leonard@selinc.com> wrote:
> Bill Gatliff <bgat@billgatliff.com> wrote on 01/27/2012 10:42:57 AM:
>> Sounds like you DON'T want to merely export that GPIO pin to userspace.
>>
>
> Well, yes I do want to just export to userspace

I misunderstood your message, then.  I was thinking that you were
already using certain pins in kernel space, and didn't want THOSE pins
exported to userspace due to the risks that users might invoke them
and cause Bad Things to happen.

> I just want to restrict
> the pins that get exported to only those that are defined in the device
> tree. =A0I don't want or need to access any of the exported pins from ker=
nel
> space and I don't want user space to access any pin not explicitly called
> out in the device tree. =A0I want it to behave like gpio-leds only with
> input as well as output capabilities.

I glanced at gpiolib.c, and I don't immediately see a way to achieve
this with the current code.

Again, you could get the same net effect by doing a gpio_request() in
kernel space on the pins you DON'T want exported, which would prevent
those pins being exportable.  But that's still different from what you
are actually asking for.

> If I understand this correctly you're basically saying that gpiolib is a
> waste of time and I should just write my own driver?

I'm DEFINITELY not saying that gpiolib is generally a waste of time!  :)

I'm just saying that, sadly, in many ways gpiolib is still a
work-in-progress.  The userspace component has been somewhat
controversial in general over the years, and definitely lacks several
key features in addition to the one you are asking for.

Since I know others will ask :), note that the userspace component
won't give you a direction attribute for pins whose directions cannot
be changed from userspace.  That's a pretty important omission, since
it prevents me from conveniently verifying (apart from debugfs, I
mean) that a pin is in fact configured in the direction I want it to
be.  Whether I can change its direction is a different issue entirely.

Another omission that has struck me over the years is that it's not
straightforward for gpio_chip authors to add custom attributes in
sysfs for either the chip itself, or for the pins the chip exports.
Within /sys/class/gpio/gpio<N>/ I mean.

But even in its current state, gpiolib is awesome.  Maybe someday I or
someone else will find time to make it awesomer.  :)


b.g.
--=20
Bill Gatliff
bgat@billgatliff.com
