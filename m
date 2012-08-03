Return-Path: <pku.leo@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29F242C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 00:42:27 +1000 (EST)
Received: by yhnn12 with SMTP id n12so852182yhn.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Aug 2012 07:42:25 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <4C5227D8-BF6D-45BE-9201-8A6CD30FFFE8@kernel.crashing.org>
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-3-git-send-email-B38951@freescale.com>
 <6DEE036D-C59B-41C6-80F3-762D7E4AF2C1@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A359C3@039-SN1MPN1-002.039d.mgd.msft.net>
 <4C5227D8-BF6D-45BE-9201-8A6CD30FFFE8@kernel.crashing.org>
Date: Fri, 3 Aug 2012 22:42:24 +0800
Message-ID: <CADRPPNQZZ5wWUCzhMsOxCgVhK14sb9ughReM_6CzG47YE9J4ew@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] powerpc/swiotlb: Enable at early stage and disable
 if not necessary
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 3, 2012 at 8:38 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Aug 2, 2012, at 9:21 PM, Jia Hongtao-B38951 wrote:
>
>>>
>>> -----Original Message-----
>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>> Sent: Thursday, August 02, 2012 8:55 PM
>>> To: Jia Hongtao-B38951
>>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
>>> Subject: Re: [PATCH V4 2/3] powerpc/swiotlb: Enable at early stage and
>>> disable if not necessary
>>>
>>>
>>> On Aug 2, 2012, at 6:42 AM, Jia Hongtao wrote:
>>>
>>>> Remove the dependency on PCI initialization for SWIOTLB initialization.
>>>> So that PCI can be initialized at proper time.
>>>>
>>>> SWIOTLB is partly determined by PCI inbound/outbound map which is
>>> assigned
>>>> in PCI initialization. But swiotlb_init() should be done at the stage
>>> of
>>>> mem_init() which is much earlier than PCI initialization. So we reserve
>>> the
>>>> memory for SWIOTLB first and free it if not necessary.
>>>>
>>>> All boards are converted to fit this change.
>>>>
>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>> ---
>>>
>>> This doesn't seem like it addresses our issue w/regards to not being able
>>> to map all of memory from PCI.
>>
>> PCI init will determine ppc_swiotlb_enable due to PCI map. swiotlb_late_init
>> will handle all swiotlb things depend on the result of pci init.
>
> Think about the case that we have 4095M of memory & 1G of PCI memory mapped space.  The old code would enable swiotlb for this case since we would NOT be able to DMA to all 4095M of memory.  The patch does not handle this case correctly.

The patch can handle it.  The ppc_swiotlb_enable is still being set in
 fsl_pci_init() if there is 1G of PCI memory mapped space.  It is
after next patch that the ppc_swiotlb_enable is being set in the PCI
probe() routine.

Leo
