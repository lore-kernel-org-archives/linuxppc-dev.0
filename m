Return-Path: <linuxppc-dev+bounces-21773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F54DCD6E52
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 21:05:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gT8km4dvxz2y7r;
	Mon, 01 Jun 2026 07:05:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780238200;
	cv=none; b=PsyEaaOo+2BHWp+Mn8BYr+d6Z0zceCrCeVNBB5tJnc/MKjJl6juNFRcUYlzTy6PjJbXF2ipFt6+8udmzxJgo0cSeVc9gndcowsdE2W1GIiSga31ycMAdJcdrbBCHBdCNUA8PVMWloyI407ArUWeVWClPP047vk0OavZdY+Hx+aaMPmnc3SrMhgPPrGKTRm9OnwGFkeXPN1VbxSAnmusIW9UoKupCrXD1oqVKXCAWBirqFD1mwZAtjhRMzkuFXqUb/AjzfaDG40uTB5lOaT2YkYHJVHzGVHlKxVGQ1X0wVX+ULAs2uvJPyc6CEbcK6pGs54RpIE8ux4L9HycVEIPlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780238200; c=relaxed/relaxed;
	bh=RAmB6qU0tUcDyuQM8cPLpHCE5VdrhYXfLUEjav8vq/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwfAnswwmNhaT0VeP+74kwsnwR3q1SBoO9EtDy0R8XC7CRXoOBItj1rxiZJ9HOBL/HhyTTQvd4npUQLl974JXeen/bkxIkDTb3I7vraR3vPSp7ldphZLKm1kbS5U5TMiWUfU78vDrXjQviGeHbb6dGcU4PnbIsTfdewyEA1kWvUgJN6/Sb4AerD9wbYYTvSt9pMKk2kC2N9g0rTuMntcMsXbvlxK4AWy+SWYrEsDEAgIMpTSXK9zw3AvMNX1BF8LXGks5cw0brNs8POSyge2+RSDyeujYpqRRSya54C7XhfbHs9QeplDEv61kyCdW+ZyxGwfaEsAzRj/53Q7BukyLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ALDBqczu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=isyanfei.xu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ALDBqczu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=isyanfei.xu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gT05z1Mkvz2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 00:36:38 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2bea7176c72so77231955ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780238196; x=1780842996; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAmB6qU0tUcDyuQM8cPLpHCE5VdrhYXfLUEjav8vq/s=;
        b=ALDBqczu5B//59CimmQMed7XeKgU1rdeDezltCmosvyvabW3LFnstjW7lpaWusrZDS
         EkDkop0o8Wk2sXFmQ0Lb5hlVi1/uO74E0EyDrs0jU9MOWsINwkfaLBJp30Jv7+HGyrfO
         oO7AVGrn7t0K01IvMeVs2eR9zH3ldp6BBqeiSugO7e3QzjXAmw9TsvlkZvz7gF5J5JTK
         ngTFvCKzcT4PHXfTZJqnkxqGwD+/hA14oIWUulY2/TWkWY1iTOnX3H+4P6Yls372ZKb/
         Oy+5Rid42pR0LxJeXNPxE0vWF4l7c0iNkgTdKlnQeOV08AozNitr7zd2QWxfxPw8Q0+g
         oOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780238196; x=1780842996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAmB6qU0tUcDyuQM8cPLpHCE5VdrhYXfLUEjav8vq/s=;
        b=JhHVFdMTo6pxEX5FOOz6Bg6JvC8u46fzbUgVzYrGLtJOjS72qAv7VUAJg3NLTj7OUY
         EIhsNrG403wOB4gkcZda823hRahQ47mXZg7DRS1+qq1lFCci4rAzZhivw2p3rXk2cZGj
         2kDC8pXb4R7UAVFUJQ6TrkV6cjN/tq5ucQqEVmIQEaxwkTdqCX+IMmu9vmGID4SKXJhi
         vyNeiS7pgaInwwfsmj0uFodDT5nUHUPEbmJNi76ZJ2ayTxdNagZIqjBp6vCe8/FpUUxg
         gctTRoLQsyJYSUy2vYCKjjC4+idWdtZH8lYUQeYur7vUcVx0YBXMZrXJ/oSJzYqwJdl6
         TE3w==
X-Forwarded-Encrypted: i=1; AFNElJ+yF9O21S/+Q0e8G9oRg/R4NQke0qxG2+3/MyR34uEkPgrpgyTdkrbzXEqDNW1nYV+CuGpcM8VWoJSUAzQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz9ENpFV+eb3eHoLkpXYHHJzjxNWbxy5unAtefp2mL91eQKgnO9
	47IcpbB8Je++xNFmpxz1dVZcdr12wNo37GmBaCmhvBTHcmJQWk5eOmrW
X-Gm-Gg: Acq92OGmVh1hw00tbtVqiZmQUs1IGASiDUjNL7eZt7niIbkmKrn7bWwzWYeYJqI9rZh
	xf+it6oz18+uV+7ZzXtI97gAbN69roFw1doNcBqOZmNati7TREBKLa/dS+XQs99MsP/1VJwj5fK
	flLMAllgR6LEPRErQtJ8SIorVqeA5OFOWTp6QbIiYsvjI6vdjqx5RuN0RCDGoAnlBLQ/t1TRoC5
	6fi+BKrXRcZ32vtkRVN+UzciejFzPG0VoVi9ciWxEAAF8zamzcMYVDfiW8Xv7v6YWHcgVvNE+3O
	XFFlkLwgBS3Qx94YL/+m0YYUB4nbj0VtHJMYNt7Jdq3UGd5ChEu2PQD7hNWpuQhSZESGQNfZxrM
	K5Unx7nLdrA47Ol79vHQ7tCBPiYPL2zrOpuqC69n4RpE6+HFD+hulf73q/bqTmfOdt2Ntvw6LSh
	Rc+MASuF3y0UDXgyE73c4plF1up3vM476tvEirE8kZ9L7m2EY=
X-Received: by 2002:a17:903:3585:b0:2bf:160f:7038 with SMTP id d9443c01a7336-2bf367c1435mr92914815ad.12.1780238196196;
        Sun, 31 May 2026 07:36:36 -0700 (PDT)
Received: from [10.4.72.5] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b0121fsm77749365ad.49.2026.05.31.07.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 07:36:35 -0700 (PDT)
Message-ID: <5ee310d9-d432-400d-8506-751ee4a41fc6@gmail.com>
Date: Sun, 31 May 2026 22:36:27 +0800
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
Subject: Re: [v2 0/2] KVM: Validate irqchip index in routing entries
To: Greg KH <gregkh@linuxfoundation.org>, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: harshpb@linux.ibm.com, zhaotianrui@loongson.cn, maobibo@loongson.cn,
 chenhuacai@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
 sashiko-reviews@lists.linux.dev, seanjc@google.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, stable@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com,
 fangying.tommy@bytedance.com
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
 <2026053158-cussed-outweigh-6f0f@gregkh>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <2026053158-cussed-outweigh-6f0f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026/5/31 22:15, Greg KH wrote:
>> -- 
>> 2.20.1
>>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Thanks for pointing out the correct process. I saw
that PPC maintainer added "Cc: stable@vger.kernel.org"
on v1, so I mistakenly thought v2 should cc...

Thanks,
Yanfei


