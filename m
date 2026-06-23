Return-Path: <linuxppc-dev+bounces-22918-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AD7CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 07:12:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkx9K5Zj5z2yQL;
	Tue, 23 Jun 2026 17:12:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782198773;
	cv=none; b=Dj8OSMTBVdIWmdXkQjoU5JpMf+RTuvh6J4ZsWfksNutNBBT/rYxsJVNjKKGeE36MIGUZ2SQcRMa/YyVSdruqKNJzAsJZc82VXiznO72Zb8UVPiMl5n+NJWe4D4nq+eDmJ7mg4TR3q8372dpdhi0zSE9l8tXjrJ+8IwLaW+bWitU+SkNppryOosvvY2PuHnncckMLMvi2rBk9OyEzHPY1oN94WjBgVlqcoiS/3ALLe7KasixXqoHql1S4QuUzA7Zv5QGKDntA3NgrjOuNPdB+izq//VNVzt4iRBufncuJMRzgRLeV9rG8b+ZJJBYSFn8cOOY9H10GPKJzq66KoahlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782198773; c=relaxed/relaxed;
	bh=kR5ZPYKC2E79iicovREWOp2q7jMORqtJa+AUs+3teEE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=d1xizl5uNztVX2ucVc9IvXV2gsYPSVwnpARUWYEQgfbw0aHKczzHr7nN/eWrOspdkN/K4muUgCfSrG7SWy6rBr3D84KGiX0qwSGSYOHj22Okn1c9j5wjsvfWOtD/+6cgOikxq8FYAgd4Q5tJ0lJu4vj2rnd80Csj+ZmPcW1Q72jB0dL3xmM8TpIAnBQdI4G+vci9tNEQeNNGX1i+5EdeQu9pbjZgZuUe17yx66uwEJ2brA89IHL7ZygNSUP/rl0hQWRF7zTa6csF+rIM5S3mLYp9pJC1RixEa+y4GH+wq/ZWVjYWYh+tVXOT9onFUxDtjeai0cTEdsWdXKlqrRWBJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IcASu832; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IcASu832;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkx9J73Hwz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 17:12:52 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8453f568e84so5001070b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782198770; x=1782803570; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR5ZPYKC2E79iicovREWOp2q7jMORqtJa+AUs+3teEE=;
        b=IcASu832FAHCWgaaSPexy6cIKHLP9GJGZR2XfVxBcLCvaV711EuXODUOkuSjDj3PHZ
         eaZZ1+taBmaxyEr+bKly2emykZ9rqtsrs6Wj749v+UIQaEZ91cQ3V7pE0bUCDSI9BjOw
         kqvEOiXlOxdDtexgQ/HRXsc3cVogJZwjIXfSIOF05C/EShuUHke3nT0UytIkRVzS/yu2
         zyS+Jf+DHtbVgNWUeqhzkrW9thQ7sKwrWnUOucRDFFIqe6Ig9ucIa0vzmLZJL10yUQ8T
         LegL66SQ6vjqpYN11152dS2omxgh3CpUdtki2nE+DpwoH34uW+JShUwE+EAkVIsmf6SL
         tffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782198770; x=1782803570;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kR5ZPYKC2E79iicovREWOp2q7jMORqtJa+AUs+3teEE=;
        b=kOmGpnzGOJU1oqOnrkrc7CxU7sgtW0riZ5yfqwaKMoz4X1Zfm+YqU6+65FFYJrjafU
         +Dg6mUzCy5sm9QVlK7BIivHBXhk05m/N4vb5XDGsHmX4T8Rpe9wuWPm/EvZQpouah/71
         F2VwZSnsV/AD/m1bt2EMXxDxObD8h27dfGIHxxvInbcpWjPvsN1LFm1nRZsc9qUczNSf
         nymlqv/ahzGfzOrjW55jxCHLgtQoZwnSjkdcyWnfpbh9VSOSYZZgzM4a15YAiU+szwff
         /FICJabbrSSBkuH5vhiouxRvRoSTV2aTNvwF9uMPNGNf8Dfh0Cd9QvqgUK7BZlfARM1Z
         T/MQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq88iMm2cjQP27vBck2W5zZ0utKH7WhbUqf7SQpbS3XiCUPQ/SXpG9v4OvqhbnqLTuCyEy35eSOdldTibU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3k2JAffv4sfJvsguGV/i4xwZKwRy7G2lI5wJL9W5k8xhcbttm
	FpV/931BJMv4jbQXVWXk9+Jpb5y4OVhtk+8XefvypMFlSki+e4XOpfCD
X-Gm-Gg: AfdE7cnLF8dZZ/IMGUeTmiHFrp/P9ZYVJ9JZznOsgo2jsesnVbA/idTzoK/n8F3MRHH
	uyOtbrc4ttq4MN9SN8O6526V96wT8CLTzOmqykMZTft8QXhsk0QKJ4XtgqCWxw3IkU2sYmbDdCv
	YNN6nXkcoPwqKktLw6wjs/lo0axeK5S6gZ/7be4/zeqg5Bf7atMjh6WquXjqBgKecZ986KIFKhi
	xAI4bFrua9FYpBdF6mBN5EmZmwKP8FK95Jyfa/nqyNIzC4MtVUVRqsKk6mB2bSwm26uMLyRPb/u
	HhHJ5kSXyq5fnluQADh4VFVcl6H6TJ3Zj3zmXHC2INfXak98UkJeEfRtxe4riEo78uVL+bugm39
	2QWGo3/iJ6Xz4Yu1pI/A0nNJblw1/+zQOIDVVK+KhXMCRNY/uUYJpwMjoOBzXw8knoRE41CWvqA
	L+8sVFxyDKijl4Nik=
X-Received: by 2002:a05:6a00:1885:b0:842:4982:81c with SMTP id d2e1a72fcca58-8459524e222mr2191138b3a.20.1782198769867;
        Tue, 23 Jun 2026 00:12:49 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c25fsm10883733b3a.4.2026.06.23.00.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:12:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Barry Song <baohua@kernel.org>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v4 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
In-Reply-To: <CAGsJ_4zxcp-jdnRTn09b8ZfxT0P7suFq3BEpyiUzA2C_iRRUGw@mail.gmail.com>
Date: Tue, 23 Jun 2026 12:36:22 +0530
Message-ID: <1pdxybv5.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com> <ecbca3be3fa8bd7e213d013a2ec6ff9a11c6e0d1.1781843449.git.ritesh.list@gmail.com> <CAGsJ_4zxcp-jdnRTn09b8ZfxT0P7suFq3BEpyiUzA2C_iRRUGw@mail.gmail.com>
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

> On Fri, Jun 19, 2026 at 12:41 PM Ritesh Harjani (IBM)
> <ritesh.list@gmail.com> wrote:
>>
>> THP_SWAP avoids splitting of a transparent huge folio into 32 smaller
>> 64K folios (Radix-64K pagesize / 2M PMD) or into 256 smaller 64K folios
>> (Hash-64K pagesize / 16M PMD), during swapout. This improves the
>> swapping performance since all the bookking & I/O submission happens
>> once per large folio. More details at [1].
>>
>> PowerPC Book3S64 could not enable this before because PMD_ORDER is
>> selected at runtime depending upon the chosen MMU. The earlier patches
>> in this series turn SWAPFILE_CLUSTER into a runtime value and introduce
>> an ARCH_MAX_PMD_ORDER upperbound override for SWAP_NR_ORDERS. With those
>> changes, we can now enable THP SWAP for Book3S64.
>>
>> This increases bandwidth throughput with zram backend for swapout by
>> 40-50% with Radix and 100-130% with Hash (Tested by Sayali)
>
> Thanks!
>
> I am curious about the contents of the anonymous memory being tested
> and the compression algorithm used by zram.
>

I am sure it was derived from your microbenchmark itself which you had
shared here (so repetitive pattern) with default zram compression
algorithm. Thanks for that :)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0637c505f

I think I got your point - I can mention that it was a microbenchmark
similar to yours and not a real world workload test. Is this what you
meant here?

-ritesh


>>
>> [1]: https://lore.kernel.org/all/20170515112522.32457-2-ying.huang@intel.com/
>
> Best Regards
> Barry

