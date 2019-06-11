Return-Path: <SRS0=3S3E=UK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9421C43218
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 05:17:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C452063F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 05:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C452063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45NJD70W0SzDqCt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 15:17:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 45NJ9P24nSzDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 15:15:20 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55CCB344;
 Mon, 10 Jun 2019 22:15:19 -0700 (PDT)
Received: from [10.162.43.135] (p8cg001049571a15.blr.arm.com [10.162.43.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5A7FF3F73C; Mon, 10 Jun 2019 22:15:11 -0700 (PDT)
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
 <ec764ff4-f68a-fce5-ac1e-a4664e1123c7@c-s.fr>
 <97e9c9b3-89c8-d378-4730-841a900e6800@arm.com>
 <f6d295c8-574d-3e64-79ae-2f7d3ff4c9f0@c-s.fr>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1875ab7a-204e-4150-c7cc-d282f69da724@arm.com>
Date: Tue, 11 Jun 2019 10:45:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f6d295c8-574d-3e64-79ae-2f7d3ff4c9f0@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Matthew Wilcox <willy@infradead.org>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 06/11/2019 10:16 AM, Christophe Leroy wrote:
> 
> 
> Le 10/06/2019 à 04:39, Anshuman Khandual a écrit :
>>
>>
>> On 06/07/2019 09:01 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 07/06/2019 à 12:34, Anshuman Khandual a écrit :
>>>> Very similar definitions for notify_page_fault() are being used by multiple
>>>> architectures duplicating much of the same code. This attempts to unify all
>>>> of them into a generic implementation, rename it as kprobe_page_fault() and
>>>> then move it to a common header.
>>>>
>>>> kprobes_built_in() can detect CONFIG_KPROBES, hence new kprobe_page_fault()
>>>> need not be wrapped again within CONFIG_KPROBES. Trap number argument can
>>>> now contain upto an 'unsigned int' accommodating all possible platforms.
>>>>
>>>> kprobe_page_fault() goes the x86 way while dealing with preemption context.
>>>> As explained in these following commits the invoking context in itself must
>>>> be non-preemptible for kprobes processing context irrespective of whether
>>>> kprobe_running() or perhaps smp_processor_id() is safe or not. It does not
>>>> make much sense to continue when original context is preemptible. Instead
>>>> just bail out earlier.
>>>>
>>>> commit a980c0ef9f6d
>>>> ("x86/kprobes: Refactor kprobes_fault() like kprobe_exceptions_notify()")
>>>>
>>>> commit b506a9d08bae ("x86: code clarification patch to Kprobes arch code")
>>>>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-ia64@vger.kernel.org
>>>> Cc: linuxppc-dev@lists.ozlabs.org
>>>> Cc: linux-s390@vger.kernel.org
>>>> Cc: linux-sh@vger.kernel.org
>>>> Cc: sparclinux@vger.kernel.org
>>>> Cc: x86@kernel.org
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>>> Cc: Andrey Konovalov <andreyknvl@google.com>
>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>> Cc: Paul Mackerras <paulus@samba.org>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: Tony Luck <tony.luck@intel.com>
>>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> Testing:
>>>>
>>>> - Build and boot tested on arm64 and x86
>>>> - Build tested on some other archs (arm, sparc64, alpha, powerpc etc)
>>>>
>>>> Changes in RFC V3:
>>>>
>>>> - Updated the commit message with an explaination for new preemption behaviour
>>>> - Moved notify_page_fault() to kprobes.h with 'static nokprobe_inline' per Matthew
>>>> - Changed notify_page_fault() return type from int to bool per Michael Ellerman
>>>> - Renamed notify_page_fault() as kprobe_page_fault() per Peterz
>>>>
>>>> Changes in RFC V2: (https://patchwork.kernel.org/patch/10974221/)
>>>>
>>>> - Changed generic notify_page_fault() per Mathew Wilcox
>>>> - Changed x86 to use new generic notify_page_fault()
>>>> - s/must not/need not/ in commit message per Matthew Wilcox
>>>>
>>>> Changes in RFC V1: (https://patchwork.kernel.org/patch/10968273/)
>>>>
>>>>    arch/arm/mm/fault.c      | 24 +-----------------------
>>>>    arch/arm64/mm/fault.c    | 24 +-----------------------
>>>>    arch/ia64/mm/fault.c     | 24 +-----------------------
>>>>    arch/powerpc/mm/fault.c  | 23 ++---------------------
>>>>    arch/s390/mm/fault.c     | 16 +---------------
>>>>    arch/sh/mm/fault.c       | 18 ++----------------
>>>>    arch/sparc/mm/fault_64.c | 16 +---------------
>>>>    arch/x86/mm/fault.c      | 21 ++-------------------
>>>>    include/linux/kprobes.h  | 16 ++++++++++++++++
>>>>    9 files changed, 27 insertions(+), 155 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
>>>> index 443d980..064dd15 100644
>>>> --- a/include/linux/kprobes.h
>>>> +++ b/include/linux/kprobes.h
>>>> @@ -458,4 +458,20 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
>>>>    }
>>>>    #endif
>>>>    +static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
>>>> +                          unsigned int trap)
>>>> +{
>>>> +    int ret = 0;
>>>
>>> ret is pointless.
>>>
>>>> +
>>>> +    /*
>>>> +     * To be potentially processing a kprobe fault and to be allowed
>>>> +     * to call kprobe_running(), we have to be non-preemptible.
>>>> +     */
>>>> +    if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
>>>> +        if (kprobe_running() && kprobe_fault_handler(regs, trap))
>>>
>>> don't need an 'if A if B', can do 'if A && B'
>>
>> Which will make it a very lengthy condition check.
> 
> Yes. But is that a problem at all ?

Probably not.

> 
> For me the following would be easier to read.
> 
> if (kprobes_built_in() && !preemptible() && !user_mode(regs) &&
>     kprobe_running() && kprobe_fault_handler(regs, trap))
>     ret = 1;

As mentioned before will stick with current x86 implementation. 
