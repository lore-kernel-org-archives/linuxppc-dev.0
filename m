Return-Path: <linuxppc-dev+bounces-22923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA89CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 09:07:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkzjn0HJ1z2y71;
	Tue, 23 Jun 2026 19:07:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782205660;
	cv=none; b=M/MqyGfMt6hxjBYoUfDt+fbzIj1GGYLH9ZXqmA0+zPoI52xgFneiUw6s9fIjQ9ZEE16OdzesxnqBo9b4oYrv0z0JXtCIb13wRNxAa8IseTezJZCxpM8qPQGBlzDWihCoMHZAwQZmEsq0f8tVLnYkhzeyZshcZBZXDnng9yrRdbnqQHghE8z29sDOoaje+cdGvT2Bq3WIDN8kfUBAN4YA+rYFBVIe1EZ2Q0oyNTESAQQTQb1lEWvq+rnUVoLahin4y3lo470TKhAr9XFloHk0OO4myWjs2lkXf2XXdwMk61sA9KQ1aBVf/BMNVw0c8feGEPD4qwf8e2BufWF1uba73A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782205660; c=relaxed/relaxed;
	bh=6spHrHgBqIXLs3oShth/eK080eFpchGrRDS7859a1QY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=E99wyC/dHRBM2UcJI4IYLIFesv/blZlgLyJ6xW4ky0NhC6Oi382z0RFvDRtENEYdg4CWaFiwNPJvHtiXC+IXepnFtt3rbBwbe42TK8dUz8B7+8xWoaABWmGhrxfA3/cFCabBUC58f5SfKd4JF/ToGo+Wjcc0uNY99Z/BkD1grDA4f2hzFK5LU5Ich4KVBt1RM2nmTEsPNAm4xr5AHZJ84VDNdO2YCzXYC72qWP6gzFNmWbdEjOhISDWdr19b9Ul4K1szMqrRglkG6vhNkuPtPheRr2w03kPu+iM2NT3jXMhUNPzrXBFdvH+ueL0REYSLxIkBV4hQWTApzdhG/Zxcjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rTEemk5I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rTEemk5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkzjl2TkFz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 19:07:38 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so3756745a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782205655; x=1782810455; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6spHrHgBqIXLs3oShth/eK080eFpchGrRDS7859a1QY=;
        b=rTEemk5Izdk4FpcPjw4XSz7NijrFGMN9rx+3Do5aXdQh6rNnLnJQWFcNL0ZK1ezX8k
         rq+i3a1MNRjQuAig/syOvU519yzu7i/DX5i+RAXwQcLbtYz/AR4eou3ScoDhApWG7Y8i
         hCykUq5Yb+x8cNNq5Dk8OJdJWy0t5bz1soY+oCT124Il9+f/pEyIAHKSM95NmLOTYDaL
         Mw17V+vRJ30eNopnmDEv5F0/VYGM2D+7cPxbRiyqddICpxnVEImNcjshJmCCYm00KyMb
         sse3ltCvfogu5rQ/YP0eHauTITdi+F904J67IyBRZOYtwRZPjW5N7sdz20UUpDdD6S3W
         CYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782205655; x=1782810455;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6spHrHgBqIXLs3oShth/eK080eFpchGrRDS7859a1QY=;
        b=RwWy9MTblvT+sR8HE3UAKrQ2SccRjv1BgfOK1vgl833T87s85ZMbKei5nWdoxBXtLO
         HWYtF+PPSOsc+27p8aAi9tqSqVjFbeqFNJ5lkRao8NuzLmKeiigtlJADUckhFnGjmhCd
         R+5ohYryKFElUH/xEf6lCCQSn/6kG2myvNDal9zWTJNorJDmFS7B/7hEL14U9sue0DzE
         FLMaQPxNXVxk+4g4AwIr0TeExyu/GZwKKDOc/XRbGe3VjLeBmsQISm07ZiHd2pFWPheF
         vseu5WEuyRMLiofvsRDCaeBUGmddfTSSN0GDxtMuCZcs9R+E3xxy3UqXGpxNd4GHcQ+w
         Lg0g==
X-Forwarded-Encrypted: i=1; AHgh+Rp7cU93xJBGsoUfcSjDxuOnKgxI8loNfIGO9LHQfGGGoS8znzd5usyiQO8YhXM8cOwsuYLGh5dPWaH2ZVI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3Drs3dbz91qWu36K21qVMF4eoiwjrmw54TbP7iQgv03vyzyBP
	/q3pJrfoDLK3mk4Kaeyds9ztM7uI+4O7l71zWypW05DDdFrJFCf/y/K3
X-Gm-Gg: AfdE7cnusuFsIKCiFzRTXVrScVDKvZvhXcJEZS369T+wVYEOLUl0A4QEzUIP3p7tU6G
	kpYfBOTiyBOYA+KQ7nCcXyXS/Unc4RxM1pM7FGmhnQS1tmznC3b5QINjMROmnmy2ZXpsHb72eOC
	JWAsKGx7V2hL5Vh87D5X78fmkzbktvuGp5rzMKz/bPqx3unJKP5bGuG8LEtDNVkVc/JlGJ9ePme
	mVHRK1BAI4cMJizwFtaTWJ/cSzURgDYVFADJZDbp8OUfeb7xSGJHXDR8UpkmdvHFLt4ty4q5Iwo
	oqzCaLRudS6wJlePSbd1wO2YSIUiDOtZmlgUnGLsCQ0BZwayQKsuDiXt3cfo383ALVChJS92YIp
	+efwa5cXWgpF2TP7NsIVlgTr5W8vbsIC4iAMGEwyc8TKVaaIwhUkvg7IuRg9yQB9dObRmhAsMbj
	xYpsW77WrWo2HDS1CnmspTRMEl8g==
X-Received: by 2002:a17:90b:43:b0:369:7433:2fe with SMTP id 98e67ed59e1d1-37d4d834636mr13010957a91.6.1782205655379;
        Tue, 23 Jun 2026 02:07:35 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15df7424sm12256623a91.14.2026.06.23.02.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:07:34 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Barry Song <baohua@kernel.org>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v4 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
In-Reply-To: <CAGsJ_4wFVcNi2h_=wjycYGf2eHBPY-oc8aN=-3Z4wsXnT0+LYA@mail.gmail.com>
Date: Tue, 23 Jun 2026 14:33:54 +0530
Message-ID: <zf0lwrut.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com> <ecbca3be3fa8bd7e213d013a2ec6ff9a11c6e0d1.1781843449.git.ritesh.list@gmail.com> <CAGsJ_4zxcp-jdnRTn09b8ZfxT0P7suFq3BEpyiUzA2C_iRRUGw@mail.gmail.com> <1pdxybv5.ritesh.list@gmail.com> <CAGsJ_4wFVcNi2h_=wjycYGf2eHBPY-oc8aN=-3Z4wsXnT0+LYA@mail.gmail.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Barry Song <baohua@kernel.org> writes:

> On Tue, Jun 23, 2026 at 3:12 PM Ritesh Harjani <ritesh.list@gmail.com> wrote:
>>
>> Barry Song <baohua@kernel.org> writes:
>>
>> > On Fri, Jun 19, 2026 at 12:41 PM Ritesh Harjani (IBM)
>> > <ritesh.list@gmail.com> wrote:
>> >>
>> >> THP_SWAP avoids splitting of a transparent huge folio into 32 smaller
>> >> 64K folios (Radix-64K pagesize / 2M PMD) or into 256 smaller 64K folios
>> >> (Hash-64K pagesize / 16M PMD), during swapout. This improves the
>> >> swapping performance since all the bookking & I/O submission happens
>> >> once per large folio. More details at [1].
>> >>
>> >> PowerPC Book3S64 could not enable this before because PMD_ORDER is
>> >> selected at runtime depending upon the chosen MMU. The earlier patches
>> >> in this series turn SWAPFILE_CLUSTER into a runtime value and introduce
>> >> an ARCH_MAX_PMD_ORDER upperbound override for SWAP_NR_ORDERS. With those
>> >> changes, we can now enable THP SWAP for Book3S64.
>> >>
>> >> This increases bandwidth throughput with zram backend for swapout by
>> >> 40-50% with Radix and 100-130% with Hash (Tested by Sayali)
>> >
>> > Thanks!
>> >
>> > I am curious about the contents of the anonymous memory being tested
>> > and the compression algorithm used by zram.
>> >
>>
>> I am sure it was derived from your microbenchmark itself which you had
>> shared here (so repetitive pattern) with default zram compression
>> algorithm. Thanks for that :)
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0637c505f
>>
>> I think I got your point - I can mention that it was a microbenchmark
>> similar to yours and not a real world workload test. Is this what you
>> meant here?
>
> Yep. Please make it clear in the changelog what kind of workload was
> used, as different data can result in completely different compression
> ratios and compression/decompression costs. Consequently, the reported
> swap-out and swap-in performance improvements can vary significantly as
> well.
>

Sure, I will update the changelog in the next version with more details
on the benchmark ran. Mainly planning to provide the link to your commit
for the e.g. microbenchmark code we ran along with few other details.

> w/ that, please feel free to add:
>
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks Barry for the review.

-ritesh

