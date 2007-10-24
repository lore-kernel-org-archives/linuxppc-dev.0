Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710241013w41e8919cn893fa305bb538e52@mail.gmail.com>
Date: Wed, 24 Oct 2007 11:13:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <9e4733910710241001g165e7aeatdc92096544fbeb60@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
	<fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>
	<9e4733910710241001g165e7aeatdc92096544fbeb60@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 10/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > Heh, I'm one of the folks who objected to it; here's what was written:
> >
> > > > >
> > > > > pseudo-sound@0 { // use to trigger loading platform specific fabric driver
> > > > >       device_type = "pseudo-sound"
> > > > > };
> > > >
> > > > I don't think this is a good idea.  The device tree is for describing
> > > > your hardware; so the layout should reflect that.  Make the platform
> > > > code do the right thing with the real nodes.
> >
> > What I objected to was that the pseudo-sound node didn't contain any
> > real information.  It was just being a hook to trigger calling a probe
> > function.  If you're going to do that then you might as well just call
> > it directly from platform code.
>
> Calling it directly from the platform code is an option, but where
> does the fabric driver code live? It doesn't make a lot of sense to
> put ALSA code into arch/powerpc/platforms/52xx. I could make a
> function call from arch/powerpc/platforms/52xx over to
> sound/soc/powerpc but that's not very pretty.
>
> Another option is to make the fabric driver a "struct platform_driver"
> instead of a "struct of_platform_driver". "struct platform_driver" is
> not being probed in the current mpc5200 code. This option makes senses
> to me, "struct platform_driver" will load without a device tree node.
> The driver will still need to check and see if it is on the right
> platform when more than one is compiled in.

Yes, this is a good approach.

> > It would be possible and reasonable for a single fabric driver to work
> > with many different circuit layouts as long as it has the information
> > needed to adapt each instance.
>
> That is how the Apple driver is implemented. There is a single fabric
> driver that uses layout-id to set everything up to match the physical
> PCB.
> sound/aoa/fabrics/snd-aoa-fabric-layout.c
>
> But Apple put the layout id down inside the a sound node:
> /proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000/sound:
> name             "sound"
> device_type      "soundchip"
> compatible       "AOAbase"
> built-in
> layout-id        00000046 (70)
> object-model-version 00000002
> vendor-id        0000106b (4203)
> platform-tas-codec-ref ff98cba8
> linux,phandle    ff985d48

Yes, this is the same idea.  I don't think benh and segher were
particularly fond of it though.  I think Segher in particular had a
preference for the platform code probing approach.

> > Now is probably a good time to mention that there is *nothing* in the
> > device tree that enforces a 1:1 relationship between device tree nodes
> > and driver instances.  Sure, it make sense to register the i2s and
> > codec drivers from probing on the i2s and codec nodes.  However, there
> > is nothing that prevents the codec driver from *also* registering a
> > fabric driver based on a property in the codec node or the board-level
> > compatible property.
>
> But there is something in the kernel that enforces it. I haven't
> checked the powerpc code, but the PCI code won't probe anymore drivers
> once one has attached to a device. The rule of one driver per device
> is a good one. Places where that rule has been broken have caused a
> lot of problems (fbdev vs DRM).

heh; there's isn't a 1:1 relationship between device tree nodes and
device objects either.  You create the device objects that you need;
either on the platform bus or the of_platform bus.

The probe of an of_platform device can trigger the creation of a
plaform_device node for *another* driver.  This approach is safe.

>
> > Fabric drivers are codec specific anyway.  It's not all that
> > unrealistic for the device tree binding for a codec to have a list of
> > fabric drivers that it can register.
>
> The codec drivers in asoc are completely agnostic. The same codec
> driver works on x86, arm, powerpc, etc.

Yes the *driver* is agnostic; but the *binding* doesn't have to be.  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
