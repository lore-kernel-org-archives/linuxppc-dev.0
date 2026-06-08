Return-Path: <linuxppc-dev+bounces-22189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1770CD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 12:45:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYsFw2Vvlz2ytV;
	Mon, 08 Jun 2026 22:45:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780922724;
	cv=none; b=SwCZAI+iSx7qeR0uomSC+TMSc1g1pVRVxm6I3nWnNSZhgIbOHdbHb7EXIggRN5aB6Cihr1eyUW1BLyOp1OP6hvY9v/tLdB5FO3+7ES33EuE9spcbY0csYheCZxEVM++arpyRE0XuCPD56ThZ38tQ7Z4cVRzGWQ6VNUzZlNdg/OtBWE6e17Y81gOpkLhmGjqPCZSVpJAIUfAr2bLPNzKSFHw5A2Bfs7+ZqDJw7xDoQXwaYOyUp/Jh2w0MgVOEwRyaqswt0lbTnsI0uoR4OCm4o22FLJBCv8q3AfCgQIxBuS2Xcwmo4mkaL/OaQpjHI3O+qe2Mf/mjMxG606wBv7ChMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780922724; c=relaxed/relaxed;
	bh=OBX5ZjVJ9Vt5icolNqsYRF5h5TyAgyLBE7tpU2Ey3us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/nAP4FrjDuUiZLnsoz8Oig9p3303ZF6UNAn6UvwYXma+yJtqDf9axRC8YW8PvwdRAk/ROgIez0qPLrg0w4v7VwyD/j0aFHlcu14EomdkoIp0TLNfprBTgLgA+rWk0GioHqCkRMKHugtliHI7MTNL8cu57gpGu3mNOHA5gR15BqSKzoQgtDN181RvAqA5GZJD3WcCOZGMZ3ZmJFDt/SmkvPyKMVo75HLhnP8Qb/FVCRDCVTN6n42tnYmGM9K1BEJVCJlNu/iYPibCpa0jsNJWPpWAYeN7UPxxwFwF53TUXSZQpBGZeeXl40xsojHMdPqH4oKARA7ZkXh0Q5aNrpMbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWO3+cBX; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWO3+cBX; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWO3+cBX;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWO3+cBX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYsFs3Dhrz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 22:45:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780922716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OBX5ZjVJ9Vt5icolNqsYRF5h5TyAgyLBE7tpU2Ey3us=;
	b=jWO3+cBX7U4xGjrR3+YRdcKxkxtPtIhsFj9NtC77KW4Q9xFq8R0dQx65jYaet0OrnXQ/sE
	7VZdDPuJKMQ5HMxm/g7Im4ZsiHvmzCANIRY4Io0HQWVP6HUvAgweeXimZeazwTLt4SFtcM
	0kyew7RW7lb/gPibtZu0i4JBDMnx5eE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780922716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OBX5ZjVJ9Vt5icolNqsYRF5h5TyAgyLBE7tpU2Ey3us=;
	b=jWO3+cBX7U4xGjrR3+YRdcKxkxtPtIhsFj9NtC77KW4Q9xFq8R0dQx65jYaet0OrnXQ/sE
	7VZdDPuJKMQ5HMxm/g7Im4ZsiHvmzCANIRY4Io0HQWVP6HUvAgweeXimZeazwTLt4SFtcM
	0kyew7RW7lb/gPibtZu0i4JBDMnx5eE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Pnvwh_qhNAKwXI3RxDMqOQ-1; Mon, 08 Jun 2026 08:45:15 -0400
X-MC-Unique: Pnvwh_qhNAKwXI3RxDMqOQ-1
X-Mimecast-MFC-AGG-ID: Pnvwh_qhNAKwXI3RxDMqOQ_1780922714
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4600c8cb13aso2600290f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 05:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922713; x=1781527513;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBX5ZjVJ9Vt5icolNqsYRF5h5TyAgyLBE7tpU2Ey3us=;
        b=E3PJnhOW9LEzYzEblQ13lyyBZla5AwH68LY6mdw40qscPilW1cNFzANOgut8jjXryH
         1EM5CbK/WVTvODR0GhwLc+O2gfwmYgK6WtDC1WckbgaBFPurO5nClVOQ9SQnpabhwubO
         EPdQXf4TCjEgzrcgbAS5UCz4DU8lrbQ4PoMTFPA+tNYwWsoYoHvlNdC1xbCe68J6lTA/
         NZsh8QL2MURIkmtNykNM0+Ak82S3P2CaEyjVukBrsMFHCMY/8DvXbB0thVZR1LNFhJJV
         FYqq9KTcHsk9ZpsFluvr1pePiqSd2oZp+9S5KXsI+4hBpQ3XyvVAA+WefMB3pIYUWAbS
         FEoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TYSrZAlHND8OrLyveKvgEoMAnuMmYWAfkwdLwpCZz8ofbK9TXMq8xhBxYnCstkiRwXLLvdVEE0jWsAlU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyzy9KI9hBSs81GrW2WLL5GDArT6u2LYwOmiFJ+Oxhw9m/wKRNo
	QePL/UOqTK5i5KZ+EzgcXpmiLlyiJrrZa5MQ2YcWPs8jsq3dx0iSljSO9/KVkdPEoKOVdc5oc6n
	KUaA/uj/imuLW0dx0OexeUYAsvuAXLPoW/16VBlpKdJEu1jtx8XGZbe+UaqCpaxHnPY8=
X-Gm-Gg: Acq92OFsX8ohbsia/P4FfhNQkWx1p5jq4e0cimjH8TSHe6Y3SDWyMeqIOAoFyQ4Ge8z
	d5/5bXLjA7Asaop+6Nuvp9QPVyom/R9VDCnK5/BqdoQN/E1rL06EIuI3t3Z46H52YC9ZDRS0V6e
	uXxOIGqb2MkEWWqkT8flOdIltxfjRqD7Kw2i0RU2y7O4N78eP6ejR6iPoUbL6k+05HB1pFfmoR7
	5gMEOygiTW9xB0c41RisBljBOT+15IyBaSGyHRevgpAW6lt/Yu3eGDLmCwqch+9bQ8Nb13HcZYb
	231DoHH4jNYrpoIcRFTMeq/wFuIsbB2S0cKizTiFm0cm3qw/tEwpy48i9p2LW0RMdvhuEvCzzeA
	4vmP+V7/Le161YJW0f4ozfMXANk/QOw==
X-Received: by 2002:a5d:5049:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4603063cf3fmr17162358f8f.37.1780922712948;
        Mon, 08 Jun 2026 05:45:12 -0700 (PDT)
X-Received: by 2002:a5d:5049:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4603063cf3fmr17162311f8f.37.1780922712460;
        Mon, 08 Jun 2026 05:45:12 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm53768450f8f.13.2026.06.08.05.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 05:45:11 -0700 (PDT)
Message-ID: <b7aa2c73-be32-47e2-8452-e626845f4d3e@redhat.com>
Date: Mon, 8 Jun 2026 14:45:10 +0200
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
Subject: Re: [kvm-unit-tests RFC PATCH 1/6] powerpc: add pmu tests
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-2-rathc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260602064806.3101025-2-rathc@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7qDT447UBN_9XCjKN6g5O2ThdIwjsd3SC-jTB3VqWlk_1780922714
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 08.48, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Add some initial PMU testing.
> 
> - PMC5/6 tests
> - PMAE / PMI test
> - BHRB basic tests
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   lib/powerpc/asm/processor.h |   2 +
>   lib/powerpc/asm/reg.h       |   9 +
>   lib/powerpc/asm/setup.h     |   1 +
>   lib/powerpc/setup.c         |  20 ++
>   powerpc/Makefile.common     |   3 +-
>   powerpc/pmu.c               | 567 ++++++++++++++++++++++++++++++++++++
>   powerpc/unittests.cfg       |   3 +
>   7 files changed, 604 insertions(+), 1 deletion(-)
>   create mode 100644 powerpc/pmu.c

  Hi Chinmay,

the problem with Clang on Travis [*] still seems to persist:

  https://app.travis-ci.com/github/huth/kvm-unit-tests/jobs/639614142

Could you please have a look?

  Thanks,
   Thomas


[*] This already happened with Nicolas' last version:

  https://www.spinics.net/lists/kvm/msg351218.html


