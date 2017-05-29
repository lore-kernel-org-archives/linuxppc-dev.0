Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbm6y21hJzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 15:50:34 +1000 (AEST)
Subject: Re: [PATCH v1 1/8] powerpc/lib/code-patching: Enhance code patching
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-2-bsingharora@gmail.com>
 <72ff9a8a-dad8-55f3-01b0-29b24298bed0@c-s.fr>
 <1496011846.21894.7.camel@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <985293e4-50aa-9f71-8b13-7f7e6dd0c2ae@c-s.fr>
Date: Mon, 29 May 2017 07:50:21 +0200
MIME-Version: 1.0
In-Reply-To: <1496011846.21894.7.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/05/2017 à 00:50, Balbir Singh a écrit :
> On Sun, 2017-05-28 at 17:59 +0200, christophe leroy wrote:
>>
>> Le 25/05/2017 à 05:36, Balbir Singh a écrit :
>>> Today our patching happens via direct copy and
>>> patch_instruction. The patching code is well
>>> contained in the sense that copying bits are limited.
>>>
>>> While considering implementation of CONFIG_STRICT_RWX,
>>> the first requirement is to a create another mapping
>>> that will allow for patching. We create the window using
>>> text_poke_area, allocated via get_vm_area(), which might
>>> be an overkill. We can do per-cpu stuff as well. The
>>> downside of these patches that patch_instruction is
>>> now synchornized using a lock. Other arches do similar
>>> things, but use fixmaps. The reason for not using
>>> fixmaps is to make use of any randomization in the
>>> future. The code also relies on set_pte_at and pte_clear
>>> to do the appropriate tlb flushing.
>>
>> Isn't it overkill to remap the text in another area ?
>>
>> Among the 6 arches implementing CONFIG_STRICT_KERNEL_RWX (arm, arm64,
>> parisc, s390, x86/32, x86/64):
>> - arm, x86/32 and x86/64 set text RW during the modification
> 
> x86 uses set_fixmap() in text_poke(), am I missing something?
> 

Indeed I looked how it is done in ftrace. On x86 text modifications are 
done using ftrace_write() which calls probe_kernel_write() which doesn't 
remap anything. It first calls ftrace_arch_code_modify_prepare() which 
sets the kernel text to rw.

Indeed you are right, text_poke() remaps via fixmap. However it looks 
like text_poke() is used only for kgdb and kprobe

Christophe
