Return-Path: <linuxppc-dev+bounces-20187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C733DFF8871
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 18:21:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4Bj31jRQz2yrt;
	Tue, 28 Apr 2026 04:21:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777314087;
	cv=none; b=Qti3TQayoJfBTZr/EBkRakv8vVT8Q+dFuQ4hDCMgzRRfQAw4JHik00JjK2ozsSKtUNJ6Q71j0pYFWhNoOmY8RQNibkKoyRbuqVcmQtdKbczbFc0ltlGxc0Cxt/1Cwv3xhSVU6VxE+KSXevg5/87qLrqcwCty7b9rspW/UK2pwxFDhDFPUiLL4jOhVcQ6Ei4TgJ8HXDdFtlQg857fSyhcijcCMZ+CJcUH6AJ+dr6vOA9qOlwUcwFeziQn1NtS7Ynb8BBB+si4WnvRzDtk1sON2M3R11GcHZmX6+/CeUE3CcKzffoB4D76Pr/lm8+nm2lJNOCfX0NcuxPvVYUNsETxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777314087; c=relaxed/relaxed;
	bh=jRL0edEqnjRKMMuAf8kNDWGdxE3K4+zobIK6wBqidRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIwN/1d8J7R9TEPKfSiWD3ItZRT+xLfZbfyTiqhB3ehUEToYmuUta/MaDi35aubePmSSijgksfxf/b6j1ZTxsi5z9iWkObA1cE/okTY34cj7JJ7+NNQLy2PZa+MWvX9PcxBVs47XxFC+WnfBgyZwkGoHkCz9p23+uq9bjU0nvyudN3aVyLYENaiPUrV57qHuNAREkeS5svEuNhCB+GTgOX5Fy7f6lq4g0O88br/L5rQHQ5O3s/6cKUNGgvauoPj3Lbkakyx7I06lNoRtp8Z+ANOa9TE8kCmscvQTd98OFHfl+nLuCc3OBKLuSGZtA3iRNzGYJKC0DNG6yAO+dBdEnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J2scZpbK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J2scZpbK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4Bj20WY4z2yrK;
	Tue, 28 Apr 2026 04:21:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 46E9540246;
	Mon, 27 Apr 2026 18:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCCFC2BCB5;
	Mon, 27 Apr 2026 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777314053;
	bh=fSfdZ5/fBIJBn92+lTQ8RknrFiSruKk4Zm5FPbyuhQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J2scZpbKenpOejPaCkxdr8Fr6c4RornKyxLjF0dKFYhSlw+matCdj3SDWlLeqEo9E
	 a373XI9Iold2YwxLkAFI1OVkbxbR9JLgxu/comiCZJeBJjQK8IiPFbF3a0OQIu5zFJ
	 z32D8XDVz5Fo00XfpR09lc3WO+fPx7ont3FOA+TL4jxGM7w1J5Z2cHWcv2Vi05coRU
	 6lIPjD/Eh4XtMiOh4PUlJfQ+hbcnF50oIaF0Y5is14Jb9Uy7pNbq6e4WVWxwPn3QZF
	 F5175xYuXBtUSK+HvgeuPZTDTXog5e6524IUP62vgqpWl/U/vR5Pqvo+DbOYeGkne+
	 cSOzK+yVIhXWw==
Message-ID: <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org>
Date: Mon, 27 Apr 2026 20:20:38 +0200
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
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-x25@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-sound@vger.kernel.org,
 sound-open-firmware@alsa-project.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <cover.1777306795.git.chleroy@kernel.org>
 <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <ae-j2_QirCySZD02@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/04/2026 à 19:58, Yury Norov a écrit :
> On Mon, Apr 27, 2026 at 07:13:48PM +0200, Christophe Leroy (CS GROUP) wrote:
>> At the time being, x86 and arm64 are missing unsafe_copy_from_user().
> 
> No, they don't. They (should) rely on a generic implementation from
> linux/uaccess.h, like every other arch, except for  PPC and RISCV.
> 
> But they #define arch_unsafe_get_user, and the unsafe_copy_from_user()
> becomes undefined conditionally on that.
> 
> So please, fix that bug instead of introducing another arch flavor.
> We'd always choose generic version, unless there's strong evidence
> that arch one is better.

But they both implement the exact same unsafe_copy_to_user(). What is 
the difference here ?

Should that function become generic too ?

Christophe

> 
> 
> Thanks,
> Yury
>   
>> Add it.
>>
>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> ---
>>   arch/x86/include/asm/uaccess.h | 29 ++++++++++++++++++++++++-----
>>   1 file changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>> index 3a0dd3c2b233..10c458ffa399 100644
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
>> @@ -598,7 +598,7 @@ _label:									\
>>    * We want the unsafe accessors to always be inlined and use
>>    * the error labels - thus the macro games.
>>    */
>> -#define unsafe_copy_loop(dst, src, len, type, label)				\
>> +#define unsafe_put_loop(dst, src, len, type, label)				\
>>   	while (len >= sizeof(type)) {						\
>>   		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
>>   		dst += sizeof(type);						\
>> @@ -611,10 +611,29 @@ do {									\
>>   	char __user *__ucu_dst = (_dst);				\
>>   	const char *__ucu_src = (_src);					\
>>   	size_t __ucu_len = (_len);					\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
>> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
>> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
>> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>> +} while (0)
>> +
>> +#define unsafe_get_loop(dst, src, len, type, label)				\
>> +	while (len >= sizeof(type)) {						\
>> +		unsafe_get_user(*(type __user *)(src),(type *)(dst),label);	\
>> +		dst += sizeof(type);						\
>> +		src += sizeof(type);						\
>> +		len -= sizeof(type);						\
>> +	}
>> +
>> +#define unsafe_copy_from_user(_dst,_src,_len,label)			\
>> +do {									\
>> +	char *__ucu_dst = (_dst);					\
>> +	const char __user *__ucu_src = (_src);				\
>> +	size_t __ucu_len = (_len);					\
>> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
>> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
>> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
>> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>>   } while (0)
>>   
>>   #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>> -- 
>> 2.49.0
>>


