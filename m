Return-Path: <linuxppc-dev+bounces-19120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5723510F9318
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 02:05:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flpGm6L8Gz2yfl;
	Wed, 01 Apr 2026 13:05:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774946303;
	cv=none; b=XrXLkP1LJISVQrg9bWJZlxG6U7UsRdCLCXP3c5NUcOvmft5nQh4Bd7VyA8v4sRdcfDcIIajeq6YeryEwAQ6/mmWMr3Bjs8B9RJBXHtIEBCRP8MX6AsfqIdkJgL6qVYhnlirqENBqsKn4vUvmigDvHrYonXY8yqI8AHLQp66/VKmhV/w20i1HFgjqG4/k6WbyzdQ7gOZnUnVByliSRIc+BDUot1wl94Pr4taW0VfxrVaT8QLKfh7wdVmDjBe4CrZ5EGmNUtQU+qIOEgsdjwz1FwYu3lHkVILEQYDeD5wH5OGIZEYJU0utbH+2oThk5JybDieVg2USuuzDUsGxEXHPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774946303; c=relaxed/relaxed;
	bh=QHPbsfX3aub54dpfPmzxZEE4715VOJOCdtx7f098rbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQ824myYG4eNiKDJh+arPKgo/zziizD6WmMXSfFmb4FIk2vwp0kGuDIA796LPsTmQCX9pKowaubsO1wHluMc7lsXo7fhky9Y0aUm+wqmFi8SmNvQhXRLSKL9VVO0DXjPavYQVKL6WH+6AfWgCP7p7Ej22iI97ALE7gfcA5gzsJgdBXrEtKmef5ljbkUR/DOOWC/PLrgysCosuXnYXRUd2kqtJ8QvPM1BTpddD4KSHOJe4X+sQlG17/jofgoNHRuftzsFv5f/WK+RCbTTjn/8nKf60WOLK0aCu9rNayyU//2eQMKTZxRnkd66KwJmqFbGhCYx5oweXa0UBcAgpRoWYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=donnellan.id.au; dkim=pass (2048-bit key; unprotected) header.d=donnellan-id-au.20230601.gappssmtp.com header.i=@donnellan-id-au.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gdZjaIfo; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=andrew+kernel@donnellan.id.au; receiver=lists.ozlabs.org) smtp.mailfrom=donnellan.id.au
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=donnellan.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=donnellan-id-au.20230601.gappssmtp.com header.i=@donnellan-id-au.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gdZjaIfo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=donnellan.id.au (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=andrew+kernel@donnellan.id.au; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flM2k6294z2ydQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 19:38:21 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3597822d6d8so1025042a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=donnellan-id-au.20230601.gappssmtp.com; s=20230601; t=1774946299; x=1775551099; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHPbsfX3aub54dpfPmzxZEE4715VOJOCdtx7f098rbo=;
        b=gdZjaIfoUkJ39xTkilIQyIhdQdvj9sBTVyZKGpLe7l6ygZzAVzt+NJqAVRklNz1kaU
         7mbyQOCM0HWN38g/9XOLFJaXpF+s9+5YC+x4c/l1Y7OUBHmacD9MHbPi8nnnkdJsSAC2
         M/W9mrrXhquYBGZT5oDiXrx75uAw3XL4yAglrm1a5YkhRxujfAYXex3pq03RkmHI92UA
         t8EuOHgU+8wE/RpkrsTkMATMKE02TLThAa4oh/VJyyCscnwpyW170Tb0yfbG6Xzkuk1v
         os+KSsZwOvgnAHITafKvqLTbm+ILcFTwWmGM77gJM6TNw8E+CIpZ0XfAJW3Rnels56xA
         5nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946299; x=1775551099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHPbsfX3aub54dpfPmzxZEE4715VOJOCdtx7f098rbo=;
        b=UTxovRI9ZBYJ18ZR4SkpnMuQxYXrGkS9eCOY6nRXMOSD2hLPEld320xrDrq+lr0IKw
         mzISykOuFS06iuAeHOz/VDAYhoyY0bhWZOXkeZiSLSm6zC1Gb4PCpBIZEzPG37W1EYug
         fDP25jpyY8K1I7C/yiXZ0P55ud2L9s8WlGwxTxB6cucNMkLzYGgD12DVxDeGBjRoC06j
         lwvdme/pN2bMIVpGxNTXK//hLF9HKfHPFCHVXCQMbXT2Pf8Dh65bAg62ZU5BQ3kraY8v
         BtPJ2BGPHv7k2K+EldRQ1638H2NNt0j7qWbr7hMhRGPq2wUmo8xSOOnvrRwlBn5hk6+q
         cf9w==
X-Forwarded-Encrypted: i=1; AJvYcCXus47EbFUGGFY0jHzGSyPTUJiwHlgasd0/M5EKJr6IdwFlematZCfEJMeItaWVjbUJD+ZCASunpYBasWE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyxn/14ifBDXFzCH+rgx6EyFTnLLyDFX99JHiyuHyVmIVR+MVVs
	FV08gu9yb3irgp5ygfct2jOUm1gKeeGK4I+84orK4Js9OvZXoS1bSmcc7bwuusJdQCk=
X-Gm-Gg: ATEYQzxvheTlxYRCrChIw6wISVfI7+HsikIFvwr5NppqZP6FHohPqgQXmFkdmcmBp+b
	SowZWAY3inwL1WtN+396Wu4OfffnYlq54VqP6aQTuN5wQBr6egAFKsl4hPWVC1YNAjFcSiPMNg8
	VplQWiFQA+ztVpk1Dtdpvv2plOoIKM/QNuvarRhkMfAuyoNeQkaR9/RITBJTbFRB2ocesVI/o+I
	6GfDdmLur1ESv4LejfL2hRp2j0vNjjtfnxJK4QfzbUnrEV1ezDblPJIZB8+2aZUNPQ+5Xq2fOFc
	xspUYfhybC8u/kPIJPNKruo+MuOfzQ5bcL9YMNiq1lElSw+XJLClJTKMXRFv+AC/oPr0Xjgdj24
	Qi/OPzOUOCcMKVo1uQL+3rmSs7jNIEIKhTt4e82/lV+cr0B5s/9WHt1wL7tZl/j7aWoqmPuqtuG
	MB51KIl0CojeN95hB3/F/IMMBRe+uFYVzaPTbeX1FR4oDnPOYvN4f15FqUlbvNRB/LP1BdnZ3QN
	68OvJxOiM0k4h9c9pfgohCn782I+7rIVoHqh4vZA54=
X-Received: by 2002:a17:90a:fa8f:b0:35d:9d38:5363 with SMTP id 98e67ed59e1d1-35d9d38562dmr4218232a91.5.1774946299432;
        Tue, 31 Mar 2026 01:38:19 -0700 (PDT)
Received: from ?IPV6:2001:8004:5110:823:53e8:bcb3:e257:c74b? ([2001:8004:5110:823:53e8:bcb3:e257:c74b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe959886sm904198a91.14.2026.03.31.01.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 01:38:18 -0700 (PDT)
Message-ID: <319bcdb0-1a26-48af-8a6b-3392facb6b62@donnellan.id.au>
Date: Tue, 31 Mar 2026 19:38:14 +1100
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
Subject: Re: [PATCH] mailmap: Add entry for Andrew Donnellan
To: Andrew Donnellan <ajd@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20251208-mailmap-v1-1-524d5b9d175b@linux.ibm.com>
Content-Language: en-US
From: Andrew Donnellan <andrew+kernel@donnellan.id.au>
In-Reply-To: <20251208-mailmap-v1-1-524d5b9d175b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/25 16:13, Andrew Donnellan wrote:
> I'm leaving IBM in January 2026. Add mailmap aliases to switch to using my
> personal email for now.
> 
> (I will send a patch to update MAINTAINERS soon, hopefully after I can get
> someone to replace me.)
> 
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

Maddy, could this be merged via powerpc?

Thanks,
Andrew

