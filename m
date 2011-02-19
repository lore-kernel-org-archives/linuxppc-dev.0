Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CBF27B7122
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Feb 2011 19:53:00 +1100 (EST)
Date: Sat, 19 Feb 2011 09:52:53 +0100
From: Anatolij Gustschin <agust@denx.de>
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: fsl_udc_core not initializing properly?
Message-ID: <20110219095253.39540a57@wker>
In-Reply-To: <AANLkTikaH6=8JgX6wfqLu0fCFBO0A1hHDTpw7Xb64uKS@mail.gmail.com>
References: <AANLkTikaH6=8JgX6wfqLu0fCFBO0A1hHDTpw7Xb64uKS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, 18 Feb 2011 17:03:12 -0500
"Matthew L. Creech" <mlcreech@gmail.com> wrote:
...
> I'm upgrading from 2.6.36 to 2.6.37 on a MPC8313 ERDB-like board.  On
> the new kernel, it seems like the USB gadget driver (fsl_usb2_udc) is
> never initialized, so USB no longer works.
> 
> Adding some printks to the code shows that udc_init() is being run,
> which calls platform_driver_probe().  However, fsl_udc_probe() is
> never actually called afterward.  As a result, 'udc_controller' is
> left NULL, and the subsequent call to usb_gadget_probe_driver()
> returns -ENODEV.

Look at the USB node in the device tree for your board. Does it
contain the "dr_mode" property? For USB gadget the value of this
property should be "peripheral".
The device tree for MPC8313 ERDB in mainline tree doesn't specify
this property, so the host mode is the default operation mode here.
Therefore the platform device "fsl-usb2-udc" won't be created
while booting and since there is no appropriate platform device,
the probing is not done. This might be the case on your board,
too. Try with dr_mode = "peripheral"; in the usb node in your
device tree.

Anatolij
