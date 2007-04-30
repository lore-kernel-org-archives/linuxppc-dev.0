Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id A09EADDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 19:01:07 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so932922ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 02:01:05 -0700 (PDT)
Message-ID: <528646bc0704300201h55a9aa0aw84c24c0c9dfa6600@mail.gmail.com>
Date: Mon, 30 Apr 2007 03:01:05 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: [PATCH] Xilinx framebuffer device driver - 2nd version
In-Reply-To: <4630F018.3010200@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4630F018.3010200@ru.mvista.com>
Cc: rick.moleres@xilinx.com, arnd@arndb.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/26/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Add support for the video controller IP block included into Xilinx ML300 and
> ML403 reference designs.
>
> Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
> ---
>
> This patch relies on the "Patchset to establish sanity in Xilinx Virtex support" by Gran Likely to have
> the frame buffer device registered on the platform bus. Without this patchset one needs to fill in
> the struct platform_device and make sure platform_device_register() is called elsewhere.
> The DCR access has been added but not tested - my targets are configured in the "memory mapped IO" way.
> I would appreciate if those having the video controller registers accessible as DCRs
> test the DCR mode.
>
> This is the 2nd version that addresses what was pointed out by Arnd and Grant.
> Please find the interdiff against the 1st version below, and the whole patch attached to this message
> Comments are welcome.

First off; I'm an idiot.  The ml403 ref design *does* use the opb2dcr
bridge; and my design *does not* use DCR instructions; so I haven't
been able to test direct DCR access.  :-)  It might just be better to
drop the DCR stuff for now until it's accepted into mainline; or
someone is able to test it.

I've got it running on my custom board.   Seems to work well and it's
more featureful than my driver, so I'll migrate over to using yours.
The design that I'm using has a different color map from the ml300 ref
design.  blue is at offset 0 and red offset 16 (vs. blue-16 and red-0
on the ml300 ref design).   It's probably worthwhile to add those
parameters to the xilinxfb_platform_data structure.

> Would be nice to get this driver into mainline for the 2.6.22.

I certainly support getting it submitted.  Have you emailed it to the
linux-fb-devel list?

Can you split the driver and the platform device registration up into
2 patches?  It will probably make submission less painful; the device
registration patch can go through paulus, and the driver itself
through the linux-fbdev-devel list.

> ===================================================================
> --- linux-2.6.20.orig/drivers/video/Kconfig
> +++ linux-2.6.20/drivers/video/Kconfig
> @@ -1648,6 +1648,16 @@ config FB_XILINX_ROTATE
>         bool "Rotate display"
>         depends on FB_XILINX
>
> +config FB_XILINX_SCR_HEIGHT
> +       int "Screen height in mm"
> +       depends on FB_XILINX
> +       default 99
> +
> +config FB_XILINX_SCR_WIDTH
> +       int "Screen width in mm"
> +       depends on FB_XILINX
> +       default 132
> +

I'm not so fond of doing this via KCONFIG options; at least not at the
driver level.  Also, the board I'm using will have 2 of these cores,
each with different display dimesions.  For these parameters, I think
it makes more sense for the board setup code to override
virtex_device_fixup() and insert the correct values into the pdata
structure before virtex_init() registers the device.  Individual board
ports can add Kconfig setting for the dimensions if appropriate for
the system.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
