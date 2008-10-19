Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C89D2DDDE7
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 13:53:57 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 9DDCC1C7172
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 23:53:36 -0300 (BRT)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id qH5isnjHcgkN for <linuxppc-dev@ozlabs.org>;
	Sun, 19 Oct 2008 00:53:30 -0200 (BRST)
Received: from chagas.nectar.ath.cx (189-39-150-138.gru.flash.tv.br
	[189.39.150.138])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id F2B821C7327
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 23:53:22 -0300 (BRT)
Date: Sat, 18 Oct 2008 23:53:23 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
Message-ID: <20081019025323.GA7887@ime.usp.br>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20081013184443.GA20612@ld0162-tx32.am.freescale.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	akpm@linux-foundation.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

On Oct 13 2008, Scott Wood wrote:
> On Mon, Oct 13, 2008 at 08:05:09PM +0200, Guennadi Liakhovetski wrote:
> > On Mon, 13 Oct 2008, Rogério Brito wrote:
> > > The current defconfig for Linkstation/Kuroboxes has the "Disable
> > > Heap Randomization" option enabled.
> > > 
> > > Since some of these machines are facing the internet, it helps to
> > > have heap randomization enabled. This patch enables it.
> > 
> > Same as the previous patch - this is one of options, that users
> > select according to their needs. If any specific distribution
> > enables this option by default in their kernels, they can do this
> > too, don't think this is critical enough to patch the defconfig.

I guess, Guennadi, that this is questionable. Many people would base
their configs on the defconfig.

Also, the defconfig has many questionable settings for an embedded
platform like the Kurobox.

And it seems that there is something not quite right for these embedded
systems. Here is something that I get with a vanilla linkstation_defconfig:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

This gets me (with bootlogd enabled):

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Wed Dec 31 21:00:15 1969: Cannot access the Hardware Clock via any known method.
Wed Dec 31 21:00:15 1969: Use the --debug option to see the details of our search for an access method.
Wed Dec 31 21:00:15 1969: Unable to set System Clock to: Thu Jan 1 00:00:15 UTC 1970 ^[[33m(warning).^[[39;49m
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

I just saw that in the default config:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# CONFIG_PPC_CLOCK is not set
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Maybe this should be enabled? I can iterate once more to see if this
option would make any difference here.

> Just because users/distros can change it doesn't mean it's pointless
> to discuss what default is sane, and make changes if the current
> default isn't.

100% agreed again, Scott. To repeat myself here, I think that the
defconfig should show the users the best current practices.

> For security-related options it's usually best to default to the more
> secure state, especially since the option description talks about it
> being needed mainly for libc5 compatibility -- did libc5 ever even
> exist for powerpc?
> 
> The only reason it was turned on in the first place was likely the
> "default y", which in turn is there to avoid breaking old x86 distros.

I'm including both Paul and BenH here.


Regards, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
