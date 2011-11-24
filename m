Return-Path: <B35362@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 872B81007DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 20:59:03 +1100 (EST)
Message-ID: <4ECE162D.7080408@freescale.com>
Date: Thu, 24 Nov 2011 18:02:21 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322095306-13156-1-git-send-email-b35362@freescale.com>	
 <1322095306-13156-3-git-send-email-b35362@freescale.com>	
 <1322120515.24797.296.camel@sauron.fi.intel.com>	
 <3F607A5180246847A760FD34122A1E052DC61F@039-SN1MPN1-003.039d.mgd.msft.net>
 <1322122592.24797.299.camel@sauron.fi.intel.com>
In-Reply-To: <1322122592.24797.299.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E4=BA=8E 2011=E5=B9=B411=E6=9C=8824=E6=97=A5 16:16, Artem Bityutskiy =E5=
=86=99=E9=81=93:
> On Thu, 2011-11-24 at 07:49 +0000, Li Yang-R58472 wrote:
>>> Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to s=
upport
>>> large-page Nand chip
>>>
>>> On Thu, 2011-11-24 at 08:41 +0800, b35362@freescale.com wrote:
>>>> +               /*
>>>> +                * Freescale FCM controller has a 2K size limitation=
 of buffer
>>>> +                * RAM, so elbc_fcm_ctrl->buffer have to be used if =
writesize
>>>> +                * of chip is greater than 2048.
>>>> +                * We malloc a large enough buffer (maximum page siz=
e is
>>> 16K).
>>>> +                */
>>>> +               elbc_fcm_ctrl->buffer =3D kmalloc(1024 * 16 + 1024,
>>> GFP_KERNEL);
>>>
>>> Are there NANDs with 16KiB page size?
>> We are not sure, but are there possibility that chip with 16K page wil=
l appear?  Or maybe we can add a MACRO for the maximum page size?
> I do not know, but I know that allocating 32KiB of contiguous physical
> RAM may cause unneeded memory pressure and even fail if the memory is
> too fragmented. So I would not go for this unless this is necessary.
What is your suggestion ? 8k is enough ?
> Did you try to look how the NAND base interface could be changed to
> avoid re-allocation altogether, BTW?
This buffer is a controller-wide resource( as Scott said), I only=20
allocate buffer one time in this version.
It should be a large enough buffer for all chips.

-Liu Shuo
