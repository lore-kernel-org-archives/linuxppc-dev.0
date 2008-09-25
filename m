Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809241940p340beaa8xb9633707edbc1d8e@mail.gmail.com>
Date: Wed, 24 Sep 2008 22:40:31 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: USB support on mpc5200 broken
In-Reply-To: <1222307447.8277.147.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2008 at 9:50 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2008-09-24 at 21:09 -0400, Jon Smirl wrote:
>> On Wed, Sep 24, 2008 at 5:51 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> > USB is not working my hardware, so I booted my Efika and it's not
>> > working there either.  This is with linus' current git.
>> >
>> > Can anyone verify this? Or know what happened to USB?
>> > USB is loading but it is not finding anything plugged in.
>> > lsusb doesn't show anything.
>> >
>> > Last time I noticed it was working was about ten days ago. I don't use
>> > it everyday.
>>
>> Efika is broken because of this:
>>
>> ohci-ppc-of.c...
>>       is_bigendian =
>>               of_device_is_compatible(dn, "ohci-bigendian") ||
>>               of_device_is_compatible(dn, "ohci-be");
>>
>> Efika doesn't have either of those in it's compatible string.
>>
>> This doesn't look to me like a very reliable way to determine bigendian.
>
> You mean it's not reliable to expect people device-trees not to
> suck ? :-)

No, because the ochi driver has been changed to require
"fsl,mpc5200b-ohci" or "fsl,mpc5200-ohci" and generic "ohci-be"
doesn't work anymore.  You need CONFIG_USB_OHCI_HCD_PPC_SOC now for
mpc5200 usb to work.

-- 
Jon Smirl
jonsmirl@gmail.com
