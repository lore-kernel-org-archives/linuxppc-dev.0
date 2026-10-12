Return-Path: <linuxppc-dev+bounces-29335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD160CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:16:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3VdQ252mz2xwP;
	Tue, 13 Oct 2026 08:16:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791839786;
	cv=none; b=N5vEc5M1Lj7lqJq3/RcF6pYt5diV4ul53j/9OiXm/Z92r9rG8I1AC076FxG713sGi9yj6ECkwxq7o7jbe0B59j7yK7D8kaMiOYks7JNUN/Aq2PDIjqA6IBN2KzChXL6QMTZHNokXes7Fz8z1BPVJ6VUWhWZBKOcCsrU2Z66J8qpnGz0lhBeFYAo7vMZBZJZycFkUNdJwXcMyHzUxBdNzsX2qJ5PI7ddi48vtVyxbgPLYjFuJWFg88rbKlkegoaLQaxqGLzaJaJ5wskeSPF7HvlpcvnX28UjE5kpsxUt5xAe5hFO2j08UpMomTfeGtjKJ9y2Us62VoEavrJRZ3m8jgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791839786; c=relaxed/relaxed;
	bh=uOeRbY5zd/YMwkNv8/66VsyHhlD9kyU9Q3Cur7XCeV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpaAa4JHO5UZEV3lp9A0yxkNMtfu1iUhj77uy3nil76y2RU/qDMXjr1yZjbMWDp0opthxzv5VtwQ50k31OyM4fFJW4zzL7aOOMjvng7MjjE0PhY48BOSq9GXyuHoSnphqxMO6Pzl9JXWFxL6eeJNYSOecOoE0h7kRQ2imkejKV0aVybGPUIgnTgSM3r9nkTuh9vYzFveQKRclXxLOO1hMnd60wxtJxosvOPTVl4K2lA0+yQPuZagaHej6ZaJ1DndHUn4af/dJ0zHaLU7FTPfiRHnhZNfpqG6EVkL1JZzF2uhPe5uWlLxsVzag6DYVqE5srFM4Q5r8gxD+4osrwkz6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S3cd/pSB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S3cd/pSB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3VdP3Fqmz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 08:16:25 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJiWnb1149521;
	Mon, 12 Oct 2026 21:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uOeRbY
	5zd/YMwkNv8/66VsyHhlD9kyU9Q3Cur7XCeV4=; b=S3cd/pSB5SFi9qQcfyqkfz
	w1DJl3CKIUOb8zriuiIZ+fXSB43G1xKBQL9Kx7JEsEGVSQbQGvYDIpbTrEob4KeL
	ov4B/RBd1pc7TyABPCtJkVrsaQasZl7CtwezYMB19GOinidRxsO3og3yvJCvwd5B
	Zfmidd82CoVbBWpnVooSZhjbABPJUYVYfUEOeqolTM+aQ2xQWMPfK8XT/WjGMLr5
	p6pEx4CntrNZGBy157Buy4B9MszsShr38imY+PSnkR3Gux1TxcqRM6wL/mr9q5LX
	ZiwjOh6zAXbu7qrylrJ31n0fxpBg5en0yMFDf8i0xPgCrerwokpRisamnhyROz7A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w2gqb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 21:10:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJONOC1811998;
	Mon, 12 Oct 2026 21:10:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppq2pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 21:10:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CLAZhM64291212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 21:10:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE4BA58057;
	Mon, 12 Oct 2026 21:10:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF9F158058;
	Mon, 12 Oct 2026 21:10:33 +0000 (GMT)
Received: from [9.67.101.21] (unknown [9.67.101.21])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 21:10:33 +0000 (GMT)
Message-ID: <85244b39-017b-4978-8a4e-ff8e8dc89ffb@linux.ibm.com>
Date: Mon, 12 Oct 2026 14:10:33 -0700
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
Subject: Re: [PATCH v2 RESEND 2/3] powerpc/pseries: switch to dynamic ibmebus
 root device
To: Johan Hovold <johan@kernel.org>, Geoff Levand <geoff@infradead.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
 <chleroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260812142016.55136-1-johan@kernel.org>
 <20260812142016.55136-3-johan@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260812142016.55136-3-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MiBTYWx0ZWRfX4jm1s17p7m4a
 8AXeQna4bddFo0wjBacUmoesRy5dysvN/oiivDaDFihLP/mweu8+zXvRfJ4mxJOn6VJlJGRXHe3
 SCesNQCq5McNGOiz8W0PQaEymDJfPsc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MiBTYWx0ZWRfX8qTZ+EyLKK90
 Cz+q67knmRZc4PyrZr0fjluLr2i7wwqPpNbUlG4x/2DfAkHHCSpOoy0aArBplY/U7ZrzVG9UeGh
 Q0zfQn3quUJj65xf/+/gbYJvpNxenVVYWGLqqPCWXKY0q2D45CYTNJP3dKeKTleW5d0SH4Qe97Y
 2PMIiGbTfHadGpKqOGFMzdu1AK979/1KDZSYuc/FhxpMwQrXyVvPA/TQ4JkXnjJi75Obkd9VIgV
 NWW7SgHhzgbYQxeqG2w6UWj0EZRRVm/RGOYuY81FAzjpBq9hTPnu5kLmncb7yGxF4y11oNwmPyD
 HMMrTxtvPlYaIY0fJSxToY1045pURPb6FOBpHUKOjgY+ps5kPqBFP3hDFRFI6SjLRob3KbKEoAF
 yujFb6o8xIwDI+1dosmqm6DWjDcGK5OIlMgsH5QLaRkC+lfOl45pTfzAQsww7hdudnovtG/ZCaX
 7/hwERXSLqwlwsFb6hw==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acd4ccd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KVws_vwQB_PUgFkgaC8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9FlBh5Fau2QIPUMtfXf7FTs3ruR3S-ld
X-Proofpoint-GUID: 692mHVGhtEQmnnpE3l61Ukqs4nvewVUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120082

On 8/12/26 7:20 AM, Johan Hovold wrote:
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly if a device that lacks a release function is
> ever freed.
> 
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
> 
> Also add the missing sanity check when registering ibmebus devices to
> avoid use-after-free if the bus failed to register (which would
> previously have triggered a bunch of use-after-free warnings).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   arch/powerpc/platforms/pseries/ibmebus.c | 39 ++++++++++++++----------
>   1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
> index 2d0f991da2c8..48076fe6ab30 100644
> --- a/arch/powerpc/platforms/pseries/ibmebus.c
> +++ b/arch/powerpc/platforms/pseries/ibmebus.c
> @@ -52,9 +52,7 @@
>   #include <asm/ibmebus.h>
>   #include <asm/machdep.h>
>   
> -static struct device ibmebus_bus_device = { /* fake "parent" device */
> -	.init_name = "ibmebus",
> -};
> +static struct device *ibmebus_bus_device;	/* fake "parent" device */
>   
>   const struct bus_type ibmebus_bus_type;
>   
> @@ -172,7 +170,10 @@ static int ibmebus_create_device(struct device_node *dn)
>   	struct platform_device *dev;
>   	int ret;
>   
> -	dev = of_device_alloc(dn, NULL, &ibmebus_bus_device);
> +	if (!ibmebus_bus_device)
> +		return -ENOENT;
> +
> +	dev = of_device_alloc(dn, NULL, ibmebus_bus_device);
>   	if (!dev)
>   		return -ENOMEM;
>   
> @@ -448,6 +449,7 @@ EXPORT_SYMBOL(ibmebus_bus_type);
>   
>   static int __init ibmebus_bus_init(void)
>   {
> +	struct device *root;
>   	int err;
>   
>   	printk(KERN_INFO "IBM eBus Device Driver\n");
> @@ -459,23 +461,28 @@ static int __init ibmebus_bus_init(void)
>   		return err;
>   	}
>   
> -	err = device_register(&ibmebus_bus_device);
> -	if (err) {
> -		printk(KERN_WARNING "%s: device_register returned %i\n",
> +	root = root_device_register("ibmebus");
> +	if (IS_ERR(root)) {
> +		err = PTR_ERR(root);
> +		printk(KERN_WARNING "%s: root_device_register returned %i\n",
>   		       __func__, err);
> -		put_device(&ibmebus_bus_device);
> -		bus_unregister(&ibmebus_bus_type);
> -
> -		return err;
> +		goto err_deregister_bus;
>   	}
>   
> +	ibmebus_bus_device = root;
> +
>   	err = ibmebus_create_devices(ibmebus_matches);
> -	if (err) {
> -		device_unregister(&ibmebus_bus_device);
> -		bus_unregister(&ibmebus_bus_type);
> -		return err;
> -	}
> +	if (err)
> +		goto err_deregister_root;
>   
>   	return 0;
> +
> +err_deregister_root:
> +	ibmebus_bus_device = NULL;
> +	root_device_unregister(root);
> +err_deregister_bus:
> +	bus_unregister(&ibmebus_bus_type);
> +
> +	return err;
>   }
>   machine_postcore_initcall(pseries, ibmebus_bus_init);

I went through the init error paths and they look right: the global is
only set once the root device exists and is cleared before the root is
unregistered, so the new NULL check in ibmebus_create_device() stays
valid after a failed init.

Reviewed-by: Mingming Cao <mmc@linux.ibm.com>

