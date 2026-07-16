Return-Path: <linuxppc-dev+bounces-24314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0159CC44512
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 06:43:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h13Qs0PwQz2yXj;
	Thu, 16 Jul 2026 16:43:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784184212;
	cv=none; b=GvpCGSEmZcyoAxek8LQ0NkjUmvaNlybzZuwVuCSZ3vLUGKwThApVBOlE2b/VuZPjPXbBfJM3IHikjp8IfGdUcm5/RbqxJ+KbkduTaV4yrYcyEOwi2Gt9rWx52QR13jUQUQbgRG0Ca0c+7Asv90bYJk/oCk+GGxv+kPkIkeFGa3kPlgqS7Nqxd0bVwnWOdCW3y6Zq0G7ks1jHEXVPcBsCU2b+46h0Nx+RUu4AHJcL5/uhNbTlZ3copM/iIwIDuUSo0IT7PJlm3X7D5g4JyRhWgq9Okrb+iPCb6nOqYIpcrbhKzMQPKxR9lTqoi6OJx5F0LvTMwTHiJtjEgRS08nMD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784184212; c=relaxed/relaxed;
	bh=DsLGcom3ZeTfINfwuqzujf0E8Uw6ZU39l4TQYXgHLvQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CWPTFXfqBOuCppP3Dyyv7NcpuSPctbXT0K4dhP11gwXBH4YrzyyFWOtj9D2H3BMVqab5M3OwZxr6h7K0uN4KEu5njmrzBrfbZRwtSAH6WyM6KzgbWZHnZWK9q3ufWW3ZW27/QZJ07Gnlby+i7y+XxMJjWV+mD4+f4J+AwzN55kKk9lfIQeJaPx5tvoMTM86SfzoPfPIsYCH2vXA3Eu9GtkvrSZ8HstJO1Qg0iERVtN4e698UBECgit0TEsdX0e+dsNc7QVdR608cKzxw+S9i6HjRtMBh7sksahiKNGv52qwbNf7eHizUyqg0gwJSy89fQ9WjOIcm720ADUMkGBvcpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZPjaeVxZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZPjaeVxZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h13Qr06d3z2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 16:43:31 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-382ef647e20so5859578a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 23:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784184209; x=1784789009; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DsLGcom3ZeTfINfwuqzujf0E8Uw6ZU39l4TQYXgHLvQ=;
        b=ZPjaeVxZDXuvpY2mvg1TmfPi2OZqtU280ymR6CL2i+Ww/HI+vTeha3/isWPdUBbEhA
         /ZC+VbVFkpnvBuIyc0mHzMm+sz/usIrL7xzK33sC9oUqJq4YbtVqV8MdGvostiZ/fre1
         gSeWcW++hjm20Vh0zHydCHX0QmOtrWGlHEb2e5sL5qsg3QQITudc6IJIxfzz6M9xWAA1
         q6owcDbpO+58ceTcXhJCf3oNnfwB/aGclfvGRSgFBztzUl8Bbs8wLRmwbM5EtSSkqg8x
         a+bsQDyR42MwKP2lG+ML81uxP/2hngodTSIuPAvnEQO/QC6MyBAZvH1BGEo22DmkQDjo
         7s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784184209; x=1784789009;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DsLGcom3ZeTfINfwuqzujf0E8Uw6ZU39l4TQYXgHLvQ=;
        b=EF/kkzGS2E/wEk2EIgakJk4SRqH57wT9dF1qohyYF/o20CZ8nQJkO4LRu6203MXnSg
         7YGD2iIA5CjHwxDDCKP60j2KfQ1Gp433gDTxNa1lpKTjD616pFiDUffDGpzUs0FxuOl3
         eNE2gEBAl7fS4cIxmKkzinZWq3M7MavMLII522Ul0JUHJ7VzlgqkCism4Weot3tXg3uB
         nDan/V0TMh3QKiFqblTtud7GjzVxEgpuN+4DE3VR98ApFEOHaW6We6XWixU9INLtXh7Z
         iKXsPXJ9pJV37wUAEgzXvTgU6BPWpEaPVpQlrIlytlVl/i96hqQDJotfrF4XRlwHbB8v
         8sJg==
X-Gm-Message-State: AOJu0YwmTqL39WWzqSgJfjHhDzIju2dWIbTAc+d95W5QigdMM5ISEHx/
	qbYuoXRE7hTrRhwUeJD8IdrofDOn+Q4gHYOLzFit37/oOWIOs2ourmX4
X-Gm-Gg: AfdE7cnge5pXyjz86HtniqVBTZWWH3tqJruv4yMlQ7kRrUBMoY59ngSP/7gbC3ekRZ8
	YLftbTMJ46xhe/z+LCT04gyfkjHwgWp3AN65UaauvbwNR0kMzUsQxIem15Bv97lfvVSR6Utv9RX
	18coD/L1DkMXKNa4k77TBh2+KA2GPNQDugYGDOhvJwU7ZBIIFsHdJrFhaRREuBjlKO0rpywvgKf
	y730rHftR91O+GIl0ml/ijzdcsO/BYPuEMHDllsPgTj6+2d/6NAXRFzpv9SiRyIYz7lrd5JVWN7
	4CVqJLYItHkIw154skmQPQsiBsj6zm6EsNM4AsFrR/R064x6X1dchOEahUQP+E4bjJdHixCJsKh
	+g4qpQDuvZMTpBPainu5Sr7PSV70aRGSgdJa9mXREh5ZPyFzgJE4Q9byfHR3vaNW6MhtF8/yy6C
	h/
X-Received: by 2002:a17:90b:2b43:b0:38d:eac8:2dbc with SMTP id 98e67ed59e1d1-38e29f6c683mr4912316a91.9.1784184208670;
        Wed, 15 Jul 2026 23:43:28 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6a626bsm8222656eec.19.2026.07.15.23.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:43:26 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com, chleroy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] powerpc/numa: Support coregroup on PowerNV
In-Reply-To: <alYBOcxjv6DqxUyT@linux.ibm.com>
Date: Thu, 16 Jul 2026 12:07:16 +0530
Message-ID: <bjc7v3s3.ritesh.list@gmail.com>
References: <20260605055242.1757485-5-srikar@linux.ibm.com> <20260605055242.1757485-8-srikar@linux.ibm.com> <v7anv1ib.ritesh.list@gmail.com> <alYBOcxjv6DqxUyT@linux.ibm.com>
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

Srikar Dronamraju <srikar@linux.ibm.com> writes:

> * Ritesh Harjani <ritesh.list@gmail.com> [2026-07-10 11:18:12]:
>
>> Srikar Dronamraju <srikar@linux.ibm.com> writes:
>> 
>> > Coregroup support on powerpc has so far been limited to PowerVM LPARs.
>> > However, PowerNV can also support coregroups when firmware exposes the
>> > required coregroup information through the associativity hierarchy.
>> >
>> > Detect coregroup support by checking whether primary_domain_index is the
>> > penultimate domain in the CPU node's ibm,associativity property. On
>> > PowerNV, a non-penultimate primary_domain_index indicates that firmware
>> > provides an additional level for coregroup information.
>> >
>> > This keeps the logic compatible with PowerVM systems, where
>> > primary_domain_index is likewise not the penultimate associativity
>> > domain.
>> >
>> > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
>> > ---
>> > Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
>> > - Handle comments from Christophe Leroy; make code more flat
>> >
>> >  arch/powerpc/mm/numa.c | 56 ++++++++++++++++++++++++++++++++++--------
>> >  1 file changed, 46 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> > index 9aa71eb7e96b..e97b624203ea 100644
>> > --- a/arch/powerpc/mm/numa.c
>> > +++ b/arch/powerpc/mm/numa.c
>> > @@ -889,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
>> >  	return 0;
>> >  }
>
> Hi Ritesh,
>
> Thanks for the review.
>
>> >  
>> > +/*
>> > + * If hierarchy extends beyond primary_domain_index + 1, then next
>> > + * level corresponds to coregroup.
>> > + */
>> > +static int detect_and_enable_coregroup(const __be32 *associativity, int index)
>> 
>> Do we care about it's return value? We are not reading that in the
>> patch.
>
> Yes, We do care about the return value. If the index is set to -1, we don't
> retry enabling the coregroup.
>

yes, my bad. Agreed it is being used.


>> this function is mainly only needed in __init, can we mark it so.
>
> Yes, this will be done.
>
>> 
>> > +{
>> > +	if (!associativity || index == -1)
>> > +		goto out;
>> > +
>> > +	index = of_read_number(associativity, 1);
>> > +
>> > +	if (index > primary_domain_index + 1) {
>> > +		coregroup_enabled = 1;
>> > +		return index;
>> > +	}
>> > +out:
>> > +	coregroup_enabled = 0;
>> > +	return -1;
>> > +}
>> 
>> For PowerVM, we now have two places which will enable coregroup_enabled
>> during mem_topology_setup(). Is there some way we can unify that?
>> 
>
> For PowerVM, we have two extra associativity properties
> ibm,ibm,current-associativity-domains and ibm,max-associativity-domains.
> On PowerNV, these two properties are not used/exported.
>
> All we depend is the layout of these properties to determine if coregroup is
> enabled. If the layout tells us that there is place after
> primary_domain_index for coregroup, we assume coregroup is enabled.
>
> So in this patch, we hook at the place we look at each of the CPU
> associativity. This should work for both PowerVM and PowerNV.
>
> So, I can think of two options.
> 1. Remove the previous logic of depending on PowerVM specific code.
> 2. Allow the previous logic to be around. Since its not going to hurt
> functionally or performance wise.
>
>> This also means we enable coregroup in case of PowerVM with SPLPAR when
>> per-cpu VPHN associativity index > primary_domain_index+1. But this
>> isn't reflected in your commit msg. The commit msg only says this
>> affects PowerNV.
>
> I don't think, I said this affects PowerNV only. But I still don't think
> the logic would change. The logic to enable coregroup remains the same.
> Just that we may now be depending on the 1st CPU associativity instead of
> the PowerVM specific properties.
>

So let's just add this info in the commit msg please. Because it was not
clear otherwise.

-ritesh


