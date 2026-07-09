Return-Path: <linuxppc-dev+bounces-23946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E733AC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:33:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx0s94KLHz3c9w;
	Fri, 10 Jul 2026 02:33:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783614829;
	cv=none; b=ow11ZihPHqpAI5LQK6CgEIUWQvnTyNJcGoo7BlzNJS7DTUvvwYX01OMfP1zSKs61LgBCXV7YMp2Rjxy5lmSiaEBRNg3+msxkf4TSQ0AFf5VyfrPTN5FEvPN2RwHZKKAdON42VbRqnpeXbpi0JJx8ILCPZeHHwdmWNP+jn/HAf8HpkYM0+yQyLiC88ni95MuFnvL55xzW9LrPLfprIvc7EWZRvBxBg6oDcKr1raMjwySPJrtHc/j6/C8zFQbqWQfIDlpaoy/6RMYqxtSBI88ThFCz+2lYpMfIZWBhoyzYxc/bY/8SRJbuZKFf9GYNI+b8zxjT6H4tZ2URWz7AxwfJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783614829; c=relaxed/relaxed;
	bh=KMftOyLsg2hqgJ1UXh7XgE6vQFA27+YO4IPdcFXy4PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leTXdat7JUK8qy6E5W/KpgddXcxHDV4m4EYDxQ7k9hOOfGGIb8zM4KHtjIaslJQbEPmiQBIKaxcjpR9OA2b5Yy/2xU0OdDnMo9g4ooWOF3bb3fIBvfBaFWDvbp822l5nvXlMEPVkv/a11F4Ef3MFk/u0kj5PoX1oIxDIPMzgKCySTsOzyDqacLnEm/4flVcJTYhU1aiYCKuLObRxO943IGsYAKE3TZCrLNxusyhtzEzHhpZ0PgGx+2odx+iKFwXxTnaNHMlb4T4DxV/TvBY5q5S5hMouYUhjJJagqSqCOVroTcOeGGz/z7mEFovdv7Ddi6UjypSY98aiSgo1uFXM+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVCZp4dj; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVCZp4dj; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVCZp4dj;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVCZp4dj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx0s82qR4z3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 02:33:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783614822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KMftOyLsg2hqgJ1UXh7XgE6vQFA27+YO4IPdcFXy4PA=;
	b=OVCZp4djTVmiN9bVYRTOHHRnd0pUF3LiCevP00PucspdtUL9D0qPMwEVEQqHpLBz0ibPhB
	sTzM/RRCYVY2lTy58WTzKYX8gj5K98SWTmn/UvIaTtqX9QSkIH3NvqNlowmXNa/G/bsU4z
	0FDw5DqwuisnyKfWf/qFTSVzVCcdtsg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783614822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KMftOyLsg2hqgJ1UXh7XgE6vQFA27+YO4IPdcFXy4PA=;
	b=OVCZp4djTVmiN9bVYRTOHHRnd0pUF3LiCevP00PucspdtUL9D0qPMwEVEQqHpLBz0ibPhB
	sTzM/RRCYVY2lTy58WTzKYX8gj5K98SWTmn/UvIaTtqX9QSkIH3NvqNlowmXNa/G/bsU4z
	0FDw5DqwuisnyKfWf/qFTSVzVCcdtsg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-nMmnL105MuCGfbzIZSqdIw-1; Thu, 09 Jul 2026 12:33:40 -0400
X-MC-Unique: nMmnL105MuCGfbzIZSqdIw-1
X-Mimecast-MFC-AGG-ID: nMmnL105MuCGfbzIZSqdIw_1783614819
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so6378795e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 09:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614819; x=1784219619;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KMftOyLsg2hqgJ1UXh7XgE6vQFA27+YO4IPdcFXy4PA=;
        b=pMzv3xxu0uOFmHuoQ378qJqqJlY1/ooY1qsxZDZe673/zmc91j22DTAUyHVcBpaAUb
         +4FjZNAIBc4hwQbStKdHF6YO7gHOIq8G6GJ6qxLug5AFeliIvbQCypYoaRWPH2UJHTYj
         MIvqly3YqECwwYbiWs332rIjzIOk/E1Oc5UcRBdXhE93Aq98P8SXZZTivsXp3KJJ0zxn
         QKkZJsWvUBUYGKZvTdhZf/mmKffle4LuD45SMVS1VMoHc0VNLOCEfY5zPzc5VtKG6f45
         HTQFp+gdNXxmiuhk5ZuXMitmEbn8IwTBqg6R3abHt6ePcwv4Q+OjrERs5NfABF30mGGT
         Kndw==
X-Forwarded-Encrypted: i=1; AHgh+RoIPcWxzLWUMH8Fauvp82cMeajjB6oxl1koJHZak9eKiHgXRurkqhpxSpOlvznyXxESCEW/8wynlFtirIg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy/GuFYFBXTsUxTopI8E9v3yiRpBlU6+vBWWMUbfouth81+UD0i
	Edvqp5AW7ViYTe3Gr4gvUXcgVEXJGCfqRyER73C3t1YI1+fSog7BJi9uXL1TjzHSgiaG8pTBZHq
	3Woc1vO4vGXDXn1SPzEkoWdOLVsvHxQXjyj0zcPae82/DxFqjO2JjjKh1p7Jid2ph40Q=
X-Gm-Gg: AfdE7clTZC0iFzySqTG1WjzqlhrOKk5sACmri/BqQnwQPPphLkSEIAMu/zj87kvvCVs
	d2E7luq3HU8WYuMesRH1keR12nCJt1PsviRwiMP3Ug8ymeHNTS74E4OLCoX7XG41wf0YD7l+PS/
	nwArmNtVhmCtCv9i0MzkOOygqsD2ROIW1nkfoQtzdOgEydJvI4b6dFNYKE/gd0w22qqB+CYGg7T
	Gf0R3NDPjrhCHNMGLzDjLkJaZYln2SBC/QMpG0O9POUZiuCOqa+ZjJuidXRKA3bJZdPjWSKPhGS
	MGUK1f/BTIIUW+qS7ddb5EKJbPU/hR185KokF8+pqC3bDgeGkT9qHVwgQNM9TAGZnSxTjV/GExr
	sT5KYHw6l
X-Received: by 2002:a05:600c:c0d2:10b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-493ec775ff9mr29063535e9.18.1783614818945;
        Thu, 09 Jul 2026 09:33:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d2:10b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-493ec775ff9mr29063295e9.18.1783614818617;
        Thu, 09 Jul 2026 09:33:38 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb74b3edsm81659555e9.15.2026.07.09.09.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 09:33:38 -0700 (PDT)
Message-ID: <dafb66eb-2dd7-46cc-8fe7-eb26a8715442@redhat.com>
Date: Thu, 9 Jul 2026 18:33:35 +0200
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
Subject: Re: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, andrew.jones@linux.dev, sbhat@linux.ibm.com,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
 <20260708105122.1177210-5-rathc@linux.ibm.com>
 <bd10e435-de06-4b67-962c-b520a43a8280@redhat.com>
 <8c9b739c-8a9b-4e9a-8e43-7b1a6e1aa330@linux.ibm.com>
 <73573868-2fb9-445d-b5c6-02166a0feb25@redhat.com>
 <4dd23a35-8dcc-422c-8ffa-2387abf92558@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4dd23a35-8dcc-422c-8ffa-2387abf92558@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KnCIb86evIgyIdu8jmQ_LeRnI9cQGhfpEkUJlBzGr3Q_1783614819
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2026 18.08, Harsh Prateek Bora wrote:
> 
> 
> On 09/07/26 8:46 pm, Thomas Huth wrote:
>> On 09/07/2026 16.32, Harsh Prateek Bora wrote:
>>> + folks who might be interested.
>>>
>>> Hi Thomas,
>>>
>>> On 09/07/26 12:16 pm, Thomas Huth wrote:
>>>>> +++ b/powerpc/unittests.cfg
>>>>> @@ -24,6 +24,14 @@ file = selftest-migration.elf
>>>>>   machine = pseries
>>>>>   groups = selftest migration
>>>>> +# make a kvm-only version for CI for now
>>>>> +# TCG accel support with Qemu and distro release used in gitlab CI 
>>>>> needs to checked.
>>>>> +[selftest-migration-ci]
>>>>> +file = selftest-migration.elf
>>>>> +machine = pseries
>>>>> +groups = nodefault selftest migration
>>>>> +accel = kvm
>>>>
>>>> This does not make sense (or I don't understand it) - gitlab-CI 
>>>> currently only runs with TCG for the ppc64 jobs, so adding a separate 
>>>> test for this with "accel = kvm" just adds a job there that will always 
>>>> be skipped. What should this be good for?
>>>
>>> I understand it may get skipped in gitlab CI for kvm-unit-tests,
>>> but it might be helpful to those who can run it on their Power HW.
>>> If the job can safely skip on non-ppc HW, I hope it's fine?
>>> We would like to get it integrated in IBM's internal CI with Power HW.
>> You mean you also use a gitlab instance internally within IBM? ... 
>> otherwise it does not make sense to add this to the .gitlab-ci.yml file 
>> (which you did earlier in this patch).
> 
> I do not think we currently use a gitlab runner as of now, but that's a 
> future possibility.

Ok, then please remove the related entries from .gitlab-ci.yml again.

> Chinmay,
> My understanding is that we wanted to use kvm accel also when executed
> manually using scripts, as we wanted it to be integrated in IBM's
> internal CI that runs on Power HW. Do we need additional changes for that?
KVM unit tests run by default with KVM, so you don't need an extra entry for 
this in the unittest.cfg file, I think.

  Thomas


