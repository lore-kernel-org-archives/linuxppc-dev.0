Return-Path: <dgibson@ozlabs.org>
Date: Fri, 18 Apr 2008 10:17:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
Message-ID: <20080418001722.GA8724@yookeroo.seuss>
References: <1208105558.3026.137.camel@pmac.infradead.org>
	<4807427B.3030902@genesi-usa.com>
	<1208443057.9212.250.camel@pmac.infradead.org>
	<48076A00.1080608@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48076A00.1080608@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 04:17:20PM +0100, Matt Sealey wrote:
>
> David Woodhouse wrote:
>> On Thu, 2008-04-17 at 13:28 +0100, Matt Sealey wrote:
>>> I thought we were using efika.forth for this in Fedora.
>>
>> We were, until you pointed out that the kernel actually works just fine
>> these days without it.
>
> I said the kernel has had braindead patches shoved into it that sort of
> obviate the need for the most heinous of crimes committed in the Efika
> device tree.
>
> The Linux kernel fixups don't add the CDM or XLB arbiter or many other
> components some out-of-mainline drivers will need (and should be able
> to just access without writing a fixup first) to map to work properly.
> Adding these will clean up things like the UART module, Sylvain's sleep
> patches will work on Efika, etc.
>
>> can't set environment variables from within Linux (and yes, we can
>> probably improve on that too, but we let them setenv for themselves, for
>> now).
>
> You really won't be improving on it because there's no reliable way to
> pass setenv back to the firmware from userland :D
>
>> That might be a little cleaner than what we have at the moment, yes. But
>> what we have also works, so I'd rather concentrate on things like
>> getting audio support merged, before we faff around with what are
>> essentially cosmetics.
>
> My ideal situation is all this stuff is stripped from the kernel. You do
> realise 90% of the Efika traffic on this list is submitting code that
> fixes fixups for a firmware which has a seperated fixup script, putting
> the responsibility firmly where Linux-PPC policy dictated it should be
> (with the firmware).

That's not Linux-PPC policy as far as I'm concerned.  It's nice if
firmware provides a more-or-less accurate device tree, but we're not
naive enough to think that's actually going to happen.  Firmware
always is, and always will be, crap, so it's expected that the kernel
will have to workaround device tree inaccuracies in the firmware.

Sometimes the simplest way of doing that is just to have workarounds
in the drivers.  Other times, doing that would be ugly and invasive,
so instead the bootwrapper should fixup the device tree before passing
it on to the kernel - this is one of the purposes of the bootwrapper.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
