Return-Path: <linuxppc-dev+bounces-25116-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49898C55162
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 14:06:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9rbJ327nz2xnp;
	Fri, 31 Jul 2026 00:06:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=46.105.34.251
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785420380;
	cv=none; b=SxQ23DJ3JMU2GipyRZhSEXXmQwZC+UNmIVxZlNxv9iJqyaMTNuG+5al3lEnyVEw8D8ASvnYp31ogNnf8ru8sKL0Skz/zffAVqfPLPTK/eygzttrPc/lk9tMWzju62fThy46Rtzdwk4bEGws0vIV+S10x8FePmtK735C6S3+b/V8olJX0lepwCrfUXmeZgSXUSY+U44L8yAC0gql4L41dI1P3GcyaqY9SMgjhzclXOW+QDnMB3VO2yITmdZwH5ERBAvMWWVCPuvnuu2PpV2ngzdZY1ZuxzpM0S5UCM4nHXwb8HX5qnXx14Etvac8t9szCBYyIwA9v31tHMbrlsesPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785420380; c=relaxed/relaxed;
	bh=9TXFhSKnguuKF0vOqXGMANd6BK2Y6WyDKFdnAhPd7+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvQwIi8GK/6MehG4EjwDLJq5r2+CiUJVBoNjPkIfDGyfhVHV6aTECgh5ri1X2R2CuxiCL5IYn8oP6wNhqwbvjZEdFqjUwfuqHGK7CXHVgaVIxN85MlLsZ4zvuNEZEYfriDBWPpIOoBYgeDqOfR4yxgZTbKUpkxmwYwR/DL3E2NzXbG8uip7Ziki7JnaMgAJwCkFKcfS399vyozwk5EeL+PxFYuNKVJZ3MTVvmCQkEjdu5tNNtVCNVi8dTKYXOGD6j4EL2sHeiQQdo/t0yDGvdVp4Do4810JAyUlpefYHFWPdU/jC1HICMixz//8+bmkjJsLSJb0cP68+RM9AEqsxzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org; dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=j1Y/VctN; dkim-atps=neutral; spf=pass (client-ip=46.105.34.251; helo=smtpout1.mo528.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org) smtp.mailfrom=kaod.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=j1Y/VctN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kaod.org (client-ip=46.105.34.251; helo=smtpout1.mo528.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org)
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9rbD2wfFz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 00:06:14 +1000 (AEST)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [57.128.106.70])
	by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4h9rb31szPz6G0Z;
	Thu, 30 Jul 2026 14:06:06 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <gouhaojake@163.com>; Thu, 30 Jul 2026 14:06:06 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.172])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h9rb23kNXz7vq3;
	Thu, 30 Jul 2026 14:06:06 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
	(Authenticated sender: clg@kaod.org)
	by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 3E1E51923E3C;
	Thu, 30 Jul 2026 14:06:03 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-112S0060b587b28-99f4-4694-9261-c477869e1f34,
                    AC7CF6B499241E80DF5F4EA75DE932BE963BA335) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <5dd79d09-d064-4bbe-9a97-215968252b83@kaod.org>
Date: Thu, 30 Jul 2026 16:06:02 +0200
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
Subject: Re: [PATCH v3 1/5] powerpc/xive: make xive IPI allocation NULL-safe
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Gou Hao <gouhao@uniontech.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, namcao@linutronix.de, peterz@infradead.org,
 kees@kernel.org, lgs201920130244@gmail.com, srikar@linux.ibm.com,
 ynorov@nvidia.com, nilay@linux.ibm.com, benh@kernel.crashing.org,
 miltonm@bga.com, mkchauras@gmail.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com, kernel@uniontech.com
References: <20260727104215.184786-1-gouhao@uniontech.com>
 <20260727104215.184786-2-gouhao@uniontech.com>
 <ff80d246-1bc6-4092-861c-9169d0fc599b@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <ff80d246-1bc6-4092-861c-9169d0fc599b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6507138515010628668
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFTDFqvRsx6GODkBq9UjxxCZAHTXQO26oYXl3nseKyzL0OCmbNzYWvmLOgyCtqlaMHbY/e1uynls7SXE0674T1Ebw95ZdbcSqVEndcJlOAOtNXmY/D1yZOLx/5et47VCz6Lis3dleaYmEwYoqyClvv+4pYjroTYkUXklq1dc1nT3Z3HHlHdlEtQtDbZDNPDwfpc0CCRfwCZtt7sXVzKikjakLuMLWg7saU1ADhnjHU8Cl34DTvMeC/3LGhhAsWjRcpHClsaSMVHCXG/OZ+apIXFrT4mPxDmaXoPVTXb1QtGKiVWe5CPuxRQumxii4tozqgB6OmGXdV91ni9sQ81BhVCc9zYO1fvRhDBkpdZGeigZumi4F1bnAwHM51Qhe3HB0tX4Srl2Uc+xLkrUe5vaeo8p4U10LvtmieU8NAoCZ8Y0/TwbcqRSvHUT78L9sGPLC0Fw3raqUnU2+UUO+lO3i2bJDsOPCb/Cxgl855TryUjU1z3rXf092qoiZikeUqxYl8x6maChhGD2i7eD2UrU/8skXDdoQgrKOAlfTNwQYtDJT0NrhRXWKIWu08W1TFGq9z3eHZnhwttrt6+E40wmzYi9LC+nVBeEAdoGeCgtFAJoIVi8G9JNUfcn2PiCCAh3qtfsh82uZDYEjpX6u9M7TKjiJ7ioGFflC6JOJkpjhAHxQ
DKIM-Signature: a=rsa-sha256; bh=9TXFhSKnguuKF0vOqXGMANd6BK2Y6WyDKFdnAhPd7+o=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1785420369; v=1;
 b=j1Y/VctNRVY84GLgIj+umutlcAgBHttulIR5P/SNvRZzZm6ifZo5B/gajOnRafEErFyr++1F
 Ql6Mu+KkjKUiCeDC+ZtUMFK5pEqcbnSMy4j+w7p4GdLhc2N9Hv+yjBs0dAQeE+9VyLULZ135wMz
 /bpaJBELbG9UpFXXUTfX8RACA+tXz5O5g0zUXD0nnIclRH3uAXxPZ8nu54zAPeEaqETxn1krbGp
 mGSrBH3PbXHXQpuwKOITLnS2MFe6fMTk78JmF+He/jx3gkVMH6zbuRhcJRyIXponWuZDJUIk46g
 RyYvb8KUTbYXK/p8DKy8isjK3MlY2ZrTpzoskN7b2bzyw==

On 7/30/26 15:53, Shrikanth Hegde wrote:
> 
> 
> On 7/27/26 4:12 PM, Gou Hao wrote:
>> __GFP_NOFAIL should not be used in new code [1].  xive_init_ipis()
>> allocates the xive_ipis array with __GFP_NOFAIL, which makes the
>> subsequent NULL check unreachable dead code.
>>
>> Remove __GFP_NOFAIL so the allocation can fail, and make all xive_ipis
>> access paths NULL-safe:
>>
>> - Return XIVE_BAD_IRQ from xive_ipi_cpu_to_irq() when xive_ipis is NULL.
>> - Set xive_ipis to NULL after kfree() in the error path to prevent
>>    use-after-free.
>> - Guard xive_setup_cpu_ipi() and xive_cleanup_cpu_ipi() against
>>    xive_ipi_irq == XIVE_BAD_IRQ to avoid dereferencing an uninitialized
>>    or already-freed xive_ipis array.
> 
> I would rather prefer a BUG_ON if the allocation fails. That keeps the earlier
> semantic.
> 
> - If xive fails, then who will send the interrupts?. It is better to crash instead
> of leaving the system in weird state.

Then do like XICS, which has BUG_ON(). I don't know why we took this
direction when XIVE was first introduced.

C. 
>>
>> No functional change when allocation succeeds.
> 
> Please don't put a statement like this.
> It should be either no functional changes or function changes.
> 
>>
>> Link: https://lore.kernel.org/all/20260725202632.dcb325658896a470df91cf57@linux-foundation.org/ [1]
>> Fixes: 7dcc37b3eff9 ("powerpc/xive: Map one IPI interrupt per node")
>> Signed-off-by: Gou Hao <gouhao@uniontech.com>
>> Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
>> Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>> Suggested-by: Cédric Le Goater <clg@kaod.org>
>> Suggested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>   arch/powerpc/sysdev/xive/common.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
>> index dadd1f46ec93..86c78af1f68e 100644
>> --- a/arch/powerpc/sysdev/xive/common.c
>> +++ b/arch/powerpc/sysdev/xive/common.c
>> @@ -74,6 +74,8 @@ static struct xive_ipi_desc {
>>    */
>>   static unsigned int xive_ipi_cpu_to_irq(unsigned int cpu)
>>   {
>> +    if (!xive_ipis)
>> +        return XIVE_BAD_IRQ;
>>       return xive_ipis[early_cpu_to_node(cpu)].irq;
>>   }
>>   #endif
>> @@ -1132,8 +1134,7 @@ static int __init xive_init_ipis(void)
>>       if (!ipi_domain)
>>           goto out_free_fwnode;
>> -    xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
>> -                 GFP_KERNEL | __GFP_NOFAIL);
>> +    xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids, GFP_KERNEL);
>>       if (!xive_ipis)
>>           goto out_free_domain;
>> @@ -1158,6 +1159,7 @@ static int __init xive_init_ipis(void)
>>   out_free_xive_ipis:
>>       kfree(xive_ipis);
>> +    xive_ipis = NULL;
>>   out_free_domain:
>>       irq_domain_remove(ipi_domain);
>>   out_free_fwnode:
>> @@ -1190,6 +1192,9 @@ static int xive_setup_cpu_ipi(unsigned int cpu)
>>       pr_debug("Setting up IPI for CPU %d\n", cpu);
>> +    if (xive_ipi_irq == XIVE_BAD_IRQ)
>> +        return -EIO;
>> +
>>       xc = per_cpu(xive_cpu, cpu);
>>       /* Check if we are already setup */
>> @@ -1234,6 +1239,9 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
>>       /* Disable the IPI and free the IRQ data */
>> +    if (xive_ipi_irq == XIVE_BAD_IRQ)
>> +        return;
>> +
>>       /* Already cleaned up ? */
>>       if (xc->hw_ipi == XIVE_BAD_IRQ)
>>           return;
> 


