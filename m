Return-Path: <radu.rendec@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428Mq54ZW2zF37f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 08:17:21 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id x197-v6so43396132oix.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 15:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAD5jUk_e3LwPZGN7G3ZGHx=zdQBZSdAeoKWjxwE7Ei2=LtXQTg@mail.gmail.com>
 <e6b9f0f0-1cd9-c183-eff4-bec1ca18a373@c-s.fr>
 <fc3e7ca0f018afbf6c104c333b381ffbae6a48c3.camel@gmail.com>
 <c0b2c45c-815c-d627-e975-a2d622494223@c-s.fr>
In-Reply-To: <c0b2c45c-815c-d627-e975-a2d622494223@c-s.fr>
From: Radu Rendec <radu.rendec@gmail.com>
Date: Mon, 10 Sep 2018 18:17:07 -0400
Message-ID: <CAD5jUk-oEoMwndqqPUs+AWnQThUjH+DA6fJUb5_W2rOPB1Njtw@mail.gmail.com>
Subject: Re: MPC83xx reset status register (RSR, offset 0x910)
To: christophe.leroy@c-s.fr
Cc: linuxppc-dev@lists.ozlabs.org, oss@buserror.net, mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, 2018-09-10 at 07:37 +0200, Christophe Leroy wrote:
> Le 10/09/2018 =C3=A0 01:13, Radu Rendec a =C3=A9crit :
> >
> > I'm using U-boot as well, but it's just not configured to read or clear
> > the RSR. I'm curious: if U-boot reads/clears the RSR in your case, how
> > do you make the initial value available to user space programs running
> > under Linux?
>
> I'm surprised. When looking at U-boot code, I don't see any way to
> configure that. It seems just do by default in function cpu_init_f():
>
> https://elixir.bootlin.com/u-boot/v2018.07/source/arch/powerpc/cpu/mpc83x=
x/cpu_init.c#L217
>
>         /* RSR - Reset Status Register - clear all status (4.6.1.3) */
>         gd->arch.reset_status =3D __raw_readl(&im->reset.rsr);
>         __raw_writel(~(RSR_RES), &im->reset.rsr);

I'm working as a contractor in a large embedded project, so I don't know
all the bits and pieces. I just checked the U-boot code. Whoever was
maintaining it, "configured" it by commenting out the __raw_writel()
that clears the register :)

Probably the reason was specifically to be able to read it from Linux,
but unfortunately the guy is not here any more to ask him.

It may make more sense to read it from U-boot, but (1) the value must
still be passed to Linux somehow and (2) in my case, I would prefer not
to touch U-boot.

> Do you know any user space program in Linux that needs this value ?

I don't know of any "standard" program that needs it. In the project I'm
working on, there are multiple peripherals on the board and initialization
is slightly different when the reset line is physically asserted vs. a
soft CPU reset. Besides, we need to show the reset reason to the user.

I guess in the embedded world this is a fairly common use case, so
perhaps others can benefit from that if I fix it in a way that can be
pushed upstream.

> > Thank you very much for the patches. Is there any chance they can be
> > submitted upstream?
>
> I see no problem submitting them upstream, but are they really worth it
> ? Adding Michael in copy to get his opinion.

I guess it's worth if they are changed to make the value available to
the kernel and user space rather than just decoding/printing it, for the
reasons I mentioned above.

The MPC83xx also has a watchdog and the kernel driver (mpc8xxx_wdt.c)
could also be improved to support the WDIOC_GETBOOTSTATUS ioctl and
properly report if the system rebooted due to a watchdog.

> > I tried to look for something similar on other platforms or architectur=
es,
> > but couldn't find anything.
>
> I believe furst thing is to identify some app needing such an
> information, then we'll be able to investigate how to handle it.

Well, I guess I explained my reasons and use case. If there is any
interest in that, I will gladly implement it in a way that makes sense
to upstream. Let's see what Michael thinks.

Thanks,
Radu Rendec
