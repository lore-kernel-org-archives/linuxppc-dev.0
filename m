Return-Path: <linuxppc-dev+bounces-19118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A5210F92EC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 02:03:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flpDT5mDdz2yfl;
	Wed, 01 Apr 2026 13:03:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774945331;
	cv=none; b=e61C5bGcN490tOoLMZRuLqTl/ABqrQPPydmhxRXTEIv7x8bsXDrhG3OmNFW0fDh9D/+CA+4UimAknf8+NXDO0rnyIJ4OonWRdVPMOmOOEozAQLDSW52NoylEMCpWotT4eianAMXRDA/whJKtEw8GOgKGpiHxdq7PYV+m2eL6uTC+tzoEP9lQULeBG5Vr7b4uGxFA26tnelS5lFa8bqa2NpvEnOdDxd1P7i34rbfYP3w/AzlUQSETk7q+JTIX/+6xHmHsvSa4ZFTp2KD9j5Jhxaho+L7+RZnumyvfhYUxsUaoyG3f2neX/7b1I8xgElTmqP3cZKsSkg9waGoT89hW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774945331; c=relaxed/relaxed;
	bh=JzhlrwPwuPlVKuZviBWvAhMpg2EI5KHV48XIJzIuEMg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=Hoz16dbjU6IXFvx/AfSHl/+TNRqtGEZjIf7BtI4ae9oXgLfpxWBk5QPDVcfxs78KPFs4A2SwJzwM3VXtQUWVmkWPHyN9XoxDLEahOOhqrMfM6+0FCsm0atCIYpBKryZTTb/BnE/Ly84KESx9hYGVBnsFi9NT5t9HUgZSlM++UahGhr8kc52VgA81xgfG8b7l5hUYoxsaR/vv0PzEjRLxqkDVFE5IkCn066McrF9ZnSHWAUey6piqYM3vCHfSx0NJqg8+9N8hE4pp8xmfr83WKdUXkco6DMrLluylq+C2lGSz3hWEuIAJF5HETYuZYqwr30W1p+vZLSjQxK2ArsDArg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=donnellan.id.au; dkim=pass (2048-bit key; unprotected) header.d=donnellan-id-au.20230601.gappssmtp.com header.i=@donnellan-id-au.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=oyNwxDXQ; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=andrew@donnellan.id.au; receiver=lists.ozlabs.org) smtp.mailfrom=donnellan.id.au
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=donnellan.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=donnellan-id-au.20230601.gappssmtp.com header.i=@donnellan-id-au.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=oyNwxDXQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=donnellan.id.au (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=andrew@donnellan.id.au; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flLh13wPtz2ydQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 19:22:08 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c738fcba660so283393a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=donnellan-id-au.20230601.gappssmtp.com; s=20230601; t=1774945325; x=1775550125; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzhlrwPwuPlVKuZviBWvAhMpg2EI5KHV48XIJzIuEMg=;
        b=oyNwxDXQdPzSKO1UV+fzHrZznWU7TNo8szEj4LQ48Feq0opa9SaRE40dzWMKzSwjbG
         8bwcYAf5yQVL20wzB7d/POgusZYQVcT6wDr6WQvg6PaSGbsp9Lxp50arkg989eADBjr0
         a9A/kuQvXDuYYxiKs4PUj+FoleSDVyXNZV/13+Y6AXtTw8gjW9ZG2Ft7V7B+Xyr0NSwJ
         qM46ifMNWBB+IKlwIq6ppNfymgd9LseC5t/nXbeKMQnlo3tS3wAD8rjcWdDbKy7+ynlb
         NagiHq26H3JL4nW6nvfiD6ki1K3nUaky0Q2ZSSWaRX28CFwaYDkYy2Xj8yH7XuwgUs2F
         MMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774945325; x=1775550125;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzhlrwPwuPlVKuZviBWvAhMpg2EI5KHV48XIJzIuEMg=;
        b=bM+99lK8Y6goMtUx36gyBouTd3rJN81pJ5kTWTqTPTlw2QhwleISnTZ9TL0Fo7Xz0z
         bKpJ2hznr4jNt0eMg7OhHOkgEuui9GW5lDdw++2rNOeaO/CVsRvrcJn7GcGtSljQf11c
         azOhT0SjF/JREAzlr1ZbcHqePHNY+74vQ5xWLXiiRQX8u7WMNNfjEah5yO2HjGG44F9a
         E+vrfypoOVS1biKVvayTqR5T61D0CFYgI7IwFu2snMso+QQlrh8jTGwsslWdf5wa12CC
         VP/ax2AhHHRPBmEEic2aX/1GlrOLWWXRAuLOBRiVI+dHWR+T6JYSGy4uFFcgBX8gXhNm
         dl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2WaQ7I8WRNXR3ktHomzCTQq+BUO+MjvAka9zTtI/dFQ8zJSDb1dKlHAchY9VJPLX6SicmSOtxMHVMsc0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIH6liBIO69reiU80hEmGGBZMc1JOVPYVx0SPPPxkaluFUPhkJ
	c5t3M7moG+rklSXzfPpgB4XHRyW7ipvv6Cud0AU0OQ/3XAcEFr7snj262e9nb4IgRbE=
X-Gm-Gg: ATEYQzw/88/Baf176kFSbuUR5hCDPMN47QePiBkX/+qbH5g+jM0cDv10t8Dyit1X1kw
	lpZbpq6qmSDUvggwapBWTiCdNd/aVqwCr7oebx3JLUGRILiDgnPUlkjVWFlrFYS9ld+tnBKkJ3J
	w/iQqc2GXw1vbz2xupC2yr1iCeU+g1eB+HlPaxrWM1AyIgoFihbFOSjw285C2KXFTAQpbQBs4Bv
	IEwYs93QYzGp+bkdLPsvb11HZvCqgmf9x4KeGdSVwfCo1xD/POPEs6gjTM9Nm6PePnrCa52/wtB
	v/6rtt9X0e4DKB79jgSrNX8ij4BFaNSmQm1WgutOxw0Pu2pIYKrCAlb+jF5qCUdIM3xrq5A/jfb
	1yotVCe/T1LccBC92UrpGD+X/e4LSH/lbffDvoDSJJbINUsQlHHEnuImxGCvOrHEjCSCjdOtr2A
	SUaPBcn+i9vLpdhC0nLApZycZPmNfKfouY4l7I3/SZ1WnLsxqHQykflyha9/6txGs+5ABZD1+V+
	8ocDGATGIn7OCzyPXiqKNz9nI8YXNRUsw8FSeolibM=
X-Received: by 2002:a05:6a20:1604:b0:398:84d9:64ef with SMTP id adf61e73a8af0-39c877ed8f8mr11229915637.2.1774945325225;
        Tue, 31 Mar 2026 01:22:05 -0700 (PDT)
Received: from ?IPV6:2001:8004:5110:823:53e8:bcb3:e257:c74b? ([2001:8004:5110:823:53e8:bcb3:e257:c74b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c769179e30dsm8564549a12.20.2026.03.31.01.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 01:22:04 -0700 (PDT)
From: Andrew Donnellan <andrew@donnellan.id.au>
X-Google-Original-From: Andrew Donnellan <andrew+kernel@donnellan.id.au>
Message-ID: <09db4bdb-6c87-484a-a2c9-87a1a2af2a8a@donnellan.id.au>
Date: Tue, 31 Mar 2026 19:21:51 +1100
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
Subject: Re: [PATCH] MAINTAINERS: Update ocxl maintainer details
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>,
 Christophe Lombard <clombard@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20251210-ocxl-maintainer-status-v1-1-d73981866db9@linux.ibm.com>
 <7bc40b84-4f1a-453f-9040-4ceae4d7e638@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7bc40b84-4f1a-453f-9040-4ceae4d7e638@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/25 00:53, Frederic Barrat wrote:
> 
> 
> Le 10/12/2025 à 11:49, Andrew Donnellan a écrit :
>> I am leaving IBM, and Fred isn't working on OpenCAPI either. Mahesh has
>> kindly agreed to take over as maintainer to review the odd fixes that
>> still come in, and he has plenty of powerpc-specific experience.
>>
>> Add Mahesh as ocxl maintainer, remove Fred as a maintainer, and downgrade
>> myself to reviewer using my personal email address.
>>
>> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>> ---
> 
> Thanks Andrew! It's in good hands with Mahesh!
> 
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

Can we get this merged?

Thanks,
Andrew

