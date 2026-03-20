Return-Path: <linuxppc-dev+bounces-18529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF39D108B8FF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 05:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd6wN2qDSz2yYq;
	Sat, 21 Mar 2026 16:11:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774069876;
	cv=none; b=hLhRMoRC7cD/iRNB4Dtryrz4qhglLEbjy+uEn8fKCuVyjWGIiWr5ZmE0jtUIvx6AH6kvPa6KCExILlGEdtzgFzZwczwm7hZYuWQCVRJtKVQh5u0Su6bqt6x4gbazn+XZLw7Psri6GvTcoBgCcCjAJvPxQIPmqpQqoy925egyKXhHZUkeRj6EIk1ldQ1G7jhgwaVVBgIu5Dop6IHG8MlXdFVDNaG1a/IC4ofTsfjGo+Pz0T5/KKGe9RmbfJZ/wFBoiOsFjjMr6gIxcgd8aXz5xQt8LVsJqcubASDg3uM8zo01Av8zLF75IGQNluKDpoj5RF5zSuTUo1gQM8AEKIK+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774069876; c=relaxed/relaxed;
	bh=7QxDv7wA5vy2wx/iALi99txiEfbwQ3ENlpnWZYhHz0A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=JvEC/KlpFXqqt3GX4NlFis2G6J4PyUxUAvaFQTcMyMuFMh8fWn1gfb5O143bwaOsZnadPYDuwaV1yxXxCqYhiYWyou+g6izaRopNhrla5lBD3M6EiHziRaEQ9UupCSAEyYG35orWHf+iR2dEYeEbqKy58/NnVruIkGs+eBn6u5SWmaTli3mn0hv4wOaJ2ICenDQO8Qg6GkrAMD6Poff56RSy6DCq9UOOp7QmBpe+o/JWU30R/ZGd3dSrlSfKjVI1npCAj78hVfn9VdXWLowbEgB9RWKPT3FLpK9aCXiKEa/z3QUNg5q8i8JXWAn9vLZgu1lxNlLA68qnBu8PGKt3Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fUsP3+vd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fUsP3+vd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd6wM4PcXz2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 16:11:15 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c7412b07f22so1590107a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 22:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774069873; x=1774674673; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7QxDv7wA5vy2wx/iALi99txiEfbwQ3ENlpnWZYhHz0A=;
        b=fUsP3+vdyaggmKdVcOQI/Am25WLj52DkeSiJs7LQ35xxXWVWEQzUuyME/h60jTKI08
         qWn0MtAvqZjxSjpQgizC7JAokl4XXMn3bmqYLPCtVPpQlN2/G1Wbii9U2H7cYPz+3XUN
         W3R20TJGnaTSL1ptmhOcTF13W7aAiFj5ZLM+aof+MtvDig/vxs/NEbQn9P/wAxcnfo/Y
         wwlqKiu8pJUoEwe53VH05LHoMxdyrr3mT9zHhcX6IG2Iur6eAZln7bCdrwaxiXHiNEfp
         BG0HTYHtN2JPDIZcAWYeaM3x+BkuSUbrEqdLJhYPHGZuGRn1JHmFJYpma5mciF0c0eY8
         ZdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774069873; x=1774674673;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QxDv7wA5vy2wx/iALi99txiEfbwQ3ENlpnWZYhHz0A=;
        b=cXw6yz0+9E61l+Gg/UoLblRIyLNZecT0i+OvSb4V8zpbswIUhRvrHTeGQv/VM1bsXz
         N1mriaiOW3uzyh/k/t7MZ2iM6rGyugOXj+1Lsb8XV3WdC7oM/ul83UGjoQTXmMDMjDnx
         tkL22lbwjUSYdwEEynE4pdcv7OtU8LTbqtV9UoMlBTm8KcbCIZcZ20t/POS6L8DPpx+C
         9SH6ENMq1eA3auKl2ygXNW1J+eYyy71kafx4eETq5PTx6Qhc0PTNEC9+Rw/Apgeu7J0F
         dwNPet/5TMn7S+6sPML00yATvc/ACUGhTfU5D+fDQO2+eImVbqIOLN5M9WpUMyAe2Dvn
         tJXA==
X-Forwarded-Encrypted: i=1; AJvYcCUNeSwZxJxhMIkvL7ZeRerbQ/sMfuRs+AYV6xzJ4kuMJoiXrohMSxDpg7SrungQdXt6Ps94bfCQVPET/VU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyi45x4w9/q0w8YoIZvKrUtfam8uJ56guIW7cnecMttDczl2e4G
	2X32FJWPrnAEp/an+r7lg+3LiTdsezPj+9+uu4c0LXTCLnQVlMNonS7j0/LXHhtq
X-Gm-Gg: ATEYQzxwuU41Tsw8iKt8lZuIWLXrpZY6JZncyRlyfXiU2h+49kN5atXkJgoEDOGNhUQ
	WyFiAsk4rH3IvU+l9h72sRW067dF/Ekvj2ayXzfZ8mQT4OHZLd3fxix+omMFKE8d7xo+349qvmT
	5ueGSILHrKyoWWbHA2sFiBmJOw54ClXRSN2UBcDdViCOK8TSFjkQ4/kfPP7KDdP7Fix9Q/StrmG
	IvgHRQLvjNVEGWddd4RmLH6EJ4gYyQmS5dt31Ql++aUkonc6pV9CX4Tr4wPJKDoTR+r8F6aloON
	lf8BqFXXyLDkDHzGSd/Iq+TOF2faVr1RdzYxz4r2pHphx6c2XGxOZfTPDOsxej976Hs7BtI8LYC
	VYo7vjGmMrHSkHsv4lL1RkX+Vy2PU1Sv+ABYJxvQTaz42hAgh2kuX289Z5/jUxm+hEcknuIDmkG
	L+a9qD92wkJlqqA/PmyFp4RA==
X-Received: by 2002:a05:6a21:4cca:b0:39b:9c3a:f54f with SMTP id adf61e73a8af0-39bb25e7511mr8216718637.32.1774069873215;
        Fri, 20 Mar 2026 22:11:13 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a939af0sm2729778a12.16.2026.03.20.22.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:11:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: change to return bool for ptep_test_and_clear_young()
In-Reply-To: <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:27:48 +0530
Message-ID: <ikarxctf.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Callers use ptep_test_and_clear_young() to clear the young flag and check
> whether it was set. Change the return type to bool to make the intention
> clearer.
>

Right I checked all callers of ptep_test_and_clear_young(). I agree, we
only need bool here. 

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  8 ++++----
>  arch/arm64/mm/contpte.c                      |  4 ++--
>  arch/microblaze/include/asm/pgtable.h        |  2 +-
>  arch/parisc/include/asm/pgtable.h            |  6 +++---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  4 ++--
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  6 +++---
>  arch/powerpc/include/asm/nohash/pgtable.h    |  4 ++--

I looked at it because of powerpc changes, but ended up looking into all
call sites anyways. So overall it LGTM (and I agree that we can remove
the unnecessary externs from function declarations)

With that please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

