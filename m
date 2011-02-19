Return-Path: <mlcreech@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4EA77B712D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Feb 2011 05:02:03 +1100 (EST)
Received: by wwb29 with SMTP id 29so5223554wwb.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Feb 2011 10:01:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110219095253.39540a57@wker>
References: <AANLkTikaH6=8JgX6wfqLu0fCFBO0A1hHDTpw7Xb64uKS@mail.gmail.com>
	<20110219095253.39540a57@wker>
Date: Sat, 19 Feb 2011 13:01:57 -0500
Message-ID: <AANLkTikvPOak6mamoeBrDBS5j_M3KuPmQi6DR5Ng6vki@mail.gmail.com>
Subject: Re: fsl_udc_core not initializing properly?
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 19, 2011 at 3:52 AM, Anatolij Gustschin <agust@denx.de> wrote:
>
> Look at the USB node in the device tree for your board. Does it
> contain the "dr_mode" property? For USB gadget the value of this
> property should be "peripheral".
> The device tree for MPC8313 ERDB in mainline tree doesn't specify
> this property, so the host mode is the default operation mode here.
> Therefore the platform device "fsl-usb2-udc" won't be created
> while booting and since there is no appropriate platform device,
> the probing is not done. This might be the case on your board,
> too. Try with dr_mode = "peripheral"; in the usb node in your
> device tree.
>

Yes, it's there.  Here's the DTS entry in case anything else sticks out:

		usb@23000 {
			compatible = "fsl-usb2-dr";
			reg = <0x23000 0x1000>;
			#address-cells = <1>;
			#size-cells = <0>;
			interrupt-parent = <&ipic>;
			interrupts = <38 0x8>;
			phy_type = "utmi_wide";
			dr_mode = "peripheral";
			sleep = <&pmc 0x00300000>;
		};

I think dr_mode was required in past kernel versions as well (since I
seem to recall bumping in to the problem you describe a long time ago
when we first tried to get device-mode USB working).  :)

Thanks

-- 
Matthew L. Creech
