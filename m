Return-Path: <bsingharora@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsGCV4VL4zDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:11:18 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id a96so13485678ioj.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:11:18 -0700 (PDT)
Message-ID: <1497935415.2255.1.camel@gmail.com>
Subject: Re: [RFC v2 00/12] powerpc: Memory Protection Keys
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 dave.hansen@intel.com, hbabu@us.ibm.com
Date: Tue, 20 Jun 2017 15:10:15 +1000
In-Reply-To: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-16 at 20:52 -0700, Ram Pai wrote:
> Memory protection keys enable applications to protect its
> address space from inadvertent access or corruption from
> itself.

I presume by itself you mean protection between threads?

> 
> The overall idea:
> 
>  A process allocates a   key  and associates it with
>  a  address  range  within    its   address   space.

OK, so this is per VMA?

>  The process  than  can  dynamically  set read/write 
>  permissions on  the   key   without  involving  the 
>  kernel.

This bit is not clear, how can the key be set without
involving the kernel? I presume you mean the key is set
in the PTE's and the access protection values can be
set without involving the kernel?

 Any  code that  violates   the  permissions
>  off the address space; as defined by its associated
>  key, will receive a segmentation fault.
> 
> This patch series enables the feature on PPC64.
> It is enabled on HPTE 64K-page platform.
> 
> ISA3.0 section 5.7.13 describes the detailed specifications.
> 
> 
> Testing:
> 	This patch series has passed all the protection key
> 	tests available in  the selftests directory.
> 	The tests are updated to work on both x86 and powerpc.

Balbir
