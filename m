Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 59ED8DDEB6
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2008 13:59:45 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1239143wag.13
	for <linuxppc-dev@ozlabs.org>; Sat, 09 Feb 2008 18:59:43 -0800 (PST)
Message-ID: <9e4733910802091859o3e91b6f6y4b0e6b31f722d8e6@mail.gmail.com>
Date: Sat, 9 Feb 2008 21:59:43 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: of_iomap and request_mem_region
In-Reply-To: <200802100345.54580.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910802091838x3e596debj113089faef08c1c8@mail.gmail.com>
	<200802100345.54580.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/9/08, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 10 February 2008, Jon Smirl wrote:
> > of_iomap doesn't implicitly do a request_mem_region().  How should
> > request_mem_region() be handled? When using of_iomap you don't get the
> > length of the region back so it isn't easy to call request_mem_region.
> >
> > What about adding a third param to of_iomap for the driver name? If it
> > is non-null also do the request region. If it is null check to make
> > sure the region has already be requested.
>
> I'd prefer changing of_iomap so that it gets the of_device instead of
> the device_node. That would help us do two changes at once:
>
> 1. call request_mem_region using dev->driver->name, as you mentioned.
> 2. use managed registrations, as lib/devres.c does e.g. in pcim_iomap,
> so that we can kill all the calls to iounmap in the cleanup path
> of OF drivers.
>
> maybe we can do a new ofm_iomap interface first, and then move
> drivers over to use that one.

There are only four drivers using of_iomap. It is not much work to
change them. Looking at them I don't see any that request the
resource. That's probably because they don't have the length needed to
make the call.

There are a lot of drivers using of_address_to_resource. They could
probably be converted to of_iomap if it gets changed. All of the ones
I checked follow the of_address_to_resource with a request_resource
call.

>
>         Arnd <><
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
