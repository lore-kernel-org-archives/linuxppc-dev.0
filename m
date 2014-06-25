Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D18C1A000E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:28:05 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 10:58:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3FA1A3940048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:58:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P5SGDG61997292
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:58:16 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P5RxXp008387
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:58:00 +0530
Date: Wed, 25 Jun 2014 13:27:58 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
Message-ID: <20140625052758.GA8873@richard>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53AA4C32.7060004@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com, yan@linux.vnet.ibm.com,
 bhelgaas@google.com, qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 25, 2014 at 02:12:34PM +1000, Alexey Kardashevskiy wrote:
>On 06/25/2014 11:12 AM, Wei Yang wrote:
>> On Tue, Jun 24, 2014 at 08:06:32PM +1000, Alexey Kardashevskiy wrote:
>>> On 06/10/2014 11:56 AM, Wei Yang wrote:
>>>> Current iommu_table of a PE is a static field. This will have a problem when
>>>> iommu_free_table is called.
>>>
>>> What kind of problem? This table is per PE and PE is not going anywhere.
>>>
>> 
>> Yes, for Bus PE, they will always sit in the system. When VF PE introduced,
>> they could be released on the fly. When they are released, so do the iommu
>> table for the PE.
>
>iommu_table is a part of PE struct. When PE is released, iommu_table will
>go with it as well. Why to make is a pointer? I would understand it if you
>added reference counting there but no - iommu_table's lifetime is equal to
>PE lifetime.
>

Yes, iommu_talbe's life time equals to PE lifetime, so when releasing a PE we
need to release the iommu table. Currently, there is one function to release
the iommu table, iommu_free_table() which takes a pointer of the iommu_table
and release it.

If the iommu table in PE is just a part of PE, it will have some problem to
release it with iommu_free_table(). That's why I make it a pointer in PE
structure.

>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
