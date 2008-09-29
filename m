Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
Date: Mon, 29 Sep 2008 10:14:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>, linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	"David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: USB support on mpc5200 broken
In-Reply-To: <20080929034329.GB8694@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop> <48E02FD0.8000809@genesi-usa.com>
	<20080929034329.GB8694@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 28, 2008 at 11:43 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Sun, Sep 28, 2008 at 08:30:56PM -0500, Matt Sealey wrote:
>>
>> Benjamin Herrenschmidt wrote:
>>> On Wed, 2008-09-24 at 21:09 -0400, Jon Smirl wrote:
>>>>> Last time I noticed it was working was about ten days ago. I don't use
>>>>> it everyday.
>>>> Efika is broken because of this:
>>>>
>>>> ohci-ppc-of.c...
>>>>     is_bigendian =
>>>>             of_device_is_compatible(dn, "ohci-bigendian") ||
>>>>             of_device_is_compatible(dn, "ohci-be");
>>>>
>>>> Efika doesn't have either of those in it's compatible string.
>>>>
>>>> This doesn't look to me like a very reliable way to determine bigendian.
>>>
>>> You mean it's not reliable to expect people device-trees not to
>>> suck ? :-)
>
> Alas, this is true :(.


Efika has this:
compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci";

That completely describes the hardware. Isn't that what a device tree
is supposed to do?

If we really need a big endian flag, should it be an attribute?

		usb@1000 {
			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci";
			ohci-be;
			reg = <0x1000 0xff>;
			interrupts = <0x2 0x6 0x0>;
			interrupt-parent = <&mpc5200_pic>;
		};

Shouldn't the driver already know it is being used on a BE machine?


>
>> It's reasonable to expect that device-trees do not get updated with the
>> kernel for certain platforms (it does not fit into most quality assurance
>> schedules to reflash every user's firmware every time they want to move up
>> one revision to another, given the kernel release schedule of every 3-4
>> months) and when updating the search for compatible entries it should
>> take into account these platforms.
>
> This, of course, is exactly why I *don't* recommend embedded platforms
> move to including the device tree in the flashed firmware.  Keeping
> the device tree in the bootwrapper means that it *is* updated with the
> kernel and we don't have to mess around with as much backwards
> compatibility junk.

How do I adjust my build to put the DTB into a wrapper? I'm based on
the pcm030 makefile and it assumes the DTB is built externally.

Can u-boot handle the wrapped DTB? I'm using a pointer to kernel and
one to DTB when booting from u-boot.

-- 
Jon Smirl
jonsmirl@gmail.com
