Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <fa686aa40710222057y58202c8ev4610e045e5e389df@mail.gmail.com>
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<fa686aa40710222057y58202c8ev4610e045e5e389df@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <07657acdf391ff46e339c75d6036bb25@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Audio codec device tree entries
Date: Tue, 23 Oct 2007 10:06:01 +0200
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Isn't this the ac97 bus node?  Can't the ac97 codecs simply be
> children of this bus?

They should be, yes.

>> pseudo-sound@0 { // use to trigger loading platform specific fabric 
>> driver
>>       device_type = "pseudo-sound"
>> };
>
> I don't think this is a good idea.  The device tree is for describing
> your hardware; so the layout should reflect that.  Make the platform
> code do the right thing with the real nodes.

There _can_ be good reasons for using a "pseudo-device" node,
but I don't see any such reasons here.  The main reason for
doing a "pseudo" is if there is some hardware you need to
describe, but it doesn't fit anywhere in the device tree; one
example is certain weird interrupt routings.

> I think this is what you want:
>
> ac97@2000 {           // PSC1
>       compatible = "fsl,mpc5200b-psc-ac97","fsl,mpc5200-psc-ac97";
>

>       // The following codec stuff could be a little off; It has been
> a while since I've looked
>       // at ac97 codec interfacing, but if I remember correctly you
> can have multiple
>       // codecs on an ac97 bus; an audio codec and a modem codec.  The 
> following
>       // reflects that understanding...

You can have more than two, and then there is the weird stuff where
"hd" codecs have more than one address.  But this all can be neatly
described with "reg", so no problem.

>       ac97-codec@0 {

"sound@0", says the generic naming doc.

>       ac97-codec@1 {
>             // This could be the modem codec

So "modem@1".

> i2s@2000 {           // PSC1

>       codec-handle = <&codec0 &codec2>;

I would really do it the other way around: have the codec node point
to the I2S bus.

>       codec0: i2s-codec@0 {

>       codec1: i2s-codec@1 {

>       codec2: i2s-codec@2 {

0, 1, 2 aren't valid I2C addresses.  But this was only an example ;-)

> So, this scheme describes the hardware, but it does not describe 2 of
> your questions:
>
> 1. How does the device tree describe the myriad of possible circuits
> that an audio codec can get dropped into, and
> 2. How do the drivers get probed
>
> For question #1, I think the answer is simple... it doesn't try.  :-)
>
> As was described in the previous thread, trying to describe the
> circuit is very complex and figuring out what software would do with
> such a description is even worse.  Instead, I propose the following:
> - as much as possible, make the board firmware and the platform setup
> code configure the GPIOs, port_config, and other 'fixed' configuration

Certainly agreed.

> - make the driver code look at either the board model/compatible
> properties or add a board-unique value to the codec's compatible list.

Make the _platform_ code look at the board version properties, and have
_it_ instantiate the correct fabric driver, with the correct 
configuration
for it.  Some of that configuration could be probed from the device tree
("codec gpio pin 0 is used as a level-low headphone detect switch") but
I wouldn't go over the top with it, there are just way way too many
different ways all of this is put together.

>  Either way the driver can apply board specific tweaks to its
> behavious.  (I think the better solution is to add a value to the
> front of the codec's compatible list because the same circuit can be
> used on a different board and it can then claim compatibility with the
> older board for just that part of the circuit).

The "fabric" stuff isn't really a codec property, but a board-global
property.  So that's how this should be described in the device tree
as well: board-global.

> As for question #2, I think you make the i2s driver probe on the i2s
> bus node and the ac97 driver probe on the ac97 bus node.  In both
> cases, the driver can find the link to the codec; determine what kind
> of system it is running on, and instantiate the appropriate ASoC
> fabric driver.

In the i2s case, if the i2s driver has to know about the codecs at all,
it should get references to the codecs passed in by the platform driver.

Same goes for the fabric driver.

Or, that's the only sane way of doing things I can imagine, anyway :-)


Segher
