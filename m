Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 4254ADDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 09:03:51 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so574313qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 15:03:50 -0700 (PDT)
Message-ID: <49024646.3050300@genesi-usa.com>
Date: Fri, 24 Oct 2008 17:03:50 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
In-Reply-To: <49011C42.2020101@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Mitch Bradley wrote:

>>         gpio_pin@2 {
> 
> The name here should reflect the purpose of the pin, i.e. what it does 
> (perhaps "NAME,magic"), not the fact that is is GPIO pin.  By analogy, 
> an ethernet controller's node name is "ethernet", not "pci-card".  The 
> fact that the node represents one or more gpio pins is implicit and 
> obvious - all children of a gpio-controller node are gpio pin(s).  All 
> children of a scsi node are SCSI devices, ad nauseum.

Right. I had a similar discussion about this the other day with Anton (I
think he forwarded it here but I wasn't subscribed at that point..). The
current ideology for device trees is to get rid of device_type for new
trees that aren't OF-based. I think it's relevant to give nodes fancy
names (i.e. not "timer" or even "ethernet") since the name property is
entirely descriptive in nature. I also think it's relevant that device_type
still exists because since the name is totally irrelevant except from a
user-friendliness point of view, marking a device as a generic type is
quite important (device_type = serial, ethernet, rtc, keyboard) where
compatible properties are usually wildly over-specific.

This reminded me of a discussion I had a long time back that encoding
the manufacturer and chip name into EVERY child node was bordering on
the insane (and if the dt wasn't compressed in the first place, wasting
space) - if you have /soc/usb and they have compatible="fsl,mpc5200b"
and "fsl,mpc5200b-usb-ohci" respectively, isn't that encoding redundant
information? Someone I think proposed assigning a couple of quirk
properties to notify drivers that fsl,mpc5200b-usb-ohci did things
differently because of the chip revision, and I was shot down when I
asked if the driver could just check it's parent node instead.

Apparently current ideology there is to have every node self-contained
(however the current practise in the Linux kernel, for example with
some PCI quirks, is to search for the parent PCI southbridge and check
off some values or disable features there, which I don't think is that
much different..)

Anyway back to the actual discussion, yes, I should have given it a
much fancier name than "gpio_pin" but at the time I wasn't thinking of
any particular use and didn't want to confuse by giving it a fancy
name like "sleep-controller-wakeup-pin".

> It has been my experience that full explicit descriptions are usually a 
> win in the long run.  (Which is not to say that I've always done the 
> right thing, but when I have it has often been worthwhile.)

In my view, having an overly descriptive and unwieldy device tree is
only bad when you type "ls" on the forth prompt and it scrolls off
the screen 8 times. At the driver level

One thing I had a crazy dream about was a GUI-based device tree builder
for platforms. Instead of editing them manually and passing them
through the compiler, wouldn't it be fun to drag and drop system
components (and build new ones) into something like a DirectX Filter
Graph Builder (or the GStreamer one for that matter) or those GUI
SQL database builders, so that you could build a tree and have it
output all the craziness and connect phandles to range properties
etc.

That way dropping a bunch of pins on a GPIO bank, or i2c devices
on an i2c bus (I have a board here with an i2c bus with 8 devices
on it, I suppose you could have more than 100 if you got your
addresses right) and having a device tree that goes on for 8
screens would not be so bad to maintain.

And no, I did NOT just volunteer to write one, I'm happy coding my
device tree updates in Forth :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
