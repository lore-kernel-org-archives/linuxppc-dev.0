Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B51ECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:01:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E6B2081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rQ1f1bRGzF3Qn
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 01:01:26 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rPz90Vx3zF3P1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 00:59:16 +1100 (AEDT)
Received: by mail-qk1-f193.google.com with SMTP id y16so25341923qki.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 05:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HEbdqYE9zkR4dfr2fg3xE2ZDioBzmagWmjY0LRTGCNI=;
 b=ahxgjVJ+lCI/No7/oQ2qGzIXcBKZYk5b8gyPkCkdYk7LfdCQUqXWCsLQRb4J4bRO9k
 /r1u7dZYNCtWA8mJJFr+5eHxu8s+fpPCntb8DcFx80ZeluGMlUUVfrERzhCuzthH+Byq
 Cq80peX7g1fYzk1C7KiqCYCvRIdPUSzcU5Ew2iTAqo/c33J0bXPN9X1V0bhXP/WR5uC0
 tZk2AG/0amt84p59Eckxbuz+d1WzS+a5cFVCKzok0DNcjw6vq667Wbc7mr8oqHiFx3+D
 82K5NSi5//Aq8dhWyg7zyBTxovgsC5S+atp6CZpc7sbQUVdtBuzI3dniZgZ2eR8/JOCg
 smCQ==
X-Gm-Message-State: AGRZ1gKaQccca0yfRwAOJe/btYVPlzyAt3gKuxlyuGadUjmf1hM+JjTR
 aLQi2TxzEB7w1kdxK/vvIN4=
X-Google-Smtp-Source: AJdET5fqR83DeT0n89SK+4jwnLbLnD0YjV8D6yuAnKJDnVaECsf5T2i+GrTN1P28r6qOOgdCW+8IIg==
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr4467119qti.336.1541685554456; 
 Thu, 08 Nov 2018 05:59:14 -0800 (PST)
Received: from [9.18.239.97] ([32.104.18.243])
 by smtp.gmail.com with ESMTPSA id z8-v6sm1962298qto.71.2018.11.08.05.59.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Nov 2018 05:59:13 -0800 (PST)
Subject: Re: [PATCH] powerpc: Mark variable `cpumsr` as unused
To: Mathieu Malaterre <malat@debian.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>
References: <20181107202641.7865-1-malat@debian.org>
 <d3ba180c-9ab1-d204-7a62-0563ecabad70@c-s.fr>
 <CA+7wUsz8TVtOuSvmWVGeZmPKGvxFhHy2mVSKex4REFs9uGb_xQ@mail.gmail.com>
From: Breno Leitao <leitao@debian.org>
Message-ID: <1b62012a-1c59-ef62-117f-ec04fa47a815@debian.org>
Date: Thu, 8 Nov 2018 11:59:11 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+7wUsz8TVtOuSvmWVGeZmPKGvxFhHy2mVSKex4REFs9uGb_xQ@mail.gmail.com>
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
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mathieu, Christophe

Thanks for spotting and fixing this bug.

On 11/08/2018 05:25 AM, Mathieu Malaterre wrote:
> On Thu, Nov 8, 2018 at 7:09 AM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>
>>
>> On 11/07/2018 08:26 PM, Mathieu Malaterre wrote:
>>> Add gcc attribute unused for `cpumsr` variable.
>>>
>>> Fix warnings treated as errors with W=1:
>>>
>>>    arch/powerpc/kernel/process.c:231:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
>>>    arch/powerpc/kernel/process.c:296:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>
>> I don't think this is the good way to fix that. This problem was
>> introduced by commit 5c784c8414fb ("powerpc/tm: Remove
>> msr_tm_active()"). That commit should be reverted and fixed.
> 
> I see, it makes sense.
> 
>> That commit should have removed the macro and kept the inline function.
> 
> Breno, what do you think ?

Turning this macro into a function might cause the code to be more confused,
since all the other TM states bits are checked using a macro, for example:

 MSR_TM_SUSPENDED     Checks if the MSR has Suspended bits set
 MSR_TM_TRANSACTIONAL Checks if the MSR has the transactional bits set
 MSR_TM_RESV          Checks if the MSR has the TM reserved bits set	

That said, I understand that it makes sense to have an uniform way to check
for TM bits in MSR, thus having a MSR_TM_ACTIVE macro to check for the active
bits. Using a non-uniform function just to fix this warning seems to be an
overkill. Reverting the patch seems to bring back the old style, which is
having a macro and a function with the same name, where the function just
calls the macro.

Anyway, I think it might have other ways to fix warning, as I can think now:

 1) Avoid setting cpumsr if CONFIG_PPC_TRANSACTIONAL_MEM is not enabled

 2) If !CONFIG_PPC_TRANSACTIONAL_MEM, redefine MSR_TM_ACTIVE(x) to something
as (x & 0) instead of 0.

 3) Avoid double definition of MSR_TM_ACTIVE, i.e, have the same definition
independent of PPC_TRANSACTIONAL_MEM being set or not.

Anyway, I would like to try option 3), which is the hardest one to implement
and validate, but it seems to be the most correct option, once it checks for
a MSR bit configuration, and the caller should have the logic.
