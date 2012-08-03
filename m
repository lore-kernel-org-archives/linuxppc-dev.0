Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C5E7C2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 02:15:47 +1000 (EST)
Subject: Re: [PATCH V4 2/3] powerpc/swiotlb: Enable at early stage and disable
 if not necessary
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CADRPPNQZZ5wWUCzhMsOxCgVhK14sb9ughReM_6CzG47YE9J4ew@mail.gmail.com>
Date: Fri, 3 Aug 2012 11:15:30 -0500
Message-Id: <C9270E64-271F-4479-B317-017DE787AF8D@kernel.crashing.org>
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-3-git-send-email-B38951@freescale.com>
 <6DEE036D-C59B-41C6-80F3-762D7E4AF2C1@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A359C3@039-SN1MPN1-002.039d.mgd.msft.net>
 <4C5227D8-BF6D-45BE-9201-8A6CD30FFFE8@kernel.crashing.org>
 <CADRPPNQZZ5wWUCzhMsOxCgVhK14sb9ughReM_6CzG47YE9J4ew@mail.gmail.com>
To: Li Yang <leoli@freescale.com>
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


On Aug 3, 2012, at 9:42 AM, Li Yang wrote:

> On Fri, Aug 3, 2012 at 8:38 PM, Kumar Gala <galak@kernel.crashing.org> =
wrote:
>>=20
>> On Aug 2, 2012, at 9:21 PM, Jia Hongtao-B38951 wrote:
>>=20
>>>>=20
>>>> -----Original Message-----
>>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>>> Sent: Thursday, August 02, 2012 8:55 PM
>>>> To: Jia Hongtao-B38951
>>>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li =
Yang-R58472
>>>> Subject: Re: [PATCH V4 2/3] powerpc/swiotlb: Enable at early stage =
and
>>>> disable if not necessary
>>>>=20
>>>>=20
>>>> On Aug 2, 2012, at 6:42 AM, Jia Hongtao wrote:
>>>>=20
>>>>> Remove the dependency on PCI initialization for SWIOTLB =
initialization.
>>>>> So that PCI can be initialized at proper time.
>>>>>=20
>>>>> SWIOTLB is partly determined by PCI inbound/outbound map which is
>>>> assigned
>>>>> in PCI initialization. But swiotlb_init() should be done at the =
stage
>>>> of
>>>>> mem_init() which is much earlier than PCI initialization. So we =
reserve
>>>> the
>>>>> memory for SWIOTLB first and free it if not necessary.
>>>>>=20
>>>>> All boards are converted to fit this change.
>>>>>=20
>>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>> ---
>>>>=20
>>>> This doesn't seem like it addresses our issue w/regards to not =
being able
>>>> to map all of memory from PCI.
>>>=20
>>> PCI init will determine ppc_swiotlb_enable due to PCI map. =
swiotlb_late_init
>>> will handle all swiotlb things depend on the result of pci init.
>>=20
>> Think about the case that we have 4095M of memory & 1G of PCI memory =
mapped space.  The old code would enable swiotlb for this case since we =
would NOT be able to DMA to all 4095M of memory.  The patch does not =
handle this case correctly.
>=20
> The patch can handle it.  The ppc_swiotlb_enable is still being set in
> fsl_pci_init() if there is 1G of PCI memory mapped space.  It is
> after next patch that the ppc_swiotlb_enable is being set in the PCI
> probe() routine.
>=20
> Leo


Gotcha.  I was thinking the swiotlb_init(0) was:

if (ppc_swiotlb_enable)
	swiotlb_init(0)

Now I see, we call it unconditionally, than fixup in swiotlb_late_init

- k=
