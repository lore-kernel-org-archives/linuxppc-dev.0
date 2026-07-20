Return-Path: <linuxppc-dev+bounces-24487-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE50C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:59:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3gb32kMZz2y8F;
	Mon, 20 Jul 2026 22:59:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784552383;
	cv=none; b=iL/0JaEZL9sOzST3JjZ20QlDti0+9PAO8h5mvfDIqnFE70zYjxJaUM/VMK5/udU5F+zjZKrkiFeuMb9CcqIW+u0mcBOKIjJuaIbpg8NB4yaeGf0bEn1nuujz1QhkbITo8T/6wTkEoTbHgM6Kj8Or+iN7mZd/TSkqL0hSYpI3TRYu+YW7VsZ0MPN56h6A8JUKmgCwjWvQlHF9Yy84nJIJIQvTss4z+QIGX93Mxp30NqiXqTSKWtBkPKHBz++iIi7Ra0OsETDOAm1HEXcGFnLb0HITjD98x8/Ctu+IoYNvRpv4bTCVg3YSrR0H2ek9mm3YbEmLcdS2HbDtw5uCt11R2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784552383; c=relaxed/relaxed;
	bh=X6oZONNfb5uP+JaptYLp2osr1QmMr2AutfOA1S9NH7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXqBO9024hvOk8AQ6JQUQ9kxCwXJu/hg9K3FRLev0eZMrO/r53W1REVoovlaK6pg9RHoNhXxOOD3hUBh88DZgHNlJyPRbf5dKUU501lzAEjtgChGO/w2nyL9sOPHS+jPp0E9NMc81Ot766SjJMYNZNy/H9niYbfIFRu/YXTgJuttZCcg8VG/iceP5B+IZtMnSg4lSaCZOYJAKW5PD55hOYxHsibN8Bdu/F9wnNAGDHnmse1xo1xGtLFYEYHNi5CSKf3BZhCUfbEWCuhEp2fdFNqvqf5aw8awo33OVOURCf31Nw04yH5WsstLHXsrvbc7zvcd29LSEhUJ0oNuiqebcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dKmABXHE; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dKmABXHE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3gb00yqfz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 22:59:38 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F0EC2B;
	Mon, 20 Jul 2026 05:59:01 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B928E3F99C;
	Mon, 20 Jul 2026 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784552345; bh=tj7DETiWrYqcYhPQBV0lQIQF5ojnhC7kaKJUMMnBNUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKmABXHEllSGT7FeFg6oxaG2ujJktWVxIXZ3hFzKw45EJWrXdCv86Cdi8Lk3ybb+P
	 2eyzZw9sSqz4kKd+F7OoRuZNUZsH093wu+fiiSmVRvRLMFKAt3uEPGr18dcBdv9V/F
	 kKFNdv+XlRp4DjEuV/4GCCvpzaekEZeXf66xmNSY=
Message-ID: <e4f9b266-8d9e-48fe-99c0-58b61e02c9bd@arm.com>
Date: Mon, 20 Jul 2026 13:58:27 +0100
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
Subject: Re: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/07/2026 10:24 am, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.

This is very much non-portable code specific to OF-only platforms, but 
if the intention is to remove platform_device_set_of_node() again 
already, then FWIW,

Acked-by: Robin Murphy <robin.murphy@arm.com>

(Although I'm slightly puzzled by the cover letter - AFAICS in -next, 
platform_device_set_of_node() is itself very much a user of 
platform_device_set_fwnode(), however in terms of symbol exports, 
perhaps the former could now just be a static inline wrapper?)

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>   drivers/iommu/fsl_pamu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index c83bbc3faad56d6ee1c89b0a7f74028af02c81e9..268a1f752fbceab4fd24013aeea5df1b6982fbb1 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -975,7 +975,7 @@ static __init int fsl_pamu_init(void)
>   		goto error_device_alloc;
>   	}
>   
> -	platform_device_set_of_node(pdev, np);
> +	platform_device_set_fwnode(pdev, of_fwnode_handle(np));
>   
>   	ret = pamu_domain_init();
>   	if (ret)
> 


