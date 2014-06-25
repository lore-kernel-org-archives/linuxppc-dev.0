Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D3B91A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 19:31:21 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 15:01:16 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id DDDD4E0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:02:26 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P9VTeE10224108
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:01:30 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P9VCqa009831
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:01:12 +0530
Date: Wed, 25 Jun 2014 17:31:10 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
Message-ID: <20140625093110.GA8362@richard>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru> <20140625052758.GA8873@richard>
 <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
Cc: 'Wei Yang' <weiyang@linux.vnet.ibm.com>,
 "benh@au1.ibm.com" <benh@au1.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
 "yan@linux.vnet.ibm.com" <yan@linux.vnet.ibm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 25, 2014 at 09:20:11AM +0000, David Laight wrote:
>From: Wei Yang
>> On Wed, Jun 25, 2014 at 02:12:34PM +1000, Alexey Kardashevskiy wrote:
>> >On 06/25/2014 11:12 AM, Wei Yang wrote:
>> >> On Tue, Jun 24, 2014 at 08:06:32PM +1000, Alexey Kardashevskiy wrote:
>> >>> On 06/10/2014 11:56 AM, Wei Yang wrote:
>> >>>> Current iommu_table of a PE is a static field. This will have a problem when
>> >>>> iommu_free_table is called.
>> >>>
>> >>> What kind of problem? This table is per PE and PE is not going anywhere.
>> >>>
>> >>
>> >> Yes, for Bus PE, they will always sit in the system. When VF PE introduced,
>> >> they could be released on the fly. When they are released, so do the iommu
>> >> table for the PE.
>> >
>> >iommu_table is a part of PE struct. When PE is released, iommu_table will
>> >go with it as well. Why to make is a pointer? I would understand it if you
>> >added reference counting there but no - iommu_table's lifetime is equal to
>> >PE lifetime.
>> >
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
>What are the sizes of the iommu table and the PE structure?

I calculated it in my mind, the size of iommu_table, defined in
arch/powerpc/include/asm/iommu.h is 256 bytes.

>If the table is a round number of pages then you probably don't want to
>embed it inside the PE structure.

If my understanding is correct, the iommu table structure size is not that
big.

>
>	David
>

-- 
Richard Yang
Help you, Help me
