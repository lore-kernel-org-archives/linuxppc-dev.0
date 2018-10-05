Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A190FC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:47:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E39C208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTCCdqVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E39C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rmcy0rjFzF3dW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 09:46:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="LTCCdqVa";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RWgP1MT5zDqlD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 00:03:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="LTCCdqVa"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42RWgN6Ls6z8tQB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 00:03:12 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 42RWgN51yQz9s7W; Sat,  6 Oct 2018 00:03:12 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=jannh@google.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="LTCCdqVa"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42RWgM0wR6z9s4V
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2018 00:03:10 +1000 (AEST)
Received: by mail-ot1-x342.google.com with SMTP id o13-v6so12792469otl.4
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Oct 2018 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LMlA8ceh8GGu9wycFMaq7ciltZVRspE/kRUK3YOk+Wc=;
 b=LTCCdqVaIw4LPPpo4mnC4uhs9DudlareuUBxdR7fs619oMjTKu+VxKhEAm2ISoy1C4
 cV1pAAp0IjXyX26diJY/pp9Y8rct2HJ5GQ6ILdGWnKXPCpFXWLWCmDPtr07uyF7mLEFg
 szM0vdxrilPkkK2fKOwNz6VWv/rVm1huvJKDzsB1L2QLU6YvB6R5MZeTv1L5KXRhDbxr
 XoSFMd5UWZ57ZzhWuy5Zj/Poc7FgIkAIE7bkpOTCvk6KKcs5fpyaxO8lf3QydF3NHyIT
 UjvNTIou1FWBpzHJMvU6jfdnrKEIRPTy9HMJL1M2Fnrs/et7ExLZqGJHmA3UU4hUj5Sk
 VUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LMlA8ceh8GGu9wycFMaq7ciltZVRspE/kRUK3YOk+Wc=;
 b=PlWl1hCzp/l8qY+7x3B523Va+jx68F8fpiDS1j3sK3nuNAXzOWnedYkTi+kujI+kHs
 P6QUY7JMw1+Hpw2ocgE4EwexqQXCuDiCjRPYfx6J7OJpN5v45iI8PAsxbZsnw3xUjmn+
 S7cfsCp6ZFGj3cXOcD//awyYEiyNMwCTcf7lea7E+WqYXKyPYTrXYaEx1zf4a9nlEWyQ
 yeTGmBV+PXqdU6/qlLwreZsFd6Qft2EaX/YuQ8m+iDo4M7ypsVioawTZ+7ikYp9w5o7n
 T3gOFGp4nqx597DLsmzrnTxnJGZRpGTnn+ZdQfp2lFF0Ct+lIZEvk1bqCwQL0mAMtIlB
 hfCQ==
X-Gm-Message-State: ABuFfojJP2ghaeNYUGIRyoCFPwf43Jia1tvPwsjvkJEq42eovMgQfQ7p
 S7RzWmFvN335BbTVSWgrArqyT9yFM+wFNFrovGbFyg==
X-Google-Smtp-Source: ACcGV615ViuYEz7HPIbNlvwPFlVqMWyasMafuOu08HtqXIapS3v7Kc7ANngsaRpka0+LUqWrH8KX98v0vNmMdc8rsLc=
X-Received: by 2002:a9d:2117:: with SMTP id i23mr6358207otb.230.1538748188572; 
 Fri, 05 Oct 2018 07:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181005132123.6038-1-mpe@ellerman.id.au>
In-Reply-To: <20181005132123.6038-1-mpe@ellerman.id.au>
From: Jann Horn <jannh@google.com>
Date: Fri, 5 Oct 2018 16:02:42 +0200
Message-ID: <CAG48ez3OZ5iquQeeqsy_SaLQF04hf6kphTSuP=OfsWC35G+TbA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 06 Oct 2018 09:42:00 +1000
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
Cc: linuxppc-dev@ozlabs.org, muriloo@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 5, 2018 at 3:21 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Recently we implemented show_user_instructions() which dumps the code
> around the NIP when a user space process dies with an unhandled
> signal. This was modelled on the x86 code, and we even went so far as
> to implement the exact same bug, namely that if the user process
> crashed with its NIP pointing into the kernel we will dump kernel text
> to dmesg. eg:
>
>   bad-bctr[2996]: segfault (11) at c000000000010000 nip c000000000010000 lr 12d0b0894 code 1
>   bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a10028 38810020 fb810050 7f8802a6
>   bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b79> 4082002c e8010080 eb610048
>
> This was discovered on x86 by Jann Horn and fixed in commit
> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on usermode RIP").
>
> Fix it by checking the adjusted NIP value (pc) and number of
> instructions against USER_DS, and bail if we fail the check, eg:

This fix looks good to me.

In the long term, I think it is somewhat awkward to use
probe_kernel_address(), which uses set_fs(KERNEL_DS), when you
actually just want to access userspace memory. It might make sense to
provide a better helper for explicitly accessing memory with USER_DS.
