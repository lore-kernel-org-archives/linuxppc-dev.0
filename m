Return-Path: <linuxppc-dev+bounces-21131-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81E4CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 20:50:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK90y33PSz2xpn;
	Tue, 19 May 2026 06:50:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779137410;
	cv=none; b=jYsXPiQcrLsxBB+iHeYkg6zyyHH0Bwn/IR0CybGrahV8VjyoMriaXYd81hjq83VpJamgRADmBKg4dr3gVXqkFrGVxTgCTdTY9/V8PCSe+rS7kUIV1Ckbe98q4J9jxEs0LRCCGm2O62Y14UPJvkxTv3XrnNzGBxbzp499XCf5AwJ4aTgKj+Y+h7t37d+FI1h5eCaACMHXz+TYXopVrCkosz6CwsoH4GIR/NTsyIlToMqn7b+8WeZvpTKHpFD1gE8emJT1snByETUUHNweITwYNXYfYb9dJNR+GNeebGKYHg1q8u1L43tlCqGt2u9eVFhbxPSqGpvT9RV5Q7R5yyCzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779137410; c=relaxed/relaxed;
	bh=l2NTPpzDiFlBQXBmoJbzyiHW1xJm+/TyVqfGW6eXiWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQVc5cqVsVm5bym52g9CSTuR+IWNs+ahT1YL9QmasNMBa2LNftV+jQN4YXC5VcQfaN1SZp/41LrzBtFBG2C3ndCKk+Tajel1E6+5f8MohsseWPrcSU1G7cUSVnpgytbxnqOsgNYiOElbO2n/f67eXZtQehotrliGHZGV/7ZWFNCQGwjxtNxhWBYNe3bvfXnvdtk8HMpGnZbzqZoA+t+xoXu7TU00pOsWTDaaMokumP6htmuf3qInw1oNTkfiX+JSZMlVFT3mG+KmSUu0uRLKeg7mBW5FMlBIxBOssmt15K3Z77qauNR//hk1BOulwSc55cbondho+h1rzjUbk3wNIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=MA3830Wx; dkim-atps=neutral; spf=temperror (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=MA3830Wx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=arista.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK90w14vjz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 06:49:47 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso37374455e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779137379; x=1779742179; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2NTPpzDiFlBQXBmoJbzyiHW1xJm+/TyVqfGW6eXiWI=;
        b=MA3830Wx/krNts6EzKXBBXQ1+GGrVxMBTEfRECVdG+nFvNONTbg10JOwTMflGeKOgT
         bn3yO4bEJLDjRTcXUasoOS/I5L10WTOaPCVPwFDdMNVqQGB5GPK+RXHlbiI//+UapVgL
         YPYJbCd4+u9cyDly3LSDef9RpRNKl2OU8MK8073r4nKVN5m8ALRHk3dLT1lca0J7tB7u
         8Q3xeC1aRQFeIqpgrqn1bP6wHB9tvinZJSUjtT5qsETxcQUVmqaZrwb2s2OmsO7n56gR
         a4kAiawyCzDQ9H+cMvPUHer0CtZ/SPxlrFfF+CLvxQ0bnUl0tDYb2x8+lJvU20bvnEjM
         7D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779137379; x=1779742179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2NTPpzDiFlBQXBmoJbzyiHW1xJm+/TyVqfGW6eXiWI=;
        b=LM1DbV/VgJu31VYmUD0lD5VlGwqLUmPlzMCj/gbSffCLtOTDEec8oDaNYU3cRhsFWT
         Fe2JgLS1lUgOxJJPFm0oDGmfXJhkgRu1xfyAectl/GX3I+qCpFZui9hTrj51VM5ew/3i
         DYoWAZIM2LKe2GAxZi90JPTtT7agvm88FrxJrijzuMBqmGcVbZxQvDhrTghEIDffLKjC
         ode+FeMAwBcdfU2L1QNzOTZv0xWDepS2UOXdERjuvD1pWB47fLAlMIPvMXHpIQEdpuwJ
         0pfl8ODwBSnx7lcVyydlzHmUDKm2Rt6ooVz+gYZB2RvdTQ6zdBrm4FEuoEIIdcOEj0NL
         Cj6A==
X-Forwarded-Encrypted: i=1; AFNElJ/jBtOIOOAcDIcJgDg7OHIoMFM+zfFwqk6Y3bpQSZqb/qUu12b99yheZ52Q+YGjzmiGbtXCAtz9d+oigTA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzbdEdBUhuKsNAnEmAnXNJepJeHVQMSU0dbIAFyGTiQOQqyJo9n
	X0QLtKyiHj00ztY5D8HOHGBsqdhI12+LryPiQ0rwTQpMW3zIOoCRQHdBLPF0a9gfTw==
X-Gm-Gg: Acq92OFfU2m4rMs1b+O7V4IHlmmmmPNECU8vBVi7OBXL4B5ms5SFJHhM0kHx5Jodho5
	UaymPdLjxywWZOFnbjQgancXIU1GzLpiSAubr0Mec7aHO584/Di39x7ZpWkFt/PQj320zk4pJmD
	tCbi15VqXkoTBzcNxf4ZHyPI56gtcAGXyW8usUEaUqQQ6i4ckvR78IozPKWhPujIwzg/P39VH0M
	M2EtpUxWTPMYXHqYpSTMkfv8OJ3uLTfSfCTtSgVcZKQM90gbR9u8PFIzEMwzq5l42OEJor7+07V
	1ifquJEIrivJIFS6MEPn9hD1/91dfV/5+QR+4dXmet/sCZHIs/1h9A0FCyIgfRw2zvvqXAN7RlG
	1i+rWZ2ju3pdqqarHHODPA5/X3is2BZ9b6MpK0U5144RGJcZLfydwVMYwtBEuXm+zNrwe1XZKWN
	jMeTiocNibjXSBDOUKkJuvVBk=
X-Received: by 2002:a05:600c:2d81:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-48fe651d7cemr158815975e9.32.1779137378929;
        Mon, 18 May 2026 13:49:38 -0700 (PDT)
Received: from [10.83.43.186] ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm273208205e9.14.2026.05.18.13.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 13:49:38 -0700 (PDT)
Message-ID: <01dd7a1d-fac7-4e5a-aeee-cc8dccef41e4@arista.com>
Date: Mon, 18 May 2026 21:49:35 +0100
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
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Lukas Wunner <lukas@wunner.de>
References: <20260518202903.GA641158@bhelgaas>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <20260518202903.GA641158@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Current behavior has existed for a long time and I could easily imagine 
that there is software which relies on the fact that the system is in a 
non-modified state if AER recovery failed. The software can analyze the 
system and do cleanup afterwards. Sometimes, if something fails in the 
system, it is better to have it in a non-modified state.
In short, I just wanted to preserve the current logic by default because 
there is a chance that we have software which relies on the current 
behavior.

On 5/18/26 21:29, Bjorn Helgaas wrote:
> [+cc Lukas]
>
> On Mon, May 18, 2026 at 02:23:36PM +0100, Yury Murashka wrote:
>> pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
>> If a new AER error is subsequently reported, the AER driver calls
>> find_source_device() to find the source of the error. It rescans the
>> whole bus and picks the first device reporting an AER error. Because the
>> previous error was never cleared, the error is attributed to the wrong
>> device and AER recovery is started for the wrong device.
>>
>> Add a kernel boot parameter pci=aer_clear_on_recovery_failure to clear
>> AER error status even when recovery fails, preventing stale errors from
>> causing incorrect device identification on subsequent AER events.
> Why should we add a kernel parameter for this?  How would a user
> decide whether to use the parameter?  Are there cases where we
> find the source of the first error, but we *wouldn't* want to clear
> it if recovery fails?

