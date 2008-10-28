Return-Path: <dgibson@ozlabs.org>
Date: Tue, 28 Oct 2008 11:34:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081028003452.GE26424@yookeroo.seuss>
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<49024646.3050300@genesi-usa.com> <49025DE0.6070403@firmworks.com>
	<4904DD76.7070706@genesi-usa.com>
	<20081026235303.GE22339@yookeroo.seuss>
	<4905E857.6040206@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4905E857.6040206@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2008 at 11:12:07AM -0500, Matt Sealey wrote:
>
>
> David Gibson wrote:
>> On Sun, Oct 26, 2008 at 04:13:26PM -0500, Matt Sealey wrote:
>>>
>>> Mitch Bradley wrote:
>>
>> device_type in 1275 defines the runtime method interface.  It's *not*
>> for declaring the general class of the device, although it often
>> matches that in practice.
>
> It *is* for declaring the general class of the device, even if it's
> purpose is to make it known that it implements all the required
> methods and therefore acts in a certain predefined way when those
> methods are used; it's not a necessary property but it is a USEFUL
> property:

No, it's really not.  There are only two ways device class information
can be useful:
	- for human readability.  For this purpose the node name with
the generic names convention suffices.
	- for manipulating the device without having a driver specific
to the device.  This works *only* if there is a class-defined protocol
for doing this manipulation.  Clearly, this can't exist unless the
firmware provides some sort of runtime service to abstract away
differences between devices.  Flat trees cannot of themselves provide
such a thing, and so should not advertise that they can with
device_type.

Even if a firmware did provide run time services, but they weren't in
the form of the OF defined method interface, they should not use
device_type, but some other property to advertise their own particular
brand of runtime service interface.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
