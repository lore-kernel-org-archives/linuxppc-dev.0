Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413Tpy6rYQzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 18:30:01 +1000 (AEST)
Received: by mail-vk0-f67.google.com with SMTP id o138-v6so10620466vkd.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 01:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
 <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Jun 2018 10:29:45 +0200
Message-ID: <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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

On Sat, Jun 9, 2018 at 2:20 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > > Is this enum used by any user space code? If so, perhaps rather
> > > > leave the PMU_68K_V1 in there to avoid upsetting that?
> > >
> > > It also changes the value of PMU_68K_V2, which is an ABI break.
> >
> > Yes, that's what I worry about - but do we know of any users of that
> > particular interface?
>
> There is no ABI issue AFAIK. The value of pmu_kind is visible to userland
> only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k. This patch
> series will make these UAPIs available on m68k, and for that reason I've
> chosen the value PMU_UNKNOWN for pmu_kind.

While /dev/pmu and /proc/pmu/* may not exist on m68k, definitions in
include/uapi/linux/pmu.h are part of the ABI, and cannot be changed or removed,
unless we are 100% sure there are no users.

If I would write a program interfacing with /dev/pmu and /proc/pmu/*, and
needing to check the PMU type, it would have a switch() statement with
all existing values defined in <linux/pmu.h>. So that would become broken
by your change.

Hence the enum is append-only.

> New pmu_kind values can be defined as and when the need arises. But that
> would imply a useful classification scheme for pre-PCI powerbooks, and I
> don't know what that scheme will look like because at this stage there is
> neither userland nor kernel code to support backlight, buttons and battery
> for pre-PCI powerbooks.
>
> In anycase, the "v1" and "v2" scheme is obviously inadequate when you
> consider the range of m68k powerbook models. Also, consider the

New values can be added at the bottom.

> out-of-tree adaptation of via-pmu by the Nubus-PMac project, which has
> this ABI break:
>
> diff --git a/include/linux/pmu.h b/include/linux/pmu.h
> index cafe98d9694..9882a185a52 100644
> --- a/include/linux/pmu.h
> +++ b/include/linux/pmu.h
> @@ -90,6 +90,7 @@ enum {
>          PMU_HEATHROW_BASED,     /* PowerBook G3 series */
>          PMU_PADDINGTON_BASED,   /* 1999 PowerBook G3 */
>          PMU_KEYLARGO_BASED,     /* Core99 motherboard (PMU99) */
> +        PMU_NUBUS_BASED,        /* 1400, 2300, 5300 */
>          PMU_68K_V1,             /* 68K PMU, version 1 */
>          PMU_68K_V2,             /* 68K PMU, version 2 */
>  };

That's bad.  But as long as the NuBus-PMac project is out-of-tree, the
enum values it uses are not part of the Linux ABI, IMHO.
During upstreaming, PMU_NUBUS_BASED should be moved to the bottom.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
