Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74F3C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 19:33:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1EB2085B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 19:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1EB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qKV50cdJzF3Dv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 06:33:49 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qKS05qBYzF3DL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 06:32:00 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so4006571qtj.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 11:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bol+1sd/y0yWgVrSDHnvUJ4i+sEtZfe/tLozo1tHVVw=;
 b=ngFG+/84FgBDvjhWj151iFjO1Gd9TKlBCiqfIlGtd7c50XI4pRdraARFJPF+0opoVW
 aR8c12qBnfglDyoZNMv/U/Yg8SC4fTATaWHOlvPPbfy3ZGzIiMOL22jhx/fEezoOaWcs
 +O7m4F8TgEbGCgldz8fI3xwsnJ1+bmYmU4cRjeEMhOhKsQ7Y8+biRNjgNF13opUxicyp
 VY+kVsHmqdJnwSYxfv8WtjUbVhX6TD6umOdKLrT0G7QvdtbvUUgflX9Ip48ZVW1aBj4i
 C1aZq0boP7BJH3chhNpIH6mEhlXaGWUR3g++DNCTxR08ZqoQhOdZDsBRpzm7pvrC+mFU
 khyQ==
X-Gm-Message-State: AGRZ1gJ9dWL8Lq+EDosEF7Jfzpx9+ZevlxARVs7srZyGDJBc4NbG54KK
 1lWuh2DVAAXyqDw93eMyt5Y=
X-Google-Smtp-Source: AJdET5cjRLzV9hd4Vd7+XQUDhwG4JKWAk6oghewhHr2zi787LuAPxQee7oJGF+LezWw/fPO01eGz2w==
X-Received: by 2002:a0c:ade7:: with SMTP id x36mr26161803qvc.66.1541532718346; 
 Tue, 06 Nov 2018 11:31:58 -0800 (PST)
Received: from [9.18.239.97] ([32.104.18.203])
 by smtp.gmail.com with ESMTPSA id 5sm12078930qkv.93.2018.11.06.11.31.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Nov 2018 11:31:57 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/14] New TM Model
To: Florian Weimer <fweimer@redhat.com>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <87zhumkqfa.fsf@oldenburg.str.redhat.com>
From: Breno Leitao <leitao@debian.org>
Message-ID: <12883814-0100-91dc-3aac-84b689f82273@debian.org>
Date: Tue, 6 Nov 2018 17:31:55 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87zhumkqfa.fsf@oldenburg.str.redhat.com>
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
Cc: mikey@neuling.org, gromero@linux.vnet.ibm.com,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>, ldufour@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Florian,

On 11/06/2018 04:32 PM, Florian Weimer wrote:
> * Breno Leitao:
> 
>> This  patchset for the hardware transactional memory (TM) subsystem
>> aims to avoid spending a lot of time on TM suspended mode in kernel
>> space.  It basically changes where the reclaim/recheckpoint will be
>> executed.
> 
> I assumed that we want to abort on every system call these days?
> 
> We have this commit in glibc:
> 
> commit f0458cf4f9ff3d870c43b624e6dccaaf657d5e83
> Author: Adhemerval Zanella <adhemerval.zanella@linaro.org>
> Date:   Mon Aug 27 09:42:50 2018 -0300
> 
>     powerpc: Only enable TLE with PPC_FEATURE2_HTM_NOSC
>     
>     Linux from 3.9 through 4.2 does not abort HTM transaction on syscalls,
>     instead it suspend and resume it when leaving the kernel.  The
>     side-effects of the syscall will always remain visible, even if the
>     transaction is aborted.  This is an issue when transaction is used along
>     with futex syscall, on pthread_cond_wait for instance, where the futex
>     call might succeed but the transaction is rolled back leading the
>     pthread_cond object in an inconsistent state.
>     
>     Glibc used to prevent it by always aborting a transaction before issuing
>     a syscall.  Linux 4.2 also decided to abort active transaction in
>     syscalls which makes the glibc workaround superfluous.  Worse, glibc
>     transaction abortion leads to a performance issue on recent kernels
>     where the HTM state is saved/restore lazily (v4.9).  By aborting a
>     transaction on every syscalls, regardless whether a transaction has being
>     initiated before, GLIBS makes the kernel always save/restore HTM state
>     (it can not even lazily disable it after a certain number of syscall
>     iterations).
>     
>     Because of this shortcoming, Transactional Lock Elision is just enabled
>     when it has been explicitly set (either by tunables of by a configure
>     switch) and if kernel aborts HTM transactions on syscalls
>     (PPC_FEATURE2_HTM_NOSC).  It is reported that using simple benchmark [1],
>     the context-switch is about 5% faster by not issuing a tabort in every
>     syscall in newer kernels.
> 
> I wonder how the new TM model interacts with the assumption we currently
> have in glibc.

This new TM model is almost transparent to userspace. My patchset basically
affects where recheckpoint and reclaim happens inside kernel space, and
should not change userspace behavior.

I say "almost transparent" because it might cause some very specific
transactions to have a higher doom rate, see patch 14/14 for a more detailed
information, and also a reference for GLIBCs "tabort prior system calls"
behavior.

Regarding Adhemerval's patch, it is unaffected to this new model. Prior to
kernel 4.2, kernel was executing a syscall independently of the TM state,
which caused undesired side effect, thus GLIBC decision to abort a
transaction prior to calling a syscall.

Later, kernel system call mechanism was aware of the TM state, and this GLIBC
workaround was not necessary anymore.

More than that, this workaround started to cause  performance degradation on
context switches, mainly when TM facility became lazy enabled, i.e, the TM
facility mechanism would be enabled on demand (a task uses TM explicitly).
This happens because this "abort prior to every system call" workaround
started to trigger the TM facility to be enabled for every task that calls
system calls.

In fact, I was the one that identified this performance degradation issue,
and reported to Adhemerval who kindly fixed it with
f0458cf4f9ff3d870c43b624e6dccaaf657d5e83.

Anyway, I think we are safe here.

Thanks for bringing this up.
Breno







