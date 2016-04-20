Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqWrf6hlfzDqK8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 16:17:38 +1000 (AEST)
Received: by mail-pf0-x232.google.com with SMTP id 184so14971131pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 23:17:38 -0700 (PDT)
Subject: Re: [PATCH V2 18/68] powerpc/mm: Move hash and no hash code to
 separate files
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <570B329E.8060607@gmail.com> <87k2jwa65h.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57171EF4.9060509@gmail.com>
Date: Wed, 20 Apr 2016 16:17:24 +1000
MIME-Version: 1.0
In-Reply-To: <87k2jwa65h.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +		if (htab_bolt_mapping(ea, ea + PAGE_SIZE, pa, flags,
>>> +				      mmu_io_psize, mmu_kernel_ssize)) {
>>> +			printk(KERN_ERR "Failed to do bolted mapping IO "
>>> +			       "memory at %016lx !\n", pa);
>>> +			return -ENOMEM;
>>
>> What happens when we do unmap this? I know this code has been around for a while
>> so its not new
> 
> you mean iounmap ? it do call vunmap, which look for a linux page table
> entry. If it is a bolt_mapping entry as above, we will not have a linux
> page table entry and that unmap will not relaly remove the mapping. 

Make sense, thanks!

Balbir
