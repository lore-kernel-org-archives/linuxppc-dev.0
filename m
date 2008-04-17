Return-Path: <SRS0+717c909e079b4f65c96e+1698+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5456DDEF7B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 02:37:34 +1000 (EST)
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
From: David Woodhouse <dwmw2@infradead.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48076A00.1080608@genesi-usa.com>
References: <1208105558.3026.137.camel@pmac.infradead.org>
	<4807427B.3030902@genesi-usa.com>
	<1208443057.9212.250.camel@pmac.infradead.org>
	<48076A00.1080608@genesi-usa.com>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 17:37:27 +0100
Message-Id: <1208450247.9212.275.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-04-17 at 16:17 +0100, Matt Sealey wrote:
> David Woodhouse wrote:
> > On Thu, 2008-04-17 at 13:28 +0100, Matt Sealey wrote:
> >> I thought we were using efika.forth for this in Fedora.
> > 
> > We were, until you pointed out that the kernel actually works just fine
> > these days without it.
> 
> I said the kernel has had braindead patches shoved into it that sort of
> obviate the need for the most heinous of crimes committed in the Efika
> device tree.

:)

> The Linux kernel fixups don't add the CDM or XLB arbiter or many other
> components some out-of-mainline drivers

I don't give a monkey's left testicle about code which isn't mainline.
If and when it's merged, we can make sure the device-tree fixups are
sufficient for it -- by whatever means.

> > can't set environment variables from within Linux (and yes, we can
> > probably improve on that too, but we let them setenv for themselves, for
> > now).
> 
> You really won't be improving on it because there's no reliable way to
> pass setenv back to the firmware from userland :D

Except by putting it in a text file which is booted instead of yaboot,
the first time after install. The user just types 'boot hd:,\fixme.fth'
instead of having to set the variables manually.

> My ideal situation is all this stuff is stripped from the kernel. You do
> realise 90% of the Efika traffic on this list is submitting code that
> fixes fixups for a firmware which has a seperated fixup script, putting
> the responsibility firmly where Linux-PPC policy dictated it should be
> (with the firmware).

The fixup script is a fairly unwieldy hack for a distribution to try to
support. It turns our release/install notes for Efika from a few lines
of "Efika firmware is a bit crap" into twice as many lines of "Efika
firmware is entirely crap".

> I think it's stunting the development of the platform. In lieu of a
> real, solid, flashable firmware update that fixes the problems, 

Bored now. Quit whining and give us a real, solid, flashable firmware
update that fixes the problems. Really.

> I don't think patching the Linux kernel is the correct solution, and I
> do not appreciate the 180 degree turn that Linux-PPC policy has taken
> with this.
> If we could not commit fixes for it in the beginning and were lambasted
> for shoving firmware bugfixes into the kernel, how should it be so
> different now?

Haven't we covered this? We were originally promised a firmware update
which would fix all this, about a year ago. It was quite reasonable at
the time to wait for it and avoid putting the hacks in the kernel.
Now we've come to the conclusion that it isn't going to happen, it's
also quite reasonable to change tack and work around it.

If there was a chance of policy, it was because we were promised
something which didn't appear.

> You do realise that once the fixes are in the kernel *you may never
> see another firmware update*? There'll be no point..

Except to fix the off-by-one problems and various other breakages other
than the device-tree, perhaps. But I thought we'd already reached the
conclusion that we may never see another firmware update?

OTOH, it probably wouldn't be _so_ hard to port Mitch's OpenFirmware to
mpc5200...

-- 
dwmw2
