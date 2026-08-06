Return-Path: <linuxppc-dev+bounces-25493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C05C56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:30:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGCSd2DFwz308X;
	Fri, 07 Aug 2026 02:30:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786033841;
	cv=none; b=PwfguTq82fbGVRLXuPaD25RshwYGb52+p70M2nIxCBk7H4vXMTTfVTiFJFnFx+3RbZ68cF1T2UMa4MhmK/K4cprhmlwxcaLqtCYYrH7OMYn8SARLqJD33BZpc1KrYRjEn6Z0IHXWA3K0OjwskY9TE6epnsS0msApBEeuOnjg7zEt4b7NTQjVhlBWlQMn3xGDiYzQydVwf5YzeW9L3TLjIZ4rBkNiUQIn85Xt3wTaCH4S9LBswKpvqKaun9zW06ITvBAWd+yG/8UUz1OZNiOyzBVgtJOSSkPEYeCS0Esc4oBWj0WeOZC+izQKnqpFWJzXqYMLpYfu7ezD0eK26E5lVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786033841; c=relaxed/relaxed;
	bh=5N643OcZ6TKjcgSUXv0mk+FEk5LRIN0olw3gyMmc8Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNtfZcNoJQy3prXRzgcxHesh/REhPSY4qyK2j9Fklg39FpAQ/ObKdm1BaAvCP2RPm8a+EVl6ByRW73yVwVk1nc8YdtgQbzyYogKZ224Guk3mxFfwVZk3IXOzbVYddNz3sb5jYuGglBRruowPgtzr1nS+cjTVI7zuBL09HWPtgQDgPAlC2oA4uKkvtEqRfCc0DyMZViVvQbYTtR0g8UgTJHv+kyeMRCJEPsHUdB9XMwS6A8ZS8NhgsDHr9don5TxKWiHANJSlwsKaEQ+9cNOUfPVos6oPYyg69dbt2b1QZ1buNspejmww9rcCgXUuAYEehchm4Q5BDlmo8BcXXj12WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQk45cNz; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dlemoal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQk45cNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dlemoal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGCSc46cgz3080
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 02:30:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57DE4419CD;
	Thu,  6 Aug 2026 16:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E651C1F000E9;
	Thu,  6 Aug 2026 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033838;
	bh=5N643OcZ6TKjcgSUXv0mk+FEk5LRIN0olw3gyMmc8Ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nQk45cNzbKYZ+bNorwbh3f0Q7tR7Z3+HV5CIQ3MQDGfI4LAP2RUlFD9jGgIkkBFLS
	 syPZ+NKhtOd/jVqIjQQJ1rOeMRrF/vSeOrIll1V3sPCoxuVLnx4NNbJGd4dFy63Tth
	 oUx2iStVPA1S/NEyxFaI1HviKL8aEqLkiA1depBAp9Oly8jFut1bHTFcKKtcCkCqLX
	 LtK8ElpNlzi0pJDm87Uuwi4ioI61DjdflBnBZJJtP+/VTp9hjw8aDu5DPUdmaaHxKX
	 o6TGURv5D+v37GYyRvMMEMkuB1BHsjJZ2aTblxb4O7NtJL5q2whlGBt3cE8FbckVLf
	 dHcFy1qHNUdYw==
Message-ID: <9bd395e3-5df4-4e13-886f-b1afeeb5d4a2@kernel.org>
Date: Thu, 6 Aug 2026 09:30:34 -0700
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
Subject: Re: [PATCH v2] scsi: core: Drop Scsi_Host.default_lock
To: John Garry <john.g.garry@oracle.com>,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, bvanassche@acm.org,
 linux-s390@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-usb@vger.kernel.org, John Garry <john.garry@linux.dev>
References: <20260806113958.3127942-1-john.g.garry@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260806113958.3127942-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/08/06 4:39, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> Back in the 2.6.xx days, it was possible to for low-level drivers to set

s/to for/for

> the shost lock pointer. That is why there is a default lock and a pointer
> to the shost lock.
> 
> However, support for this has long been removed, so drop
> Scsi_Host.default_lock and make Scsi_Host.host_lock as the actual lock.
> 
> Getting the address of embedded host_lock structure just requires adding
> a fixed offset value to the shost pointer. However, getting the value of
> the host_lock pointer requires loading from a fixed offset to the shost
> pointer. The latter should be very slightly slower, which is relevant as
> this lock is used a lot throughout the core code and drivers.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
For the ata bits,

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

