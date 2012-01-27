Return-Path: <bgat@billgatliff.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 575ADB6F67
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2012 05:43:01 +1100 (EST)
Received: by ggm4 with SMTP id 4so1053328ggm.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 10:42:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF2BD13139.450D178D-ON88257992.0018BB93-88257992.0018CFCA@selinc.com>
References: <OF2BD13139.450D178D-ON88257992.0018BB93-88257992.0018CFCA@selinc.com>
Date: Fri, 27 Jan 2012 19:42:57 +0100
Message-ID: <CADkCAusUm3_hNY3MYQOPcEnuw-91PHUMF9Yx6mwcM+WeJG50+Q@mail.gmail.com>
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

On Fri, Jan 27, 2012 at 5:31 AM,  <Bruce_Leonard@selinc.com> wrote:
>
> The problem is we've got a number of other things hooked up to the GPIO
> pins that it would be very bad if someone from user space played with
> them, like our FPGA configuration pin. =A0Some one toggles that and our b=
ox
> goes stupid. =A0So what I'm wondering is if there's a way, preferably via
> the device tree, to limit the GPIOs that GPIO Lib exposes to user space?

Sounds like you DON'T want to merely export that GPIO pin to userspace.

If you have anything in kernel space doing a gpio_request() on that
pin, it won't be exportable to userspace anyway.  Regardless, you are
probably better off implement a DEVICE_ATTR that, in its store()
method, treads lightly on said pin.  And then do a gpio_request() in
kernel space so that users can't ever see the pin directly.

Just my $0.02.


b.g.
--=20
Bill Gatliff
bgat@billgatliff.com
