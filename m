Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7E35B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 23:14:59 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C190BDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 23:14:57 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 26 Jun 2009 15:14:54 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5hr5xa9d5q.wl%tiwai@suse.de>
Message-ID: <20090626131454.246580@gmx.net>
MIME-Version: 1.0
References: <20090621181855.74980@gmx.net>	<1245623678.16880.27.camel@pasglop>
	<s5h8wjkoi70.wl%tiwai@suse.de>	<20090623085554.9200@gmx.net>
	<20090623214224.104620@gmx.net>	<20090624084601.273130@gmx.net>
	<s5hr5xa9d5q.wl%tiwai@suse.de>
Subject: Re: ALSA fixes for non-coherent ppc32 again
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 24 Jun 2009 11:47:13 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
> Betreff: Re: ALSA fixes for non-coherent ppc32 again

> At Wed, 24 Jun 2009 10:46:01 +0200,
> Gerhard Pircher wrote:
> > 
> > 
> > -------- Original-Nachricht --------
> > > Datum: Tue, 23 Jun 2009 23:42:24 +0200
> > > Von: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> > > An: benh@kernel.crashing.org, tiwai@suse.de
> > > CC: linuxppc-dev@ozlabs.org
> > > Betreff: Re: ALSA fixes for non-coherent ppc32 again
> > 
> > > Okay, that's wrong. I somehow messed up the .config file. It doesn't
> > > compile, too.
> > I got it to compile now and it seems to work fine. I overlooked a typo
> > in sound/core/Makefile first (ifndef CONFIG_SND_NONCOHERNT_DMA.)
> 
> Gah, thanks, fixed now on the git tree too.

The Kconfig option still needs to be fixed, otherwise SND_COHERENT_DMA
isn't selected for my "PPC32 && NOT_COHERENT_CACHE" machine.

config SND_NONCOHERENT_DMA
        def_bool n  <-- should be "y"
        depends on (PPC32 && NOT_COHERENT_CACHE)...

BTW: Can you put me on CC: please, if you bring up this topic on
linux-arch or so?

Gerhard

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
