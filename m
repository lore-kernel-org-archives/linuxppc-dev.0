Return-Path: <linuxppc-dev+bounces-21345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DA7CD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 00:27:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gM5hD742zz2xJT;
	Fri, 22 May 2026 10:27:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779409644;
	cv=none; b=j/Z6EjaDhU1QrVZY7SZAtSFCtE04mYEr5R3x8P6ImY0Q5vSdIkZ3ggAchNchyFSHQ47a5GTYq0GXCi8yO3dXLKr1f5SduWHf1cqfSpPeW0nGuxLCJijqE+X5tU5zKPUdtv5xLTD/rfm/ffEfNnhTWUgT4c1ejiyttwOSFnCogsWRkkApw4c17iMgKDG1u9bFd9G1UGAD+afhe7R9/9++cLng4NlL2CuPGABazBGPWQDM98QwZ1jOT3O78+vrxVBUl9XEyYyqOMHK2Qca99HJSyP7OLFwBOeBn/oDsQ9vDsvPHu5XQfOuZLGxL+UleLV1EWpgVCecVg96xfR4nCbYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779409644; c=relaxed/relaxed;
	bh=6Ay5nOcwCJCKL9kJTKSvIioIW4guYTs+JXkN6Y689XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgfaaAGRgusZMUPL6VOvZ9StUHM7mMkAsGKSoX1gM//A1ugvXahJoi9DoqlPahzycycbcHpi2U+inP0Vk3aW5umYXmk5ixEFVdbeP/q6T5UQ1x7R+8wllwseoxFMbg3HdNAJ7AYWBUW0cDEXzzvmv9zESNJ2M6IzsRnvlhpIujeRQS54zdD4yznmdF2gdRoxSQpA/zmo7DvKjiddc5DtdDbVpGxYZrgNEFkfmFCysbLkuVPQO/QJYY8zzuJFAsFNEe/ioM8YwktwV0DwaRN/qac15ohK34IsTN8vayH5WTjiSHk8f0dlKSDQkxkXE6VfDOEUdRlRTfhTHFkvRlh7Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PxehIGu1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=wqu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PxehIGu1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=wqu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gM5hC1zQXz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 10:27:22 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-48e82c23840so54318085e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779409639; x=1780014439; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ay5nOcwCJCKL9kJTKSvIioIW4guYTs+JXkN6Y689XM=;
        b=PxehIGu1rk8UcsNte9c66FZZj6sTCJ+pUes2LAtZn233P1nU5ufBRKjgdVTu77dhdR
         KhfvWLXl3S2qY/EcvdOgTUw//Z7nmVuhslbNHrTj68iX4Ku8VRnl/BbDbYY2FU3Fflkx
         4NH3UMQcXEiVk9LQfyvy29O9kpZznqCSGbTve2LJspsngJomnvzSZ+pBXcJylH4JpbWy
         Jc2xAauXBZhe67gjzcv8ZLydE8KvENjS/O3zqxwakIz3LRP9Dy4ghjpMXoHffJg5jVEh
         e2XqjQTMTlYOINGxvRqEJv4HXSQ22BAmaDRT+4OfGstSzCO72TyRZeuEfshodSEVGlq/
         aUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779409639; x=1780014439;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ay5nOcwCJCKL9kJTKSvIioIW4guYTs+JXkN6Y689XM=;
        b=fjnWI3JpUt9ktV1YPUDAiXRZuQVqa31He9a+gIVdgGkzm+ak7klmYQiqq9/pdWtsyG
         H4NuUl2Qt/d59z+hFb49ZdpbNV3xizS11qhnzD6G8YOIlYgG3YQ8idUlChzWJ2vGr9Pi
         ZWHVqXvB+W7xS+/1gBnEbmaeORIdfUnjM1U2n10PN1VoorENvkJzcuY2yTx/6JPQP8MA
         +G9eJjhktwuzjTCpfMng/ZhBKnAa/KZiJCwhsiHikNsTMtSh3yhT+9D073fYyfVomZUK
         QQTRcxvPFCATp8t0TqC7Se2e075wNBXF4PrRLciFOah6itxzUSK7Zr3JHHdhxTrqskQh
         BGvQ==
X-Forwarded-Encrypted: i=1; AFNElJ817lJV0wI7HTkLWE0dd75j65u+WdZp7P2XSqEzdzebr98K/95hpP4lfP7aohHf7WjEe6S2S0K+Z8iM0FY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJOdWWtdI+nq2H6/TCdpELrE9WNS1Y8UVmGRmlB+OB10CYQlu+
	i3d5A26dLY68JiAiXiDyEPgTDFSBun0/yqZDHwpG056xRKctVMcGLSjSHvahb2oupxo=
X-Gm-Gg: Acq92OHoM+tBrtHal+UEKsBeaw3vmNv3VUP10l845QwNEMKUgaJLg3YsAyUV8Z7VwNZ
	rECeC4sbi5dwISPsg5H+1x3nVYV8xS4At4OYtOfeuDkbati4+Z9a24CLlspydJCofM8zLI6OnHd
	jOn3912UrADR0eDqoLy6FzaB/a3WN/tiDzXt9r3VjLwc91aWkPUR46HpkDhcx2icPVz/kPDXfut
	09Lq28vgd4jraXz8v5W1JYkT+dFdLA1+XMCBpYGKp2jQt4pbBGn66QmF12r4v60kpV264LjLr5f
	jOf/B9Mdf6oS0d9VYr2QxGon4RNu3PlbK3gsrjAqEGmXXP9ckU2GTK8lRPL/AzJycI4pIDarrao
	eCWjjzh2YaWvlIbELnwNQxGt18f8le9wl4tUbPloSbq9ufIyg1K1vd2J1DiqUo6xsb0V3H4GH8D
	v/tXunD97fb7N0Hd/M1ptuKCsWyjwjKJDnLzqa7AJb3aV8fIPjilRWoSgOeZJ9rgjuJx8PwY6g7
	y07QfgkNOlmkfFglZbpItbLQyo1m1HtJohaUNMoOwrVKhUlQNBexfTx5Q==
X-Received: by 2002:a05:600c:4ecc:b0:490:3c90:2cda with SMTP id 5b1f17b1804b1-490426cef73mr10709345e9.20.1779409638952;
        Thu, 21 May 2026 17:27:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb0f91bccsm4187125ad.36.2026.05.21.17.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 17:27:17 -0700 (PDT)
Message-ID: <cced8d26-d846-470d-b112-344e53ec1b9c@suse.com>
Date: Fri, 22 May 2026 09:57:00 +0930
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
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
To: Andrew Morton <akpm@linux-foundation.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>, "H. Peter Anvin" <hpa@zytor.com>,
 kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 Song Liu <song@kernel.org>,
 Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
 Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-raid@vger.kernel.org
References: <20260512052230.2947683-1-hch@lst.de>
 <20260512052230.2947683-2-hch@lst.de> <20260512114231.GG2558453@suse.cz>
 <20260513054742.GA1018@lst.de>
 <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
 <20260515043705.GA3855@lst.de>
 <34C16854-1065-4542-8836-DDED58EC1844@zytor.com>
 <20260518051207.GB9374@lst.de> <f46636c8-80ba-4802-a6a0-74cbc35e7bee@gmx.com>
 <20260521171730.7872482df453975cf60ce7dc@linux-foundation.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260521171730.7872482df453975cf60ce7dc@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/5/22 09:47, Andrew Morton 写道:
> On Wed, 20 May 2026 18:11:09 +0930 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> 
>>
>>
>> 在 2026/5/18 14:42, Christoph Hellwig 写道:
>>> On Fri, May 15, 2026 at 12:59:34PM -0700, H. Peter Anvin wrote:
>>>> I don't think this is a good idea. Error out; it is the btrfs maintainers' job to ensure user data isn't lost.
>>>>
>>>> The RAID-6 code has *never* supported only 3 units, and if it ever worked for *any* of the implementations it was purely by accident. Speaking as the original author I should know; this was deliberate as in some cases the degenerate case (3) would have required extra trays in the code to no user benefit.
>>>>
>>>> I would not be surprised if the kernel crashed or corrupted the page cache in that case.
>>>
>>> It does, that's why I wanted to exclude it.  Anyway, for the about to be
>>> resent version I'll drop this btrfs patch over the stated objection and
>>> will otherwise not change anything.  This means the (IMHO hypothetical)
>>> users of this configuration will get a WARN_ON_ONCE triggered, but
>>> otherwise keep working (or rather not working) as before.
>>>
>>
>> For the btrfs part, I believe I can get the current 2-disk-raid5 and
>> 3-disk-raid6 to fallback to raid1 inside btrfs.
>>
>> I hope the btrfs part can be finished and reach the next merge window,
>> but I'm not 100% sure.
>>
>> What is the planned cycle to merge this raid5/6 cleanup?
> 
> At present it's on track for the 7.2-rc1 merge window.  Does that suit?

The current btrfs fix (*) is pretty small, I believe we can get it into 
the next merge window, as long as we got enough review on it.

*: 
https://lore.kernel.org/linux-btrfs/a1d63733465229936351804f3760803d5894a962.1779274630.git.wqu@suse.com/T/#u




