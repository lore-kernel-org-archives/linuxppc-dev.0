Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D46F11A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 14:12:42 +1000 (EST)
Received: by mail-pa0-f42.google.com with SMTP id lj1so1160044pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 21:12:40 -0700 (PDT)
Message-ID: <53AA4C32.7060004@ozlabs.ru>
Date: Wed, 25 Jun 2014 14:12:34 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
In-Reply-To: <20140625011211.GA5785@richard>
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

On 06/25/2014 11:12 AM, Wei Yang wrote:
> On Tue, Jun 24, 2014 at 08:06:32PM +1000, Alexey Kardashevskiy wrote:
>> On 06/10/2014 11:56 AM, Wei Yang wrote:
>>> Current iommu_table of a PE is a static field. This will have a problem when
>>> iommu_free_table is called.
>>
>> What kind of problem? This table is per PE and PE is not going anywhere.
>>
> 
> Yes, for Bus PE, they will always sit in the system. When VF PE introduced,
> they could be released on the fly. When they are released, so do the iommu
> table for the PE.

iommu_table is a part of PE struct. When PE is released, iommu_table will
go with it as well. Why to make is a pointer? I would understand it if you
added reference counting there but no - iommu_table's lifetime is equal to
PE lifetime.



-- 
Alexey
