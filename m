Return-Path: <linuxppc-dev+bounces-24458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DC4C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:31:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3ZyK2GNLz2xm3;
	Mon, 20 Jul 2026 19:31:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539865;
	cv=none; b=DUtYJd9ghTocImeNnCAwRZ6ivYTJXaikATg5DNLfTIQhBA1us6QW/z+VoFFIzGoCZWlb+y4GSwIaa9VMLuWM0cz6MZqhBkgwoDdjxDl5D2DM78ZSISr5bcfQF/jf9bkSpBMbfaje0NUe473Ee5/6iyGLMl1vzUF+ns2yyzOxbovWIq5QYqokNerH/fGKrwW69VhVSJZ5T2Bt+PbvQRKqM83LZrgL81TTTmNHvfSfexgykXkE0JLr2a9378gk2EnrDqFLY/j7Nx0NzhVCVhlxm5w5GTtww9Obyg9hvnEpiWlnVHsGl5uYvk/wHa8UEX9ZhIuOkWhn9hO377RW7kl+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539865; c=relaxed/relaxed;
	bh=N8CxclYG5NULruRRAvMxBAfpyq68GFNT8X9UeD7miNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIosk6zEOK+5kCHMwZlVCwYuFXzFVyyADRNC1Tplqr63jArQ+BrZA3qEq96QUTlgIh4C4pICSGtskHVUsWIAcX4LhqT7ilaEf/WeHt0+Pvf7XjiIttPWekzl9Lyv1fvr0c+vKINl20fjauWIX5IgjDhTXX1Buk/dY9Iv12kcYdr1zstlZTym+plmYefM0yjnjoAVzcJjdSYcuzJH7ByMlF4IMqGyjIg8RblZ5RjDTEaF2sDZGFZDGSMGi90TRDwcovDbqeIhrf+z5Di6tKSgw8xTGFLRZ2U0nmSLx85Vs+bSYh6XnlshJZoO0N2LNO+fHD4agGaOdWOYqzqso3W1KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cun9WsIG; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cun9WsIG; dkim-atps=neutral; spf=permerror (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cun9WsIG;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cun9WsIG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3ZyH5hXTz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:31:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784539857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N8CxclYG5NULruRRAvMxBAfpyq68GFNT8X9UeD7miNQ=;
	b=cun9WsIGf9XFsy8os4inFCRvh4UWQVsVQjFtO0oph+VCpab0JqwqztQlHarBZw02NCAbw+
	xlmLifmxaGRzh6jG4/1iLvlZoHS4fp4c1Sx/RG4ZBb9uaY/lyR9T7It8c4Kdqapu917HXP
	VucAx3kjJRrbl3ygCW7l3xvdgx6QLQ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784539857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N8CxclYG5NULruRRAvMxBAfpyq68GFNT8X9UeD7miNQ=;
	b=cun9WsIGf9XFsy8os4inFCRvh4UWQVsVQjFtO0oph+VCpab0JqwqztQlHarBZw02NCAbw+
	xlmLifmxaGRzh6jG4/1iLvlZoHS4fp4c1Sx/RG4ZBb9uaY/lyR9T7It8c4Kdqapu917HXP
	VucAx3kjJRrbl3ygCW7l3xvdgx6QLQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-MxIXw_VkN1KJX3gTO6iJWg-1; Mon, 20 Jul 2026 05:30:55 -0400
X-MC-Unique: MxIXw_VkN1KJX3gTO6iJWg-1
X-Mimecast-MFC-AGG-ID: MxIXw_VkN1KJX3gTO6iJWg_1784539854
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47485fde05aso5826517f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539854; x=1785144654;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N8CxclYG5NULruRRAvMxBAfpyq68GFNT8X9UeD7miNQ=;
        b=gzpKgMRE5WKTlYLoM7sViBBlbSBRLDXgLwc5uG7Ri0qaF9cPtUPZAARVGXpKWqOaQG
         n7ZqgeXNFjgq6jpwlct4wbwVkVRdyAoslJN2ggNy8X5aKLLVM+N1lJ/SjR0TCtvLHccz
         hn8Ti/qS7oy2qUEGql5V4EFQ2h9f5IQ32m75HRfz++KMy4zfp2E+7wMMCzEaoLoIlWeI
         bt8tGEHRchLJ+2Z46IZc9nB65Q1it60EDjYW186VNlxW176/VN4KiJOnBeqdMq+0O81z
         zTD+SRHVt0+wj4DOaidb5tqiUX5/q0jhQqysFuiwjXul45bAyvlcZzRz9SZ9RclGQUQo
         f9Iw==
X-Forwarded-Encrypted: i=1; AHgh+RqtkXysTHzIjdFjvTkn7c7M5W7KCshxqGvGDD6Hm1N4hV12WhnWtjo4JA/CHB9hnTdnLZzBFeTfUos1t3k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvHK1nQQq5ifQ4ZCa09nK2kDjuXpzHntPUTq5Arrn9e/L4Lr+H
	wYVYYzlpwisl/+NO12y327C3wydGEx5CHeJf3163mvyjjlHGXWv9cUIzdxKHClIvaI1w4oOym16
	4v55XS9pUZDu3Yryuthcn/7HcLImL+Z8rdOIHr6gd85wIyP15YhfVGwTBFKTut1AJA2Q=
X-Gm-Gg: AfdE7cm7wGsyVxrN4EJbjadI76qqTVxXbJsKVt5GYg0ifU2nWcADRA8Zgq2EBYe7qFh
	FC+3MuWwH/lnRzXXTXArm6cIWubFjLXSq2V9ToQ1SWHULk9tnzgGY+ez60N5LPTc/w04NtK2Vc8
	PQsZ8AKslSKaJ8AcjKLG7nucLLDCkxvf1DNKrXqLLe5Y3O2pCssSfrUJVAW7SHpQQVgCSq4oLI2
	+AhDTd6pT0+nuDpcl7yxNKiXUd+1Z0jHgywwpUkVaWgKN3Wni369hmUod0xQSYnJpqsGfmk/evH
	o0J815csWY3TKvSvXpMbtjxRRDBJLgfA1ywNDDn5N/uEIXWCdtf3u3QvQ9sc7qKV3H0PyIw34Q=
	=
X-Received: by 2002:a5d:59c2:0:b0:47f:2baf:5e2b with SMTP id ffacd0b85a97d-47f623074e0mr18760940f8f.1.1784539854531;
        Mon, 20 Jul 2026 02:30:54 -0700 (PDT)
X-Received: by 2002:a5d:59c2:0:b0:47f:2baf:5e2b with SMTP id ffacd0b85a97d-47f623074e0mr18760883f8f.1.1784539854103;
        Mon, 20 Jul 2026 02:30:54 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm29860816f8f.5.2026.07.20.02.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:30:53 -0700 (PDT)
Message-ID: <c53b1c7e-ee9b-4c45-95c6-6648f696cf11@redhat.com>
Date: Mon, 20 Jul 2026 11:30:52 +0200
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
Subject: Re: [kvm-unit-tests PATCH v2 0/6] powerpc improvements
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260719130027.2347519-1-rathc@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yL2Heao7zMBwkm2rwVK8roA6M6iTMaXK5Bx303gSBWE_1784539854
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 15.00, Chinmay Rath wrote:
> This series aims to add a couple of new powerpc tests and improve the
> powerpc build structure.
> 
> This is originally Nick's work. The last version (v10) of which can be seen here :
> https://lore.kernel.org/linuxppc-dev/20240612052322.218726-1-npiggin@gmail.com/
> Couple of patches from the series are already merged.
> 
> Since it has been 2 years since this series was posted, I originally
> posted this as a RFC. This v1 series has changes accomodating the review comments
> received in the RFC :
> https://lore.kernel.org/kvm/20260602064806.3101025-1-rathc@linux.ibm.com/
> v1:
> https://lore.kernel.org/kvm/20260708105122.1177210-1-rathc@linux.ibm.com/
> 
> I have rebased the patches to the upstream state.
> For the patches which did not require any changes in the existing upstream code,
> I have retained the "Reviewed-by"s and "Acked-by" (patch 3,5 & 6) from
> Nick's series. I have also added Andrew's "Reviewed-by" received on
> patch 2 in the RFC. Nick had originally introduced powernv tests as well.
> Removed it for now since it was causing CI failure in the current upstream.
> 
> Link to Gitlab tree with patches :
> https://gitlab.com/rathc/kvm-unit-tests/-/tree/ppc64
> Link to Gitlab pipeline :
> https://gitlab.com/rathc/kvm-unit-tests/-/pipelines/2688519679
> 
> Change log from RFC to v1:
> 1. Patch 2: Added Andrew's "Reviewed-by".
> 2. Patch 4: Removed usage of gitlab-ci group to run test - Thomas
>     It would be nice to make use of the gitlab-ci group, but doing the
>     change of all archs would make sense in a separate series. I look
>     forward to doing that.
> 3. Patch 6: Removed addition of panic test in gitlab-ci group - Thomas
> 
> There was a discussion on the build failing in Travis CI with Clang, in the
> RFC, which I have addressed there.
> 
> Change log from v1 to v2:
> Patch 4: Addressed all comments by Thomas :
> 1. Removed extra blank line.
> 2. Removed accel=kvm test from gitlab-ci.
> 3. smp = 2 preserved in atmoics test.
Thanks, looks fine now, so I pushed it to the repository.

  Thomas


