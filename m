Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 0F5B167BDA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 02:32:01 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so133345ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 02 Nov 2006 07:31:59 -0800 (PST)
Message-ID: <528646bc0611020731g26198316y5e162fff487e416b@mail.gmail.com>
Date: Thu, 2 Nov 2006 08:31:57 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Vitaly Wool" <vwool@ru.mvista.com>
Subject: Re: [PATCH] adding ROM chips to device tree
In-Reply-To: <20061102145539.f0b8657f.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061102145539.f0b8657f.vwool@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/2/06, Vitaly Wool <vwool@ru.mvista.com> wrote:
> Hello folks,
>
> inlined below is the patch which adds support for flash device descriptions to the OF device tree. It's inspired by and partially borrowed from Sergei's patch which can be found at http://patchwork.ozlabs.org/linuxppc/patch?id=6526 but arranges things in a different way.
> It should be used together with the corresponding MTD layer extension the current version of which was recently posted to linux-mtd list for discussion and can be found at http://lists.infradead.org/pipermail/linux-mtd/2006-November/016700.html.
> In fact, currently this description can handle only flash devices mapped into memory in a linear way. For NAND flashes we'll need a whole lot different description but let's solve problems as they arise since I'm not aware of any ppc board w/ NAND chip yet :)
>
>  Documentation/powerpc/booting-without-of.txt |   37 +++++++++++++++++++++++++++
>  arch/powerpc/sysdev/Makefile                 |    1
>  arch/powerpc/sysdev/flash.c                  |   27 +++++++++++++++++++
>  3 files changed, 65 insertions(+)
>
> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
>
> Index: powerpc/Documentation/powerpc/booting-without-of.txt
> ===================================================================
> --- powerpc.orig/Documentation/powerpc/booting-without-of.txt
> +++ powerpc/Documentation/powerpc/booting-without-of.txt
> @@ -1693,6 +1696,41 @@ platforms are moved over to use the flat
>                 };
>         };
>
> +    viii) Flash chip nodes
> +
> +    Flash chips (Memory Technology Devices) are often used for solid state
> +    file systems on embedded devices.
> +
> +    Required properties:
> +
> +     - device_type : has to be "rom"
> +     - compatible : Should be the name of the MTD driver. Currently, this is
> +       most likely to be "physmap".
> +     - reg : Offset and length of the register set for the device.
> +
> +    Recommended properties :
> +
> +     - bank-width : Width of the flash data bus in bytes. Must be specified
> +       for the NOR flashes.
> +     - partitions : Several pairs of 32-bit values where the first value is
> +       partition's offset from the start of the MTD device and the second
> +       one is partition size in bytes with LSB used to signify a read only
> +       partititon (so, the parition size should always be an even number).
> +     - partition-names : The list of concatenated zero terminated strings
> +       representing the partition names.

What about selecting driver; ie. CFI vs. non-CFI FLASH devices?
(Although I'm not sure that it really matters).


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
