Return-Path: <linuxppc-dev+bounces-22919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEFACD4F26
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 08:02:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkyH44hbxz2y71;
	Tue, 23 Jun 2026 18:02:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782201776;
	cv=none; b=QrJ01Anlnit5NhmKhfrtGdvjdyzprmSR1kQ9XNB/OFaOqPA/NcqFJX5heBdn0Fey+P9+8QecLKfJVudGy8QT84exm3eN9EH5Ywr7Jkja0WpSBGQfZjpfc9wCIXviT8jJBUnGz5Poq2gIi8CrcEU0HrcF+JxDVyTvTTfZpcgIYj2jRhZ6jMI5HLzXBHGY9fuhLcMbgeZS7TkIVe4V3o0fxLmKEhs/k099Q/1M+6Jdptr5j89khud2KfNQkHcNqXyOhuQFLr71uXvmKLjrSimRgBatx+4y8HA05MYFpHfaeaVM2ljSVAaU2R4c8cx1TdRjnhHsJMttOoNRXvs7r9gIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782201776; c=relaxed/relaxed;
	bh=uGXAbbvDtMgdseoEBMP4tUzRSWv2MJSuTR3Me0ClWC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLYV/jCW5E5d4QA0Vm9DkbgyEGjsPPNIqBYIPHonrzJrTTejm84wlZC87Tr8bd+xnk6mdJoNfEYuJVr72CZw7hQLwIadPkKr2rdhrmDd5DweGCl8Kuk+Wz0A3Cdu7rB4EG46UHWJVQysCojrcX84lMKeJwqoHgGLw6+CL0cQeL4tCALoGYj9vkK3KrNRiu2z9peJxGVc8qCqL04VKfReTBWMba/oc791M5sxly4g+L8ovJdzYMfsHk3d7lTzBaa19iYg1JeyUSdMR7Yf/iD+hjY/+L9IoR9wa+ScPWhCOZmnccui4iWNViJUbrFQeSnpYA6ESwqz/HpDzNomByYHtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FklgZfZv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FklgZfZv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkyH31X2Qz2xwL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 18:02:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C6A2437DF;
	Tue, 23 Jun 2026 08:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986D81F000E9;
	Tue, 23 Jun 2026 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782201771;
	bh=uGXAbbvDtMgdseoEBMP4tUzRSWv2MJSuTR3Me0ClWC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FklgZfZvf9emq2gmny2eGq6EMuPFgTPg3jmwAxmLaYfdeYYOx9o/LUsxGSyhC90Aj
	 wyT19RvXdWlMCbyU9x5qRfWKwzHtDUwLyiTaRdHPzlhCnqASxByUiH+reBxZa6dm6/
	 2eUrKJ7Sl3Ard2QCWFs5RMYz0cEIAQCf+F3cTsedtE8mzwpzHancQo4aEImHF0L8cr
	 Fy0cEII7dznV9is/6QM/nYIXsQ76KUnc8J3lz0n9fEPXD9BgbtOHKKHco2unHFN5KT
	 hMyDhDgPqCuk0aLgK7toBqI2XUvKRYcOcAAOK274SYOnvXU30gUDeEG5XgOjyI10Dd
	 19K+31feZDQsg==
Message-ID: <d04f745d-eb3e-4d2c-8ea2-5fdcf2cf27b8@kernel.org>
Date: Tue, 23 Jun 2026 10:02:40 +0200
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
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org, bhe@redhat.com,
 chentao@kylinos.cn, chrisl@kernel.org, jack@suse.cz, kasong@tencent.com,
 kunwu.chan@gmail.com, liam@infradead.org, lianux.mm@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 liyangouwen1@oppo.com, ljs@kernel.org, loongarch@lists.linux.dev,
 mhocko@suse.com, nphamcs@gmail.com, nzzhao@126.com, pfalcato@suse.de,
 rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com,
 vbabka@kernel.org, wanglian@kylinos.cn, willy@infradead.org,
 youngjun.park@lge.com
References: <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <20260623075805.466317-1-zhanghongru@xiaomi.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260623075805.466317-1-zhanghongru@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/26 09:58, Hongru Zhang wrote:
>> On 5/20/26 23:15, Matthew Wilcox wrote:
>>>
>>> all of the applications i run are either single threaded or don't fork.
>>> what multithreaded applications call fork?
>>
>> Traditionally the problem was random libraries using fork+execve to launch other
>> programs ... instead of using alternatives like posix_spwan (some use cases
>> require more work done before execve and cannot yet switch to that). I'd hope
>> that that is less of a problem on Android.
>>
>> I assume Android zygote might be multi threaded? Maybe sshd as well? Systemd?
>> But I'd be surprised if there are really performance implications.
>>
>> Not sure about webbroswers .... I think most of them switched to fork servers,
>> where I would assume fork servers would be single-threaded.
>>
>> So, yeah, getting a clear understanding how this ends up being a problem on
>> Android would be great.
> 
> Barry asked me to share observations on fork() usage across Android
> applications.
> 
> I wrote a BPF-based tracing tool (kprobe on copy_process, checking
> CLONE_VM to distinguish process creation from thread creation) and ran
> it against the top 200 Android applications in the China market during
> normal usage scenarios.
> 
> Results:
> - 82 out of 200 apps (41%) call fork() during normal operation

Crazy. Thanks for these numbers.

> - Among these, some call fork() from multiple threads
> 
> These are not zygote forks — they are fork() calls initiated by app
> threads at runtime. Examples by category:
> 
>   Browsers:     com.quark.browser, com.UCMobile, com.xunlei.browser
>   Shopping:     com.taobao.taobao, com.tmall.wireless, com.achievo.vipshop
>   Video:        com.youku.phone, com.qiyi.video, com.hunantv.imgo.activity
>   Social/IM:    com.alibaba.android.rimet, com.ss.android.lark
>   News:         com.ss.android.article.news, com.ss.android.article.lite
>   Navigation:   com.autonavi.minimap, com.sdu.didi.psnger
>   Finance:      com.eg.android.AlipayGphone, com.chinamworld.main

I know that especially browser usually use fork servers: a tiny
(single-threaded) process just to create new child processes. Any information
regarding the apps above that use fork() on small vs. large processes?

> 
> This confirms that fork() is widely used in real-world multi-threaded
> Android applications.

Above you write "some call fork() from multiple threads". Any further
information on that?

-- 
Cheers,

David

