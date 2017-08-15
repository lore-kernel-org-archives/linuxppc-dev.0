Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWvl203H7zDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 00:20:13 +1000 (AEST)
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com
 [209.85.216.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A4BB622CB7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 14:20:11 +0000 (UTC)
Received: by mail-qt0-f177.google.com with SMTP id v29so5037827qtv.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 07:20:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6819c6ae-e898-3293-d8b0-7a80108d7628@arm.com>
References: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
 <82633e62b64e28dc18bc466319065b92faf2414f.1502468875.git.robin.murphy@arm.com>
 <CAL_JsqKW7nhkCDu4eEDCgdC87b0MLH1UFO8LvaH22BcJMBsY7w@mail.gmail.com>
 <6819c6ae-e898-3293-d8b0-7a80108d7628@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 15 Aug 2017 09:19:50 -0500
Message-ID: <CAL_Jsq+pDHbrpLDYUVu22tk4OtR9Di4vxZUozwWJDu2ebYSBdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: Restrict DMA configuration
To: Robin Murphy <robin.murphy@arm.com>
Cc: Frank Rowand <frowand.list@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Hans Verkuil <hverkuil@xs4all.nl>, Johan Hovold <johan@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 15, 2017 at 5:18 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 14/08/17 21:08, Rob Herring wrote:
>> +linuxppc-dev
>>
>> On Fri, Aug 11, 2017 at 11:29 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>> Moving DMA configuration to happen later at driver probe time had the
>>> unnoticed side-effect that we now perform DMA configuration for *every*
>>> device represented in DT, rather than only those explicitly created by
>>> the of_platform and PCI code.
>>>
>>> As Christoph points out, this is not really the best thing to do. Whilst
>>> there may well be other DMA-capable buses that can benefit from having
>>> their children automatically configured after the bridge has probed,
>>> there are also plenty of others like USB, MDIO, etc. that definitely do
>>> not support DMA and should not be indiscriminately processed.
>>>
>>> The good news is that DT already gives us the ammunition to do the right
>>> thing - anything lacking a "dma-ranges" property should be considered
>>> not to have a mapping of DMA address space from its children to its
>>> parent, thus anything for which of_dma_get_range() does not succeed does
>>> not need DMA configuration.
>>>
>>> The bad news is that strictly enforcing that would likely break just
>>> about every FDT platform out there, since most authors have either not
>>> considered the property at all or have mistakenly assumed that omitting
>>> "dma-ranges" is equivalent to including the empty property. Thus we have
>>> little choice but to special-case platform, AMBA and PCI devices so they
>>> continue to receive configuration unconditionally as before. At least
>>> anything new will have to get it right in future...
>>
>> By "anything new", you mean new buses, not new platforms, right?
>> What's a platform bus device today could be a different kernel bus
>> type tomorrow with no DT change. So this isn't really enforceable.
>
> Indeed, it would be virtually impossible to do anything on a
> per-platform basis, but I think per-bus is a workable compromise - if
> someone changes their hypothetical bus driver in a way that would affect
> deployed DTs that can't be updated, at worst they can still add their
> new bus type to the special case list at the same time.
>
>> I don't completely agree that omitting dma-ranges is wrong and that
>> new DTs have to have dma-ranges simply because there is much precedent
>> of DTs with dma-ranges omitted (just go look at PPC). If a bus has no
>> bus to cpu address translation nor size restrictions, then no
>> dma-ranges should be allowed.
>
> Sure, I agree that that genie is never going back in the bottle, but
> people seem to manage to get empty "ranges" right to differentiate
> between memory-mapped vs. non-memory-mapped buses, so it would be nice
> to encourage getting the other direction right as well.

Well, they get ranges right because they don't get an address
otherwise. The problem on dma-ranges is the bus we describe is the
slave side, not the master side. So a given bus may have a mixture of
DMA capable devices and non-DMA capable devices. If we're still
setting DMA masks on all the devices, what have we gained? Maybe we
could get stricter on PCI buses at least.

> For the immediate issue at hand, I guess the alternative plan of attack
> would be to stick a flag in struct bus_type for the bus drivers
> themselves to opt into generic DMA configuration. That at least keeps
> everything within the kernel (and come to think of it probably works
> neatly for modular bus types as well).

I'm fine with the change as is, it's really just the commit text I'm
commenting on.

Rob
