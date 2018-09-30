Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1482EC004D2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 23:53:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D18206B7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 23:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D18206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Nj0B0gP8zF37n
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 09:52:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NhyG64hzzF35y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 09:51:18 +1000 (AEST)
Received: by mail-qt1-f193.google.com with SMTP id x23-v6so12265272qtr.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 16:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hopShcAgampKd1H4M0GHXigLiv3HWr8avHiojBaRuW4=;
 b=k+vkJ/hXvAmKIQGtOmGSfYOwP+h7UGw0xaFrjNtylgg+oNewJbdudnQpN63QEkIvys
 cRF57lIgLsJUC5ztVB3XgMu2lRhr8HQUAUAhUOK8rzrUSaEKEbudSTLfIqeNgVX/3iKF
 Im428d/XJrzgeEZhGy0zkLkrrQxlfgsYf4B9F6rbwVusPtVJNarZAv7DOHn4zh9Utt1z
 uPIO/IqmI+yME2D9XDJqGZ6Q1waijZIDn/Q0e8fabkO/QzjgBcE/Bt5lUYkdzvP+ySJj
 +LIkscYG3BnxvGlhngRJM1yu1CvzMu9FdmFXHfUiT6EHabNr3P6r8TQFrtByUQGEcWqp
 M6oQ==
X-Gm-Message-State: ABuFfohD0xgZNXmuPKKD0bddP9YrYUkXc9qneL6NSYqx59EMjhTDLSti
 QF/fagiPrj9glYsP8vIJP1E=
X-Google-Smtp-Source: ACcGV62RFYE8C0jTocN9zhaazCYM6yrJJ6HATTKVLdTMQwZ4sHdqsKupkIcuiFbv3QpUykkxVQm9nQ==
X-Received: by 2002:ac8:4a11:: with SMTP id
 x17-v6mr6625905qtq.232.1538351475998; 
 Sun, 30 Sep 2018 16:51:15 -0700 (PDT)
Received: from [10.0.0.8] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id l43-v6sm390312qtc.80.2018.09.30.16.51.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Sep 2018 16:51:15 -0700 (PDT)
Subject: Re: [RFC PATCH 08/11] powerpc/tm: Do not reclaim on ptrace
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-9-git-send-email-leitao@debian.org>
 <743b29dab736700c1b284fabb8fccf7c83ddb3c2.camel@neuling.org>
 <18dcf8b7-1001-d6cc-1847-af9c679f9435@debian.org>
 <ceb1c2179b62ff0d418c727d9f016bb854578252.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <64e4d511-bfe6-fe37-1145-eed90939d079@debian.org>
Date: Sun, 30 Sep 2018 20:51:09 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ceb1c2179b62ff0d418c727d9f016bb854578252.camel@neuling.org>
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

On 09/28/2018 02:36 AM, Michael Neuling wrote:
>>>> +	WARN_ON(MSR_TM_SUSPENDED(mfmsr())); + +	tm_enable(); + 
>>>> tm_save_sprs(&(tsk->thread));
>>> 
>>> Do we need to check if TM was enabled in the task before saving the
>>> TM SPRs?
>>> 
>>> What happens if TM was lazily off and hence we had someone else's TM 
>>> SPRs in the CPU currently?  Wouldn't this flush the wrong values to 
>>> the task_struct?
>>> 
>>> I think we need to check the processes MSR before doing this.
>> 
>> Yes, it is a *very* good point, and I think we are vulnerable even 
>> before this patch (in the current kernel). Take a look above, we are 
>> calling tm_save_sprs() if MSR is not TM suspended independently if TM
>> is lazily off.
> 
> I think you're right, we might already have an issue.  There are some 
> paths in here that don't check the userspace msr or any of the lazy tm 
> enable. :(

I was able to create a test case that reproduces this bug cleanly.

The testcase basically sleeps for N cycles, and then segfaults.

If N is high enough to have load_tm overflowed, then you see a corrupted
TEXASR value in the core dump file. If load_tm != 0 during the coredump, you
see the expected TEXASR value.

I wrote a small bash that check for both cases.

  $ git clone https://github.com/leitao/texasr_corrupt.git
  $ make check

Anyway, I will propose a fix for this problem soon, since this whole patchset
may delay to get ready. Is it OK?

Thank you





