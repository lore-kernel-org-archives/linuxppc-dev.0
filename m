Return-Path: <pku.leo@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 10ED6B7118
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 20:39:00 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 1DDFFDDD1B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 20:38:57 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so1641978anc.39
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 03:38:56 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <718B5524-9FB1-4835-BAEA-C5B990F78DAC@kernel.crashing.org>
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<90AED712-28A1-4800-978C-125A887D0DA7@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9ED483CCD@zch01exm26.fsl.freescale.net>
	<5D8775BD-9973-4DE8-B442-91FB15F86ACC@kernel.crashing.org>
	<2a27d3730906120627l112030b3wa11ea5aa3fcb1087@mail.gmail.com>
	<718B5524-9FB1-4835-BAEA-C5B990F78DAC@kernel.crashing.org>
Date: Mon, 15 Jun 2009 18:38:56 +0800
Message-ID: <2a27d3730906150338u224126e1yf6fb0b77675a6633@mail.gmail.com>
Subject: Re: [PATCH 1/6] rapidio: add common mapping APIs for RapidIO memory
	access
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Zhang Wei <zw@zh-kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 12, 2009 at 9:58 PM, Kumar Gala<galak@kernel.crashing.org> wrot=
e:
>
> On Jun 12, 2009, at 8:27 AM, Li Yang wrote:
>
>> On Thu, Jun 11, 2009 at 9:32 PM, Kumar Gala<galak@kernel.crashing.org>
>> wrote:
>>>
>>> On Jun 11, 2009, at 4:47 AM, Li Yang-R58472 wrote:
>>>
>>>>> On May 12, 2009, at 3:35 AM, Li Yang wrote:
>>>>>
>>>>>> Add the mapping functions used to support direct IO memory access of
>>>>>> rapidIO.
>>>>>>
>>>>>> Signed-off-by: Zhang Wei <zw@zh-kernel.org>
>>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>>
>>>>> Use inbnd/outbnd instead of inb/outb which make one think of
>>>>> byte level io accessors.
>>>>>
>>>>> As I look at this I don't think this is the correct API. =C2=A0I
>>>>> think we should be using the DMA mapping API to hide these
>>>>> details. =C2=A0The concept of mapping like this seems to be more a
>>>>> function of FSL's Address translation/mapping unit (ATMU) than
>>>>> anything specific to the RIO bus standard.
>>>>
>>>> This is a separate RIO block level ATMU. =C2=A0Although it looks like =
the
>>>> system level ATMU, system ATMU doesn't have the knowledge of rapidIO
>>>> target device ID. =C2=A0The mapping need to be dynamic, as it's easy t=
o have
>>>> more RIO devices than the outbound windows.
>>>
>>> I understand that. =C2=A0What I'm saying is the RIO block level ATMU is=
 a
>>> Freescale specific detail and not part of any standard RIO bus
>>> programming
>>> model. =C2=A0We have mapping APIs that we can connect to for this via t=
he DMA
>>> API
>>> layer.
>>
>> Ok, I see your point now. Do you mean dma_map_*() for DMA API layer?
>> But in my understanding the current dma_map_*() APIs are preparing
>> local memory for device to access which is similar to the inbound
>> case. =C2=A0Is it suitable to also use them for mapping device's space f=
or
>> CPU access? =C2=A0Can you give an example of using this API for Address
>> Translation and Mapping purpose?
>
> Yes, I meant the dma_map_*() API. =C2=A0Any system with a true IOMMU uses=
 the
> dma_map_ layer as the way to do address translation.

IOMMU case is not very similar to the RapidIO scenario.  RapidIO
mapping is more like PCI address space mapping.

To be specific, the DMA API return dma_addr_t not the rapidIO address
type.  And they can only handle inbound mapping not both ways.  I
don't think the DMA API is competent enough to be used here for RIO
mapping.  Unless we have a more universal mapping API, it can be
justified to create its own API.

- Leo
