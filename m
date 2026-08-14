Return-Path: <linuxppc-dev+bounces-25857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D34C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 08:12:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLw2P41jVz2yS0;
	Fri, 14 Aug 2026 18:12:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786695165;
	cv=none; b=HSfOwSvnDanYF6RWCp7GiaMEgTsmUJirHUA5LtLhcsYB6hjoNTozlgzcloSScpvC6Fji3NmNxyW6C7+9yIBHV2TwupuDGvqKyknbN+vXDKPv/xs3kh+q0xDEB92AJWx9Cy9XUzWESXh+pkOOrj4O7G67Cg+xXhKoyfRUxKL7TDtpVTMNseMi449n5wXPUrVElohIfsy7Kzu3spCyy7pD2POgWiU9mAt3CA5bzRsgNd33eXEjMSMItJVyTZV8voeX9ApLmJ04TY7Yxyup/FdHE5l5A4x2/PLQRRirzaAMf3jk0S28a4b9LDMR4FKI/UhnbVuOQwocuqp65R6ufMiHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786695165; c=relaxed/relaxed;
	bh=N9rgzWOT5ERO/iBAjWJm0I+ZwZbpkreU6DGPLtd6BSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyjcLBtnH5SM253Q8LcyYoQEV7zCLR61p916dnTiyt/9zWMr0RJW8ZvP+7rzz1l8bd27OitCq4KJZ7YBTcFaM34XMEBfO/6oVbMnmEa2/WnFp0WHOutW3E9gmc1cH5VqcS+bjvyV6h2EpfbUFMh4FxW/vbL8XX1D3cAKZzllAYLa6lsC6osR2cM57pIkGmbiRB4WZ7RDxQrc3WFnF8gilCBlRQWNEvrpBV8+Zv0k5yrw1J8P+grs2+egVKAs+49oIO+Ud9soV0W2DLqDitd1XVfG5xhXefj2n+KON2Hkbcd6DQkNA7tsP8/C8mc3Tnt09ZO9vNKdLMuDtL81wJgInw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hFG4W94U; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hFG4W94U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLw2N5Phkz2yRZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 18:12:43 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E81YX9533164;
	Fri, 14 Aug 2026 08:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N9rgzW
	OT5ERO/iBAjWJm0I+ZwZbpkreU6DGPLtd6BSk=; b=hFG4W94UBsN52vAbWS5Nf2
	Ref6hvaNWO/L1Lq/dWJmz+ZWEm7Gd6MydV9JPD2WuLtKdeH/oUhAf5SdXObMzuRd
	0o5ixw3TZiUhim8WVPAo4Q41xGQnD5K1d8UfYY/zRA7QKNYCUar++31RVBSYiSkV
	UhwTpKa4sUJNhHyjv9u14bsnoRVT0iYGogEMtrrkVG8fUfxnIVS3VYM/j0g6DxtL
	vmxyfP7cZqBjJ+plZhQJMh4zRZ4VAgKQtX+aEQY1g3fUzy7MlKWZ0fQrSTdyY0HV
	Utvngi22TNe4HDHbeWevauayz8KEqNIHavIg2CBOJF0WpguM0aYaJmM0DpyNVUcw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9uu82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:12:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E8BeoK002250;
	Fri, 14 Aug 2026 08:12:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv98gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:12:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E8CJ7u50856226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 08:12:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D4720043;
	Fri, 14 Aug 2026 08:12:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A776420040;
	Fri, 14 Aug 2026 08:12:15 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 08:12:15 +0000 (GMT)
Message-ID: <ce787895-e2f1-4e32-b2c7-737e26c862f9@linux.ibm.com>
Date: Fri, 14 Aug 2026 13:42:14 +0530
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
Subject: Re: [PATCH v2 2/3] firmware/edd: use kobject_put() on
 edd_device_register() failure
To: Tarun Sahu <tarunsahu@google.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, djeffery@redhat.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, dmatlack@google.com,
        Pasha Tatashin <pasha.tatashin@soleen.com>, souravsgl@google.com,
        skhawaja@google.com, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
References: <20260813095421.1700945-1-tarunsahu@google.com>
 <20260813095421.1700945-3-tarunsahu@google.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260813095421.1700945-3-tarunsahu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iGVBPvI2HEE-VIn2U7aVn8Ny_U0OIQGn
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ecde6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=6E-QQtZnqdiRGRPtamYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfX3Rxe6UtmOwff
 goAzMiubQh1Cio/v7ELBpgC3WTABtPfcrjunBOXc8C83RbP8IOh+i17WGszVRe/Y/wCGlJ6vbaO
 PS0NtEV9JnagKpSL7nyIVmg/FmDflAZCDV76Nks1P4An+ikcVG01d7pOsOPK9sW/sZfwfvn6gML
 dUUx3jgv0U0DY5AOPjOWa3nuk4TTaGzwZ4ZXtEMXsr4wwS+chWpWJBBd/CfV4TJ6CVY0j8EPn+F
 QBqqd6esCnJXDefihis/OMaJfQpGZJJlau6ZuPXlgUPjVsdKV1kRfi3++LKGJgujYV0ohLAVlOa
 g47y0uHa/qdmp7m/D2fIN03Gmxlor+L1sHbJLzCRMiGEl2KLnUYG5HRpLitS66m2YrKTs5Y51+t
 +DChXn3p1mVN1LJgVZSF8KJOqtSrYpG9q9e4JX15cjpQBJW9kBXvL2i8leG8nqsXZbkQkdahP7b
 O7+3+zt/hBJbsTRCbqw==
X-Proofpoint-ORIG-GUID: CVJL8JRRoyCQS4Lz7jYUsO5wrEkc1bn_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfX18EkSN8NZslK
 7eNIj1Khe3FkPY1SKh+NnYwA/6UDwi0c421Cw1G45+U53760sTDpI+FjmXRs03/zYnZv5yfwj0R
 0xJ5Tq+EWLvK68LICgJsfttEuEfL9NE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140061



On 13/08/26 15:24, Tarun Sahu wrote:
> When edd_device_register() fails after initializing the kobject with
> kobject_init_and_add(), calling kfree(edev) directly bypasses the
> kobject release callback (edd_release) and leaks the allocated kobject
> resources.
>
> Fix this by replacing direct kfree(edev) with kobject_put(&edev->kobj) on
> registration failure.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>   drivers/firmware/edd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
> index f980c5b56858..763e7b16d517 100644
> --- a/drivers/firmware/edd.c
> +++ b/drivers/firmware/edd.c
> @@ -748,7 +748,7 @@ edd_init(void)
>   
>   		rc = edd_device_register(edev, i);
>   		if (rc) {
> -			kfree(edev);
> +			kobject_put(&edev->kobj);

The EDD device is registered with a ktype that has a release function, 
so it is
better to call kobject_put() to release edev instead of freeing the 
memory manually.

Changes look good to me. Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>


>   			goto out;
>   		}
>   		edd_devices[i] = edev;


