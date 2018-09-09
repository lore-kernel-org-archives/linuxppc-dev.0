Return-Path: <radu.rendec@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427n630BwCzF3Bd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 09:13:11 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id h3-v6so27287696ita.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Sep 2018 16:13:11 -0700 (PDT)
Message-ID: <fc3e7ca0f018afbf6c104c333b381ffbae6a48c3.camel@gmail.com>
Subject: Re: MPC83xx reset status register (RSR, offset 0x910)
From: Radu Rendec <radu.rendec@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>
Date: Sun, 09 Sep 2018 19:13:04 -0400
In-Reply-To: <e6b9f0f0-1cd9-c183-eff4-bec1ca18a373@c-s.fr>
References: <CAD5jUk_e3LwPZGN7G3ZGHx=zdQBZSdAeoKWjxwE7Ei2=LtXQTg@mail.gmail.com>
 <e6b9f0f0-1cd9-c183-eff4-bec1ca18a373@c-s.fr>
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

Hi,

On Fri, 2018-08-24 at 16:20 +0000, Christophe Leroy wrote:
> > On 08/03/2018 04:36 PM, Radu Rendec wrote:
> >
> > Is there any kernel code that handles the "reset status register" (RSR)
> > on MPC83xx? I looked at arch/powerpc/platforms/83xx/misc.c, but it seems
> > to only map the reset register area and it's static. The watchdog driver
> > (drivers/watchdog/mpc8xxx_wdt.c) doesn't seem to look at it either (for
> > the bootstatus flags).
>
> How do you boot your Linux kernel ?
>
> My 832x board boots using U-boot, and U-boot reads the RSR then clears
> it. So when Linux kernel reads it, it is just 0.

I'm using U-boot as well, but it's just not configured to read or clear
the RSR. I'm curious: if U-boot reads/clears the RSR in your case, how 
do you make the initial value available to user space programs running 
under Linux?

> > Basically I need to check the CPU reset reason and I thought I would ask
> > first, before starting to write any code of my own.
>
> Anyway, find below a set of two patches I used for testing. Feel free to
> use them if you bootloader doesn't clear the register

Thank you very much for the patches. Is there any chance they can be 
submitted upstream?

Of course, just printing the decoded bits is only helpful for testing. I
was thinking of a way to make the value available to both the kernel 
(as an exported symbol) and user space (e.g. via sysfs). Is there a
standard or preferred way to do this?

I tried to look for something similar on other platforms or architectures,
but couldn't find anything.

Thanks,
Radu Rendec
