Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B6742C007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 11:49:31 +1000 (EST)
Message-ID: <500DFF21.2060804@freescale.com>
Date: Mon, 23 Jul 2012 20:49:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop> <500D7921.6060804@freescale.com>
 <1343082030.2957.38.camel@pasglop>
In-Reply-To: <1343082030.2957.38.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Mingkai Hu <Mingkai.hu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Chen Yuanquan <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2012 05:20 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2012-07-23 at 11:17 -0500, Scott Wood wrote:
>>> This is wrong.
>>
>> How so?
>>
>>> Don't you have an iommu do deal with those devices anyway ?
>>
>> Yes, but we don't yet have DMA API support for it, it would lower
>> performance because we'd have to use a lot of subwindows which are
>> poorly cached (and even then we wouldn't be able to map more than 256
>> pages at once on a given device), and the IOMMU may not be available at
>> all if we're being virtualized.
> 
> Ugh ? You mean some designers need to be fired urgently and wasted
> everybody's time implementing an unusable iommu ? Nice one ...

Yeah, that's old news.

It's somewhat usable for specific purposes, using very large pages, but
not for arbitrary use.

>>> But even then, I'm dubious this is really needed.
>>
>> We'd like our drivers to stop crashing with more than 4GiB of RAM on 64-bit.
> 
> Fix your HW :-)

I wish...  Some hardware people may solicit input from us every now and
again, but ultimately they do what they want.

Returning addresses in excess of a device's declared DMA mask is
something that needs fixing too, though.

-Scott
