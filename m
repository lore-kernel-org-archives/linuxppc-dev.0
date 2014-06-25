Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B87241A0011
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 17:50:15 +1000 (EST)
Received: by mail-pd0-f182.google.com with SMTP id y13so1316316pdi.41
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 00:50:13 -0700 (PDT)
Message-ID: <53AA7F30.40504@ozlabs.ru>
Date: Wed, 25 Jun 2014 17:50:08 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru> <20140625052758.GA8873@richard>
In-Reply-To: <20140625052758.GA8873@richard>
Content-Type: text/plain; charset=KOI8-R
Cc: benh@au1.ibm.com, linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, bhelgaas@google.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2014 03:27 PM, Wei Yang wrote:
> On Wed, Jun 25, 2014 at 02:12:34PM +1000, Alexey Kardashevskiy wrote:
>> On 06/25/2014 11:12 AM, Wei Yang wrote:
>>> On Tue, Jun 24, 2014 at 08:06:32PM +1000, Alexey Kardashevskiy wrote:
>>>> On 06/10/2014 11:56 AM, Wei Yang wrote:
>>>>> Current iommu_table of a PE is a static field. This will have a problem when
>>>>> iommu_free_table is called.
>>>>
>>>> What kind of problem? This table is per PE and PE is not going anywhere.
>>>>
>>>
>>> Yes, for Bus PE, they will always sit in the system. When VF PE introduced,
>>> they could be released on the fly. When they are released, so do the iommu
>>> table for the PE.
>>
>> iommu_table is a part of PE struct. When PE is released, iommu_table will
>> go with it as well. Why to make is a pointer? I would understand it if you
>> added reference counting there but no - iommu_table's lifetime is equal to
>> PE lifetime.
>>
> 
> Yes, iommu_talbe's life time equals to PE lifetime, so when releasing a PE we
> need to release the iommu table. Currently, there is one function to release
> the iommu table, iommu_free_table() which takes a pointer of the iommu_table
> and release it.
> 
> If the iommu table in PE is just a part of PE, it will have some problem to
> release it with iommu_free_table(). That's why I make it a pointer in PE
> structure.

So you are saying that you want to release PE by one kfree() and release
iommu_table by another kfree (embedded into iommu_free_table()). For me
that means that PE and iommu_table have different lifetime.

And I cannot find the exact place in this patchset where you call
iommu_free_table(), what do I miss?




-- 
Alexey
