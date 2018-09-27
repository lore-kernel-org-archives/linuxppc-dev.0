Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B71C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:16:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7F1216FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7F1216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LngL4pbCzF398
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 07:16:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.193; helo=mail-qk1-f193.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LnDl42LdzF387
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 06:57:11 +1000 (AEST)
Received: by mail-qk1-f193.google.com with SMTP id 80-v6so2565845qkj.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AcuXv+tzhOPXhBrGrILHtCXFzHst/AHY84/5VuUBWiI=;
 b=XyU5UjBJG/LfLlE/vPt/jsqtE03TcgIscjlaG8Q3ew84zagdHQV+erdeTmyGLpzlxm
 mipF5u0Hg+zLxQbSnTVVDG0C0mFIm3dGGbQFM+My5xw9QqTKZva5Ala3J/sTcVyI8od+
 KTk0E4kluPxzXAwhDWXMMSVvrhJTwk+6BAZpIaWt865FpubHxTooSbouXgvxYdgk39jB
 l+aQPNDt1InhS6/KDHS9BxeT+zA1zVOEL1loSd2A75tfO5cB72rj8OmN/fePN01sZFoX
 kkkIuiuuGswDOfhXqjvTHN3RC89ARematYJjp6OlHLkP5w/oeFFGPdAYXFMVAn2PCYwH
 YkjQ==
X-Gm-Message-State: ABuFfojFFDsO2xrduwhUVSeqcxXzQnsOxUu0jG7Lc8bX/R2xmPrl09sn
 2HrZwxmBi8bZ/tfsN+1jo58=
X-Google-Smtp-Source: ACcGV60vQOBmuhyv2XVZ4V8EkXLUcWgMyQptszHScUkyk88PuN8RmceaEmk/6Egl+1FzdDVxpTLfrg==
X-Received: by 2002:a37:b446:: with SMTP id
 d67-v6mr9497067qkf.104.1538081829180; 
 Thu, 27 Sep 2018 13:57:09 -0700 (PDT)
Received: from [10.0.0.9] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id o2-v6sm2080047qkl.63.2018.09.27.13.57.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 13:57:08 -0700 (PDT)
Subject: Re: [RFC PATCH 11/11] selftests/powerpc: Adapt the test
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-12-git-send-email-leitao@debian.org>
 <b544029461059473cb7b8b6c66815a3ff31ec540.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <434af377-492f-358a-b759-ab68eaeccb3c@debian.org>
Date: Thu, 27 Sep 2018 17:57:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b544029461059473cb7b8b6c66815a3ff31ec540.camel@neuling.org>
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
Cc: ldufour@linux.vnet.ibm.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mikey,

On 09/18/2018 03:36 AM, Michael Neuling wrote:
> On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
>> The Documentation/powerpc/transactional_memory.txt says:
>>
>>  "Syscalls made from within a suspended transaction are performed as normal
>>   and the transaction is not explicitly doomed by the kernel.  However,
>>   what the kernel does to perform the syscall may result in the transaction
>>   being doomed by the hardware."
>>
>> With this new TM mechanism, the syscall will continue to be executed if the
>> syscall happens on a suspended syscall, but, the syscall will *fail* if the
>> transaction is still active during the syscall invocation.
> 
> Not sure I get this. This doesn't seem any different to before.
> 
> An active (not suspended) transaction *will* result in the syscall failing and
> the transaction being doomed.  
> 
> A syscall in a suspended transaction should succeed and the transaction.

I understand that a transaction will always be doomed if there is a
reclaim/checkpoint, thus, if the you make a system call inside a suspended
transaction, it will reclaim and recheckpoint, thus, dooming the transaction,
and failing it on the next RFID.

So, the syscall executed in suspended mode may succeed, because it will not
be skipped (as in active mode), but the transaction will *always* fail,
because there was a reclaim and recheckpoint.

> You might need to clean up the language. I try to use:
> 
>    Active == transactional but not suspended (ie MSR[TS] = T)
>    Suspended == suspended (ie MSR [TS] = S)
>    Doomed == transaction to be rolled back at next opportinity (ie tcheck returns doomed)
> 
> (note: the kernel MSR_TM_ACTIVE() macro is not consistent with this since it's
> MSR[TS] == S or T).

Ok, I agree with this language as well. I might want to improve the code to
follow the same language all across the code.

>> On the syscall path, if the transaction is active and not suspended, it
>> will call TM_KERNEL_ENTRY which will reclaim and recheckpoint the
>> transaction, thus, dooming the transaction on userspace return, with
>> failure code TM_CAUSE_SYSCALL.
> 
> But the test below is on a suspend transaction?

Sorry, I meant "suspended transaction" above instead of "transaction is
active and not suspended".

> 
>> This new model will break part of this test, but I understand that that the
>> documentation above didn't guarantee that the syscall would succeed, and it
>> will never succeed anymore now on.
> 
> The syscall should pass in suspend (modulo the normal syscall checks). The
> transaction may fail as a result.

Perfect, and if the transaction fail, the CPU will rollback the changes and
restore the checkpoint registers (replacing the r3 that contains the pid
value), thus, it will be like "getpid" system call didn't execute.

For this test specifically, it assumes the syscall didn't execute if the
transaction failed. Take a look:

	FUNC_START(getppid_tm_suspended)
		tbegin.
		beq 1f
		li      r0, __NR_getppid
		tsuspend.
		sc
		tresume.
		tend.
		blr
	1:
		li      r3, -1
		blr

So, the tests thinks the syscall failed because the transaction aborted.

Anyway, I can try to improve this test other than removing this test, but I
am not sure how.

Thank you
