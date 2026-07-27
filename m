Return-Path: <linuxppc-dev+bounces-24851-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0069BC53200
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 03:13:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7kF86hNhz2y1F;
	Mon, 27 Jul 2026 13:13:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785121996;
	cv=none; b=QepROWfRtFIbdEXFrjo4ARAjmD1HveTaM93ev8pSc20WX7dx+RfJO1RfZPz/5960lbimFF1lQdma31ITuhlcXc0kwjBMJcW8UvYpPVjah5tSY4erqv8pssmN6wq9M3swu/Xcv2ocnaG9eOSYkWN4J8P8xTYYvkDdq6UtFKz3IPUEVdRxs9pFokV1hFpPsS0xScW1qndcKv2J/yeNgrgJfSgYKDf/8UwnVU2CqAvL47k/DMY+DMMRGsu9FmVloYDXH7d6yX8HBfHmHSBCC13u5WmmKAON4hMXtkXqz72KSbKTSriazMuDoj1tDbX+FcifnHahfTIpyPYR2jr6FpdJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785121996; c=relaxed/relaxed;
	bh=jJpzWOd2AQ0qcTlQZVOnkgLY7Mxhg/fTu1TETcsiZ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9HwSdgPjU6YWWBdo8f2mclxqBsQoXgKacUhwgMBPRJ/04qDctE8o0zJNn3SQfcBzbR9QvUCEZQwc7m3VnQ8AI9Eum1rB901A15Hb9R58QqAGQKYJqFSOZ9QitI+pNqNnYE7etDLB2mEqA/MFICiCfN/VSSULdesQgbNw6m9AmbAJIWiZHYe2HXsaVPSkBhadYK8fjP2/QfURIG0KioCyT/H9izAQagkebAY1cYTRaW55S7AFg3x0NqOXc7B4jl5m50IjSBzCTeciw0V7N+4gxS4jvgJKR7xIMLLbOIOqZJb4gJwVWioseq1D3lc4eqLs/t8RdJCkbVj9+a9cJoRhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=IZHEJfIL; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=IZHEJfIL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7kF54KS3z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 13:13:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785121918;
	bh=jJpzWOd2AQ0qcTlQZVOnkgLY7Mxhg/fTu1TETcsiZ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IZHEJfILfjskUgMmZGNHrmCzLAlhFokY2rkrfaWvb21Z/H0n/c7pIqscwxCpzy3a6
	 JO8GcBhH6AfbOgpd31mvxFhbAnKi3hNNKdyLmd4yUk+BZj56/n0Gan7ycmYywBZwUp
	 dRH+d99+fNPs6vzealCHRWiLv02QWh7yKX3+tUeU=
X-QQ-mid: zesmtpip4t1785121908t349a5306
X-QQ-Originating-IP: eeOVjjpr6h1nN30mzWPlymvg2gXH398TA2mHByZ2jLo=
Received: from [IPV6:240e:659:1b0:640::113:101 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 11:11:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12037815108902466553
EX-QQ-RecipientCnt: 25
Message-ID: <AEAA5D0F00F603DD+457fbbba-bb97-42f8-afbd-3dd9c2dacd6e@uniontech.com>
Date: Mon, 27 Jul 2026 11:11:44 +0800
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
Subject: Re: [PATCH v2 1/6] powerpc/xive: remove dead NULL check after
 GFP_NOFAIL allocation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, bharat@chelsio.com, jgg@ziepe.ca,
 leon@kernel.org, akpm@linux-foundation.org, namcao@linutronix.de,
 ynorov@nvidia.com, sshegde@linux.ibm.com, nilay@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
References: <20260724022851.466017-1-gouhao@uniontech.com>
 <20260724022851.466017-2-gouhao@uniontech.com>
 <3fba3c54-ea4f-449c-8cd3-f24c516bb31d@kaod.org>
Reply-To: 3fba3c54-ea4f-449c-8cd3-f24c516bb31d@kaod.org
From: Gou Hao <gouhao@uniontech.com>
In-Reply-To: <3fba3c54-ea4f-449c-8cd3-f24c516bb31d@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: Nq568l2fjb0ETx1z47ieAjHTFU6M8K+VsJ0+LVpGNXOlon28F/NxmqGa
	XbRp4d8sE521XJpwDNBe2KXuh1/q4Vj6ZU28SboOCNCDkWv09keyXakL56Rda1SHg1+4ECA
	pQvkMJLoIK0yWjQEw8207TQlQ0cbChC1qrqkg5nWTVteEY7eegQoN5CIrrBq/nXcYaiodGk
	cx7+C6GzodOVvV7lmUn5AAcVaZFixiccvoqpKTpKSnkYs4eM/cNR++9v1IOUwv2BhYbzPVY
	8CDKNBoFtmy4mBSVVZqdSZU6PLnQ7GLZgQYxTs/NiS1fTHCprfdswG3+p42nLKWe90q/wjT
	rVTKl0E444x9zQ0KyI7pxaLxyhw6HdBa382C3y/I6AzWD3Fvg+2OYsg8zeiAkz2TW8ZV7rc
	aZcA98UeXgQU88o7wpKa4g6s/45KczhP6bFY5PfP+nVDQ0+JbbHdFn2jkRCMDeewHtbsp/B
	vOR6NadfalcDFLssoUW4gb1VvVWd7q1+mGtsRflMxfKYF1JEc7JoawtycvBr0gDoG7XWJVG
	r3j2TVdEy117jcoxYIjTzO+/3aRZySoeqbkhs92iu4AlpJc6AcMhMr/Al2/VFV3HGovWUdm
	OwzctXqb/v2pYVQRK+yrEo8RxUK2wN/twBS9b9tCILUiJR6U+Y3Fq+SidK1fKveYVZ7Z5zp
	cZOCFK0OqcZuzYcVpms5wXkNVkFpsIdQKnvALAIesouvS0jdr0n+kFA/ScAQyTwwmaBPdXB
	T0kT3Q6eQ1MHUCIe0uXZG58FHIl049fHbMsZU2ULhuOhcortEiH0GZLj2w5D8HVIxxc9NaY
	Dv7RqEhh60c4q//35uBcOh1Bhe+6bQitRa+bNVxPTbKRc90P2GWu4C+pcBhuCvEkDq0fSYE
	DsZFGsKRWqehO7HJiwvTcSPWORVtN/fqgSSwmgH/h2k461Wg9HlSMGnDRFp10nDLxLfDutZ
	+yvCUtafIbMk+1kJdvYxQqxfJCoXE7R/tbdZJ9KjiuH+IoZgnf0UeEOJ2X3Caz43GUTsJV5
	+DYEFfrB0LQ/Bz4h3HqIcw5fUoX23rCyS0yeQDTqkFe8Y0g5MN6YYTmZV9VdDjjb9mehZDO
	Bn5rPRFyXPi
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On 7/27/26 01:04, Cédric Le Goater wrote:
> As suggested by Andrew, let's change the approach and remove entirely
> __GFP_NOFAIL instead and make all xive_ipis access paths NULL-safe.

Yes, that's better.

> On 7/24/26 04:28, Gou Hao wrote:
>> kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
>> subsequent NULL check is unreachable dead code. Remove it.
>>
>> Signed-off-by: Gou Hao <gouhao@uniontech.com>
>> Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
>> Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
>> ---
>>   arch/powerpc/sysdev/xive/common.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/ 
>> xive/common.c
>> index dadd1f46ec939..f2904a5c2b7bf 100644
>> --- a/arch/powerpc/sysdev/xive/common.c
>> +++ b/arch/powerpc/sysdev/xive/common.c
>> @@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
>>       xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
>>                    GFP_KERNEL | __GFP_NOFAIL);
> 
> So let's remove __GFP_NOFAIL here.
> 
>> -    if (!xive_ipis)
>> -        goto out_free_domain;
>> -
> 
> Let's keep it now that allocation can really fail.
> 
>>       for_each_node(node) {>           struct xive_ipi_desc *xid = 
>> &xive_ipis[node];
>>           struct xive_ipi_alloc_info info = { node };
>> @@ -1158,7 +1155,7 @@ static int __init xive_init_ipis(void)
>>   out_free_xive_ipis:
>>       kfree(xive_ipis);
>> -out_free_domain:
> 
> and keep the out_free_domain label
> 
>> +    xive_ipis = NULL;
> 
> and yes we should add 'xive_ipis = NULL;'
> 
>>       irq_domain_remove(ipi_domain);
>>   out_free_fwnode:
>>       irq_domain_free_fwnode(fwnode);
> 
> 
> The prepare_cpu() path is broken. To fix, we need to check xive_ipis
> is not NULL in xive_setup_cpu_ipi() and xive_cleanup_cpu_ipi(). It
> should be a straight forward local change. Nothing complex.
> 
> You can test with QEMU. The pSeries and the PowerNV machines are well
> supported under emulation. Ping me if you need help.
> 
Thank you for the review. I will fix these issues in the next version of 
the patch, and test locally.

-- 
Thanks,
Gou Hao


