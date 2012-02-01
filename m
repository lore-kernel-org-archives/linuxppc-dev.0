Return-Path: <bgat@billgatliff.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1D75B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 02:56:47 +1100 (EST)
Received: by iabz21 with SMTP id z21so1925807iab.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2012 07:56:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120201123231.GB13723@sirena.org.uk>
References: <OF2BD13139.450D178D-ON88257992.0018BB93-88257992.0018CFCA@selinc.com>
 <CADkCAusUm3_hNY3MYQOPcEnuw-91PHUMF9Yx6mwcM+WeJG50+Q@mail.gmail.com>
 <OF0788007E.17A6C7B1-ON88257996.00000E0C-88257996.00009D99@selinc.com>
 <CADkCAuvkWvBLbDwhDFBdZ0mGoPv5HyZSD-ivXPyTKbMo_9GXvg@mail.gmail.com>
 <20120201123231.GB13723@sirena.org.uk>
Date: Wed, 1 Feb 2012 09:56:45 -0600
Message-ID: <CADkCAus2r-dzXsHEa6nRAgrz-v+AnmbSDBeVcHHzmM=FcwgePg@mail.gmail.com>
Subject: Re: Question about GPIO Lib
From: Bill Gatliff <bgat@billgatliff.com>
To: Mark Brown <broonie@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Bruce_Leonard@selinc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark:

On Wed, Feb 1, 2012 at 6:32 AM, Mark Brown <broonie@sirena.org.uk> wrote:
>
> Just to expand on this a bit: lots of people would prefer not to have a
> userspace component at all due to the same hardware safety concerns that
> you have, or to have the userspace component be a driver using gpiolib
> which needs to be explicitly connected to the GPIOs.

... which I think is a spectacularly bad idea. :)

Diversion from the original theme of this thread notwithstanding, I
don't see the point in the additional complexity of implementing such
a heavy-handed lockout when it's pretty darned easy to just do a
gpio_request() in kernel space to take the pin entirely away from
users.  I do that pretty routinely, but then in the relevant
kernel-side driver I almost always offer a sysfs attribute of my own
that lets me grant users controlled access to the functionality
provided by the pin.

For example, if it's a RESET-type pin for an external chip, then I'll
have a /sys/.../assert_reset attribute such that when root writes to
it, my store() method sends a timed pulse to the physical GPIO pin. Or
not, depending on what mood the device is in at the time--- which the
driver always knows.

I won't let the user kill anyone, of course, but I WILL grant them
tools like the above to bring the platform under control and
investigate problems during hardware integration.  The productivity
improvement more than offsets the thought and code investment
required.

I have often considered a gpiolib patch that just makes sysfs
attributes read-only when kernel-side does a gpio_request(), rather
than taking the pin attributes away entirely.  That way I can have
simple tools in userspace to silently log GPIO activity for
troubleshooting.  The blocking reads that some versions of gpiolib
offer today make this work even better.



b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
