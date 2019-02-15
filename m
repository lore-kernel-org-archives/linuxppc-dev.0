Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBABC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 16:43:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C26C2192B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 16:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wmvKt3GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C26C2192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441JxB671czDqhK
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 03:43:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="wmvKt3GF"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441JvS41XjzDqVY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 03:42:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 441JvK1bZvz9vKJL;
 Fri, 15 Feb 2019 17:42:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=wmvKt3GF; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id wFruSF5h5nEE; Fri, 15 Feb 2019 17:42:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 441JvK0Rw0z9vKJ2;
 Fri, 15 Feb 2019 17:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550248925; bh=N0GxXZAZjf/t+PyaEvFZaigQA7Fxeh5/5I55hnizrJg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=wmvKt3GFIFKFS+jMrFvJkzSVRKeRdJkCwXdBPkrVlpgmr4ggQGD8RxdI/38e5qER0
 uvINDKKrWS1ZjWwMEG+G1i8ScifxM3dugJc8Wxw9puzwcw8ndmgTq90HdRl7VE2GGv
 YU+hzWZPMNHGWiYId7l/OM0/om5ML51K8piSSx8s=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 919868B915;
 Fri, 15 Feb 2019 17:42:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Pk0ElruzQP_P; Fri, 15 Feb 2019 17:42:06 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 601C78B90C;
 Fri, 15 Feb 2019 17:42:06 +0100 (CET)
Subject: Re: [RFC PATCH 0/5] powerpc: KASAN for 64-bit Book3E
To: Daniel Axtens <dja@axtens.net>, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
References: <20190215000441.14323-1-dja@axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1509a715-ed76-5a67-2987-fbeac60ca7ac@c-s.fr>
Date: Fri, 15 Feb 2019 16:39:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190215000441.14323-1-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 02/15/2019 12:04 AM, Daniel Axtens wrote:
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to the e6500, a 64-bit Book3E processor which doesn't have a
> hashed page table. It applies on top of Christophe's series, v5.
> 
> It requires some changes to the KASAN core - please let me know if
> these are problematic and we see if an alternative approach is
> possible.
> 
> The KASAN shadow area is mapped into vmemmap space:
> 0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
> To do this we require that vmemmap be disabled. (This is the default
> in the kernel config that QorIQ provides for the machine in their
> SDK anyway - they use flat memory.)
> 
> Only outline instrumentation is supported and only KASAN_MINIMAL works.
> Only the kernel linear mapping (0xc000...) is checked. The vmalloc and
> ioremap areas (also in 0x800...) are all mapped to a zero page. As
> with the Book3S hash series, this requires overriding the memory <->
> shadow mapping.
> 
> Also, as with both previous 64-bit series, early instrumentation is not
> supported.
> 
> KVM, kexec and xmon have not been tested.
> 
> Thanks to those who have done the heavy lifting over the past several years:
>   - Christophe's 32 bit series: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-February/185379.html
>   - Aneesh's Book3S hash series: https://lwn.net/Articles/655642/
>   - Balbir's Book3S radix series: https://patchwork.ozlabs.org/patch/795211/
> 
> While useful if you have an Book3E device, this is mostly intended
> as a warm-up exercise for reviving Aneesh's series for book3s hash.
> In particular, changes to the kasan core are going to be required
> for hash and radix as well.
> 
> Regards,
> Daniel

Hi Daniel,

I'll look into your series in more details later, for now I just want to 
let you know that I get a build failure:

   LD      vmlinux.o
lib/string.o: In function `memcmp':
/root/linux-powerpc/lib/string.c:857: multiple definition of `memcmp'
arch/powerpc/lib/memcmp_32.o:/root/linux-powerpc/arch/powerpc/lib/memcmp_32.S:16: 
first defined here


Christophe

> 
> Daniel Axtens (5):
>    kasan: do not open-code addr_has_shadow
>    kasan: allow architectures to manage the memory-to-shadow mapping
>    kasan: allow architectures to provide an outline readiness check
>    powerpc: move KASAN into its own subdirectory
>    powerpc: KASAN for 64bit Book3E
> 
>   arch/powerpc/Kconfig                          |  1 +
>   arch/powerpc/Makefile                         |  2 +
>   arch/powerpc/include/asm/kasan.h              | 77 +++++++++++++++++--
>   arch/powerpc/include/asm/ppc_asm.h            |  7 ++
>   arch/powerpc/include/asm/string.h             |  7 +-
>   arch/powerpc/lib/mem_64.S                     |  6 +-
>   arch/powerpc/lib/memcmp_64.S                  |  5 +-
>   arch/powerpc/lib/memcpy_64.S                  |  3 +-
>   arch/powerpc/lib/string.S                     | 15 ++--
>   arch/powerpc/mm/Makefile                      |  4 +-
>   arch/powerpc/mm/kasan/Makefile                |  6 ++
>   .../{kasan_init.c => kasan/kasan_init_32.c}   |  0
>   arch/powerpc/mm/kasan/kasan_init_book3e_64.c  | 53 +++++++++++++
>   arch/powerpc/purgatory/Makefile               |  3 +
>   arch/powerpc/xmon/Makefile                    |  1 +
>   include/linux/kasan.h                         |  6 ++
>   mm/kasan/generic.c                            |  5 +-
>   mm/kasan/generic_report.c                     |  2 +-
>   mm/kasan/kasan.h                              |  6 +-
>   mm/kasan/report.c                             |  6 +-
>   mm/kasan/tags.c                               |  3 +-
>   21 files changed, 188 insertions(+), 30 deletions(-)
>   create mode 100644 arch/powerpc/mm/kasan/Makefile
>   rename arch/powerpc/mm/{kasan_init.c => kasan/kasan_init_32.c} (100%)
>   create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c
> 
