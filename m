Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 948CCDDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 03:12:05 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1639745qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 09:12:04 -0700 (PDT)
Message-ID: <4905E857.6040206@genesi-usa.com>
Date: Mon, 27 Oct 2008 11:12:07 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>, Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<49024646.3050300@genesi-usa.com> <49025DE0.6070403@firmworks.com>
	<4904DD76.7070706@genesi-usa.com>
	<20081026235303.GE22339@yookeroo.seuss>
In-Reply-To: <20081026235303.GE22339@yookeroo.seuss>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



David Gibson wrote:
> On Sun, Oct 26, 2008 at 04:13:26PM -0500, Matt Sealey wrote:
>>
>> Mitch Bradley wrote:
> 
> device_type in 1275 defines the runtime method interface.  It's *not*
> for declaring the general class of the device, although it often
> matches that in practice.

It *is* for declaring the general class of the device, even if it's
purpose is to make it known that it implements all the required
methods and therefore acts in a certain predefined way when those
methods are used; it's not a necessary property but it is a USEFUL
property:

~~
It is not necessary for every node to have a “device_type” property. If a
particular device is not useful for any Open Firmware function (e.g., booting,
console, probing) then it need not have a device type. For example, Open
Firmware has no use for a FAX modem, so such a device does not need a device
type. However, there is no restriction preventing it from having a device type
so long as its device type is not the same as one of the standard types
(i.e., a device should not claim to be something that it is not).
~~

I'm all for it being legacy and optional but marking ethernet ports as
network, and serial ports as serial, is a wonderfully good idea especially
if they were used in ANY firmware environment to bring up the console,
drag in the boot files, or provide a framebuffer display.

It's quite possible that a generic framebuffer driver be written that
only needs to know that it is a "display", read a property to find out
where the memory starts, and gain some rudimentary information about
the dimensions. Oh, wait, it already exists, it's offb.c (if you strip
out the ATI hacks, it'll work on *a n y* framebuffer that is defined
as such, and needn't have any specific compatible to do it)

> Drivers which attempt to use it this way are buggy.

I'm more concerned about code that lives specifically outside of the
driver itself - examples;

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg11772.html
http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg11773.html

When you're about to take control of the system and do your board
setup, it is usually a great idea to use what the firmware was
using, you do not want to go through and find out that you were
using a serial console but Linux has inited a display and expects
a keyboard on a framebuffer console, because that is what "most
people get" when they boot Linux.

(I will concede that using "serial" as the VGA textmode console
is, while a semi-accurate abstraction of an ANSI-capable terminal
with no framebuffer, is kind of braindead when it comes to giving
the OS accurate information about which devices are in use)

> matches the stated device_type.  However, flattened trees clearly
> can't provide the method interface, and so shouldn't declare the
> device_type.

Even if they are used in the firmware environment for console, booting
or probing? :D

> In practice, we do suggest including device_type in certain, limited,
> circumstances precisely because there are a whole bunch of buggy
> drivers out there which match (at least partly) on device_type.
 > We don't want to break these gratuitously,

Oh that's rich. If you were that concerned you'd rip the device_type
out and fix all the drivers in a huge patch, like everyone else does
when they change the ABI.

> driver matching.  Hence the current policy.

I might say that the policy on device trees has changed by the month
for the last 2 years and ePAPR didn't fix down a single concern that
wasn't already documented in the original IEEE 1275 specification.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
