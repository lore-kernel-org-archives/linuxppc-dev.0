Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037EBC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 17:52:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5594F206B5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 17:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5594F206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P8yC4MxwzF38y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 03:52:51 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P8wB2Q66zF38n
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 03:51:05 +1000 (AEST)
Received: by mail-qk1-f193.google.com with SMTP id a85-v6so8684612qkg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 10:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7WgNnuub9beRnJPs8uto0sYpo4EQ7sW7EtJ8s1tP+As=;
 b=sG5sQL86RLWh/nnHmL99/sgTu1eI3LwT0PxyJfzodNsMyVkRhz6nWYT/YXT3xJztF2
 dhipj9RUHCP/g2pDJwrjmXzGZ5A7Ga8OVzwlqW7yVbiXW1r2GDLnT4MFgKZjp0xAtCrm
 8oFZilLF4NQ09fxLhyuY0cTrDCffrpkHMy0YkHg7MioB2/OPoAp2aq09Pt8yooHeedSb
 62mKmSa5fx3KABO8d+xttGAf3uikjBS2/04OCUPbEa7NZCFxOGAX7i/jrRwne7VvgLRJ
 Mz09iY25inU5t7cb9UXlrBfSJoEAOGZCZeZRrpumdjdzSfruoOcK9oIyzaOCu2c6cl8T
 5Xcw==
X-Gm-Message-State: ABuFfohXm80fZDVCDLLNICRa04rw3ef19qtIe/UheQXiWSra3+5VKtah
 au5FNZF63USKmejzovpSbO4=
X-Google-Smtp-Source: ACcGV61jOO/roXXnUYOZHwCOoLFqL9C0CrmALe/u6WJhA3YBOAft9yIVCX4GdreI0Jeo0qwOE3b11w==
X-Received: by 2002:ae9:ea1a:: with SMTP id
 f26-v6mr8941672qkg.210.1538416262756; 
 Mon, 01 Oct 2018 10:51:02 -0700 (PDT)
Received: from [10.0.0.8] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id y7-v6sm6900599qkf.38.2018.10.01.10.51.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Oct 2018 10:51:01 -0700 (PDT)
Subject: Re: [RFC PATCH 11/11] selftests/powerpc: Adapt the test
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-12-git-send-email-leitao@debian.org>
 <b544029461059473cb7b8b6c66815a3ff31ec540.camel@neuling.org>
 <434af377-492f-358a-b759-ab68eaeccb3c@debian.org>
 <e852ee2d7f960efc7d28c5fb7c9ea782b2f87856.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <9cde3619-b0d8-4f97-f87d-e4c0f74bab1f@debian.org>
Date: Mon, 1 Oct 2018 14:50:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e852ee2d7f960efc7d28c5fb7c9ea782b2f87856.camel@neuling.org>
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

On 09/28/2018 02:25 AM, Michael Neuling wrote:
>> Perfect, and if the transaction fail, the CPU will rollback the changes and
>> restore the checkpoint registers (replacing the r3 that contains the pid
>> value), thus, it will be like "getpid" system call didn't execute.
> 
> No.  If we are suspended, then we go back right after the sc. We don't get
> rolled back till the tresume.

Yes, but the test code (below) just run tresume after 'sc'. i.e, the syscall
will execute, but there is a tresume just after the syscall, which will cause
the transaction to rollback and jump to "1:" label, which will replace r3.
with -1.

So, the difference now (with this patchset) is that we are calling
treclaim/trecheckpoint in kernel space, which will doom the transaction. It
was not being done before, thus, the test was passing and it is not anymore.

Anyway,  the other way to check for it is calling 'blr' just after 'sc' (
before 'tresume.'), and then tresume after checking if pid == getpid().

If you prefer this method, I can implement it.

>> For this test specifically, it assumes the syscall didn't execute if the
>> transaction failed. Take a look:
>>
>> 	FUNC_START(getppid_tm_suspended)
>> 		tbegin.
>> 		beq 1f
>> 		li      r0, __NR_getppid
>> 		tsuspend.
>> 		sc
>> 		tresume.
>> 		tend.
>> 		blr
>> 	1:
>> 		li      r3, -1
>> 		blr
>>

Thank you!
