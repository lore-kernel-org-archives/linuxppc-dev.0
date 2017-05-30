Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSSL3T5fzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:08:02 +1000 (AEST)
Date: Tue, 30 May 2017 10:56:39 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Takashi Iwai <tiwai@suse.de>
cc: Bhumika Goyal <bhumirks@gmail.com>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, broonie@kernel.org, clemens@ladisch.de,
 julia.lawall@lip6.fr, linuxppc-dev@lists.ozlabs.org, perex@perex.cz,
 johannes@sipsolutions.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: declare snd_kcontrol_new structures as const
In-Reply-To: <s5hvaoiencx.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.20.1705301056200.2981@hadrien>
References: <1495896375-30855-1-git-send-email-bhumirks@gmail.com>
 <s5hvaoiencx.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tue, 30 May 2017, Takashi Iwai wrote:

> On Sat, 27 May 2017 16:46:15 +0200,
> Bhumika Goyal wrote:
> >
> > Declare snd_kcontrol_new structures as const as they are only passed an
> > argument to the function snd_ctl_new1. This argument is of type const,
> > so snd_kcontrol_new structures having this property can be made const.
> > Done using Coccinelle:
> >
> > @r disable optional_qualifier@
> > identifier x;
> > position p;
> > @@
> > static struct snd_kcontrol_new x@p={...};
> >
> > @ok@
> > identifier r.x;
> > position p;
> > @@
> > snd_ctl_new1(&x@p,...)
> >
> > @bad@
> > position p != {r.p,ok.p};
> > identifier r.x;
> > @@
> > x@p
> >
> > @depends on !bad disable optional_qualifier@
> > identifier r.x;
> > @@
> > +const
> > struct snd_kcontrol_new x;
> >
> > Cross compiled these files:
> > sound/aoa/codecs/tas.c - powerpc
> > sound/mips/{hal2.c/sgio2audio.c} - mips
> > sound/ppc/{awacs.c/beep.c/tumbler.c} - powerpc
> > sound/soc/sh/siu_dai.c - sh
> > Could not find an architecture to compile sound/sh/aica.c.
> >
> > Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>
> Applied now, as it looks safe enough.  But I prefer splitting to
> individual patches, so please try to do that at the next time.

Individual patches in a series?

julia
