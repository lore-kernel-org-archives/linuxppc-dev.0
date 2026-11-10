Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DE606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CzjDzgR5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP9ST0Hlbz2yNj;
	Wed, 11 Nov 2026 02:24:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794324296;
	cv=none; b=hYryPXq+e27tjUuPFCLbLG2/8IN+55aoOCRNNAC29/Nwi/QfBptx26Zaq9sG58fB2lONQtiYKJhiWcqxl75PjCwa5Y8lsdcO1GRwB6SYNyhFg/2eTaZ7Zt36QUUDjhyOyUm/yuMJaHz6eKz+TCBjWuSlaSNDHT4TmYolWphmbyrGCI+F2liGGQWEXrIOtke7WoCTdGQIPe75/GlT9fSpDhadjs4sNko9hzSLwlUM8Bba6Rchl6yqBhAgPH/t12vM3OYdy+KfS/FGYEc0wja+yJ/8YTM985QiMDjvxJxyZFUYl1dLxp/9dSxVwdtU5Fh0yEVlMwEXJZagg1TQ411q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794324296; c=relaxed/relaxed;
	bh=yZ/2fkbURm/euOen6SmjaXi4JzbG61hpQmv47R3Y1cU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bUvb5b/PSE6KxXxjbU6wZVRcECNPRjLS3bwMimUpPO1WxNIIH+GUGExYi9HJrkoGEXZ2nGY6dudFnoIrictRdF3TkpY4rbC5piwzy2KAwm02ciuhIgcjMI1PEgCl3pc4q5RyhXnMGy/PK2vB+PiQacN6OIjaM31ORruT5gt3dgnucppghRAxtfcoIT0q3ciuUD2J/ZVrD5HFnhC5CIKJg/YpveGKss9Fg5LIti36WXK/pIUopOYshm+Hi2BiFG3m4TqXREbBnIms2i8rGffgkc+VXfm9WjoOHP2KAP2gVVBJCBxTftOYbBG/Ku5FPrOQ/OQZGhyIx04nysJT1rJ/zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CzjDzgR5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CzjDzgR5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP9SR5tKdz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 02:24:54 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-37000e7234bso3857815eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 07:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324292; x=1794929092; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yZ/2fkbURm/euOen6SmjaXi4JzbG61hpQmv47R3Y1cU=;
        b=CzjDzgR5LuOPg5Ast6Cbea7J/IB4HPUs3+G7CWiR5XuTXVdhcDB2GmLnw+7CULMIWr
         75u61Wl7DtuRYYtYDRuWzv19QTDec1lLgHF/1owgD/PklGkGfCBHNnhu67bk8yCJB5KA
         mQpgPVBz2OEl5MxKBLyFdJ8K8wLLerdn77xlclSUmDuQ3H2oSd3KppEYX0W7aiGdBpJK
         aQ4hraojWgY+XregItFqbkURsUMsOzEvyuDIvCQqbDaco/stTPgLAOVyrfOmPiZYOSu4
         YFDFvMSRgbawAOoBrjwTQsWwF9rZSxWVSkvY7b3WtCsAROUBtkxd0IBWjqjbzgyUOR/8
         Hoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324292; x=1794929092;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZ/2fkbURm/euOen6SmjaXi4JzbG61hpQmv47R3Y1cU=;
        b=o/QUBOe2w72iLd1L0rOPcdME/IdyzS+FFRGgcGBFIwhqiQ0hnd60ycxaKD4h3y6l03
         p/nm4EvUYzyDipVCfvGED5jIYdNRwLzgknl5UsUItnFtWfOiQrtlzPre/JxZCBEbCPg/
         gFQOPiniRLhoBLyZ4RVaXJ4jmVBAgGjvW7fQPUGq38ZlTUQFf520zDcWCo2NKFKjIlLT
         8hHWpEjk+wkflW+MKiyLebNOWPd31sPz9EXjscbaJaLNdljh58d5OjNAwlp+538k2s1O
         6qe0ZOW2c9gnQw5NVJlrTHt+mJqn1K3W9OEK0MtqLSMXTT01mncxfROL3YlW061GdZSl
         e4iA==
X-Forwarded-Encrypted: i=1; AL+hErGZ0rVy3X73LDoEHLohhFeM7WW8X3kRcl7MgUBeYCJ6AcSOYhAp59nSfYgobWLC2NJJ1FIz0ae1qQTU2j8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8DbrWm1r+KvP0Vl0SGerak1vXpsq4Wi8OA3pDKrz7d9m0cXmdp
	JKTWGzgV8N3I/e24pSeCnBGwASGYBZCAMi8ktUz1O+xU3IqdUKJw66dF
X-Gm-Gg: AYBFou1W81UtLBc1GBC+dZmTXmSHIJzF9a6v87FOUglfthvI+rt+Z6tg0FBWJjT/CIW
	xUkklNdKZFdGnzxJ1eWD4EFZSx6QeGPalhWeU5+YCdZ8Ng34DumM0UaJy7SVRdtqzq5okiWA5S0
	UGRbJJzjsHhd3L4hlF8qMbZoTGjFRsI2RcypTCrVwnCezNunpPIvJXHqVnXZUbYk4VF+0b2Zxre
	FhwjNF3W+RtXnbsQah/7Jwr+Z8cOH8GrGQpAhVr0AFCRHmO1U55PHS6lxL6/a98Ewym3F4OlK8m
	KEabqWkql4SYK6mG5QVLWs2+W3+gA7klfEZLHuQ1u4gRSMGVf+kHv9Ew/L7n0aqZ47BDWsfE0pl
	nJpdSGx5GGnQg07OM+vlVk2S3h7sDvwmtj0oRTM2M+kP2K1Q9m4tQ4cwHqUdysnPjr2SyhSBKMc
	SwmrWbNIyNK5XpSi/EMxbRFiw6jhfLoAI2+yi5iqs9HnUxdrAJOXs58FkhjbSbpFkxaL3jqQh7k
	p9Ysqf5GlNyGaujRJULU/kl27EEcmUXwvbYqIum5U3URjiKDeZcLZHTU+2Ds8pwNAfwS+lw5+9A
	JSQSsLQBG0Ux2xhPUPfqE8aC/0x0
X-Received: by 2002:a05:7301:430c:b0:36a:2382:7dab with SMTP id 5a478bee46e88-3751eb8b08cmr3765547eec.6.1794324290885;
        Tue, 10 Nov 2026 07:24:50 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9e03sm16241137eec.23.2026.11.10.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:24:50 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/smp: Handle missing ibm,thread-groups in parse_thread_groups()
In-Reply-To: <e6b47bd5-425d-4c8e-8c68-5a36d47bd977@linux.ibm.com>
Date: Tue, 10 Nov 2026 20:53:37 +0530
Message-ID: <o6bw90cm.ritesh.list@gmail.com>
References: <39282c731de90f47678952e471236ef22e9d4b15.1794317777.git.ritesh.list@gmail.com> <e6b47bd5-425d-4c8e-8c68-5a36d47bd977@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> Hi Ritesh,
>
> +cc nathan, Kees,
>
> On 11/10/26 7:13 PM, Ritesh Harjani (IBM) wrote:
>> Power systems can have ibm,thread-groups properly absent like in one of
>> the PowerNV Power9 boxes where there was a warning splat reported on
>> 7.4-rc2:
>> 
>>    WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x174/0x1a0, CPU#124: swapper/124/1
>>    ...
>>    Call Trace:
>>     __kmalloc_noprof+0x490/0x690
>>     _kzalloc_noprof.constprop.0+0x1c/0x7c
>>     init_thread_group_cache_map+0xd0/0x2d4
>>     smp_prepare_cpus+0x2bc/0x484
>>     kernel_init_freeable+0x168/0x3c4
>>     kernel_init+0x34/0x1ac
>> 
>> This happens because today we don't check for whether the properly is
>> present or not and directly pass the return value of
>> of_property_count_u32_elems(), to the allocator.
>> 
>> This went unnoticed because earlier kcalloc() caught the overflow due to
>> check_mul_overflow() check and returned NULL.
>> But since commit 0af298e62e5c ("treewide: refresh kmalloc_obj()
>> conversions") switched this call to kzalloc_objs(), size_mul() saturates
>> the size to SIZE_MAX instead and we now get a warning at boot.
>> 
>> Bail out early if the property is missing or empty. Follow the return
>> value as documented in kernel doc of parse_thread_groups() function.
>> 
>> Fixes: 790a1662d3a2 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
>> Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   arch/powerpc/kernel/smp.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 7a25eaa59e62..9a0f63e43821 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -824,6 +824,10 @@ static int parse_thread_groups(struct device_node *dn,
>>   	int i = 0;
>> 
>>   	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
>> +	if (count < 0)
>> +		return count;
>> +	if (!count)
>> +		return -ENODATA;
>
> This zero count check is not necessary.
>

yes, not strictly necessary, but good to have. 

>>   	thread_group_array = kzalloc_objs(u32, count);
>>   	if (!thread_group_array)
>>   		return -ENOMEM;
>> --
>> 2.39.5
>> 
>
> Nathan reported the same issue on QEMU.The same symptoms.
>
> https://lore.kernel.org/all/20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org/

I didn't notice this. Thanks for pointing it out. In that case let's drop
this patch.

-ritesh

