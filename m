Return-Path: <SRS0=pDMz=DZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99167C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 03:54:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF84721D47
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 03:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMIxmEy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF84721D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CDQx26pWCzDqWt
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 14:53:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=sandipan.osd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BMIxmEy+; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CDQsg64CHzDqdb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2020 14:51:03 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id w11so3281612pll.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t195MLn3b23APVSUdeShfpvxsIZOuaM9Jk2CSnLLHdM=;
 b=BMIxmEy+GZm/hp2MXv6DzpzjlJvbbVhKUg2qa+shaZrz5Ntr6LHu/zWZfRwOwAsJmy
 sf3aCmtzbxsWrQ609I+ujuHP4EZWBAZMQscqsedqvS3Y4CqdszeWRzXB5OlUEIQRpBvm
 sF7dSUG1hgr3qFlKLJWtZwiHp4G/3eRSrXe52mZlHr93HbXsHVZUJEsXVOfSEZByuewc
 SK1fRmA7IMn7P8rV11bxnvbKTd5Sl0ql5CppZC0GyjfPlvTSk57x3Z55WuaxSKo2aNzs
 ct4dVT9Q5KFfW9Tb8IrTu8bgfji2jVjRXMq7cAplIPvGgnKLANTdPYjsrK4OlA5j+aOb
 etOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t195MLn3b23APVSUdeShfpvxsIZOuaM9Jk2CSnLLHdM=;
 b=meh8vtl6BvwTdzR8vOjurpJB4Ct5kODOAj7DPO/PulJzjSUTU3L4x1r0IsYk/0W6pJ
 uOOg6ktOx+8BO9mXjv6JbI61WBdj8mbBKozJI594TLJinaCPrXm9jeXwM/N77dpL4d3R
 gnzP4DJv364vnqESFBxJ6VMGf6TkalC2Mpx5O8zJvfaD7I3j7GnQsznwaUzYByfNo7fp
 fEkI2vc9m7u4Uu5elmCFmCQr4cdF35tegRH8JCnuc2VjbolLqS5JoBso37RhzztVYuBA
 psrlWwOaQUzJUGgagKGnaQJnJiqws65Dc7lahAAaM+r8EXLeJBpb9MbG0mMiMORBZBu2
 6s6g==
X-Gm-Message-State: AOAM532L1LrNtJF7BlFuG7VCcBpfe6gUlldI0N8jAWrdh1zbEeLSAtmz
 JkY8QwxwW/vlkwSxYP/VqM4=
X-Google-Smtp-Source: ABdhPJx45gLTioHx/szy7KOr+wFvUXSxOx+FrqHUXQHfsbFQeaxPOA+nYlbd6BsZrGjKnmD11C9bKQ==
X-Received: by 2002:a17:902:bcc1:b029:d3:9bdf:32e3 with SMTP id
 o1-20020a170902bcc1b02900d39bdf32e3mr11304338pls.1.1602993060622; 
 Sat, 17 Oct 2020 20:51:00 -0700 (PDT)
Received: from [192.168.0.102] ([49.207.205.150])
 by smtp.gmail.com with ESMTPSA id r6sm7689447pfg.85.2020.10.17.20.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 20:51:00 -0700 (PDT)
Subject: Re: [PATCH v5 12/23] powerpc/book3s64/pkeys: Inherit correctly on
 fork.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20200827040931.297759-1-aneesh.kumar@linux.ibm.com>
 <20200827040931.297759-13-aneesh.kumar@linux.ibm.com>
From: Sandipan Das <sandipan.osd@gmail.com>
Message-ID: <d608ada2-365b-1119-e5d0-19642ed92908@gmail.com>
Date: Sun, 18 Oct 2020 09:20:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827040931.297759-13-aneesh.kumar@linux.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 27/08/20 9:39 am, Aneesh Kumar K.V wrote:
> Child thread.kuap value is inherited from the parent in copy_thread_tls. We still
> need to make sure when the child returns from a fork in the kernel we start with the kernel
> default AMR value.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/kernel/process.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Sandipan Das <sandipan@linux.ibm.com>
