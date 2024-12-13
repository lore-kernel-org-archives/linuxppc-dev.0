Return-Path: <linuxppc-dev+bounces-4080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62C3E7717D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2024 06:28:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8fYZ0pXtz2yNf;
	Fri, 13 Dec 2024 17:28:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.235.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734071330;
	cv=none; b=AHfE3ifQbhWWMZRaqi2Nzie7ObcTNFamYMmmx/0Z7yAHFWo2Q8HfoHvc7CPlf0k26RytpDsgRSa8B5jUp37upGECIh6TjCr2JvMCw2AwuQSBeNzt48+fDx5tSkmDswm52Udv1lZye+Plz7abAhHnbTFkNBgZS5kVJa8aQy0+tGc4qR7lGU171zn8YcRMHng6jxFd4ZXAccytTq9udLFtLHlDBwiMhXuxnps5kNH1u3RgJGHPdiF+3KwlYI4ss55TValpJbBlUKpBhno/c8960AcfPW5ETayHL8QHxqcGuFGqlNDsJoitJbcWysXlATUWnAQblWdu0eGHESeE1+tV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734071330; c=relaxed/relaxed;
	bh=/Jj91bZEyFVQWZ6WKBYgTkdPikVYbXrVLiZNXIic/Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXuVdXlNp137C7p3yNFupYA9pNAOWpx7v0WHwEdAFaqCLKcNswaJcGxn5XEqhGVE3t6ZuCh4vAQ/dVT47tE4jugFcayJoKsS8Kc7XGthnEaE5+NRylCZqpu8QUa1XVRSblY3KHuRMLBVQJODNTE2sc+9EE/Njb81JPmvk5eKXZ8xRi+g66cwRtdjtt2GoWcrcS/K3wqMBHh4bE3Cca6unqhjIWQIWX549M5U3KzzojIWCsGg+JCLAFPPXqlSdb8oaGZJCATPjo7i5xlkVeN468I/pt/E7DObdUZKBjsSTv1Q2z9BanApJX82LmE5buYo9Kphab0WYDghsEosUIx2ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8fYY1Zs8z2yMF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2024 17:28:48 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y8fYV4W1mz9stv;
	Fri, 13 Dec 2024 07:28:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nRIFyjzOzWwM; Fri, 13 Dec 2024 07:28:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y8fYV3lykz9sts;
	Fri, 13 Dec 2024 07:28:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 719C78B773;
	Fri, 13 Dec 2024 07:28:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id I9yCcYxlM4Xk; Fri, 13 Dec 2024 07:28:46 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF70C8B763;
	Fri, 13 Dec 2024 07:28:45 +0100 (CET)
Message-ID: <991aee8b-fb10-4152-89fb-6ac542ee87c1@csgroup.eu>
Date: Fri, 13 Dec 2024 07:28:45 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
 <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
 <Z1sOTf6UZbruptnl@smile.fi.intel.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z1sOTf6UZbruptnl@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/12/2024 à 17:24, Andy Shevchenko a écrit :
> On Mon, Nov 18, 2024 at 03:10:09PM +0100, Christophe Leroy wrote:
>> Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
>>> Remove legacy-of-mm-gpiochip.h header file. The above mentioned
>>> file provides an OF API that's deprecated. There is no agnostic
>>> alternatives to it and we have to open code the logic which was
>>> hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
>>> drivers are using their own labeling schemas and resource retrieval
>>> that only a few may gain of the code deduplication, so whenever
>>> alternative is appear we can move drivers again to use that one.
>>>
>>> As a side effect this change fixes a potential memory leak on
>>> an error path, if of_mm_gpiochip_add_data() fails.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Thanks, what's next?
> 

Next step is that Michael or Madhavan apply it I guess ?

Christophe

