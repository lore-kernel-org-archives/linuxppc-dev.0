Return-Path: <SRS0=2H2D=XA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9DDC3A5AB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 09:55:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87992184B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 09:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87992184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46PGK06ftQzDr3P
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 19:55:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46PGGL3ty4zDqxk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 19:53:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 46PGGL0Mbhz9sN1; Thu,  5 Sep 2019 19:53:14 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46PGGK4Z9Jz9sBF;
 Thu,  5 Sep 2019 19:53:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/64: Fix stacktrace on BE when function_graph is
 enabled
In-Reply-To: <1566636816.4snngx2qd3.naveen@linux.ibm.com>
References: <20190823122901.32667-1-mpe@ellerman.id.au>
 <1566636816.4snngx2qd3.naveen@linux.ibm.com>
Date: Thu, 05 Sep 2019 19:53:12 +1000
Message-ID: <87woennk6v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Michael Ellerman wrote:
>> Currently if we oops or warn while function_graph is active the stack
>> trace looks like:
>>   .trace_graph_return+0xac/0x100
>>   .ftrace_return_to_handler+0x98/0x140
>>   .return_to_handler+0x20/0x40
>>   .return_to_handler+0x0/0x40
>>   .return_to_handler+0x0/0x40
>>   .return_to_handler+0x0/0x40
>>   .return_to_handler+0x0/0x40
>>   .return_to_handler+0x0/0x40
>>   .return_to_handler+0x0/0x40
>>   .cpu_startup_entry+0x34/0x40
>>   .start_secondary+0x680/0x6f0
>>   start_secondary_prolog+0x10/0x14
>> 
>> Notice the multiple entries that just show .return_to_handler.
>> 
>> There is logic in show_stack() to detect this case and print the
>> traced function, but we inadvertently broke it in commit
>> 7d56c65a6ff9 ("powerpc/ftrace: Remove mod_return_to_handler") (2014),
>> because that commit accidentally removed the dereference of rth which
>> gets the text address from the function descriptor. Hence this is only
>> broken on big endian (or technically ELFv1).
>> 
>> Fix it by using the proper accessor, which is ppc_function_entry().
>> Result is we get a stack trace such as:
>> 
>>   .trace_graph_return+0x134/0x160
>>   .ftrace_return_to_handler+0x94/0x140
>>   .return_to_handler+0x20/0x40
>>   .return_to_handler+0x0/0x40 (.shared_cede_loop+0x48/0x130)
>>   .return_to_handler+0x0/0x40 (.cpuidle_enter_state+0xa0/0x690)
>>   .return_to_handler+0x0/0x40 (.cpuidle_enter+0x44/0x70)
>>   .return_to_handler+0x0/0x40 (.call_cpuidle+0x68/0xc0)
>>   .return_to_handler+0x0/0x40 (.do_idle+0x37c/0x400)
>>   .return_to_handler+0x0/0x40 (.cpu_startup_entry+0x30/0x50)
>>   .rest_init+0x224/0x348
>> 
>> Fixes: 7d56c65a6ff9 ("powerpc/ftrace: Remove mod_return_to_handler")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/kernel/process.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index 8fc4de0d22b4..1601d7cfe45e 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -2048,7 +2048,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>  	struct ftrace_ret_stack *ret_stack;
>>  	extern void return_to_handler(void);
>> -	unsigned long rth = (unsigned long)return_to_handler;
>> +	unsigned long rth = ppc_function_entry(return_to_handler);
>
> Thanks! This looks good to me. A small suggestion though -- can we use 
> dereference_kernel_function_descriptor() instead? It will be a nop for 
> ABIv2, which would be nice, but not really a major deal.

ppc_function_entry() isn't a nop on ABIv2, *if* the function has a local
entry point.

As it happens return_to_handler doesn't have a local entry point, so it
is currently a nop.

But if return_to_handler did have a local entry then
ppc_function_entry() would do the right thing here because we use
ppc_function_entry() in prepare_ftrace_return().

At least I think that's true :)

> In either case:
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

cheers
