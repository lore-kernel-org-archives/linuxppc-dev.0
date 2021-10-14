Return-Path: <SRS0=Ntje=PC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A37FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 09:23:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091296101D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 09:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 091296101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVP8h3Hzlz30Qr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 20:23:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=yun.wang@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVP8C1RMhz2xWy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2021 20:23:04 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=yun.wang@linux.alibaba.com;
 NM=1; PH=DS; RN=31; SR=0; TI=SMTPD_---0UrnMW2X_1634203363; 
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com
 fp:SMTPD_---0UrnMW2X_1634203363) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 14 Oct 2021 17:22:45 +0800
Subject: Re: [PATCH v3 1/2] ftrace: disable preemption between
 ftrace_test_recursion_trylock/unlock()
To: Miroslav Benes <mbenes@suse.cz>
References: <609b565a-ed6e-a1da-f025-166691b5d994@linux.alibaba.com>
 <7e4738b5-21d4-c4d0-3136-a096bbb5cd2c@linux.alibaba.com>
 <alpine.LSU.2.21.2110141108150.23710@pobox.suse.cz>
From: =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <d293a0d2-9864-3f92-a333-e29d919d5a02@linux.alibaba.com>
Date: Thu, 14 Oct 2021 17:22:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2110141108150.23710@pobox.suse.cz>
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
Cc: "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, live-patching@vger.kernel.org,
 linux-riscv@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 Joe Lawrence <joe.lawrence@redhat.com>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Petr Mladek <pmladek@suse.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jiri Kosina <jikos@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Borislav Petkov <bp@alien8.de>, Nicholas Piggin <npiggin@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Colin Ian King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2021/10/14 下午5:13, Miroslav Benes wrote:
>> diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
>> index e8029ae..b8d75fb 100644
>> --- a/kernel/livepatch/patch.c
>> +++ b/kernel/livepatch/patch.c
>> @@ -49,14 +49,16 @@ static void notrace klp_ftrace_handler(unsigned long ip,
>>
>>  	ops = container_of(fops, struct klp_ops, fops);
>>
>> +	/*
>> +	 *
> 
> This empty line is not useful.
> 
>> +	 * The ftrace_test_recursion_trylock() will disable preemption,
>> +	 * which is required for the variant of synchronize_rcu() that is
>> +	 * used to allow patching functions where RCU is not watching.
>> +	 * See klp_synchronize_transition() for more details.
>> +	 */
>>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>>  	if (WARN_ON_ONCE(bit < 0))
>>  		return;
>> -	/*
>> -	 * A variant of synchronize_rcu() is used to allow patching functions
>> -	 * where RCU is not watching, see klp_synchronize_transition().
>> -	 */
>> -	preempt_disable_notrace();
>>
>>  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
>>  				      stack_node);
>> @@ -120,7 +122,6 @@ static void notrace klp_ftrace_handler(unsigned long ip,
>>  	klp_arch_set_pc(fregs, (unsigned long)func->new_func);
>>
>>  unlock:
>> -	preempt_enable_notrace();
>>  	ftrace_test_recursion_unlock(bit);
>>  }
> 
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> 
> for the livepatch part of the patch.
> 
> I would also ask you not to submit new versions so often, so that the 
> other reviewers have time to actually review the patch set.
> 
> Quoting from Documentation/process/submitting-patches.rst:
> 
> "Wait for a minimum of one week before resubmitting or pinging reviewers - 
> possibly longer during busy times like merge windows."

Thanks for the Ack and suggestion, will take care from now on :-)

Regards,
Michael Wang

> 
> Thanks
> 
> Miroslav
> 
