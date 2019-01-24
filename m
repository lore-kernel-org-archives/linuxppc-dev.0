Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A551C282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 09:45:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124C220855
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 09:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="a9cRoELF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124C220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lchz0lP6zDqJ8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 20:45:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="a9cRoELF"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lcfy5gYzzDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 20:43:54 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43lcfs24ctz9v0GN;
 Thu, 24 Jan 2019 10:43:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=a9cRoELF; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qerfoCtk40gn; Thu, 24 Jan 2019 10:43:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43lcfs0jGJz9v0GM;
 Thu, 24 Jan 2019 10:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548323029; bh=pdpzN4Cls9VIi57rwmgYgmW1ymLGgOvDPZus6sPQUOw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=a9cRoELFwxDif1NC2YT2l165rRga4QNBnkYLLw3lLr06pUcnaKGhX5ZgZuGt1m98b
 NS1ZYi6k3427XVB/4aIqzh6C85pBbZCmP2zcUloJuk8vxpgtbj5ppWRIftd20dfeie
 Dswq3SPH6SpkCh0W3SzrlZcENjGXogSHvb9q7ZxU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3629D8B838;
 Thu, 24 Jan 2019 10:43:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id P6qvuZTZhQ0g; Thu, 24 Jan 2019 10:43:50 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A582A8B755;
 Thu, 24 Jan 2019 10:43:49 +0100 (CET)
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
 <2e700e1c-5bd9-652e-b535-68a89dd703a1@c-s.fr>
 <87y37ax3ru.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9b4dab64-6a6b-a599-4676-bf891473ada7@c-s.fr>
Date: Thu, 24 Jan 2019 09:43:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87y37ax3ru.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 01/24/2019 01:06 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 12/01/2019 à 10:55, Christophe Leroy a écrit :
>>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
>>> moves the thread_info into task_struct.
>>>
>>> Moving thread_info into task_struct has the following advantages:
>>> - It protects thread_info from corruption in the case of stack
>>> overflows.
>>> - Its address is harder to determine if stack addresses are
>>> leaked, making a number of attacks more difficult.
>>
>> I ran null_syscall and context_switch benchmark selftests and the result
>> is surprising. There is slight degradation in context_switch and a
>> significant one on null_syscall:
>>
>> Without the serie:
>>
>> ~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
>> 55542
>> 55562
>> 55564
>> 55562
>> 55568
>> ...
>>
>> ~# ./null_syscall
>>      2546.71 ns     336.17 cycles
>>
>>
>> With the serie:
>>
>> ~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
>> 55138
>> 55142
>> 55152
>> 55144
>> 55142
>>
>> ~# ./null_syscall
>>      3479.54 ns     459.30 cycles
>>
>> So 0,8% less context switches per second and 37% more time for one syscall ?
>>
>> Any idea ?
> 
> What platform is that on?

It is on the 8xx

> 
> On 64-bit we have to turn one mtmsrd into two and that's obviously a
> slow down. But I don't see that you've done anything similar in 32-bit
> code.
> 
> I assume it's patch 8 that causes the slow down?

I have not digged into it yet, but why patch 8 ?


I run null_syscall with perf, and I get the following. Can we conclude 
on something with that ?

Without the serie:

# Overhead       Samples  Command       Shared Object      Symbol 

# ........  ............  ............  ................. 
........................................
#
     32.95%         46375  null_syscall  [kernel.kallsyms]  [k] DoSyscall
     23.64%         33275  null_syscall  [kernel.kallsyms]  [k] 
__task_pid_nr_ns
     15.47%         21778  null_syscall  libc-2.23.so       [.] 
__GI___getppid
      8.92%         12556  null_syscall  [kernel.kallsyms]  [k] 
__rcu_read_unlock
      5.69%          8014  null_syscall  [kernel.kallsyms]  [k] sys_getppid
      4.01%          5643  null_syscall  [kernel.kallsyms]  [k] 
__rcu_read_lock
      3.67%          5166  null_syscall  [kernel.kallsyms]  [k] 
syscall_dotrace_cont
      2.52%          3542  null_syscall  null_syscall       [.] main

With the serie:

     30.04%         56337  null_syscall  [kernel.kallsyms]  [k] DoSyscall
     13.89%         26060  null_syscall  [kernel.kallsyms]  [k] 
__rcu_read_unlock
     13.36%         25062  null_syscall  libc-2.23.so       [.] 
__GI___getppid
     12.73%         23872  null_syscall  [kernel.kallsyms]  [k] 
__task_pid_nr_ns
     11.21%         21033  null_syscall  [kernel.kallsyms]  [k] sys_getppid
      8.24%         15457  null_syscall  [kernel.kallsyms]  [k] 
syscall_dotrace_cont
      4.38%          8217  null_syscall  [kernel.kallsyms]  [k] 
ret_from_syscall
      2.54%          4773  null_syscall  null_syscall       [.] main


Christophe
