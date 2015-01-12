Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x229.google.com (mail-lb0-x229.google.com
 [IPv6:2a00:1450:4010:c04::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CC301A05E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 03:27:12 +1100 (AEDT)
Received: by mail-lb0-f169.google.com with SMTP id p9so18468389lbv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 08:27:09 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150112162438.GA18723@roeck-us.net>
References: <20150112180322.003b44f2@canb.auug.org.au>
 <20150112162438.GA18723@roeck-us.net>
Date: Mon, 12 Jan 2015 17:27:08 +0100
Message-ID: <CAMuHMdUYEe=L=H75AOYVjinRSW=okRJNrNJVy-bY1gshdVrO7Q@mail.gmail.com>
Subject: Re: linux-next: Tree for Jan 12 (build failures: m68k, ppc)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>, Linux-Next <linux-next@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 12, 2015 at 5:24 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Jan 12, 2015 at 06:03:22PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20150109:
>>
>> The usb-gadget-fixes tree gained a conflict against the usb.current tree.
>>
>> The net-next tree gained a build failure for which I reverted a commit.
>>
>> The pinctrl tree gained a build failure so I used the version from
>> next-20150109.
>>
>> The akpm tree lost a few patches that turned up elsewhere.
>>
>> Non-merge commits (relative to Linus' tree): 2202
>>  2272 files changed, 69868 insertions(+), 38441 deletions(-)
>>
>
> Build failures, seen since next-20150109:
>         m68k:allmodconfig
>         powerpc:ppc6xx_defconfig
>
> Due to:
>         ERROR: "__get_user_bad" [drivers/gpu/drm/drm.ko] undefined!
>         make[1]: *** [__modpost] Error 1
>
> Caused by commit d34f20d6e2f (drm: Atomic modeset ioctl).

Yeah, it needs a get_user() that supports 64-bit data.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
