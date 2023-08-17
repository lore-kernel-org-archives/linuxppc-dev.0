Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B42AC2FC14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Aug 2023 12:48:30 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kIK4mCA3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRPv05QKHz3cGM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Aug 2023 22:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kIK4mCA3;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRPt36KJXz2yVp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2023 22:47:39 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
	id 4RRPt35m7qz4wy6; Thu, 17 Aug 2023 22:47:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1692276459;
	bh=wZiTI8CR38/3QTUTH1PhMf9XS4nHplieDjj0LRk5an0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kIK4mCA3pouUSyX2xZPGRmXQ/GKmdvJnQQE0h8FpVJXqrp4plQRKLqXeB+9rR+S+7
	 Ssk002TqfBqwkHWVRpGwBNfLBpRsnUa3gKXml+sIVzmTvzHI1KbH90BN0NpMSaJvbU
	 dxQ60AclpwofqNlN7xB8l5SWhQ4os8EnGeQIpLdf1wkvApTQDvtngXsYIJf12zPaup
	 /uSvu4Um6GNAonA8q2jAu/2Mi97Yok10Jy6xLMhjIa7ne+5pqoQ13+zXx58BhFaRo0
	 M0aNLM7la3xOjvGMKN/5A2S5+Jctthai75tOlv9kwOPHWy58M+GgJFP3BI/1gdxwIi
	 R4ddJVqUKCfbQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRPt34pCxz4wy5;
	Thu, 17 Aug 2023 22:47:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc/fadump: reset dump area size if fadump
 memory reserve fails
In-Reply-To: <8732c11e-77e4-2231-dc84-568a5e8ea652@linux.ibm.com>
References: <20230704050715.203581-1-sourabhjain@linux.ibm.com>
 <8732c11e-77e4-2231-dc84-568a5e8ea652@linux.ibm.com>
Date: Thu, 17 Aug 2023 22:47:39 +1000
Message-ID: <874jkxesyc.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: mahesh@linux.vnet.ibm.com, Mahesh Salgaonkar <mahesh@linux.ibm.com>, hbathini@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sourabh Jain <sourabhjain@linux.ibm.com> writes:
> Hello Michael,
>
> Are there any reviews or comments on this fix?

No, looks fine. Will pick it up for 6.6.

cheers

> On 04/07/23 10:37, Sourabh Jain wrote:
>> In case fadump_reserve_mem() fails to reserve memory, the
>> reserve_dump_area_size variable will retain the reserve area size. This
>> will lead to /sys/kernel/fadump/mem_reserved node displaying an incorrect
>> memory reserved by fadump.
>>
>> To fix this problem, reserve dump area size variable is set to 0 if fadump
>> failed to reserve memory.
>>
>> Fixes: 8255da95e545 ("powerpc/fadump: release all the memory above boot memory size")
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> ---
>> Chnages form V1:
>> * Reset the dump area size within the error_out path to cover more
>>    failure cases. Furthermore, the commit description has been modified
>>    accordingly.
>> ---
>>   arch/powerpc/kernel/fadump.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index f3166acab09b..5a07d0f9c7f0 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -654,6 +654,7 @@ int __init fadump_reserve_mem(void)
>>   	return ret;
>>   error_out:
>>   	fw_dump.fadump_enabled = 0;
>> +	fw_dump.reserve_dump_area_size = 0;
>>   	return 0;
>>   }
>>   
