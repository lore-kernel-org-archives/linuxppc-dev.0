Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2506B1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 20:30:48 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id rd3so1553647pab.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 03:30:45 -0700 (PDT)
Message-ID: <53AAA4CF.70606@ozlabs.ru>
Date: Wed, 25 Jun 2014 20:30:39 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 'Wei Yang' <weiyang@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru> <20140625052758.GA8873@richard>
 <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
Content-Type: text/plain; charset=KOI8-R
Cc: "benh@au1.ibm.com" <benh@au1.ibm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "yan@linux.vnet.ibm.com" <yan@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2014 07:20 PM, David Laight wrote:
> From: Wei Yang
>> On Wed, Jun 25, 2014 at 02:12:34PM +1000, Alexey Kardashevskiy wrote:
>>> On 06/25/2014 11:12 AM, Wei Yang wrote:
>>>> On Tue, Jun 24, 2014 at 08:06:32PM +1000, Alexey Kardashevskiy wrote:
>>>>> On 06/10/2014 11:56 AM, Wei Yang wrote:
>>>>>> Current iommu_table of a PE is a static field. This will have a problem when
>>>>>> iommu_free_table is called.
>>>>>
>>>>> What kind of problem? This table is per PE and PE is not going anywhere.
>>>>>
>>>>
>>>> Yes, for Bus PE, they will always sit in the system. When VF PE introduced,
>>>> they could be released on the fly. When they are released, so do the iommu
>>>> table for the PE.
>>>
>>> iommu_table is a part of PE struct. When PE is released, iommu_table will
>>> go with it as well. Why to make is a pointer? I would understand it if you
>>> added reference counting there but no - iommu_table's lifetime is equal to
>>> PE lifetime.
>>>
>>
>> Yes, iommu_talbe's life time equals to PE lifetime, so when releasing a PE we
>> need to release the iommu table. Currently, there is one function to release
>> the iommu table, iommu_free_table() which takes a pointer of the iommu_table
>> and release it.
>>
>> If the iommu table in PE is just a part of PE, it will have some problem to
>> release it with iommu_free_table(). That's why I make it a pointer in PE
>> structure.
> 
> What are the sizes of the iommu table and the PE structure?

This is all about iommu_table struct (which is just a descriptor), not
IOMMU table per se (which may be megabytes) :)


> If the table is a round number of pages then you probably don't want to
> embed it inside the PE structure.




-- 
Alexey
