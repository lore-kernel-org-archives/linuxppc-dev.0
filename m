Return-Path: <pku.leo@gmail.com>
Message-ID: <2a27d3730901061951g333d10b6mf4dc0219570e521b@mail.gmail.com>
Date: Wed, 7 Jan 2009 11:51:12 +0800
From: "Li Yang" <leoli@freescale.com>
Sender: pku.leo@gmail.com
To: "Li Yang" <LeoLi@freescale.com>,
	"Wood Scott-B07421" <scottwood@freescale.com>,
	linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
Subject: Re: The usage of compatible 'simple-bus'
In-Reply-To: <20090107020006.GD13731@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20090106014323.GB29456@yookeroo.seuss>
	<3A45394FD742FA419B760BB8D398F9ED0B38C9@zch01exm26.fsl.freescale.net>
	<20090107020006.GD13731@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 10:00 AM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Tue, Jan 06, 2009 at 01:46:21PM +0800, Li Yang wrote:
>> > -----Original Message-----
>> > From:
>> > devicetree-discuss-bounces+leoli=freescale.com@ozlabs.org
>> > [mailto:devicetree-discuss-bounces+leoli=freescale.com@ozlabs.
>> > org] On Behalf Of David Gibson
>> > Sent: Tuesday, January 06, 2009 9:43 AM
>> > To: Wood Scott-B07421
>> > Cc: linuxppc-dev@ozlabs.org; Li Yang-R58472;
>> > devicetree-discuss@ozlabs.org
>> > Subject: Re: The usage of compatible 'simple-bus'
>> >
>> > On Mon, Jan 05, 2009 at 01:20:53PM -0600, Scott Wood wrote:
>> > > On Mon, Jan 05, 2009 at 06:27:39PM +0800, Li Yang wrote:
>> > > > I got an assumption from the existing device trees that having
>> > > > 'simple-bus' in the compatible property of a node means that all
>> > > > child nodes should be added as of_platform_device in platform
>> > > > initialization phase.  No matter it represents a bus in
>> > common sense
>> > > > or not.  Is this truly the case?
>> > >
>> > > Yes, simple-bus indicates that the children can be driven
>> > standalone
>> > > from any knowledge of the parent bus.
>> >
>> > Erm, well, sort of.  Strictly it indicates that the only way
>> > to locate the child devices of this bus is by using the
>> > address information in the device tree - there's no way to
>> > dynamically probe the bus.
>>
>> So if I understand correctly, "simple-bus" is intended to be used for
>> true buses.
>
> Generally, yes, although there may be some situations where it's
> appropriate for other things.  So, for example, in some cases it's
> used (correctly) for compound devices .  I don't think this particular
> case is a sensible situation for it, though.
>
>> > The fact that this causes of_platform_devices to be
>> > instantiated is a Linux implementation specific detail (and
>> > one we might change in future).
>>
>> Here we have a common case for SoC that part of a device has its
>> separate driver besides the driver for the main feature of the whole
>> device.  The resources used by the sub-device is usually part of the
>> resources of the parent device.  So it makes sense to put the node of
>> sub-device beneathe the node of main device.  Shall we have a convention
>> to mark such devices in device tree so that the sub-device can be
>> scanned and probed as a standalone of_platform_device?
>>
>> If "simple-bus" may cause confusion to do this job as it's not a bus
>> actually, I propose to use "has-subdevice".
>
> As Grant says, you're thinking about what drivers will do with things
> rather than what the actual hardware setup is, which is what the
> device tree should describe.
>
> I see two sensible options for this situation:
>        - Move the MDIO node to outside the gianfar MAC node.  I think
> this is already done on some boards with gianfar?

Yes, we can use good old way.  But as Scott has moved the MDIO into
the gianfar node on MPC8313, maybe it's a better way to describe the
relationship of the two parts.

>        - Explicitly add the gianfar device to the list of things to
> scan for of_platform subdevices.

I'm not against this solution.  However, the situation is kind of
common for SoC.  So I was just wondering if we can get to a new
convention in device tree than maintain a list in the code.  It will
be easier to figure the situation out by just reading the dts than
combining with the code.

- Leo
