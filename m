Return-Path: <SRS0=LxjK=MT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A60C65C1B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Oct 2018 16:39:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD252206B2
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Oct 2018 16:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD252206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Sq2K1qLgzF3BN
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 03:39:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Sq076b00zF37v
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 03:37:09 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Spzt1sNnz9ttBZ;
 Sun,  7 Oct 2018 18:36:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Og01nZPEZOnK; Sun,  7 Oct 2018 18:36:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Spzt1H8Fz9ttBL;
 Sun,  7 Oct 2018 18:36:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 73F6C8B780;
 Sun,  7 Oct 2018 18:37:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cfHNl7nNwXag; Sun,  7 Oct 2018 18:37:06 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E15158B74B;
 Sun,  7 Oct 2018 18:37:05 +0200 (CEST)
Subject: Re: [PATCH v5 3/9] powerpc: Prepare for moving thread_info into
 task_struct
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <cover.1538687073.git.christophe.leroy@c-s.fr>
 <65eac9f906b12b55010a00b477619f7739c1cac5.1538687075.git.christophe.leroy@c-s.fr>
 <87tvlzi6yq.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <459532cd-5ae3-681e-2641-4833d3abb4a3@c-s.fr>
Date: Sun, 7 Oct 2018 05:31:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87tvlzi6yq.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 10/06/2018 12:40 PM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
>> index 47a03b9b528b..818451bf629c 100644
>> --- a/arch/powerpc/include/asm/livepatch.h
>> +++ b/arch/powerpc/include/asm/livepatch.h
>> @@ -49,7 +49,7 @@ static inline void klp_init_thread_info(struct thread_info *ti)
>>   	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;
> 
> We need to do something about this.

Oops I missed that one.

> 
> Currently the thread_info sits at the low address of the stack, and we
> use the space immediately above that as a miniature upward growing stack
> for livepatching.
> 
> If we keep the livepatch_sp in the thread_info then we need to
> initialise it somewhere when the task starts running on a stack. And I
> don't know how that works if we end up running on the emergency stack
> for example.
> 
> So I'm not sure that makes much sense.
> 
> Instead we might need to keep the livepatch_sp on the stack page at the
> base, where thread_info currently lives.
> 
> That obviously sucks because you can still overflow into it and trash
> it, but it's no worse than what we have now for livepatching.
> 
> Need to think about it some more.
> 

I think for that serie we can leave with it in the stack, as it won't be 
worst than before. Then in a future patch we can change it. I'll open an 
issue for that on github.

Then for now, I'll add the following change in this patch.

diff --git a/arch/powerpc/include/asm/livepatch.h 
b/arch/powerpc/include/asm/livepatch.h
index 47a03b9b528b..8a81d10ccc82 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -43,13 +43,14 @@ static inline unsigned long 
klp_get_ftrace_location(unsigned long faddr)
  	return ftrace_location_range(faddr, faddr + 16);
  }

-static inline void klp_init_thread_info(struct thread_info *ti)
+static inline void klp_init_thread_info(struct task_struct *p)
  {
+	struct thread_info *ti = task_thread_info(p);
  	/* + 1 to account for STACK_END_MAGIC */
-	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;
+	ti->livepatch_sp = end_of_stack(p) + 1;
  }
  #else
-static void klp_init_thread_info(struct thread_info *ti) { }
+static inline void klp_init_thread_info(struct task_struct *p) { }
  #endif /* CONFIG_LIVEPATCH */

  #endif /* _ASM_POWERPC_LIVEPATCH_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d9d4eb2ea6c9..a12307ebb7ef 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1632,7 +1632,7 @@ int copy_thread(unsigned long clone_flags, 
unsigned long usp,
  	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
  	struct thread_info *ti = task_thread_info(p);

-	klp_init_thread_info(ti);
+	klp_init_thread_info(p);

  	/* Copy registers */
  	sp -= sizeof(struct pt_regs);
diff --git a/arch/powerpc/kernel/setup-common.c 
b/arch/powerpc/kernel/setup-common.c
index 9ca9db707bcb..8054a7b9e026 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -940,7 +940,7 @@ void __init setup_arch(char **cmdline_p)
  	/* Reserve large chunks of memory for use by CMA for KVM. */
  	kvm_cma_reserve();

-	klp_init_thread_info(&init_thread_info);
+	klp_init_thread_info(&init_task);

  	init_mm.start_code = (unsigned long)_stext;
  	init_mm.end_code = (unsigned long) _etext;

Christophe
