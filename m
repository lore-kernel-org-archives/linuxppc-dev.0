Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 420281007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 03:53:47 +1100 (EST)
Date: Wed, 1 Feb 2012 16:53:41 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Question about GPIO Lib
Message-ID: <20120201165341.GA24063@sirena.org.uk>
References: <OF2BD13139.450D178D-ON88257992.0018BB93-88257992.0018CFCA@selinc.com>
 <CADkCAusUm3_hNY3MYQOPcEnuw-91PHUMF9Yx6mwcM+WeJG50+Q@mail.gmail.com>
 <OF0788007E.17A6C7B1-ON88257996.00000E0C-88257996.00009D99@selinc.com>
 <CADkCAuvkWvBLbDwhDFBdZ0mGoPv5HyZSD-ivXPyTKbMo_9GXvg@mail.gmail.com>
 <20120201123231.GB13723@sirena.org.uk>
 <CADkCAus2r-dzXsHEa6nRAgrz-v+AnmbSDBeVcHHzmM=FcwgePg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADkCAus2r-dzXsHEa6nRAgrz-v+AnmbSDBeVcHHzmM=FcwgePg@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Bruce_Leonard@selinc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 01, 2012 at 09:56:45AM -0600, Bill Gatliff wrote:
> On Wed, Feb 1, 2012 at 6:32 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> > Just to expand on this a bit: lots of people would prefer not to have a
> > userspace component at all due to the same hardware safety concerns that
> > you have, or to have the userspace component be a driver using gpiolib
> > which needs to be explicitly connected to the GPIOs.

> ... which I think is a spectacularly bad idea. :)

> Diversion from the original theme of this thread notwithstanding, I
> don't see the point in the additional complexity of implementing such
> a heavy-handed lockout when it's pretty darned easy to just do a
> gpio_request() in kernel space to take the pin entirely away from
> users.  I do that pretty routinely, but then in the relevant

Well, it's about the default - some people feel a lot safer blocking
everything by default and then enabling particular signals they want
userspace to control.  That default is more annoying for people who want
to do debug but a lot less controversial in terms of things possibly
going wrong.

> I have often considered a gpiolib patch that just makes sysfs
> attributes read-only when kernel-side does a gpio_request(), rather
> than taking the pin attributes away entirely.  That way I can have
> simple tools in userspace to silently log GPIO activity for
> troubleshooting.  The blocking reads that some versions of gpiolib
> offer today make this work even better.

That's a useful idea.
