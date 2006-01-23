Return-Path: <bcollins@ubuntu.com>
Received: from a34-mta02.direcway.com (a34-mta02.direcpc.com [66.82.4.91])
	by ozlabs.org (Postfix) with ESMTP id BE812681BD
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jan 2006 00:13:06 +1100 (EST)
Received: from mail.phunnypharm.org
	(dpc67142247022.direcpc.com [67.142.247.22]) by a34-mta02.direcway.com
	(iPlanet Messaging Server 5.2 HotFix 1.25 (built Mar  3 2004))
	with ESMTP id <0ITJ00D8YRDPSM@a34-mta02.direcway.com> for
	linuxppc-dev@ozlabs.org; Mon, 23 Jan 2006 08:13:04 -0500 (EST)
Date: Mon, 23 Jan 2006 08:12:51 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Alsa-devel] RFC: OSS driver removal,
	a slightly	different	approach
In-reply-to: <s5hd5ijyw2q.wl%tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Message-id: <1138021971.22672.65.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
References: <20060119174600.GT19398@stusta.de>
	<20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
	<20060120212917.GA14405@suse.de>
	<1137799001.12998.59.camel@localhost.localdomain>
	<1137799330.13530.30.camel@grayson> <s5hd5ijyw2q.wl%tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>, linuxppc-dev@ozlabs.org,
	Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-01-23 at 13:20 +0100, Takashi Iwai wrote:
> > > > > Can someone from the ppc developers drop me a small note whether 
> > > > > SND_POWERMAC completely replaces DMASOUND_PMAC?
> > > > 
> > > > It doesnt. Some tumbler models work only after one plug/unplug cycle of
> > > > the headphone. early powerbooks report/handle the mute settings
> > > > incorrectly. there are likely more bugs.
> > > 
> > > Interesting... Ben Collins hacked something to have Toonie work as a
> > > "default" driver for non supported machine and saw that problem too, I
> > > think he fixes it, I'll check with him what's up there and if his fix
> > > applied to tumbler.c as well.
> > 
> > My "fix" was basically the result of converting to the platform
> > functions. It's hit or miss whether this works with tumbler too.
> > 
> > You can try the Ubuntu kernel packages (they can be unpacked and used on
> > non Ubuntu systems pretty easily) to see if it works for you. Tumbler
> > platform function conversion isn't even tested, so I'd be happy to hear
> > any feedback.
> 
> Don't forget to forward your patches to alsa-devel or me ;)

I'm passing everything through to BenH, especially since it's all using
functions new in his ppc tree.

Update on this "fix", it worked only because platform function
interrupts weren't enabled. Now that they are, it's back to the same old
thing.

At least that's a clue, though.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux
