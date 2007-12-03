Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 53FF4DDE07
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 10:52:09 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so6347056wag
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Dec 2007 15:52:06 -0800 (PST)
Message-ID: <9e4733910712031552j36efd4b2u933f0f4e9832a003@mail.gmail.com>
Date: Mon, 3 Dec 2007 18:52:06 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 0/4] Series to add device tree naming to i2c
In-Reply-To: <20071203233752.GA7041@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071203212032.23543.3453.stgit@terra.home>
	<20071203233752.GA7041@lixom.net>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/3/07, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Dec 03, 2007 at 04:20:32PM -0500, Jon Smirl wrote:
> > The following series implements standard linux module aliasing for i2c modules
> > It then converts the mpc i2c driver from being a platform driver to an open
> > firmware one. I2C device names are picked up from the device tree. Module
> > aliasing is used to translate from device tree names into to linux kernel
> > names. Several i2c drivers are updated to use the new aliasing.
>
> May I ask why you want to modify the i2c layer instead of keeping the
> OF->i2c driver mapping in PPC code? It seems simpler to keep it in the
> PPC-specific code, since otherwise you might end up with confused i2c
> driver writers that make up their own OF names without knowing for sure
> that's what will be used. No?

Audio codecs have the same problem. That table is could end up with
hundreds of entries. The right place to store the mappings is in the
device driver for the device.

A side effect of moving the mappings into the device drivers is that
the correct i2c drivers can be automatically loaded by the kernel.
This lets you make distro CDs with all of the i2c drivers on disk and
the device tree will cause insmod of the correct ones.

I'm working on a parallel patch for Alsa SOC but it isn't ready yet.

>
> I recently posted (and asked Paulus to pull) a patch where I consolidate
> the fsl_soc mapping code so I can also use that on pasemi, and modified
> the pasemi platform code to setup the board_info from the device tree
> accordingly.
>
> Finally, whitespace is broken in several of your patches.
>
>
> -Olof
>


-- 
Jon Smirl
jonsmirl@gmail.com
