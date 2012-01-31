Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
 by ozlabs.org (Postfix) with ESMTP id F286FB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 11:06:46 +1100 (EST)
In-Reply-To: <CADkCAusUm3_hNY3MYQOPcEnuw-91PHUMF9Yx6mwcM+WeJG50+Q@mail.gmail.com>
References: <OF2BD13139.450D178D-ON88257992.0018BB93-88257992.0018CFCA@selinc.com>
 <CADkCAusUm3_hNY3MYQOPcEnuw-91PHUMF9Yx6mwcM+WeJG50+Q@mail.gmail.com>
To: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
Subject: Re: Question about GPIO Lib
Message-ID: <OF0788007E.17A6C7B1-ON88257996.00000E0C-88257996.00009D99@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 30 Jan 2012 16:06:43 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bill,

Bill Gatliff <bgat@billgatliff.com> wrote on 01/27/2012 10:42:57 AM:

> 
> On Fri, Jan 27, 2012 at 5:31 AM,  <Bruce_Leonard@selinc.com> wrote:
> >
> > The problem is we've got a number of other things hooked up to the 
GPIO
> > pins that it would be very bad if someone from user space played with
> > them, like our FPGA configuration pin.  Some one toggles that and our 
box
> > goes stupid.  So what I'm wondering is if there's a way, preferably 
via
> > the device tree, to limit the GPIOs that GPIO Lib exposes to user 
space?
> 
> Sounds like you DON'T want to merely export that GPIO pin to userspace.
> 

Well, yes I do want to just export to userspace, I just want to restrict 
the pins that get exported to only those that are defined in the device 
tree.  I don't want or need to access any of the exported pins from kernel 
space and I don't want user space to access any pin not explicitly called 
out in the device tree.  I want it to behave like gpio-leds only with 
input as well as output capabilities.

> If you have anything in kernel space doing a gpio_request() on that
> pin, it won't be exportable to userspace anyway.  Regardless, you are
> probably better off implement a DEVICE_ATTR that, in its store()
> method, treads lightly on said pin.  And then do a gpio_request() in
> kernel space so that users can't ever see the pin directly.
> 
> Just my $0.02.
> 

If I understand this correctly you're basically saying that gpiolib is a 
waste of time and I should just write my own driver?

Bruce
