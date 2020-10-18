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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E666DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 04:02:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC9921D47
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 04:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM39GmhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC9921D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CDR6S2sw8zDqfB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 15:02:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=sandipan.osd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=TM39GmhE; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CDR4K3NgSzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2020 15:00:15 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id gm14so3485547pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 21:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2slP0j21/XFlLU0lQts0wjebti5IaQeN6EXj2Rojyok=;
 b=TM39GmhEBd4vHB4EDpUMVFlijFiReB7VhIQyk06DWa/VaPyq/AKDBBbRNTS4SyQ+Sb
 4Hxyogk9FBoEAEev4YsTxDLPvWM2PdEPnMSyXjwcMMOkIYLacOKycRbDvwsgmwstiqOl
 fjhpVe7dRvrDUlN7KV+WX89lYwaZQF4Kfms8GnETewroeic+jU3lBmgm57ff+0m9n5XB
 6RcRzXBlb2ByZT5h6ZdVojSuZw8hdutvJSMYORO5EmW3mFyU+iYilPISUkBqygFmG+Vh
 peCFbKN6TelIkspzN/E84V26fvgwB4OaJBdO2dWVDEn2V7JYsXlrkQvjE4Gg2yBYO3gf
 H96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2slP0j21/XFlLU0lQts0wjebti5IaQeN6EXj2Rojyok=;
 b=DMPB9mCplb1ZWO4azZFwNS1i6iJ166IRJry3kmzaZeReML+DN8sAF6S9Ey0SlzIaFD
 rXmjtIW4RpSyD6hAlKwu53lTsupxa3wLM3E1eTJipUiwMGmL+DcUHyQ9aRxKZVVCJYXe
 vCCxqTFJlML08uh2HTpHQDp3GcOelvUosPSm8Ptq0n3KkOgjA/R6lgmidDelzD1S3jsE
 pbaWCtITfN8CtvfdNNr14r/b9qBkmCl5cXZEfJrnm8BzZGG7i/Pw9fwLmoC0XB1jmTEd
 kPwxuP0akJmciyt8t+LczoGEsZfIhz/oJYtce0FA4uPJFqPcIOy2s/ESqU7QM2kMD1Xn
 0Ifg==
X-Gm-Message-State: AOAM533+OcajO0wkD+bRTc3lBGssZfrw02O6lQJzbH3B7kfRtQdFHKBf
 HDXCGZLrfZSc1TuZ96ReFVQ=
X-Google-Smtp-Source: ABdhPJxhVrLogIx3QXsTMEpRCKbJ7dJlqkOHqTqPJOEbmGL9GKhGe4sn1K6rs1WELJvhyOO29EaQWg==
X-Received: by 2002:a17:90a:2e0f:: with SMTP id
 q15mr11537559pjd.29.1602993614134; 
 Sat, 17 Oct 2020 21:00:14 -0700 (PDT)
Received: from [192.168.0.102] ([49.207.205.150])
 by smtp.gmail.com with ESMTPSA id l18sm7461487pfd.210.2020.10.17.21.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 21:00:13 -0700 (PDT)
Subject: Re: [PATCH v5 16/23] powerpc/book3s64/kuap: Restrict access to
 userspace based on userspace AMR
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20200827040931.297759-1-aneesh.kumar@linux.ibm.com>
 <20200827040931.297759-17-aneesh.kumar@linux.ibm.com>
From: Sandipan Das <sandipan.osd@gmail.com>
Message-ID: <7c490811-8858-a354-b573-f2f4f73e4ba5@gmail.com>
Date: Sun, 18 Oct 2020 09:30:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827040931.297759-17-aneesh.kumar@linux.ibm.com>
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
> If an application has configured address protection such that read/write is
> denied using pkey even the kernel should receive a FAULT on accessing the same.
> 
> This patch use user AMR value stored in pt_regs.kuap to achieve the same.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/kup.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Sandipan Das <sandipan@linux.ibm.com>
