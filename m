Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5260759A8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRnoKWmD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSlSb3ffTz3bfP;
	Mon, 16 Nov 2026 22:07:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794827247;
	cv=none; b=BAWy34CQfEcQLwwtrbRZ9GqVVqHbajp4uAXV2FhDk8H61mb9qW5AcoPnwkLSZLVrgTvvh5oxHxcKk4nsZQKdFOZpahOKeSGfI8Dfm7K1xiBY/dOHolQ1iuVLDZQUhnE+fJdonlNv80YbNwXbv9OsAt/zF54VUh4pujvZ6TaJtLaGkv/lrc7OGcJzFpv0RDd4qdYn+1uNHBYhx85IBUK54HJ01Th960M/hrRRRfxXRwg9zXTH6M97JxO0tojBNNTJey6ffbuiuPz68aXstc+JPOCGmCkR/IExkZ/G9yLi6UKxlZHUXj1rSYn9GogcIVbz7EsSe2sEhZUI9R7+XtcN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794827247; c=relaxed/relaxed;
	bh=13xqPWlH07Y9JkbX/hcL6Kr6C2rxu8D/5ewtdLHHCKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2TmM4CmfBs6E6OEW8cjjJlYd7j27SgUJuUIroesrYGq2AORL7aMm17Ph4fOXFUN9tl4jYTnlT61bI5Pt5y4YdYabb7a7G6+yCcsiX+D0Najjpdw/PwlqMjpsKzXQY19GNyySr+7Xi4awQu/hWnFSpQF0ItwvKdyoYqIAkLXfDmAY29/3b1TJ3VznnYqVqiKsFWYZZSbLnpWRRJVkjJqTR1XbgaXoYpaKgpWPBzKbbt1aFWDa8QGdkd22M5rdNmYyxJvWtfvw6VMLiWhqw04nPpXPGqHvs+EI/SwMwj2QfuoDx29fvWA104wvA4Zn0qWFMWJr34iBEY2zTvZH48SkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRnoKWmD; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRnoKWmD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSlSZ5BYfz30RN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 22:07:26 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D5D462960;
	Mon, 16 Nov 2026 11:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05671F000C6;
	Mon, 16 Nov 2026 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827243;
	bh=13xqPWlH07Y9JkbX/hcL6Kr6C2rxu8D/5ewtdLHHCKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZRnoKWmD34qhtWhjsgZ/TXVIblU1MDa4qdX4K2Sfmv9lnoDYKtD0oJCWme50oAeRs
	 7CsrZd59yru20fRlLQoY62hbky8hHK90YMEfl+hIeOsQ0nd44dGreK5PFHHSkJKXjN
	 7+NBaiA/wWAcxli+lOCtqmjIyxqLpHFmao44tS6InBbXvFLcGnD04df06lWrzhTbBI
	 6qhyy8fASw9tx6Un2Z5sji500GGYwl9s9QN/RYuxrAUpm25t7L+iUiFujYx0Yl3eH0
	 Ju6FvV8FrCWeKly+s8ssqQbFALHW9OtASr7/i2bAzUMywo+W1UgZ9dACMrD4x5MaAH
	 hIdK6tuMtb3OQ==
Message-ID: <b2abcfcd-2d89-44a3-ac03-7354c3be2436@kernel.org>
Date: Mon, 16 Nov 2026 12:07:18 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/powerpc: Fix set-but-not-used errors with GCC
 v16.2
To: Thomas Huth <thuth@redhat.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Shuah Khan <shuah@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Segher Boessenkool <segher@kernel.crashing.org>
References: <20261116103710.674746-1-thuth@redhat.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261116103710.674746-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 16/11/2026 à 11:37, Thomas Huth a écrit :
> When compiling the powerpc selftests with GCC v16.2, the compilation
> fails with:
> 
>   ../pmu/lib.c: In function ‘eat_cpu_child’:
>   ../pmu/lib.c:86:22: error: variable ‘i’ set but not used [-Werror=unused-but-set-variable=]
>      86 |         volatile int i = 0;
>         |                      ^
> 
> and:
> 
>   ebb.c: In function ‘ebb_child’:
>   ebb.c:352:18: error: variable ‘val’ set but not used [-Werror=unused-but-set-variable=]
>     352 |         uint64_t val;
>         |                  ^~~
>   cc1: all warnings being treated as errors
> 
> Add some "asm volatile" statements here to make to mark the variables
> as used and to avoid that the compiler might optimize the code away.

This looks really uggly, a cleaner way is likely possible, see below

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tools/testing/selftests/powerpc/pmu/ebb/ebb.c | 1 +
>   tools/testing/selftests/powerpc/pmu/lib.c     | 5 ++++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> index 21537d6eb6b7d..f4ef92bacd9ab 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> @@ -391,6 +391,7 @@ int ebb_child(union pipe read_pipe, union pipe write_pipe)
>   		val  = mfspr(SPRN_MMCRA);
>   		val |= mfspr(SPRN_MMCR2);
>   		val |= mfspr(SPRN_MMCR0);
> +		asm volatile("" :: "r"(val) : "memory");

If val is not used, why not just do:

		mfspr(SPRN_MMCRA);
		mfspr(SPRN_MMCR2);
		mfspr(SPRN_MMCR0);

mfspr() is already an 'asm volatile' so it will be executed even if the 
result is not used.

>   	}
>   
>   	ebb_global_disable();
> diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
> index 3213579874084..32cafd40d2c56 100644
> --- a/tools/testing/selftests/powerpc/pmu/lib.c
> +++ b/tools/testing/selftests/powerpc/pmu/lib.c
> @@ -95,7 +95,10 @@ static int eat_cpu_child(union pipe read_pipe, union pipe write_pipe)
>   	wait_for_parent(read_pipe);
>   
>   	/* Soak up cpu forever */
> -	while (1) i++;
> +	while (1) {
> +		i++;
> +		asm volatile("" :: "r"(i) : "memory");
> +	}

If 'i' is not used, why keep it ?

Just do

	while (1)
		;

or

	for (;;)
		;


>   
>   	return 0;
>   }

Christophe


