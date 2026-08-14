Return-Path: <linuxppc-dev+bounces-25832-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A264EC5DF66
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 02:30:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLmS14DrTz2yD8;
	Fri, 14 Aug 2026 12:30:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786674657;
	cv=none; b=bhMFig2ivzjp4sdG23N6qJo6ulhOfovyNLXBoyM1iTtq9PSM2pdSu4aHmdSSYhU/LdWzm9XNpD2jrmxhXnQVuAnZwFxab3jz8qtrQhjYojLWm0ZeBu+hIxIgpenIh4BgnnhJDswbHJzQ80siTFJ9ACEd+cNRojvm5HsCEyjonOalNm0TthlIK2p6tQfSmj3BpEYOdxFOC4hLdi4pQiQJ3iqrCJI5q4Ob92zUf8BOuuEeMCwvv5or/JX9neG6T1CUsI5DceXcRHHFfseAquXEUZw1kOBKJt5WPtmdAz6nQnWZa6huOuerlJxH/Z1mihTlU1i+pV40yA8j1RqeQLJXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786674657; c=relaxed/relaxed;
	bh=dIgSLregNr2fYwEjLwaPm1ysOKaZ+mvb7rcmx/nVi70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRLrIekZ9rPE+v7rRN2pT38uzZ5MstPEANiSxu9NXx1PMsbxpFrf/cmG9xTGbHaPdANvGooZ1AwG+iSgnuQdvy8fVn1xtN3PYYfkNqZvQGZvAIHbDu7UrDp1sHgv2Mn1Lo/bGyMRKlB32wWG9Ee7oayzm71li8Au0yQUmgWd7zB4dJ2/5vAof0sn1m8gNCuWogauDR0vfmK0AAeEJq5P1K54IHpDYaKyaTkWqkrEQcVuX6VjZ1HGOGxFBz2y6QfqX5JJXgCwJoouZkwo4NWOSk0CSqacNCD7TIQ4zPFVYAxtyNOV/we4YmjdjyqT7VGBaJKBLvPNhiKVoOF9AG5pIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sxJAcQvx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sxJAcQvx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLmS02Wqjz2xnW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 12:30:55 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E1W2cT3892807;
	Fri, 14 Aug 2026 02:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dIgSLr
	egNr2fYwEjLwaPm1ysOKaZ+mvb7rcmx/nVi70=; b=sxJAcQvx6kCe10SGRNPQba
	nqsdd/HDBvKRw9q6sVtofPSBSgsAbc0dr8Jl9CmTBm8xxFX8G8wqm7kejqQR8vjH
	foQQtx+LW1wCXEeiTRYDr/8t0mulKn7t9L+IY1DJ32KJdzQkIPHVA3pJLWp2GJEv
	sw6NCmD25SfYY4bAy1EP7oU5f80e3aaWOhu/BcZn+UdPhZLr/GDclQTxOG1KkrG7
	EhUslukKy9E/kmsvUi7d3FnWOcW8dQ6HZNSvL6nH2paHXDIUAEuL5g3SI4WklOiS
	BYjeNzaNGYP8DYuBfQd7ZnYGMM8tGEcszPGGrhBvbxUQilv/zQaH1swGm3JP666w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp39qee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 02:30:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E2QGCP018288;
	Fri, 14 Aug 2026 02:30:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk5gyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 02:30:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E2UK2W30409460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 02:30:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 244E12004B;
	Fri, 14 Aug 2026 02:30:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E2B620040;
	Fri, 14 Aug 2026 02:30:14 +0000 (GMT)
Received: from [9.39.17.52] (unknown [9.39.17.52])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 02:30:14 +0000 (GMT)
Message-ID: <5b6fd32e-037a-42b4-b9e9-bb0503561781@linux.ibm.com>
Date: Fri, 14 Aug 2026 08:00:12 +0530
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
Subject: Re: [PATCH v2 3/3] powerpc/ps3: use put_device() on device_register()
 failure in ps3_system_bus_device_register
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
 <20260813095421.1700945-4-tarunsahu@google.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260813095421.1700945-4-tarunsahu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7e7dbf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=n3Y_rXsrvEagZGvLPyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: z2GAf6TahFsdZej1SvZngaYtlb-Fq6Ap
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAxNSBTYWx0ZWRfX3S4+lINbmaWN
 JULXBrqFKQI3VokWQXKOMi7Njj3iDtiZl8Fxfq84Q2M2Q2BIksq3EMWr6OpqHfNhRpJ8sXwrVd9
 VKrCd07RthHMo7M6lTRivUtgfHR4xKI7VILXQ43p73mjJq1Z9Z14IOWDEskJwlEJkQJNPxKjxsl
 AU2J69Ktwi1R1JZYD34WNnrJ4n5EqlEqCqoQP9KHnvXcLTOFGDJDWPfJyRK34bMWk4fJ1KACHfp
 hTo9IU4Ck9gDmjkR7WPIzf5KXfT4V5zKQPkxFvI07ovxtEtz+m3o2fa8RDHc3c5/mSuV1yvA+Ne
 lx93VTNNiO+qkD9JZC+K56NIJW0yoZQ7qM2V4kFd9SYDw7VCc6bz9qSrEtX3//N6fZ9U7yJvex7
 Hm8baxg7/VQ/lAM7HtPaAyr5BkJGiGajw0qmSvUYHJCLdW0QmUuY83wRqh9b87FCu1XjT3xJ0NE
 ilAjundE8PGT2uUOS8g==
X-Proofpoint-ORIG-GUID: AT5Rq_PBXSS0X67XNK0UT2Fpaszq8ck5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAxNSBTYWx0ZWRfXyXi9L/ayC78u
 HWC799RPx6HfZxhenXGMamJ6YQVPnaWY95Fq7q5bqH4WSJRbC7B8abqQz/sEONYSQBx9A1hDVUz
 Ktd1b7BmJZ3onRlB9mXI4d/yTCogJI4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140015



On 13/08/26 15:24, Tarun Sahu wrote:
> When device_register() fails, calling put_device() ensures that the
> device reference count drops to 0, which invokes the release callback
> ps3_system_bus_release_device() to cleanly free the device and its
> associated driver core resources.

Yes, since the PS3 device has a release function, put_device() should be
used instead of manually freeing the memory, as described in 
device_register().

Changes look good to me. Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>   arch/powerpc/platforms/ps3/device-init.c | 83 ++++++++++++++----------
>   arch/powerpc/platforms/ps3/system-bus.c  |  2 +
>   2 files changed, 52 insertions(+), 33 deletions(-)
>
> diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
> index 9109c218a060..8d0c77db1764 100644
> --- a/arch/powerpc/platforms/ps3/device-init.c
> +++ b/arch/powerpc/platforms/ps3/device-init.c
> @@ -90,14 +90,12 @@ static int __init ps3_register_lpm_devices(void)
>   	if (result) {
>   		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
>   			__func__, __LINE__);
> -		goto fail_register;
> +		return result;
>   	}
>   
>   	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>   	return 0;
>   
> -
> -fail_register:
>   fail_rights:
>   fail_read_repo:
>   	kfree(dev);
> @@ -121,6 +119,12 @@ static int __init ps3_setup_gelic_device(
>   		struct ps3_dma_region d_region;
>   	} *p;
>   
> +	/*
> +	 * ps3_system_bus_release_device() calls kfree(&p->dev).
> +	 * dev must be at offset 0 so kfree() frees outer p.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
> +
>   	pr_debug(" -> %s:%d\n", __func__, __LINE__);
>   
>   	BUG_ON(repo->bus_type != PS3_BUS_TYPE_SB);
> @@ -164,13 +168,12 @@ static int __init ps3_setup_gelic_device(
>   	if (result) {
>   		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
>   			__func__, __LINE__);
> -		goto fail_device_register;
> +		return result;
>   	}
>   
>   	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>   	return result;
>   
> -fail_device_register:
>   fail_dma_init:
>   fail_find_interrupt:
>   	kfree(p);
> @@ -192,6 +195,12 @@ static int __init ps3_setup_uhc_device(
>   	u64 bus_addr;
>   	u64 len;
>   
> +	/*
> +	 * ps3_system_bus_release_device() calls kfree(&p->dev).
> +	 * dev must be at offset 0 so kfree() frees outer p.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
> +
>   	pr_debug(" -> %s:%d\n", __func__, __LINE__);
>   
>   	BUG_ON(repo->bus_type != PS3_BUS_TYPE_SB);
> @@ -252,13 +261,12 @@ static int __init ps3_setup_uhc_device(
>   	if (result) {
>   		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
>   			__func__, __LINE__);
> -		goto fail_device_register;
> +		return result;
>   	}
>   
>   	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>   	return result;
>   
> -fail_device_register:
>   fail_mmio_init:
>   fail_dma_init:
>   fail_find_reg:
> @@ -291,6 +299,12 @@ static int __init ps3_setup_vuart_device(enum ps3_match_id match_id,
>   		struct ps3_system_bus_device dev;
>   	} *p;
>   
> +	/*
> +	 * ps3_system_bus_release_device() calls kfree(&p->dev).
> +	 * dev must be at offset 0 so kfree() frees outer p.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
> +
>   	pr_debug(" -> %s:%d: match_id %u, port %u\n", __func__, __LINE__,
>   		match_id, port_number);
>   
> @@ -308,15 +322,10 @@ static int __init ps3_setup_vuart_device(enum ps3_match_id match_id,
>   	if (result) {
>   		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
>   			__func__, __LINE__);
> -		goto fail_device_register;
> +		return result;
>   	}
>   	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>   	return 0;
> -
> -fail_device_register:
> -	kfree(p);
> -	pr_debug(" <- %s:%d fail\n", __func__, __LINE__);
> -	return result;
>   }
>   
>   static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
> @@ -327,6 +336,12 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
>   	u64 port, blk_size, num_blocks;
>   	unsigned int num_regions, i;
>   
> +	/*
> +	 * ps3_system_bus_release_device() calls kfree(&p->sbd).
> +	 * sbd must be at offset 0 so kfree() frees outer p.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct ps3_storage_device, sbd) != 0);
> +
>   	pr_debug(" -> %s:%u: match_id %u\n", __func__, __LINE__, match_id);
>   
>   	result = ps3_repository_read_stor_dev_info(repo->bus_index,
> @@ -395,13 +410,12 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
>   	if (result) {
>   		pr_debug("%s:%u ps3_system_bus_device_register failed\n",
>   			 __func__, __LINE__);
> -		goto fail_device_register;
> +		return result;
>   	}
>   
>   	pr_debug(" <- %s:%u\n", __func__, __LINE__);
>   	return 0;
>   
> -fail_device_register:
>   fail_read_region:
>   fail_find_interrupt:
>   	kfree(p);
> @@ -445,6 +459,12 @@ static int __init ps3_register_sound_devices(void)
>   		struct ps3_mmio_region m_region;
>   	} *p;
>   
> +	/*
> +	 * ps3_system_bus_release_device() calls kfree(&p->dev).
> +	 * dev must be at offset 0 so kfree() frees outer p.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
> +
>   	pr_debug(" -> %s:%d\n", __func__, __LINE__);
>   
>   	p = kzalloc_obj(*p);
> @@ -461,15 +481,10 @@ static int __init ps3_register_sound_devices(void)
>   	if (result) {
>   		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
>   			__func__, __LINE__);
> -		goto fail_device_register;
> +		return result;
>   	}
>   	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>   	return 0;
> -
> -fail_device_register:
> -	kfree(p);
> -	pr_debug(" <- %s:%d failed\n", __func__, __LINE__);
> -	return result;
>   }
>   
>   static int __init ps3_register_graphics_devices(void)
> @@ -479,6 +494,12 @@ static int __init ps3_register_graphics_devices(void)
>   		struct ps3_system_bus_device dev;
>   	} *p;
>   
> +	/*
> +	 * ps3_system_bus_release_device() calls kfree(&p->dev).
> +	 * dev must be at offset 0 so kfree() frees outer p.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
> +
>   	pr_debug(" -> %s:%d\n", __func__, __LINE__);
>   
>   	p = kzalloc_obj(struct layout);
> @@ -495,16 +516,11 @@ static int __init ps3_register_graphics_devices(void)
>   	if (result) {
>   		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
>   			__func__, __LINE__);
> -		goto fail_device_register;
> +		return result;
>   	}
>   
>   	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>   	return 0;
> -
> -fail_device_register:
> -	kfree(p);
> -	pr_debug(" <- %s:%d failed\n", __func__, __LINE__);
> -	return result;
>   }
>   
>   static int __init ps3_register_ramdisk_device(void)
> @@ -514,6 +530,12 @@ static int __init ps3_register_ramdisk_device(void)
>   		struct ps3_system_bus_device dev;
>   	} *p;
>   
> +	/*
> +	 * ps3_system_bus_release_device() calls kfree(&p->dev).
> +	 * dev must be at offset 0 so kfree() frees outer p.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct layout, dev) != 0);
> +
>   	pr_debug(" -> %s:%d\n", __func__, __LINE__);
>   
>   	p = kzalloc_obj(struct layout);
> @@ -530,16 +552,11 @@ static int __init ps3_register_ramdisk_device(void)
>   	if (result) {
>   		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
>   			__func__, __LINE__);
> -		goto fail_device_register;
> +		return result;
>   	}
>   
>   	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>   	return 0;
> -
> -fail_device_register:
> -	kfree(p);
> -	pr_debug(" <- %s:%d failed\n", __func__, __LINE__);
> -	return result;
>   }
>   
>   /**
> diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
> index 0537a678a32f..0918c74d3e19 100644
> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -774,6 +774,8 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
>   	pr_debug("%s:%d add %s\n", __func__, __LINE__, dev_name(&dev->core));
>   
>   	result = device_register(&dev->core);
> +	if (result)
> +		put_device(&dev->core);
>   	return result;
>   }
>   


