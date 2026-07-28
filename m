Return-Path: <linuxppc-dev+bounces-24924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65918C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:27:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8WqW5X2pz2xyk;
	Tue, 28 Jul 2026 20:27:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785234439;
	cv=none; b=od62mK1A66Bt0mFLoEVOjozRAjj+WcRHj/V3YBGSxHikyErx9TGra+jmjWpgxABzhFRZy+PamRwjyO+nDuFhwqan+5xhJz9zB66R1QDcDiOF+7Cmg01CMdzG3Lip7u46umrbDGo5yxY3c1vaMISXv9fUbtFl2nHvb+werNHV1le71OZ4ikbTLarT5eJLzMpn+CQG38Rz4h3b9WmpZ/0xPOlQsFHEW0FQJTsHe3Ew5vAcFoVeG0OvT2yi1dQsFF1qU0ClY7V7d7kTty8719s+THH7yFh943Pluz9XDZGVhfhHZGXpW1Vcw/kHA5GTnm6V2CQGhS6W++7FEKEvFa7YHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785234439; c=relaxed/relaxed;
	bh=Nn5iXoDHWX0JycAQsqyniXS6ZiZ/OL8fjnqaXvlqjt0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fa/EVHT2mF1jI5UdaFanegLgJYSnQfMUfd3Va9O8NIL6G9oZ/AFF0ienZuhR2NvX7LbH5n+iiaQ/0N0IGB4TJrUh2EfAxrEI9q1L4UOTkwIHvRUgGJMIdkjntqkJpEjtfe/pCrV0X3vm3199XySpOLSqdN1n8wPakMGtRs0dtO3cb01xtpC928iGySwH1n3CYafkKoEeh2Q+xKkVlltzLz606Ikb+OFoyBQmEkaFuv4c9QosqWOAhN21WJYdIzoL2EENhBQa876Vgsx9N/z61X4Nwl64IyBEh/lfM7CoIhgXWbIEMNO4jLjXGRDj1VGffOmdq094njkAYd/tPxu7ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Skt06Vcy; dkim-atps=neutral; spf=pass (client-ip=54.207.19.206; helo=smtpbgbr1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Skt06Vcy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.207.19.206; helo=smtpbgbr1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 85429 seconds by postgrey-1.37 at boromir; Tue, 28 Jul 2026 20:27:14 AEST
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8WqR04pdz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:27:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785234391;
	bh=Nn5iXoDHWX0JycAQsqyniXS6ZiZ/OL8fjnqaXvlqjt0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=Skt06VcySkyBaEF9OkJj+s5kweOM6///wL3vZBD8CWwLEsIdDEgw9mZEk02yM2oSa
	 1CYgkOh23VeCiNf9UTqQx6Ec3kxT1gOKDY/PqFfqkHdb3syGOS6xvOX8abps5mvCSn
	 hJSUwAVdctg7S2Wb2ayBgMeP58/b7WdcPHpHqve8=
X-QQ-mid: zesmtpip3t1785234378tca297b40
X-QQ-Originating-IP: g4bzO+VJYaDrFblWxIDwwXHmdZRxgSRd54k3FCR/s9A=
Received: from [IPV6:240e:659:1b0:640::113:101 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Jul 2026 18:26:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8346751080323943646
EX-QQ-RecipientCnt: 21
Message-ID: <8227D7D48CF8EC74+17606f64-1639-49b1-8335-8dab2eba01e7@uniontech.com>
Date: Tue, 28 Jul 2026 18:26:15 +0800
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
From: Gou Hao <gouhao@uniontech.com>
Subject: Re: [PATCH v3 3/5] powerpc/xive: propagate IPI init errors to prevent
 use-after-free
Reply-To: amgYWAAGZ61VTXDc@linux.ibm.com
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, namcao@linutronix.de, peterz@infradead.org,
 sshegde@linux.ibm.com, kees@kernel.org, lgs201920130244@gmail.com,
 ynorov@nvidia.com, nilay@linux.ibm.com, clg@kaod.org,
 benh@kernel.crashing.org, miltonm@bga.com, mkchauras@gmail.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, gouhaojake@163.com, kernel@uniontech.com
References: <20260727104215.184786-1-gouhao@uniontech.com>
 <20260727104215.184786-4-gouhao@uniontech.com>
 <amgYWAAGZ61VTXDc@linux.ibm.com>
In-Reply-To: <amgYWAAGZ61VTXDc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: NSEFX6u+4l+Kia/+DCTIcAJpA3Ax5uz7JLP0ArzXdoECNhvKyu4Qh68W
	WiDfngJqN1dtjA7zHlvUcNjIinXoBf+yOTOjEO0HBg/DlyjuMjcbXAV2G+WXvMjcXBY+Bjw
	IcggKvaAMoUJb3Pl3bHtkwAiqHoa7nEVrbtNC/nnuI6YnvlYE+nquODY7dEE5fwZ4eH32K8
	9LrU0wipjHVTn6oZBaPsbMbPHDBfbaBCsLw8boF6GW4t5uYXZE12CbAazURRUCCpWOedtYe
	xacr+dwfwZo+W8NnMdHbDSm+uc+J2l127NT1RHNgvyshs0mMoN0tASlpiYM3iEg1NKbnsjv
	8OO9s+P5A8sUipzZ4iU3LMfkFa/aN1th9Dvn3s8m7JHbRb+Qe6U6pzmEyyfCWRp9qcXyr4A
	D7sZrOq3pkGMpInYwASR2/53GKdPDCshX1LBdzOz8qHm0Us+9/ci+mKHYmKZiPaO/2tuUNG
	OCJ57JBmxeJACnYz6YaAovGGHhZpjO9T9+Dfre1uxuAY/uYc7uFIw+MEEzFEtjmXUvp+lx+
	2fdUbiqB8uO/kdXS+zhpNEsM81zk0+0acqGgELcPHZJHN1oXXSD+amBotbDr3sGHnOKOSKe
	H8FzKLol7tjhUCT7VdmixKWktl/W42Ecgmp5PAp610G9s6E6cGfaj4zroWjIhKa42nwu/TJ
	jSS+b26WCad3qylY49LdACU1p4lYBWywpBE77wviPYztQv26cnV41SDukfZUw179BuhRcl1
	DAMv+BIO7ItnjmkL7SrvlTXbLraUMzOpCgKsYbzqF3i/tk44VMd9ocvCyvqMTKwQfrU3954
	EXVanM4e3mE1N36O8ZUwcR6hyf+mQbxV/sqENm6hpccfiGAPoTezaYHKoDiyTeAGeCklFPx
	iKsNtIrDujKpl0MHjZ/FYc7j4UJB7qT2pdicC6ukC+4dA1GRIqqHS/TFnKTSLSzk1UaqkRa
	+Fy1uLxwoF+8qxMM9L/QCa1j2eneAKHrBKbnhzyYyF35pLt1Q3lWiqHfPBOLWAEXIoKrioM
	92EOMr6FvKlmGhLaJT4Bx4CHGjKrM=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On 7/28/26 10:47, Srikar Dronamraju wrote:
> * Gou Hao <gouhao@uniontech.com> [2026-07-27 18:42:13]:
> 
>>   
>>   static void __init pnv_smp_probe(void)
>>   {
>> -	if (xive_enabled())
>> -		xive_smp_probe();
>> -	else
>> +	if (xive_enabled()) {
>> +		if (xive_smp_probe() < 0)
>> +			return;
>> +	} else {
> 
> If xive_smp_probe() fails and we return from here, what is the IPI mechanism
> that is going to be used?
> 
> Before the patch, we were not configured for IPI and we would fail.
> Now we have not configured IPI mechanism, so what are the consequences?
> 
Thank you for your review.

current approach: If xive_smp_probe() fails, smp_ops->cause_ipi remains 
NULL (patch 0004 defers the assignment). The IPI path 
(smp_muxed_ipi_message_pass) has a NULL check that silently drops the 
IPI. This means SMP won't function, but that's preferable to the current 
use-after-free crash.

> Should we try disable xive_enabled() and try xics_smp_probe() instead?
> 

When xive_enabled() is true, the entire interrupt subsystem has already 
been committed to XIVE in xive_init_host(). XICS fallback may need more 
than just disabling xive_enabled() and calling xics_smp_probe().

Full XIVE → XICS fallback is theoretically possible — the kexec path 
already demonstrates this (e.g., xive_shutdown() on PowerNV calls 
opal_xive_reset(OPAL_XIVE_MODE_EMU), and pSeries has H_INT_RESET). After 
reverting XIVE, one could call xics_init() + xics_smp_probe() to set up 
XICS completely.

Implementing a safe, complete fallback would require careful sequencing 
and likely an xive_exit() counterpart — this is a significantly larger 
change that is beyond the scope of this series, which focuses on 
removing __GFP_NOFAIL and fixing the use-after-free.

-- 
Thanks,
Gou Hao



