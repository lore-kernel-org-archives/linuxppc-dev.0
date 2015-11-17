Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6EB41A0374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 19:45:03 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 14:15:00 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4AA253940060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 14:14:58 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH8iong33488976
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 14:14:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH8in5X002786
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 14:14:50 +0530
Date: Tue, 17 Nov 2015 19:44:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 14/50] powerpc/powernv: M64 support on P7IOC
Message-ID: <20151117084438.GA16586@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D8A.2050505@ozlabs.ru> <20151117014203.GC31584@gwshan>
 <564A92E2.1040506@ozlabs.ru> <20151117030406.GB10142@gwshan>
 <564AB070.9040500@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <564AB070.9040500@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2015 at 03:43:28PM +1100, Alexey Kardashevskiy wrote:
>On 11/17/2015 02:04 PM, Gavin Shan wrote:
>>On Tue, Nov 17, 2015 at 01:37:22PM +1100, Alexey Kardashevskiy wrote:
>>>On 11/17/2015 12:42 PM, Gavin Shan wrote:
>>>>On Mon, Nov 16, 2015 at 07:02:18PM +1100, Alexey Kardashevskiy wrote:
>>>>>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>>>>>This enables M64 window on P7IOC, which has been enabled on PHB3.
>>>>>>Different from PHB3 where 16 M64 BARs are supported and each of
>>>>>>them can be owned by one particular PE# exclusively or divided
>>>>>>evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
>>>>>>of them are divided to 8 segments. So every P7IOC PHB supports
>>>>>>128 M64 segments in total. P7IOC has M64DT, which helps mapping
>>>>>>one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
>>>>>>M64DT, indicating that one M64 segment can only be pinned to the
>>>>>>fixed PE#. In order to have same code to support M64 on P7IOC and
>>>>>>PHB3, we just provide 128 M64 segments on every P7IOC PHB and each
>>>>>>of them is pinned to the fixed PE# by bypassing the function of
>>>>>>M64DT. In turn, we just need different phb->init_m64() for P7IOC
>>>>>>and PHB3 to support M64.
>>>>>
>>>>>I thought we decided (Ben suggested?) not to push P7IOC code now (or ever) as
>>>>>there is no user for it, has this changed?
>>>>>
>>>>
>>>>Remember that the code is mixed for P7IOC/PHB3. It's not harmful to support
>>>>M64 window on P7IOC, which is much larger than M32.
>>>
>>>
>>>The patchset starts with removing dead code and then adds more dead code.
>>>This is not right...
>>>
>>
>>Sorry, you mean it's fine to break the code on P7IOC as it's going to be dead.
>
>
>I am saying that the _new_ code which implements PCI hotplug on P7IOC is
>dead, not the existing P7IOC support which needs to keep working. Reworks you
>make should keep P7IOC alive but they do not have to add hotplug.
>
>imho it is more likely that we drop P7IOC support in the mainline kernel in
>next 5 years than someone plugs a PCI device to a running P7IOC machine
>anywhere.
>

This patchset isn't supporting PCI hotplug on P7IOC. At the code is mixed
for PHB3/P7IOC, I have to make some changes for P7IOC in order to support
PCI hotplug on PHB3. It's one of the reason that I introduced M64 support
for P7IOC. Another readon is M32 has limited space size (2GB) on P7IOC, one
adapter with more than 2GB memory resource will fail to work on P7IOC. So
it's still nice to support M64 on P7IOC.

>>But I'm curious when it's going happen, any idea about that?
>>
>>>>>btw please put ioda1/ioda2/p7ioc/etc to the subject line to make it easier to
>>>>>see how much work is there about particular PHB type. You rename quite many
>>>>>functions and I generally want to ask you to group all renaming patches first
>>>>>but it would also make sense to keep them close to (for example)
>>>>>p7ioc-related patches so having more descriptive subject lines may help.
>>>>>Thanks.
>>>>>
>>>>
>>>>As the code is mixed for P7IOC/PHB3, I'm not following the line (IODA1/IODA2/p7ioc/phb3)
>>>>in this patchset.
>>>
>>>But you should draw the bold line between PHB types imho.
>>>
>>>>Instead, the sequence of patchset is order related to: cod refactoring,
>>>>IO/M32/M64, DMA, PE allocation/releaseing.
>>>
>>>
>>>Some patches from this patchset are about P7IOC only. All I am asking is to
>>>say specifically in the subject line what the patch touches -
>>>IODA1/IODA2/p7ioc/phb3/all_of_them. Or I can walk through all of them, pick
>>>P7IOC's ones, evaluate the amount of code and entropy they actually add and
>>>then ask Ben what we do about it, it will just take longer rather than if you
>>>did it.
>>>
>>
>>Please give me a clear command what key words you need in the subject in next revision.
>>What I understood is you want to see one of them:
>>
>>powerpc/powernv/ioda1:
>
>Yes, looks good.
>
>>powerpc/powernv/ioda2:
>
>
>Yes.
>
>>powerpc/powernv/all:
>
>Just "powerpc/powernv".
>

Thanks for confirm, I'll put them into the subject in next revision.

Thanks,
Gavin
