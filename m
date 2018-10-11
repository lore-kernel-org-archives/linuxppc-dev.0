Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA9FC32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 08:45:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1A82087A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 08:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1A82087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42W4KZ43WtzF3HK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 19:45:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42W46n31j4zF3F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 19:35:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42W46m1mKcz9vZs; Thu, 11 Oct 2018 19:35:43 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7ead15a1442b25e12a6f0791a7c7a5a72d1f3a0c
In-Reply-To: <1538592694-18739-2-git-send-email-mhairgrove@nvidia.com>
To: Mark Hairgrove <mhairgrove@nvidia.com>, <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,
 1/3] powerpc/powernv/npu: Reduce eieio usage when issuing ATSD
 invalidates
Message-Id: <42W46m1mKcz9vZs@ozlabs.org>
Date: Thu, 11 Oct 2018 19:35:43 +1100 (AEDT)
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>, Reza Arbab <arbab@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-03 at 18:51:32 UTC, Mark Hairgrove wrote:
> There are two types of ATSDs issued to the NPU: invalidates targeting a
> specific virtual address and invalidates targeting the whole address
> space. In both cases prior to this change, the sequence was:
> 
>     for each NPU
>         - Write the target address to the XTS_ATSD_AVA register
>         - EIEIO
>         - Write the launch value to issue the ATSD
> 
> First, a target address is not required when invalidating the whole
> address space, so that write and the EIEIO have been removed. The AP
> (size) field in the launch is not needed either.
> 
> Second, for per-address invalidates the above sequence is inefficient in
> the common case of multiple NPUs because an EIEIO is issued per NPU. This
> unnecessarily forces the launches of later ATSDs to be ordered with the
> launches of earlier ones. The new sequence only issues a single EIEIO:
> 
>     for each NPU
>         - Write the target address to the XTS_ATSD_AVA register
>     EIEIO
>     for each NPU
>         - Write the launch value to issue the ATSD
> 
> Performance results were gathered using a microbenchmark which creates a
> 1G allocation then uses mprotect with PROT_NONE to trigger invalidates in
> strides across the allocation.
> 
> With only a single NPU active (one GPU) the difference is in the noise for
> both types of invalidates (+/-1%).
> 
> With two NPUs active (on a 6-GPU system) the effect is more noticeable:
> 
>          mprotect rate (GB/s)
> Stride   Before      After      Speedup
> 64K         5.9        6.5          10%
> 1M         31.2       33.4           7%
> 2M         36.3       38.7           7%
> 4M        322.6      356.7          11%
> 
> Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
> Reviewed-by: Alistair Popple <alistair@popple.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7ead15a1442b25e12a6f0791a7c7a5

cheers
