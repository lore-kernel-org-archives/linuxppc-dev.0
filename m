Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2841CC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 16:41:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D3420869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 16:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D3420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43psh61VcyzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 03:41:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43psdM4zxmzDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 03:38:47 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id l11so22980117qtp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 08:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kUuH8FQEM1GuRAZUiQjibByu2sT3rHs32qjblcZIRVY=;
 b=CkspxQQQZotoSw4iwQQzh70HI116YARd+v4XCfo2pX6vN3dVUnRioPSwuUuS6ACfLT
 ynYqcnTtFyNHYHKhwW/Z1uyTPujXf5saYSgYDEF0EiV33tHL+1NANeY/KPZtUu6mgdI2
 aXWC08aYrAo8Fq2YGT7BwbiUnta49RjktqjEeY+VCd07rGDmvdlZtwaa3Ay55nDxOibh
 iiJzRHobydGEDYyCw284kiojWvimNPlz+oyaz534PTCu3MF5tJOv9q3jre5IvOb4Ybsp
 ypkk7Dp0/ncvmoxlGP47TL9OliltmrOI8YVdugGkfA8zY/g7ZtpZEnDE3NH5j+OJJM1b
 EGfw==
X-Gm-Message-State: AJcUukfhPT2k1mvMC6k+yDPjkFKnMMFd6T7gvZ4nGy/KL537BOzb5BQU
 wHg6Ike1/MkgUyIFvhI2EcI=
X-Google-Smtp-Source: ALg8bN71mmL9OFF2Y+R9krvOecTbh/x5cTQ1tMFG8kEkCR+EuSYRW3IS1GqdhwwlSSGM5kkbv5UOcA==
X-Received: by 2002:a0c:f053:: with SMTP id b19mr25061723qvl.29.1548779924873; 
 Tue, 29 Jan 2019 08:38:44 -0800 (PST)
Received: from [10.0.0.4] ([189.29.25.55])
 by smtp.gmail.com with ESMTPSA id x202sm71460247qka.67.2019.01.29.08.38.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 08:38:44 -0800 (PST)
Subject: Re: [PATCH] powerpc/ptrace: Mitigate potential Spectre v1
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1548338509-628-1-git-send-email-leitao@debian.org>
 <43b1ccd5-ec7f-32de-4f30-d67dbea02d9e@embeddedor.com>
From: Breno Leitao <leitao@debian.org>
Message-ID: <c9996eb1-d77d-acc4-2f7c-32893ba8a8e5@debian.org>
Date: Tue, 29 Jan 2019 14:38:41 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <43b1ccd5-ec7f-32de-4f30-d67dbea02d9e@embeddedor.com>
Content-Type: text/plain; charset=utf-8
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Gustavo,

On 1/24/19 3:25 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 1/24/19 8:01 AM, Breno Leitao wrote:
>> 'regno' is directly controlled by user space, hence leading to a potential
>> exploitation of the Spectre variant 1 vulnerability.
>>
>> On PTRACE_SETREGS and PTRACE_GETREGS requests, user space passes the
>> register number that would be read or written. This register number is
>> called 'regno' which is part of the 'addr' syscall parameter.
>>
>> This 'regno' value is checked against the maximum pt_regs structure size,
>> and then used to dereference it, which matches the initial part of a
>> Spectre v1 (and Spectre v1.1) attack. The dereferenced value, then,
>> is returned to userspace in the GETREGS case.
>>
> 
> Was this reported by any tool?

It was not. I was writing an userspace tool, which required me to read the
Ptrace subsystem carefully, then, I just found this case.

> If so, it might be worth mentioning it.
> 
>> This patch sanitizes 'regno' before using it to dereference pt_reg.
>>
>> Notice that given that speculation windows are large, the policy is
>> to kill the speculation on the first load and not worry if it can be
>> completed with a dependent load/store [1].
>>
>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  arch/powerpc/kernel/ptrace.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
>> index cdd5d1d3ae41..3eac38a29863 100644
>> --- a/arch/powerpc/kernel/ptrace.c
>> +++ b/arch/powerpc/kernel/ptrace.c
>> @@ -33,6 +33,7 @@
>>  #include <linux/hw_breakpoint.h>
>>  #include <linux/perf_event.h>
>>  #include <linux/context_tracking.h>
>> +#include <linux/nospec.h>
>>  
>>  #include <linux/uaccess.h>
>>  #include <linux/pkeys.h>
>> @@ -298,6 +299,9 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
>>  #endif
>>  
>>  	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {
> 
> I would use a variable to store sizeof(struct user_pt_regs) / sizeof(unsigned long).

Right.

> 
>> +		regno = array_index_nospec(regno,
>> +				(sizeof(struct user_pt_regs) /
>> +				 sizeof(unsigned long)));
> 
> See the rest of my comments below.
> 
>>  		*data = ((unsigned long *)task->thread.regs)[regno];
>>  		return 0;
>>  	}
>> @@ -321,6 +325,7 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
>>  		return set_user_dscr(task, data);
>>  
>>  	if (regno <= PT_MAX_PUT_REG) {
>> +		regno = array_index_nospec(regno, PT_MAX_PUT_REG);
> 
> This is wrong.  array_index_nospec() will return PT_MAX_PUT_REG - 1 in case regno is equal to
> PT_MAX_PUT_REG, and this is not what you want.

Right, this is really wrong. It would be correct if the comparison was
regno < PT_MAX_PUT_REG. Since it is PT_MAX_PUT_REGS is a valid array entry,
then I need to care about this case also. Doing something as:

	regno = array_index_nospec(regno, PT_MAX_PUT_REG + 1);

Other than that, I think that for the regno = PT_MAX_PUT_REG base,
array_index_nospec() will redefine regno to 0, not PT_MAX_PUT_REG - 1.

> Similar reasoning applies to the case above.

I understand that the case above does not seem to have the same problem,
since it does not address over the array as done in the case above. Does it
make sense?

Anyway, this is how I am thinking the v2 of the patch:

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index cdd5d1d3ae41..7535f89e08cd 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -33,6 +33,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
 #include <linux/context_tracking.h>
+#include <linux/nospec.h>

 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
@@ -274,6 +275,8 @@ static int set_user_trap(struct task_struct *task,
unsigned long trap)
  */
 int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 {
+	unsigned int regs_max;
+
 	if ((task->thread.regs == NULL) || !data)
 		return -EIO;

@@ -297,7 +300,9 @@ int ptrace_get_reg(struct task_struct *task, int regno,
unsigned long *data)
 	}
 #endif

-	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {
+	regs_max = sizeof(struct user_pt_regs) / sizeof(unsigned long);
+	if (regno < regs_max) {
+		regno = array_index_nospec(regno, regs_max);
 		*data = ((unsigned long *)task->thread.regs)[regno];
 		return 0;
 	}
@@ -321,6 +326,7 @@ int ptrace_put_reg(struct task_struct *task, int regno,
unsigned long data)
 		return set_user_dscr(task, data);

 	if (regno <= PT_MAX_PUT_REG) {
+		regno = array_index_nospec(regno, PT_MAX_PUT_REG + 1);
 		((unsigned long *)task->thread.regs)[regno] = data;
 		return 0;
 	}
