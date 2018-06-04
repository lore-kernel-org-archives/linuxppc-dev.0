Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ztQL26kLzF0mR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 21:44:41 +1000 (AEST)
Received: by mail-ua0-x243.google.com with SMTP id x18-v6so15126675uaj.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 04:44:41 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 13:44:38 +0200
Message-ID: <CAMuHMdXVR3g6Pm8RoVbpcs+JpTpHDkTnZvhNsKLWBszcgsXRfA@mail.gmail.com>
Subject: Re: [PATCH 01/11] macintosh/via-pmu: Fix section mismatch warning
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

On Sat, Jun 2, 2018 at 5:27 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The pmu_init() function has the __init qualifier, but the ops struct
> that holds a pointer to it does not. This causes a build warning.
> The driver works fine because the pointer is only dereferenced early.
>
> The function is so small that there's negligible benefit from using
> the __init qualifier. Remove it to fix the warning, consistent with
> the other ADB drivers.

Some other ADB subdriver .init() and .probe() functions aren't that small.
But with the current scheme using adb_drivers_list[], they cannot be __init.
Probably the long term fix is to change the ADB subsystem from the
centralized approach of letting adb_init() call all subdrivers, to making the
subdrivers platform drivers registering with the ADB core.

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Anyway:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
