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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9E9C433E7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 03:48:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9DA207BC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 03:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcx5Qbzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9DA207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CDQq70BtQzDqdP
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 14:48:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=sandipan.osd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Xcx5Qbzs; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CDQnD5YgbzDqdX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2020 14:47:06 +1100 (AEDT)
Received: by mail-pj1-x1044.google.com with SMTP id gv6so3666154pjb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZPkmKn8mxw7N+wK3UCIAsFubQ4jPHnLsfnZJ8m/1Ytc=;
 b=Xcx5QbzsP6K6he+EIcSLDyrie5tjlykpUyJO+XaMTYxzXjGCM4ry93UwXgj1XMD2WO
 fvLNGXpVuHu/rO6kdXoO7RtE652oNb/xTcuxKDCHq6OTL3qTyW0+Vj95KFpyuEdl4BeB
 xHklQyBbX9FQH9gIIfWlFdedZcuvvU2cVhEzbMsGpYZUDVvJSV1ot78ePsdoVK1r0efk
 m/b06d3QTQ7OCyCfIoyrSMyurAOhWcOAPBWHQP/n4QE4ds+/3O1bugEsR7xpujg14DBs
 dZvoyvYyc2glyqkk72GcoFaVE6ZP2JiLssZ45/MPdigzMtqUura3aOl/a0qkjV0cZ6nZ
 tjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZPkmKn8mxw7N+wK3UCIAsFubQ4jPHnLsfnZJ8m/1Ytc=;
 b=DnAF7+TnMqbDt+U9OqOUZRphrqA4XJEFhBHYZETSHDAORKPy/mfNe2KuKLY691Js4Z
 joicXdyv4h7z+ire2DMOgHtQEfe2rYa62O+wMml5kt0EudHCDzNlNdExmvO7QhmtELCG
 PeOaVE9MUbKLneL+WY5vki+mYRJMOADQx8lLlIRBBPVFrckcqP9RPfhh5VeCx88Z6PPJ
 JH9zxBT4BtcjcqdlYIiR1svFnpatAGSnqe5TrYMFK2asU0jwQg5xhGuSVQ3+cwjux5Ws
 mgsG9/EptvqLhAS4x9y+LQN7lk6ZcwFKjXIGvMrsy/4FWhJToC7voZfbDMPIKQ3XXbqu
 3VWg==
X-Gm-Message-State: AOAM531aLui8vDyaSrU/HSFto6Izf2a6BANQW5ozWVrsKu0EnNP/uUZo
 XwW9zjOngC1thfmhMovowdc=
X-Google-Smtp-Source: ABdhPJwJ/uPrDaK7tm1LKFMetblJ3hoHnoMOlz9pFTzwWFpd6vA9y4Fz55u0u8smIiuKTTPYJM0FFg==
X-Received: by 2002:a17:902:d211:b029:d3:c8b3:4aa4 with SMTP id
 t17-20020a170902d211b02900d3c8b34aa4mr11798802ply.43.1602992823670; 
 Sat, 17 Oct 2020 20:47:03 -0700 (PDT)
Received: from [192.168.0.102] ([49.207.205.150])
 by smtp.gmail.com with ESMTPSA id h4sm6917470pgc.13.2020.10.17.20.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 20:47:03 -0700 (PDT)
Subject: Re: [PATCH v5 09/23] powerpc/book3s64/kuap: Use Key 3 for kernel
 mapping with hash translation
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20200827040931.297759-1-aneesh.kumar@linux.ibm.com>
 <20200827040931.297759-10-aneesh.kumar@linux.ibm.com>
From: Sandipan Das <sandipan.osd@gmail.com>
Message-ID: <d1329cf8-341d-4331-4160-83de1249446e@gmail.com>
Date: Sun, 18 Oct 2020 09:16:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827040931.297759-10-aneesh.kumar@linux.ibm.com>
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
> This patch updates kernel hash page table entries to use storage key 3
> for its mapping. This implies all kernel access will now use key 3 to
> control READ/WRITE. The patch also prevents the allocation of key 3 from
> userspace and UAMOR value is updated such that userspace cannot modify key 3.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  .../powerpc/include/asm/book3s/64/hash-pkey.h | 24 ++++++++++++++-----
>  arch/powerpc/include/asm/book3s/64/hash.h     |  2 +-
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 +
>  arch/powerpc/include/asm/mmu_context.h        |  2 +-
>  arch/powerpc/mm/book3s64/hash_4k.c            |  2 +-
>  arch/powerpc/mm/book3s64/hash_64k.c           |  4 ++--
>  arch/powerpc/mm/book3s64/hash_hugepage.c      |  2 +-
>  arch/powerpc/mm/book3s64/hash_hugetlbpage.c   |  2 +-
>  arch/powerpc/mm/book3s64/hash_pgtable.c       |  2 +-
>  arch/powerpc/mm/book3s64/hash_utils.c         | 10 ++++----
>  arch/powerpc/mm/book3s64/pkeys.c              |  4 ++++
>  11 files changed, 37 insertions(+), 18 deletions(-)
> 

Reviewed-by: Sandipan Das <sandipan@linux.ibm.com>
