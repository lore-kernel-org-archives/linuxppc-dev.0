Return-Path: <bhumirks@gmail.com>
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com
 [IPv6:2607:f8b0:4001:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSH62sXgzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:00:02 +1000 (AEST)
Received: by mail-io0-x230.google.com with SMTP id f102so52453521ioi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 02:00:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1705301056200.2981@hadrien>
References: <1495896375-30855-1-git-send-email-bhumirks@gmail.com>
 <s5hvaoiencx.wl-tiwai@suse.de> <alpine.DEB.2.20.1705301056200.2981@hadrien>
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Tue, 30 May 2017 14:29:59 +0530
Message-ID: <CAOH+1jEFvj_A2q6L+OjCZYrDvgfzthYk+fNkhzVh59FKh42aAg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: declare snd_kcontrol_new structures as const
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org, clemens@ladisch.de,
 linuxppc-dev@lists.ozlabs.org, perex@perex.cz,
 Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 30, 2017 at 2:26 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Tue, 30 May 2017, Takashi Iwai wrote:
>
>> On Sat, 27 May 2017 16:46:15 +0200,
>> Bhumika Goyal wrote:
>> >
>> > Declare snd_kcontrol_new structures as const as they are only passed an
>> > argument to the function snd_ctl_new1. This argument is of type const,
>> > so snd_kcontrol_new structures having this property can be made const.
>> > Done using Coccinelle:
>> >
>> > @r disable optional_qualifier@
>> > identifier x;
>> > position p;
>> > @@
>> > static struct snd_kcontrol_new x@p={...};
>> >
>> > @ok@
>> > identifier r.x;
>> > position p;
>> > @@
>> > snd_ctl_new1(&x@p,...)
>> >
>> > @bad@
>> > position p != {r.p,ok.p};
>> > identifier r.x;
>> > @@
>> > x@p
>> >
>> > @depends on !bad disable optional_qualifier@
>> > identifier r.x;
>> > @@
>> > +const
>> > struct snd_kcontrol_new x;
>> >
>> > Cross compiled these files:
>> > sound/aoa/codecs/tas.c - powerpc
>> > sound/mips/{hal2.c/sgio2audio.c} - mips
>> > sound/ppc/{awacs.c/beep.c/tumbler.c} - powerpc
>> > sound/soc/sh/siu_dai.c - sh
>> > Could not find an architecture to compile sound/sh/aica.c.
>> >
>> > Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>>
>> Applied now, as it looks safe enough.  But I prefer splitting to
>> individual patches, so please try to do that at the next time.
>
> Individual patches in a series?
>

Yes, I think so. Takashi told to send a patchset for similar changes.

Thanks,
Bhumika

> julia
