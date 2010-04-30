Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id B7E94B6EEB
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 11:44:44 +1000 (EST)
Received: by iwn11 with SMTP id 11so12492307iwn.11
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 18:44:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1272584978-19063-6-git-send-email-agust@denx.de>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-6-git-send-email-agust@denx.de>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Thu, 29 Apr 2010 20:44:12 -0500
Message-ID: <n2oed82fe3e1004291844habbdfe76lc369d66cf9a9d9fd@mail.gmail.com>
Subject: Re: [PATCH 5/5] fsl-diu-fb: Support setting display mode using EDID
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:

> +Optional properties:
> +- EDID : verbatim EDID data block describing attached display.
> + =A0Data from the detailed timing descriptor will be used to
> + =A0program the display controller.

The property name should be lower-case.

> =A0/*
> =A0* These parameters give default parameters
> @@ -217,6 +218,7 @@ struct mfb_info {
> =A0 =A0 =A0 =A0int x_aoi_d; =A0 =A0 =A0 =A0 =A0 =A0/* aoi display x offse=
t to physical screen */
> =A0 =A0 =A0 =A0int y_aoi_d; =A0 =A0 =A0 =A0 =A0 =A0/* aoi display y offse=
t to physical screen */
> =A0 =A0 =A0 =A0struct fsl_diu_data *parent;
> + =A0 =A0 =A0 char *edid_data;

edid_data should be "u8 *".  "char *" is should be used only for
strings or arrays of characters.

> + =A0 =A0 =A0 /* Still not found, use preferred mode from database if any=
 */
> + =A0 =A0 =A0 if (!has_default_mode && info->monspecs.modedb !=3D NULL) {

No need for the "!=3D NULL"

--=20
Timur Tabi
Linux kernel developer at Freescale
