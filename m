Return-Path: <linuxppc-dev+bounces-25164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3748EC54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:07:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBHG42kX3z2yYq;
	Fri, 31 Jul 2026 17:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785481676;
	cv=none; b=IBl4bu0UoJAhF7TzoM8Ns536H4+2ZgCT9seI8TNeE8UK0bFrjOniRCE1tlGdOLdKD+ER/Ew3KnIRa5EAb7E0GY2FEvOJGoe9zo6PS+Jvi2XrThWl8IpciRgDI6SixveVYgRGjGHS/Awy771wd7ojj7jo1nVCueYJ/kuF/vdY21LMHZnW2NTTtg1b5thtlExtyw3fYBLPes4LwzpN+R79wxwYMPPAa9wopp/Y+w+QxRP92j34n0QV24g8ONVBJXAmRoCCDC6TxzQSskgBLPbetudOZj4WBi3Z+vxOKZlmpS/BmDW8ympKfv+Z2xDKrThE7VmR/Vso1m9EWdqfXOGCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785481676; c=relaxed/relaxed;
	bh=jE/jZJ2b8amnc5cylmq6frdPeNVYOhh2qPsnqDWlWqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7eC050igvxOqrIuCMdKKZol6H2ZO2+gzB/6OdSlyGwIQeeKSqK03PH49ZAqjIwFn0rgPA97FxEni7EiUXJt4XufWAYXkFFlkoLumTmJ4FA6iYGECbgouMWrgYnY/gMA/vNfT9tEqWxPTMdelJQor7ArySgWTt6+POg9YStcCzq0x7LqQacEwJ4clr5xjFeinhFbdIkpwbijWLpKF6sEz+S1Hec7yjsQCCKQxV5iXjhycuLr29Pt8o38TQNT8IIpZ8dp5u9OflxtJ6ttjeJ1JPLV/Fi/KTLPMK6eRMnNlr59F0j8Y3c9f35mKTHOTf/1O51ZzlUFMEOGW12QyUpLCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqiUjDOb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqiUjDOb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBHG30VnWz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 17:07:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B4476004E;
	Fri, 31 Jul 2026 07:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A32A1F000E9;
	Fri, 31 Jul 2026 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481671;
	bh=jE/jZJ2b8amnc5cylmq6frdPeNVYOhh2qPsnqDWlWqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jqiUjDOb2GJbulM4kICNrGg1xmIlnoH6ZRX79EiQGqet9qGL98E+aEhpIbVkBnB2e
	 WUOJGbhkg0h+7n6unKewSeGaVMh7IzDpw7y72yVBa1KgeVciiFwPDQUfcsyqYTNDT1
	 Ddr/Ord0SETBjpneA9FKV76KIVZi9PiYdeCvK3kltHcWowWuuVmk4y+SUFQiWl2KSb
	 Cmmrh8SJB6pXafK2Gd5vdOpNzrQmwnPRCkWgRsiM+mkNCoJmarcmrszChX2ukM+9Hk
	 vOlPDaLXACxxgR3Tb9Tv/s3fx2P3fbLRuU15kQDweGxPmdEAq5KBzsgnrgbz5bzo8u
	 gRRJUJg1StqSg==
Message-ID: <544be782-944e-4568-a2ac-4861680829a8@kernel.org>
Date: Fri, 31 Jul 2026 09:07:47 +0200
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
Subject: Re: [PATCH] powerpc/kexec: Simplify kdump_extra_elfcorehdr_size()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260730131940.597739-2-thorsten.blum@linux.dev>
 <42ab7c21-25cd-4ed1-b43f-b155e82db1a0@kernel.org>
 <amtjkfZgkvFACYzE@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <amtjkfZgkvFACYzE@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 16:45, Thorsten Blum a écrit :
> On Thu, Jul 30, 2026 at 04:33:18PM +0200, Christophe Leroy (CS GROUP) wrote:
>> Le 30/07/2026 à 15:19, Thorsten Blum a écrit :
>>> Return the size directly and drop the extra_sz variable to simplify
>>> kdump_extra_elfcorehdr_size(). The two warning paths now fall through
>>> to the existing return 0 at the end of the function.
>>>
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>>    arch/powerpc/kexec/file_load_64.c | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>>> index c3503d698428..d0c544079e03 100644
>>> --- a/arch/powerpc/kexec/file_load_64.c
>>> +++ b/arch/powerpc/kexec/file_load_64.c
>>> @@ -377,16 +377,12 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
>>>    static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
>>>    {
>>>    #if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
>>> -	unsigned int extra_sz = 0;
>>> -
>>>    	if (CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM)
>>>    		pr_warn("Number of Phdrs %u exceeds max\n", CONFIG_CRASH_MAX_MEMORY_RANGES);
>>>    	else if (cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES)
>>>    		pr_warn("Configured crash mem ranges may not be enough\n");
>>>    	else
>>> -		extra_sz = (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
>>> -
>>> -	return extra_sz;
>>> +		return (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
>>
>> I don't understand.
>>
>> Previously, when cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES you would
>> return 0. Now you will return something different. For instance if
>> cmem->nr_ranges is (CONFIG_CRASH_MAX_MEMORY_RANGES + 1) you will return
>> (unsigned int)(-1 * sizeof(Elf64_Phdr))
> 
> It still returns 0.
> 
> When cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES, the else if
> branch prints the warning and then falls through to the return 0 at the
> end of the function. The final else branch is not entered in that case.

Hum ... Yes sorry I missed that.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>


> 
> No functional changes are intended.
> 
>>>    #endif
>>>    	return 0;
>>>    }
>>


