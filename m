Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbZqL3vH2zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 08:51:26 +1000 (AEST)
Received: by mail-pf0-x231.google.com with SMTP id e193so39673116pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 May 2017 15:51:26 -0700 (PDT)
Message-ID: <1496011846.21894.7.camel@gmail.com>
Subject: Re: [PATCH v1 1/8] powerpc/lib/code-patching: Enhance code patching
From: Balbir Singh <bsingharora@gmail.com>
To: christophe leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org,  mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
Date: Mon, 29 May 2017 08:50:46 +1000
In-Reply-To: <72ff9a8a-dad8-55f3-01b0-29b24298bed0@c-s.fr>
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-2-bsingharora@gmail.com>
 <72ff9a8a-dad8-55f3-01b0-29b24298bed0@c-s.fr>
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

On Sun, 2017-05-28 at 17:59 +0200, christophe leroy wrote:
> 
> Le 25/05/2017 à 05:36, Balbir Singh a écrit :
> > Today our patching happens via direct copy and
> > patch_instruction. The patching code is well
> > contained in the sense that copying bits are limited.
> > 
> > While considering implementation of CONFIG_STRICT_RWX,
> > the first requirement is to a create another mapping
> > that will allow for patching. We create the window using
> > text_poke_area, allocated via get_vm_area(), which might
> > be an overkill. We can do per-cpu stuff as well. The
> > downside of these patches that patch_instruction is
> > now synchornized using a lock. Other arches do similar
> > things, but use fixmaps. The reason for not using
> > fixmaps is to make use of any randomization in the
> > future. The code also relies on set_pte_at and pte_clear
> > to do the appropriate tlb flushing.
> 
> Isn't it overkill to remap the text in another area ?
>
> Among the 6 arches implementing CONFIG_STRICT_KERNEL_RWX (arm, arm64, 
> parisc, s390, x86/32, x86/64):
> - arm, x86/32 and x86/64 set text RW during the modification

x86 uses set_fixmap() in text_poke(), am I missing something?

> - s390 seems to uses a special instruction which bypassed write protection
> - parisc doesn't seem to implement any function which modifies kernel text.
> 
> Therefore it seems only arm64 does it via another mapping.
> Wouldn't it be lighter to just unprotect memory during the modification 
> as done on arm and x86 ?
> 

I am not sure if the trade-off is quite that simple, for security I thought

1. It would be better to randomize text_poke_area(), which is why I dynamically
allocated it. If we start randomizing get_vm_area(), we get the benefit
2. text_poke_aread() is RW and the normal text is RX, for any attack
to succeed, it would need to find text_poke_area() at the time of patching,
patch the kernel in that small window and use the normal mapping for
execution

Generally patch_instruction() is not fast path except for ftrace, tracing.
In my tests I did not find the slow down noticable

> Or another alternative could be to disable DMMU and do the write at 
> physical address ?
>

This would be worse off, I think, but we were discussing doing something
like that xmon. But for other cases, I think  it opens up a bigger window.

> Christophe

Balbir Singh
