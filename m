Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 621492C02F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 08:12:56 +1000 (EST)
Received: by mail-ee0-f42.google.com with SMTP id c50so4239423eek.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 15:12:52 -0700 (PDT)
Message-ID: <51A3DA5E.6080501@gmail.com>
Date: Tue, 28 May 2013 00:12:46 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <51A33447.80305@gmail.com> <1369655404.3557.33.camel@pasglop>
 <2255648.0KEmXfjCx5@wuerfel> <1369691406.3557.35.camel@pasglop>
In-Reply-To: <1369691406.3557.35.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: andrew@lunn.ch, jason@lakedaemon.net, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 buytenh@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/27/2013 11:50 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-27 at 14:47 +0200, Arnd Bergmann wrote:
>> On Monday 27 May 2013 21:50:04 Benjamin Herrenschmidt wrote:
>>> However, that wouldn't help much with the allocation/leak problem,
>>> though at least it would be easier to use. It could also *try* to re-use
>>> the current allocation if the new content is of smaller or equal size.
>>
>> I thought that dtc tried to aggressively save space by folding identical
>> strings. If you tried to reuse a property that had its contents shared
>> with another one, you would get interesting results I guess.
>
> It used to be only property names, unless that has changed in recent
> dtc. But that's a good point, we probably want a flag in struct property
> like we have for nodes, indicating whether it comes from the original
> fdt data pool or not.

But isn't that what current sparc implementation of of_set_property does
when it marks the property as dynamic?

Anyway, this definitely exceeds my knowledge of OF API for sure, so what
do I do about the MAC workaround now?

Prepare the patch with global arrays and switch to some of_set_property
as soon as it is available?

Sebastian
