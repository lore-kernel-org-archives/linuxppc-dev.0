Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgCcG6grSzDwBr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 01:38:54 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id a1so2879863pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:38:54 -0800 (PST)
Subject: Re: [PATCH v3 0/5] powerpc/mm: enable memory hotplug on radix
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <3aac2741-998f-88f0-29bf-eb2bb117a0d6@gmail.com>
Date: Sat, 17 Dec 2016 01:38:40 +1100
MIME-Version: 1.0
In-Reply-To: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/12/16 06:50, Reza Arbab wrote:
> Memory hotplug is leading to hash page table calls, even on radix:
> 
> ...
>         arch_add_memory
>                 create_section_mapping
>                         htab_bolt_mapping
>                                 BUG_ON(!ppc_md.hpte_insert);
> 
> To fix, refactor {create,remove}_section_mapping() into hash__ and radix__
> variants. Implement the radix versions by borrowing from existing vmemmap
> and x86 code.
> 
> This passes basic verification of plugging and removing memory, but this 
> stuff is tricky and I'd appreciate extra scrutiny of the series for 
> correctness--in particular, the adaptation of remove_pagetable() from x86.

On quick glance everything seemed alright to me. I'll review each patch and Ack/provide comments.
Do we care about alt maps yet?

Balbir Singh.
