Return-Path: <pku.leo@gmail.com>
Message-ID: <2a27d3730901052301m797c6c9evfde1b3db75835e2f@mail.gmail.com>
Date: Tue, 6 Jan 2009 15:01:24 +0800
From: "Li Yang" <leoli@freescale.com>
Sender: pku.leo@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: The usage of compatible 'simple-bus'
In-Reply-To: <fa686aa40901052235t1342b6e2w4fde664f1ebb3aa3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <3A45394FD742FA419B760BB8D398F9ED0B37E7@zch01exm26.fsl.freescale.net>
	<20090105192053.GB23766@ld0162-tx32.am.freescale.net>
	<20090106014323.GB29456@yookeroo.seuss>
	<3A45394FD742FA419B760BB8D398F9ED0B38C9@zch01exm26.fsl.freescale.net>
	<fa686aa40901052235t1342b6e2w4fde664f1ebb3aa3@mail.gmail.com>
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 6, 2009 at 2:35 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jan 5, 2009 at 10:46 PM, Li Yang <LeoLi@freescale.com> wrote:
>>> -----Original Message-----
>>> From:
>>> devicetree-discuss-bounces+leoli=freescale.com@ozlabs.org
>>> [mailto:devicetree-discuss-bounces+leoli=freescale.com@ozlabs.
>>> org] On Behalf Of David Gibson
>>> Sent: Tuesday, January 06, 2009 9:43 AM
>>> To: Wood Scott-B07421
>>> Cc: linuxppc-dev@ozlabs.org; Li Yang-R58472;
>>> devicetree-discuss@ozlabs.org
>>> Subject: Re: The usage of compatible 'simple-bus'
>>>
>>> On Mon, Jan 05, 2009 at 01:20:53PM -0600, Scott Wood wrote:
>>> > On Mon, Jan 05, 2009 at 06:27:39PM +0800, Li Yang wrote:
>>> > > I got an assumption from the existing device trees that having
>>> > > 'simple-bus' in the compatible property of a node means that all
>>> > > child nodes should be added as of_platform_device in platform
>>> > > initialization phase.  No matter it represents a bus in
>>> common sense
>>> > > or not.  Is this truly the case?
>>> >
>>> > Yes, simple-bus indicates that the children can be driven
>>> standalone
>>> > from any knowledge of the parent bus.
>>>
>>> Erm, well, sort of.  Strictly it indicates that the only way
>>> to locate the child devices of this bus is by using the
>>> address information in the device tree - there's no way to
>>> dynamically probe the bus.
>>
>> So if I understand correctly, "simple-bus" is intended to be used for
>> true buses.
>>
>>>
>>> The fact that this causes of_platform_devices to be
>>> instantiated is a Linux implementation specific detail (and
>>> one we might change in future).
>>
>> Here we have a common case for SoC that part of a device has its
>> separate driver besides the driver for the main feature of the whole
>> device.  The resources used by the sub-device is usually part of the
>> resources of the parent device.  So it makes sense to put the node of
>> sub-device beneathe the node of main device.
>
> First, repeat the following to yourself 10 times: "The device tree
> describes the hardware; not the way Linux uses it".
>
> Avoid thinking about how the of_platform bus works for a minute and
> ask yourself this question.  If you're talking about several devices
> which share the same set of resources; then are they really separate
> devices, or is it a single device with more than one channel or slice?

For off-chip devices you can easily separate devices by it's physical
appearance, different chips or cards are explicitly separate devices.
But for on-chip devices one can easily get two different answers if
they are looked in different ways.  The example at hand is TSEC
Ethernet controller and the MDIO part of it.  Logically it is one
controller and MDIO is one of its functions.  But they work rather
independently and can be regarded as different controllers.

- Leo
