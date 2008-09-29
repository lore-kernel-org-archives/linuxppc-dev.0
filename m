Return-Path: <dgibson@ozlabs.org>
Date: Mon, 29 Sep 2008 13:43:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: USB support on mpc5200 broken
Message-ID: <20080929034329.GB8694@yookeroo.seuss>
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop>
	<48E02FD0.8000809@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48E02FD0.8000809@genesi-usa.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 28, 2008 at 08:30:56PM -0500, Matt Sealey wrote:
>
> Benjamin Herrenschmidt wrote:
>> On Wed, 2008-09-24 at 21:09 -0400, Jon Smirl wrote:
>>>> Last time I noticed it was working was about ten days ago. I don't use
>>>> it everyday.
>>> Efika is broken because of this:
>>>
>>> ohci-ppc-of.c...
>>> 	is_bigendian =
>>> 		of_device_is_compatible(dn, "ohci-bigendian") ||
>>> 		of_device_is_compatible(dn, "ohci-be");
>>>
>>> Efika doesn't have either of those in it's compatible string.
>>>
>>> This doesn't look to me like a very reliable way to determine bigendian.
>>
>> You mean it's not reliable to expect people device-trees not to
>> suck ? :-)

Alas, this is true :(.

> It's reasonable to expect that device-trees do not get updated with the
> kernel for certain platforms (it does not fit into most quality assurance
> schedules to reflash every user's firmware every time they want to move up
> one revision to another, given the kernel release schedule of every 3-4
> months) and when updating the search for compatible entries it should
> take into account these platforms.

This, of course, is exactly why I *don't* recommend embedded platforms
move to including the device tree in the flashed firmware.  Keeping
the device tree in the bootwrapper means that it *is* updated with the
kernel and we don't have to mess around with as much backwards
compatibility junk.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
