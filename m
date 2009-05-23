Return-Path: <leon.woestenberg@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id AF60EDE0D1
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 09:07:42 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1211142ywt.39
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 16:07:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A173B72.5000201@goop.org>
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<20090519142656T.fujita.tomonori@lab.ntt.co.jp>
	<19E48A70-3332-423C-ACAD-390F940EE81C@kernel.crashing.org>
	<4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
	<1242990702.22654.253.camel@zakaz.uk.xensource.com>
	<4A173B72.5000201@goop.org>
Date: Sun, 24 May 2009 00:59:26 +0200
Message-ID: <c384c5ea0905231559i5ffb0637te62ee005074f9435@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ian Campbell <Ian.Campbell@eu.citrix.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Sat, May 23, 2009 at 1:55 AM, Jeremy Fitzhardinge <jeremy@goop.org> wrot=
e:
> Ian Campbell wrote:
>>
>> On Thu, 2009-05-21 at 14:27 -0400, Becky Bruce wrote:
>>
>>>
>>> I can work with that, but it's going to be a bit inefficient, as I
>>> =A0actually need the dma_addr_t, not the phys_addr_t, so I'll have to
>>> =A0convert. =A0In every case, this is a conversion I've already done an=
d =A0that I
>>> need in the calling code as well.
>>
>> Does
>>
>> =A0 =A0dma_addr_t dma_map_range(struct device *hwdev, phys_addr_t addr,
>> =A0 =A0size_t size);
>>
>> work for you?
>>
>> If the range does not need mapping then it returns the dma address, if
>> you needed to calculate the dma address anyway to figure out if mapping
>> is required then this is fine. If the range does need mapping then it
>> returns NULL.
>>
>
> My only concern is whether dma_addr_t =3D=3D 0 is actually equivalent to =
NULL.
> =A0That is, can we be sure that address 0 will never be used?
>
Indeed, I remember seeing 0 returned on pci_alloc_coherent() as an
address (cookie).

Regards,
--=20
Leon
