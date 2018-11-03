Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930CBC0044C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 11:43:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA8B2082E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 11:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA8B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kot-begemot.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42nHBm0jYkzF35g
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 22:43:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kot-begemot.co.uk
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kot-begemot.co.uk
 (client-ip=5.153.251.140; helo=www.kot-begemot.co.uk;
 envelope-from=anton.ivanov@kot-begemot.co.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kot-begemot.co.uk
Received: from www.kot-begemot.co.uk (ivanoab6.miniserver.com [5.153.251.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42nD6v3bjYzF369
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 20:24:53 +1100 (AEDT)
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1gIsA2-0004dx-Ls; Sat, 03 Nov 2018 09:24:06 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
 by smaug.kot-begemot.co.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1gIsA2-00028s-8O; Sat, 03 Nov 2018 09:24:06 +0000
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
To: Richard Weinberger <richard@nod.at>,
 Joel Fernandes <joel@joelfernandes.org>
References: <20181103040041.7085-1-joelaf@google.com>
 <6886607.O3ZT5bM3Cy@blindfold>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
Date: Sat, 3 Nov 2018 09:24:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6886607.O3ZT5bM3Cy@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 03 Nov 2018 22:41:25 +1100
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
Cc: Joel Fernandes <joelaf@google.com>, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-ia64@vge,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 r.kernel.org@lithops.sigma-star.at, hughd@google.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com,
 kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 pantin@google.com, linux-kernel@vger.kernel.org, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/11/2018 09:15, Richard Weinberger wrote:
> Joel,
>
> Am Samstag, 3. November 2018, 05:00:38 CET schrieb Joel Fernandes:
>> Hi,
>> Here is the latest "fast mremap" series. This just a repost with Kirill's
>> Acked-bys added. I would like this to be considered for linux -next.  I also
>> dropped the CONFIG enablement patch for arm64 since I am yet to test it with
>> the new TLB flushing code that is in very recent kernel releases. (None of my
>> arm64 devices run mainline right now.) so I will post the arm64 enablement once
>> I get to that. The performance numbers in the series are for x86.
>>
>> List of patches in series:
>>
>> (1) mm: select HAVE_MOVE_PMD in x86 for faster mremap
>>
>> (2) mm: speed up mremap by 20x on large regions (v4)
>> v1->v2: Added support for per-arch enablement (Kirill Shutemov)
>> v2->v3: Updated commit message to state the optimization may also
>> 	run for non-thp type of systems (Daniel Col).
>> v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
>> 	Rebased ontop of Linus's master, updated perf results based
>>          on x86 testing. Added Kirill's Acks.
>>
>> (3) mm: treewide: remove unused address argument from pte_alloc functions (v2)
>> v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
>>          update changelog with manual fixups for m68k and microblaze.
>>
>> not included - (4) mm: select HAVE_MOVE_PMD in arm64 for faster mremap
>>      This patch is dropped since last posting pending further performance
>>      testing on arm64 with new TLB gather updates. See notes in patch
>>      titled "mm: speed up mremap by 500x on large regions" for more
>>      details.
>>
> This breaks UML build:
>    CC      mm/mremap.o
> mm/mremap.c: In function ‘move_normal_pmd’:
> mm/mremap.c:229:2: error: implicit declaration of function ‘set_pmd_at’; did you mean ‘set_pte_at’? [-Werror=implicit-function-declaration]
>    set_pmd_at(mm, new_addr, new_pmd, pmd);
>    ^~~~~~~~~~
>    set_pte_at
>    CC      crypto/rng.o
>    CC      fs/direct-io.o
> cc1: some warnings being treated as errors
>
> To test yourself, just run on a x86 box:
> $ make defconfig ARCH=um
> $ make linux ARCH=um
>
> Thanks,
> //richard
>
>
>

UM somehow managed to miss one of the 3-level functions, I sent a patch 
at some point to add to the mmremap series, but it looks like it did not 
get included in the final version.

You need these two incremental on top of Joel's patch. Richard - feel 
free to relocate the actual implementation of the set_pgd_at elsewhere - 
I put it at the end of tlb.c

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 7485398d0737..1692da55e63a 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -359,4 +359,7 @@ do {                                                \
         __flush_tlb_one((vaddr));               \
  } while (0)

+extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+               pmd_t *pmdp, pmd_t pmd);
+
  #endif
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 763d35bdda01..d17b74184ba0 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -647,3 +647,9 @@ void force_flush_all(void)
                 vma = vma->vm_next;
         }
  }
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+               pmd_t *pmdp, pmd_t pmd)
+{
+       *pmdp = pmd;
+}
+

