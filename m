Return-Path: <radu.rendec@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FMTH6rzTzF3JW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 11:19:13 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id x79-v6so15771662ita.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 18:19:13 -0700 (PDT)
Message-ID: <525e9a1f239a34bd568d043184ca913ae88e2edd.camel@gmail.com>
Subject: Re: MPC83xx reset status register (RSR, offset 0x910)
From: Radu Rendec <radu.rendec@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, oss@buserror.net, mpe@ellerman.id.au,
 eric.miao@marvell.com
Date: Tue, 18 Sep 2018 21:19:09 -0400
In-Reply-To: <d30e4a1e-187b-2a07-ec9c-50f889375cde@c-s.fr>
References: <CAD5jUk_e3LwPZGN7G3ZGHx=zdQBZSdAeoKWjxwE7Ei2=LtXQTg@mail.gmail.com>
 <e6b9f0f0-1cd9-c183-eff4-bec1ca18a373@c-s.fr>
 <fc3e7ca0f018afbf6c104c333b381ffbae6a48c3.camel@gmail.com>
 <c0b2c45c-815c-d627-e975-a2d622494223@c-s.fr>
 <CAD5jUk-oEoMwndqqPUs+AWnQThUjH+DA6fJUb5_W2rOPB1Njtw@mail.gmail.com>
 <d30e4a1e-187b-2a07-ec9c-50f889375cde@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

On Thu, 2018-09-13 at 10:21 +0200, Christophe LEROY wrote:
>
> Le 11/09/2018 à 00:17, Radu Rendec a écrit :
> >
> > The MPC83xx also has a watchdog and the kernel driver (mpc8xxx_wdt.c)
> > could also be improved to support the WDIOC_GETBOOTSTATUS ioctl and
> > properly report if the system rebooted due to a watchdog.
>
> Very good idea.
>
> I just submitted a patch for that. Please look at it.
> I'm sure any driver which needs reset status information can do the same.

Thanks for submitting the patch and sorry for the late reply! I followed
the conversation between you and Guenter and it seems your patches are
almost accepted. That's a good thing.

> If we want to do something more central, maybe we should look at what
> was done on ARM:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04fef228fb00

Thanks for pointing out that commit. It's very similar to what I wanted
to do (for MPC83xx) in the first place: read the RSR value on start-up
into a variable and export it as a symbol to make it available to other
drivers.

I would take on the work to implement something similar for PowerPC, but
I need some guidance as to what goes where. For instance, what would be
the PowerPC equivalent of arch/arm/mach-pxa/reset.c, which defines the
reset_status variable?

Another question is if the device tree should be used. We already have
separate directories for each platform in arch/powerpc/platforms and I
guess for each platform the RSR is always there and at a fixed, well
known address.

Thanks,
Radu
