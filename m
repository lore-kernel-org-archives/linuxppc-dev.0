Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FD4C67863
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 14:13:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C148C2075D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 14:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C148C2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gC074HHVzDrK4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 01:13:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.193; helo=mail-qk1-f193.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gBxz4H5VzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 01:11:19 +1100 (AEDT)
Received: by mail-qk1-f193.google.com with SMTP id u20-v6so3199369qkk.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 07:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v9E684k29J3F/CsqOHc/n8it63zUcqkN7YlLpHd0JmA=;
 b=ZIdx2EIoITwfxzkWcTTq08A+wNKl6hJcuTuoFyHt7XMA/5BtpAHeN4u0e57oLpOV9O
 KPkvReKD7hsu8P8iciOgDF0NIUKhc4DUmMyfOFnTxd9aaeoFZZkKQDG+Tj3kNSAbP1Cz
 uaTIGF08tGQoYzbKKS1JMw6g33E3NuuNoZRlpzPYkNj+x7sIepGgMaXCCsl4e05+EmoS
 L1OrpF7C/wnvDtmTnohCS9JtRzBvh2J+kmV28aY+c337l6RNpTMtEhMeurlUldhRQGRK
 HOriq0RvpHWfmHAeHnILMVKCMopttvq9Vn9y5tawicB9Cps4oT2b65hfEE07G9VkZIzI
 edIA==
X-Gm-Message-State: AGRZ1gKFFnF9yNUQtqg6fC9eTXI1ExIyMX3VwrWAHOTMuJxDCO1iZqeW
 CPxlGKyLD2EMlXF3oVgo/FE=
X-Google-Smtp-Source: AJdET5c+zds6y/8TR+LG5lnsbjtWWX728Nyy1jqKupcQROXw/7mXiKlMDYvnFl02MxqmZNqfdjRFTg==
X-Received: by 2002:a37:9985:: with SMTP id
 b127-v6mr2542690qke.155.1540390277099; 
 Wed, 24 Oct 2018 07:11:17 -0700 (PDT)
Received: from [10.0.0.11] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id m61-v6sm2780619qte.30.2018.10.24.07.11.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Oct 2018 07:11:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] selftests/powerpc: Skip test instead of failing
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1540326197-15537-1-git-send-email-leitao@debian.org>
 <1540326197-15537-2-git-send-email-leitao@debian.org>
 <56cdd832-6229-bf95-58ee-1783f931e7bd@linux.vnet.ibm.com>
From: Breno Leitao <leitao@debian.org>
Message-ID: <132d7e4f-153f-8ba4-95f2-f0d9c1a66f28@debian.org>
Date: Wed, 24 Oct 2018 11:11:12 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <56cdd832-6229-bf95-58ee-1783f931e7bd@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Tyrel,

On 10/23/2018 05:41 PM, Tyrel Datwyler wrote:
>> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>> @@ -352,17 +352,11 @@ static int write_core_pattern(const char *core_pattern)
>>  	FILE *f;
>>
>>  	f = fopen(core_pattern_file, "w");
>> -	if (!f) {
>> -		perror("Error writing to core_pattern file");
>> -		return TEST_FAIL;
>> -	}
>> +	SKIP_IF(!f);
>>
>>  	ret = fwrite(core_pattern, 1, len, f);
>>  	fclose(f);
>> -	if (ret != len) {
>> -		perror("Error writing to core_pattern file");
>> -		return TEST_FAIL;
>> -	}
>> +	SKIP_IF(ret != len);

> If we don't have proper privileges we should fail on the open, right?
> So wouldn't we still want to fail on the write if something goes
> wrong?

That is a good point. Should the test fail or skip if it is not possible
to create the infrastructure to run the core test?

Trying to find the answer in the current test sets, I find tests where
the self test skips if the test environment is not able to be set up, as
for example, when a memory allocation fails.

File: tools/testing/selftests/powerpc/alignment/alignment_handler.c

        ci1 = mmap(NULL, bufsize, PROT_WRITE, MAP_SHARED,
                   fd, bufsize);
        if ((ci0 == MAP_FAILED) || (ci1 == MAP_FAILED)) {
                printf("\n");
                perror("mmap failed");
                SKIP_IF(1);
        }
