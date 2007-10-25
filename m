Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5DCDDDE35
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 04:08:21 +1000 (EST)
Message-ID: <4720DC0F.3010802@genesi-usa.com>
Date: Thu, 25 Oct 2007 19:10:23 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
References: <20071024163412.GA17785@ru.mvista.com>	
	<471FC191.6020704@genesi-usa.com>	
	<200710241850.05467.david-b@pacbell.net>	
	<fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>	
	<47208273.8050601@ru.mvista.com>
	<fa686aa40710250721m54dda956qe7c8986416d0dfa2@mail.gmail.com>
In-Reply-To: <fa686aa40710250721m54dda956qe7c8986416d0dfa2@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> On 10/25/07, Valentine Barshak <vbarshak@ru.mvista.com> wrote:
 >
> If it doesn't, it can be added during prom_init.c  We're already doing
> a bunch of efika fixups there anyway.

I want those to go away. Far, far away.

http://www.powerdeveloper.org/platforms/efika/devicetree

Not the most elegant solution right now, but it works (kinda, a few bugs
to sort out).

Note that Domen's ethernet driver plus a bunch of Sylvain's stuff if
it is ever cleaned up (deep sleep etc.) will not work without these
device tree changes. You should realise that if we plugged every tiny
thing into prom_init.c we would double the size of the file just for
Efika fixes.

And that's dumb.

Compatibility with old device trees should go away after there is a
production firmware people can download - like the x86 hardware monitor
drivers in lmsensors report "please upgrade your BIOS" if they have
been disabled, users will happily update their BIOS to an updated
version if it is available.

For Efika, right now, it is not.

And for Efika, right now, I fear the stupidity some of the device tree
design (mandated by a text file..) means any new firmware update
will have far more strings and reporting than it should ever truly
need.

Although you can restrict Linux kernels from running on firmwares below
a certain version, we can't knowingly restrict the board firmware to only
running Linux kernels above a certain version.

Therefore, this is an exercise in not pissing people off, not really
of any technical merit. We already had Pegasos keyboard support disappear
because someone decided the device tree usage needed to be changed. Given
the size of the fix in nvramrc, it's harmless, given that Pegasos is
a dead platform, it's harmless. Efika is still in production.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
