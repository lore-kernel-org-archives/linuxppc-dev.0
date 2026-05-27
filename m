Return-Path: <linuxppc-dev+bounces-21566-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17139CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 11:45:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQSTp598Qz2xLs;
	Wed, 27 May 2026 21:45:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779882302;
	cv=none; b=L/J/fb7IHHnoSEnw0yEd6r6x2hhjXr6ZFd5fu6uA8AEURpcYSnydeddTQpp4lnP4UijVfgAjeJXzG2gglUGmyyQuM3cX2pA7mwIAVhKhXq8RjRzT8DNSbhSRVzgbFApu53Sdmc21XzsXqG54EGs+rj2oExZP8nQgc43udRCgSNIkmCLlGB9yMfGLlQZgy9492k17/s7R2kryKbBIfWGNpyrTo8AVqIdoYuu3+ZyiI2xzQEg8mvZwAGWSGBIbSkURgdJAenowWlHJZ1sb91y5CZtefWGR8Bxuv11oG1eeuuCl2tv/bn5KIq+z6cFJUbdcdIWZGexIHFk5YVEzdjdChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779882302; c=relaxed/relaxed;
	bh=oUB0kHUhBy3ng5DetQ30N4vUPE1VonqsLOG2jbmUYA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHRWYBB0DzKP0BvWqBZ0SUpKN1xQR2TvZLL5j9IfrXoXeyOsPrzgqN7pv24R+yd69I7rCswPclIUoRx4vmfSxu+1cLz4F26lYRXffSXXyQ7lCsSDW4l4M/S8nZdnA2IdeKpFmV29a4/qpPuUgojg9dR70LzmXF4oVDgkv30kpXnDOsBBPo+jv5pLOhKEs8dFl4V6lzGzOrcY38jq4UukBkLTDt6Tcgslgxi3w9qUPYnBEuFyOOMk9JU8rxnVu6qRL9oayploXNx09r7Ag8/kj2VdbdCrTzwo58kYKA6GnITxFMuTBhn/18Udt9v517EOWYQOJFuUQoePIIkI6Q41hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KWwKGZre; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KWwKGZre;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQSTl6VQMz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 21:44:58 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779882295; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oUB0kHUhBy3ng5DetQ30N4vUPE1VonqsLOG2jbmUYA0=;
	b=KWwKGZreojKOhur/byN710zgQUAeEcVHDS8delAwewiY17gUqIbgVdKuZ98YzDUtOdwp3dV8xQxOf1ITwYMy7Y19hdO8/NlTtECJ/uaHDRRyOGBycEe6lKsLFTbkCIw6vUxFd96TnHj2bw8aLpL1f3upJ7+qUtsssjISHYRYua0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0X3jezDI_1779882292;
Received: from 30.246.179.14(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X3jezDI_1779882292 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 19:44:53 +0800
Message-ID: <8ebf43de-16c1-4798-8d48-c93390ab6df0@linux.alibaba.com>
Date: Wed, 27 May 2026 19:44:47 +0800
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
Subject: Re: [PATCH v14 4/8] mm/hwpoison: return -EFAULT when copy fail in
 copy_mc_[user]_highpage()
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
 kasan-dev@googlegroups.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
 <20260518084956.2538442-5-tianruidong@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260518084956.2538442-5-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/18/26 4:49 PM, Ruidong Tian wrote:
> From: Tong Tiangen <tongtiangen@huawei.com>
> 
> Currently, copy_mc_[user]_highpage() returns zero on success, or in case
> of failures, the number of bytes that weren't copied.
> 
> While tracking the number of not copied works fine for x86 and PPC, There
> are some difficulties in doing the same thing on ARM64 because there is no
> available caller-saved register in copy_page()(lib/copy_page.S) to save
> "bytes not copied", and the following copy_mc_page() will also encounter
> the same problem.
> 
> Consider the caller of copy_mc_[user]_highpage() cannot do any processing
> on the remaining data(The page has hardware errors), they only check if
> copy was succeeded or not, make the interface more generic by using an
> error code when copy fails (-EFAULT) or return zero on success.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Thanks.
Shuai

