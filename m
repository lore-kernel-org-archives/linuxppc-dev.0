Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96E411A012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 13:37:29 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so194887538pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 18:37:28 -0800 (PST)
Subject: Re: [PATCH v7 14/50] powerpc/powernv: M64 support on P7IOC
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D8A.2050505@ozlabs.ru> <20151117014203.GC31584@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564A92E2.1040506@ozlabs.ru>
Date: Tue, 17 Nov 2015 13:37:22 +1100
MIME-Version: 1.0
In-Reply-To: <20151117014203.GC31584@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2015 12:42 PM, Gavin Shan wrote:
> On Mon, Nov 16, 2015 at 07:02:18PM +1100, Alexey Kardashevskiy wrote:
>> On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>> This enables M64 window on P7IOC, which has been enabled on PHB3.
>>> Different from PHB3 where 16 M64 BARs are supported and each of
>>> them can be owned by one particular PE# exclusively or divided
>>> evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
>>> of them are divided to 8 segments. So every P7IOC PHB supports
>>> 128 M64 segments in total. P7IOC has M64DT, which helps mapping
>>> one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
>>> M64DT, indicating that one M64 segment can only be pinned to the
>>> fixed PE#. In order to have same code to support M64 on P7IOC and
>>> PHB3, we just provide 128 M64 segments on every P7IOC PHB and each
>>> of them is pinned to the fixed PE# by bypassing the function of
>>> M64DT. In turn, we just need different phb->init_m64() for P7IOC
>>> and PHB3 to support M64.
>>
>> I thought we decided (Ben suggested?) not to push P7IOC code now (or ever) as
>> there is no user for it, has this changed?
>>
>
> Remember that the code is mixed for P7IOC/PHB3. It's not harmful to support
> M64 window on P7IOC, which is much larger than M32.


The patchset starts with removing dead code and then adds more dead code. 
This is not right...

>> btw please put ioda1/ioda2/p7ioc/etc to the subject line to make it easier to
>> see how much work is there about particular PHB type. You rename quite many
>> functions and I generally want to ask you to group all renaming patches first
>> but it would also make sense to keep them close to (for example)
>> p7ioc-related patches so having more descriptive subject lines may help.
>> Thanks.
>>
>
> As the code is mixed for P7IOC/PHB3, I'm not following the line (IODA1/IODA2/p7ioc/phb3)
> in this patchset.

But you should draw the bold line between PHB types imho.

> Instead, the sequence of patchset is order related to: cod refactoring,
> IO/M32/M64, DMA, PE allocation/releaseing.


Some patches from this patchset are about P7IOC only. All I am asking is to 
say specifically in the subject line what the patch touches - 
IODA1/IODA2/p7ioc/phb3/all_of_them. Or I can walk through all of them, pick 
P7IOC's ones, evaluate the amount of code and entropy they actually add and 
then ask Ben what we do about it, it will just take longer rather than if 
you did it.


-- 
Alexey
