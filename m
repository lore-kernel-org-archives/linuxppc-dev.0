Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C230367A45
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 09:15:54 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050203125725.GA20087@suse.de>
References: <1106011958.4533.25.camel@gaston> <20050203125725.GA20087@suse.de>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 09:15:01 +1100
Message-Id: <1107468901.2363.40.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-02-03 at 13:57 +0100, Olaf Hering wrote:
>  On Tue, Jan 18, Benjamin Herrenschmidt wrote:
> 
> > Hi !
> > 
> > This patch updates the PowerMac sleep support. The ability to sleep is now broken
> > into 2 different flags, one, "may sleep" is set for all motherboards that we know
> > how to put to sleep and wakeup. It gets turned into "can sleep" upon a call from
> > the video driver indicating the ability to wakeup the video card. This doesn't
> > deal with head-less machines, but this can be improved later. It also adds better
> > cache flush code, which improves stability with cpufreq as well as sleep.
> > 
> > This patch actually breaks sleep support until the video drivers for the affected
> > machines have been updated. This will come as separate patches.
> 
> Is that supposed to work? 2.6.11-rc2-bk10 sleeps ok on a pismo, but -rc3
> just does nothing when closing the lid.

It's normal, the kernel is waiting for the video driver to do a platform
call to indicate it supports sleep/wakeup on this model. The video
driver updates haven't been pushed yet. This concerns laptops with
nVidia, r128 and radeon chips. The former, we don't know how to wake
them up yet, the r128 patch is trivial and should go in, the radeonfb
patch is still beeing debated on.

Ben.
