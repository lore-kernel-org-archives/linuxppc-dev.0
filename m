Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
	[209.85.211.175]) by ozlabs.org (Postfix) with ESMTP id A6417B823E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 03:54:57 +1100 (EST)
Received: by ywh5 with SMTP id 5so12797969ywh.11
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 08:54:56 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1264594052-20317-6-git-send-email-agust@denx.de>
References: <1264594052-20317-1-git-send-email-agust@denx.de>
	<1264594052-20317-6-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 27 Jan 2010 09:54:36 -0700
Message-ID: <fa686aa41001270854m2e52a19eoa4361809231f53a@mail.gmail.com>
Subject: Re: [PATCH 5/8 v2] powerpc/mpc5121: add USB host support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Bruce Schmid <duck@freescale.com>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2010 at 5:07 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Platform specific code for MPC5121 USB Host support.
> MPC5121 Rev 2.0 silicon EHCI registers are big endian.
> Add appropriate support by specifying "fsl,big-endian-regs"
> property in device tree node for USB controller. Also
> allow specifying DRVVBUS and PWR_FAULT signal polarity
> of the MPC5121 internal PHY using "fsl,invert-drvvbus" and
> "fsl,invert-pwr-fault" properties.
[...]
> --- a/Documentation/powerpc/dts-bindings/fsl/usb.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/usb.txt
> @@ -33,6 +33,14 @@ Recommended properties :
> =A0- interrupt-parent : the phandle for the interrupt controller that
> =A0 =A0services interrupts for this device.
>
> +Optional properties :
> + - fsl,big-endian-regs : boolean; if defined, indicates the USB host
> + =A0 controller registers format is big endian.

As commented in previous thread, this property should be dropped, and
the driver should test for fsl,mpc5121-usb2-dr directly.  fsl-usb2-dr
should also be dropped from the compatible list of the .dts file.

g.
