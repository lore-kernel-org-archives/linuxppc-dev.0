Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711181547h2910bb72o1fb7b7ad434a8cf3@mail.gmail.com>
Date: Sun, 18 Nov 2007 18:47:09 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <4740CB41.8030101@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/18/07, Matt Sealey <matt@genesi-usa.com> wrote:
> I'd suggest something like this:
>
> sound@0 {
>         \\ this is our magic audio fabric
>         device_type = "digispeaker,flinger";
>
>         \\ it's actually just an i2s pcm codec
>         compatible = "mpc5200-psc-i2s";
>
>         \\ and this defines the layout Jon picked for the DACs
>         \\ just like Apple's layout-id value
>         model = "flinger,2"
>
>         codec@15 {
>                 compatible = "TXN,tas5504";
>                 codec-control = <&codec-control>;
>         }
>
>         \\ and every i2s driver on the planet will just ignore these
>         \\ unless it's one of our boards
>         digispeaker,amp-control = <&amp-control>
> }


This forces a single fabric driver for audio buses that can support
more than one device (like ac97). I can live with that, but is it ok
for the design?


> Then you control the fabric for your boards and get to attach
> whatever the hell you want to those codecs, control interfaces
> and special little tweak features you always wanted.
>
> Be careful cross-referencing devices with each other,
> for instance in your example you made the i2c codec device
> point back to an i2s handle - it's a good idea, but not well
> executed in my opinion as it lacks context.
>
> Isn't the primary concern of an audio codec, to play audio?
>
> Therefore, shouldn't the audio codec point back to it's control
> interface? Also, why give the name as 'i2s-handle'? Surely it
> could be any interface. In reverse, it would be, perhaps, as
> above, i2c-handle, but then what if you change the interface
> type (for instance a bunch of Wolfson codecs can do i2c and
> spi for control). Your property name is obselete, then and
> drivers will need to switch on property names to find out
> which control interface is present.

Others have pointed out that device trees are organized by control
interface. So the codec node should be under i2c and back point to
their data stream. We could use something like codec-data instead of
i2s-handle.

I don't have a strong opinion on how to organize this stuff. I just
need some way to get the ASOC fabric drivers loaded. Actually ASOC
calls them 'machine' drivers, it is Apple's audio code that call them
fabric drivers.


>
> What they should really do, is be told where their control
> interface handle is, then you can look at that handle and
> the device it contains - that device itself will tell you the
> bus type, any devices under it, and any quirky things you
> need to do besides (above, &codec-control etc. would point to
>
> i2c@3d40 {
>         codec-control@15 {
>                 blah
>         }
> }
>
> spi@beef {
>         codec-control@19 {
>                 blah
>         }
> }
>
> gpio@cafe {
>         amp-control@0 {
>                 compatible = "gpio-bit";
>                 bit = "1";
>                 open-drain;
>         }
> }
>
> If you couldn't tell it's a device on an i2c bus then you
> are coding your driver badly. And you can have lots of
> codecs, and just back reference which control interface
> they have. I dunno.
>
> Remember, it doesn't matter what NAME you give it, the name
> is for people to read, device_type is what you search for,
> and phandles let you attach specific devices to each other.
> compatible is for when you want to tell people "it acts the
> same as this" and model is to give you the enviable ability
> to define PRECISELY what you are looking at beyond a chip
> name. I'd suggest we use all of them for great justice.
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
>


-- 
Jon Smirl
jonsmirl@gmail.com
