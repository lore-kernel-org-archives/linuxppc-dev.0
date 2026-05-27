Return-Path: <linuxppc-dev+bounces-21589-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F90CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 13:44:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQW7P2wYZz30GH;
	Wed, 27 May 2026 23:44:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779889457;
	cv=none; b=l0oRUPk8kQVVEJqLb9nodKlDZLhPo6b022vZlbowGmhcpcgkt/gO3gEUVZLu8N9yYNI67sSzDYYkVGplpZXF4Zan04KbNbHMlH1oFHhhTgMq0zNP1GpVDLvFrKtw/e5z5VBSjZGC2hY8NzBi2I9xeoNPzXRcqCTUvjItJDRfXx/AlTmmzDQStRi28NXQKdvkwBKN5EjtsshQOPOpFaRSKk6DnVkjAQPVvaN+mpbrERg3X2sqjJggoF0XHt0scuk0Q4+DSpzSGY4rKKVjJXwn0m87hsAxeR1QCdhxG5cRDlWMsYtyVd/PfMrjxn/pNB5IPm6ZA96v4GDFFk/dknOw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779889457; c=relaxed/relaxed;
	bh=Qzhck0gw9pgwJJr+ZjjO323vwaaYqicFxNlPj8CzbAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4Keyf5uWIjVTvVKtMQOg3tsNTiyYWonL7v90xqLp11rnvyuS/W45Ul5LDD1y+SZwO0/qXcyZoJ+W7enS/+jyyv6xkQmc4AvqvgGq61KDedCjHlyVQgpzgrfnGHif/h2LsIqWUnCRhb16d4m17S4P/GYBZqeK4ay6EHioVnUrvO6i7OlauVwpUdteUQ0LNqGOjXQGxKdh+FKEcGxWw7p7sCdDIGwkKo0Ls8LZ9irE9ljyVFWm8fxhFZqEB1c02G5LBj73AIoS0pMxKIpgyaTX9dNwbtKFf+zwUblGevrxzAPNaTi/cNYGMTbpyqxg+jb48+lhZVuhtSPNuXL81Om1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jW1Tm5jC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jW1Tm5jC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQW7M5ztMz30GG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 23:44:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779889439; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qzhck0gw9pgwJJr+ZjjO323vwaaYqicFxNlPj8CzbAU=;
	b=jW1Tm5jC9vRGaX/pQDf7yWqXUnnvzypjojAHC9XeBLiHjD+ZVefCJriMa4EYS/zVZa+/bfiuqKG17UYqPZYSJqaGaI3KHn8phHacsqkoxhAqS0UDJ0iX9xIK9dgA+KMrPDekR7VAEHohFKMD85CyUqaYZ/A0O+esONMTGBAj6Tk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0X3jnw6a_1779889436;
Received: from 30.246.179.14(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X3jnw6a_1779889436 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 21:43:58 +0800
Message-ID: <f75d7ff8-d965-4f17-8548-2525512a400a@linux.alibaba.com>
Date: Wed, 27 May 2026 21:43:52 +0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 6/8] lib/test: memcpy_kunit: add copy_page() and
 copy_mc_page() tests
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
 will@kernel.org, rafael@kernel.org, tony.luck@intel.com,
 guohanjun@huawei.com, mchehab@kernel.org, tongtiangen@huawei.com,
 james.morse@arm.com, robin.murphy@arm.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, ryabinin.a.a@gmail.com, glider@google.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
 <20260518084956.2538442-7-tianruidong@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260518084956.2538442-7-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/18/26 4:49 PM, Ruidong Tian wrote:
> Add KUnit tests for copy_page() and copy_mc_page(), modeled after
> the existing memcpy_test() style: a static page-aligned src and a
> two-page dst, filled with random bytes plus non-zero edges, then
> verify byte-for-byte equality and that the adjacent page is
> untouched. The copy_mc_page() case additionally checks the return
> value is 0 on clean memory and is gated on CONFIG_ARCH_HAS_COPY_MC.
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>   lib/tests/memcpy_kunit.c | 67 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tests/memcpy_kunit.c b/lib/tests/memcpy_kunit.c
> index d36933554e46..85df53ccfb0c 100644
> --- a/lib/tests/memcpy_kunit.c
> +++ b/lib/tests/memcpy_kunit.c
> @@ -493,6 +493,67 @@ static void memmove_overlap_test(struct kunit *test)
>   	}
>   }
>   
> +/* --- Page-sized copy tests --- */
> +
> +static u8 page_src[PAGE_SIZE] __aligned(PAGE_SIZE);
> +static u8 page_dst[PAGE_SIZE * 2] __aligned(PAGE_SIZE);
> +static const u8 page_zero[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
> +static void init_page(struct kunit *test)
> +{
> +	/* Get many bit patterns. */
> +	get_random_bytes(page_src, PAGE_SIZE);
> +
> +	/* Make sure we have non-zero edges. */
> +	set_random_nonzero(test, &page_src[0]);
> +	set_random_nonzero(test, &page_src[PAGE_SIZE - 1]);
> +
> +	/* Explicitly zero the entire destination. */
> +	memset(page_dst, 0, ARRAY_SIZE(page_dst));

    init_page() memsets the entire two-page page_dst to zero, and the
    test then asserts the second page is still zero. A buggy copy_page()
    that overwrites the second page with bytes that happen to include a
    zero byte would still pass.

    Please fill page_dst with a non-zero sentinel (e.g. 0xA5) instead
    of zero, and check the second half against that sentinel using
    memchr_inv():

        memset(page_dst, 0xA5, ARRAY_SIZE(page_dst));
        ...
        KUNIT_ASSERT_TRUE_MSG(test,
            !memchr_inv(page_dst + PAGE_SIZE, 0xA5, PAGE_SIZE),
            "copy_page overflow into adjacent page");

    This also lets you delete page_zero[] entirely, which on
    PAGE_SIZE=64K configs (arm64) saves a non-trivial amount of BSS.


> +}
> +
> +static void copy_page_test(struct kunit *test)
> +{
> +	init_page(test);
> +
> +	/* Copy. */
> +	copy_page(page_dst, page_src);
> +
> +	/* Verify byte-for-byte exact. */
> +	KUNIT_ASSERT_EQ_MSG(test,
> +		memcmp(page_dst, page_src, PAGE_SIZE), 0,
> +		"copy_page content mismatch with random data");
> +
> +	/* Verify no overflow into second page. */
> +	KUNIT_ASSERT_EQ_MSG(test,
> +		memcmp(page_dst + PAGE_SIZE, page_zero, PAGE_SIZE), 0,
> +		"copy_page overflow into adjacent page");
> +}
> +
> +#ifdef CONFIG_ARCH_HAS_COPY_MC
> +static void copy_mc_page_test(struct kunit *test)
> +{
> +	int ret;
> +
> +	init_page(test);
> +
> +	/* Copy and check return value. */
> +	ret = copy_mc_page(page_dst, page_src);

 From sashiko:

Does this introduce a build regression on architectures like x86_64 or
powerpc?
The CONFIG_ARCH_HAS_COPY_MC flag is selected by multiple architectures,
but copy_mc_page() is an arm64-specific API. Other architectures use the
generic copy_mc_to_kernel() API instead.
If the kernel is built with KUnit enabled on non-arm64 architectures, it
appears copy_mc_page() would be an undeclared identifier.


Thanks.
Shuai

