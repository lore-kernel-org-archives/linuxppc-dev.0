Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 00BF5B7D60
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 05:18:04 +1000 (EST)
Date: Thu, 6 May 2010 21:18:00 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] powerpc/fsl_soc.c: prepare for addition of mpc5121
	USB code
Message-ID: <20100506211800.335baf63@wker>
In-Reply-To: <u2gfa686aa41004270951o9a225091k1f68a7bf34f2972a@mail.gmail.com>
References: <1272384698-4359-1-git-send-email-agust@denx.de>
	<1272384698-4359-2-git-send-email-agust@denx.de>
	<u2gfa686aa41004270951o9a225091k1f68a7bf34f2972a@mail.gmail.com>
Mime-Version: 1.0
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

Hi Grant,

On Tue, 27 Apr 2010 10:51:21 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Tue, Apr 27, 2010 at 10:11 AM, Anatolij Gustschin <agust@denx.de> wrot=
e:
> > Factor out common code for registering a FSL EHCI platform
> > device into new fsl_usb2_register_device() function. This
> > is done to avoid code duplication while adding code for
> > instantiating of MPC5121 dual role USB platform devices.
> > Then, the subsequent patch can use
> > for_each_compatible_node(np, NULL, "fsl,mpc5121-usb2-dr") {
> > =A0 =A0 =A0 =A0...
> > =A0 =A0 =A0 =A0fsl_usb2_register_device();
> > }
> >
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > Cc: Kumar Gala <galak@kernel.crashing.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > =A0arch/powerpc/sysdev/fsl_soc.c | =A0231 +++++++++++++++++++----------=
-----------
>=20
> Hi Anatolij,
>=20
> Thanks for this work.  However, I've got concerns.
>=20
> Forgive me for ragging on code that you didn't write, but this
> fsl_soc.c code for registering the USB device really doesn't belong
> here anymore.  It should be part of the drivers/usb/host/ehci-fsl.c
> and the driver should do of-style binding (Which should be a lot
> easier if I manage to get the merge of platform bus and of_platform
> bus into 2.6.35).

Now I moved the USB devices registration code to
drivers/usb/host/ehci-fsl.c and added of-style binding there. It
works for one platform driver based on your test-devicetree branch.
It seems I can't bind more than one driver to the device described
in the tree. But I need to bind at least 2 drivers, ehci-hcd and
fsl-usb2-udc. For USB OTG support I need additional one to be bound
to the same USB dual role device (also tree different drivers
simultaneously).
I also can't register UDC device in the ehci-fsl.c since registering
of the UDC device should also be possible independent of the EHCI-HDC
driver (for USB device support we do not need host controller driver).
Is it possible to bind more than one driver to the same device
simultaneously? If so, how can I implement this?

> This patch series makes the fsl_soc.c code even more complicated, and
> scatters what is essentially driver code over even more places in the
> arch/powerpc tree.  I'm really not keen on it being merged in this
> form.

Now I see one reason why it has been originally implemented
this way.

Thanks,
Anatolij
