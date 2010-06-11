Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195]) by ozlabs.org (Postfix) with ESMTP id 7067E1007D3
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 01:47:57 +1000 (EST)
Received: by ywh33 with SMTP id 33so981700ywh.11
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 08:47:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100611132443.567daf79@wker>
References: <1272384698-4359-1-git-send-email-agust@denx.de>
	<1272384698-4359-2-git-send-email-agust@denx.de>
	<u2gfa686aa41004270951o9a225091k1f68a7bf34f2972a@mail.gmail.com>
	<20100506211800.335baf63@wker>
	<AANLkTim0TVjoVdLZE_QOSi-WPSoisdF7Gv0Y_YF-tajL@mail.gmail.com>
	<20100611132443.567daf79@wker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Jun 2010 09:47:35 -0600
Message-ID: <AANLkTimddptNp1BRrn6755YMgHph8mi1bUdePA-RlmYt@mail.gmail.com>
Subject: Re: [PATCH 1/4] powerpc/fsl_soc.c: prepare for addition of mpc5121
	USB code
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 11, 2010 at 5:24 AM, Anatolij Gustschin <agust@denx.de> wrote:
> On Wed, 19 May 2010 14:47:47 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Thu, May 6, 2010 at 1:18 PM, Anatolij Gustschin <agust@denx.de> wrote=
:
>> > Hi Grant,
>> >
>> > On Tue, 27 Apr 2010 10:51:21 -0600
>> > Grant Likely <grant.likely@secretlab.ca> wrote:
>> >
>> >> On Tue, Apr 27, 2010 at 10:11 AM, Anatolij Gustschin <agust@denx.de> =
wrote:
>> >> > Factor out common code for registering a FSL EHCI platform
>> >> > device into new fsl_usb2_register_device() function. This
>> >> > is done to avoid code duplication while adding code for
>> >> > instantiating of MPC5121 dual role USB platform devices.
>> >> > Then, the subsequent patch can use
>> >> > for_each_compatible_node(np, NULL, "fsl,mpc5121-usb2-dr") {
>> >> > =A0 =A0 =A0 =A0...
>> >> > =A0 =A0 =A0 =A0fsl_usb2_register_device();
>> >> > }
>> >> >
>> >> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> >> > Cc: Kumar Gala <galak@kernel.crashing.org>
>> >> > Cc: Grant Likely <grant.likely@secretlab.ca>
>> >> > ---
>> >> > =A0arch/powerpc/sysdev/fsl_soc.c | =A0231 +++++++++++++++++++------=
---------------
>> >>
>> >> Hi Anatolij,
>> >>
>> >> Thanks for this work. =A0However, I've got concerns.
>> >>
>> >> Forgive me for ragging on code that you didn't write, but this
>> >> fsl_soc.c code for registering the USB device really doesn't belong
>> >> here anymore. =A0It should be part of the drivers/usb/host/ehci-fsl.c
>> >> and the driver should do of-style binding (Which should be a lot
>> >> easier if I manage to get the merge of platform bus and of_platform
>> >> bus into 2.6.35).
>> >
>> > Now I moved the USB devices registration code to
>> > drivers/usb/host/ehci-fsl.c and added of-style binding there. It
>> > works for one platform driver based on your test-devicetree branch.
>> > It seems I can't bind more than one driver to the device described
>> > in the tree. But I need to bind at least 2 drivers, ehci-hcd and
>> > fsl-usb2-udc. For USB OTG support I need additional one to be bound
>> > to the same USB dual role device (also tree different drivers
>> > simultaneously).
>> > I also can't register UDC device in the ehci-fsl.c since registering
>> > of the UDC device should also be possible independent of the EHCI-HDC
>> > driver (for USB device support we do not need host controller driver).
>> > Is it possible to bind more than one driver to the same device
>> > simultaneously? If so, how can I implement this?
>>
>> No, the linux driver model can bind exactly one driver to a struct
>> device. =A0However, that doesn't mean you can't have multiple struct
>> devices (in whatever form they come) to tell the Linux kernel about
>> all the details of a single hardware device.
>>
>> >> This patch series makes the fsl_soc.c code even more complicated, and
>> >> scatters what is essentially driver code over even more places in the
>> >> arch/powerpc tree. =A0I'm really not keen on it being merged in this
>> >> form.
>> >
>> > Now I see one reason why it has been originally implemented
>> > this way.
>>
>> Should be a solvable problem. =A0The fsl_soc.c stuff was originally
>> written simply because the infrastructure wasn't there for doing it
>> any other way. =A0We're long past that point now. =A0I don't have time t=
o
>> dig into the details now (merge window and all), but ping me in a few
>> weeks and I'll take another look to see if I can help you.
>
> Hi Grant,
>
> Ping. Do you have any suggestions how to realize this using current
> infrastructure? Thanks!

It sounds like the USB OTG controller is effectively a compound device
with one host controller and one device controller plus some logic to
switch between the two.  I'm not a USB expert, so correct me if I'm
wrong here.

You've got 2 choices for implementing this:
A) create a 'master' of_driver which registers 2 platform devices it
it's probe routine.
B) Rework the drivers so that both fsl-ehci and fsl-usb2-udc bits are
called directly (essentially one driver handles both modes)

Option A probably makes the most sense as it has the least amount of
impact on current code.  Essentially, you create an of_driver and put
into it's probe hook the code that is currently in fsl_soc.c.  Then it
will bind in the normal of_platform_bus_type manner and can register
the appropriate platform devices for each platform.

Some important points though; when you create the platform devices,
make sure you set the parent pointer correctly so the new devices are
registered as children of the of_device.

Second, you can eliminate the call to platform_device_add_data() by
setting the of_node pointer in the platform device (the of_node is now
part of struct device).  Make the driver look up its own data from the
device tree instead of passing it in an anonymous data structure.

On that note, the current code looks racy anyway because it registers
the device before attaching the platform_data.  It's probably okay
because of how early it is run and no drivers are registered yet, but
it is still wrong.  It should be: allocate; add data; then register.
But I digress.  Eliminating the platform data makes this problem go
away.

I hope this helps.

g.
