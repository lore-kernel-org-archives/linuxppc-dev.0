Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA7AC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 11:27:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F9B20666
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 11:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F9B20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P0Pz2w9vzF35S
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 21:27:51 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P0My5xhXzF22T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 21:26:05 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42P0Md02zrz9ttBr;
 Mon,  1 Oct 2018 13:25:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Gk3JWOhi6fPF; Mon,  1 Oct 2018 13:25:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42P0Mc5vLkz9ttBl;
 Mon,  1 Oct 2018 13:25:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F1B18B966;
 Mon,  1 Oct 2018 13:25:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id lS_m23ETi1hg; Mon,  1 Oct 2018 13:25:55 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D29FD8B95C;
 Mon,  1 Oct 2018 13:25:55 +0200 (CEST)
Subject: Re: [v4] powerpc: Avoid code patching freed init sections
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>
References: <42GsbJ0Knkz9sCh@ozlabs.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0702294f-6a17-18aa-95f6-d97da4596dbd@c-s.fr>
Date: Mon, 1 Oct 2018 13:25:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <42GsbJ0Knkz9sCh@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Haren Myneni <haren@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 21/09/2018 à 13:59, Michael Ellerman a écrit :
> On Fri, 2018-09-14 at 01:14:11 UTC, Michael Neuling wrote:
>> This stops us from doing code patching in init sections after they've
>> been freed.
>>
>> In this chain:
>>    kvm_guest_init() ->
>>      kvm_use_magic_page() ->
>>        fault_in_pages_readable() ->
>> 	 __get_user() ->
>> 	   __get_user_nocheck() ->
>> 	     barrier_nospec();
>>
>> We have a code patching location at barrier_nospec() and
>> kvm_guest_init() is an init function. This whole chain gets inlined,
>> so when we free the init section (hence kvm_guest_init()), this code
>> goes away and hence should no longer be patched.
>>
>> We seen this as userspace memory corruption when using a memory
>> checker while doing partition migration testing on powervm (this
>> starts the code patching post migration via
>> /sys/kernel/mobility/migration). In theory, it could also happen when
>> using /sys/kernel/debug/powerpc/barrier_nospec.
>>
>> cc: stable@vger.kernel.org # 4.13+
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Applied to powerpc fixes, thanks.
> 
> https://git.kernel.org/powerpc/c/51c3c62b58b357e8d35e4cc32f7b4e
> 

This patch breaks booting on my MPC83xx board (book3s/32) very early 
(before console is active), provoking restart.
u-boot reports a checkstop reset at restart.

Reverting this commit fixes the issue.

The following patch fixes the issue as well, but I think it is not the 
best solution. I still think the test should be in patch_instruction() 
instead of being in __patch_instruction(), see my comment on v2

Christophe

diff --git a/arch/powerpc/lib/code-patching.c 
b/arch/powerpc/lib/code-patching.c
index 6ae2777..6192fda 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -29,7 +29,7 @@ static int __patch_instruction(unsigned int 
*exec_addr, unsigned int instr,
         int err;

         /* Make sure we aren't patching a freed init section */
-       if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
+       if (*PTRRELOC(&init_mem_is_free) && 
init_section_contains(exec_addr, 4)) {
                 pr_debug("Skipping init section patching addr: 
0x%px\n", exec_addr);
                 return 0;
         }


Christophe
