Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x22b.google.com (mail-lb0-x22b.google.com
 [IPv6:2a00:1450:4010:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30EED1A03B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 00:33:40 +1000 (EST)
Received: by mail-lb0-f171.google.com with SMTP id z12so449230lbi.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Oct 2014 07:33:34 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1412170086-57971-1-git-send-email-agraf@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
Date: Wed, 1 Oct 2014 16:33:34 +0200
Message-ID: <CAMuHMdWEN+q+s6ENoqqD8d0hy=hcZSiWzW3poJFBs8uEBGVuGg@mail.gmail.com>
Subject: Re: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alex,

On Wed, Oct 1, 2014 at 3:27 PM, Alexander Graf <agraf@suse.de> wrote:
> The generic Linux framework to power off the machine is a function pointer
> called pm_power_off. The trick about this pointer is that device drivers can
> potentially implement it rather than board files.
>
> Today on PowerPC we set pm_power_off to invoke our generic full machine power
> off logic which then calls ppc_md.power_off to invoke machine specific power
> off.
>
> However, when we want to add a power off GPIO via the "gpio-poweroff" driver,
> this card house falls apart. That driver only registers itself if pm_power_off
> is NULL to ensure it doesn't override board specific logic. However, since we
> always set pm_power_off to the generic power off logic (which will just not
> power off the machine if no ppc_md.power_off call is implemented), we can't
> implement power off via the generic GPIO power off driver.
>
> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
> pm_power_off as was intended. Then individual drivers such as the GPIO power off
> driver can implement power off logic via that function pointer.
>
> With this patch set applied and a few patches on top of QEMU that implement a
> power off GPIO on the virt e500 machine, I can successfully turn off my virtual
> machine after halt.

This is touching the same area as last night's
"[RFC PATCH 00/16] kernel: Add support for poweroff handler call chain"
https://lkml.org/lkml/2014/9/30/575

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
