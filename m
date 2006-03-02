Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB41367B43
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 11:04:24 +1100 (EST)
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <1141256965.4378.145.camel@grayson>
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
	<20060226173908.GA4871@suse.de> <20060301223034.GA5965@suse.de>
	<1141254596.3889.26.camel@localhost.localdomain>
	<1141256965.4378.145.camel@grayson>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 11:04:04 +1100
Message-Id: <1141257844.3889.32.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Ben Collins <ben.collins@ubuntu.com>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-03-01 at 18:49 -0500, Ben Collins wrote:
> On Thu, 2006-03-02 at 10:09 +1100, Benjamin Herrenschmidt wrote:
> > > > This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
> > > > force it on up to now, but with this patch the internal speaker will not
> > > > work with or without my patch to force it on.
> > > 
> > > But the patch fixes also my PowerBook4,1, I dont have to toggle the headphone
> > > once to get the built-in speakers enabled.
> > > Looks like 2.6.16 stuff, but its been broken for so long now...
> > 
> > What is the status of Ben's latest stuff ?
> 
> I'm rediffing now. However, I may not include my tumbler changes
> immediately. For some reason, those are the ones causing problems. I
> need to review the diff and see if I can find the problem (which I
> cannot reproduce).
> 
> The toonie stuff is great. Been working really well for all the folks
> I've heard from, and for me on my PowerBook5,9.

There is an issue with some models where asserting both mutes will reset
the codec, so you have to be careful with that. Then, there is the
old-style GPIOs where you can read the polarity from the device-tree and
the new style ones...

I _think_ apple uses the GPIO platform functions only on machines that
have "include-k2-support" property in macio too, so maybe you are trying
to use them on earlier machines and they are bogus...

Send me the complete patch and I'll see if I spot something. Olaf, can
you give me quick summary of the machines that have problems with  Ben's
code ?

Ben.
