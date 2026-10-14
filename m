Return-Path: <linuxppc-dev+bounces-29483-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1CACC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:39:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4W3z1pYBz2ynZ;
	Wed, 14 Oct 2026 23:39:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791981567;
	cv=none; b=ma+pwpz63lNgU/bOZgm8+VXIfueTlF/ffGieABP9wKjaV/6U/R2lVWRTTwrdbZ763SbOoV7rzFqE+FKUyPZVPQ+D93sSwo5neS1b2JTflgbuW6GWKYDOg9IO3QWdUcEB/vXGqmqRMKA1+k93PQyq7mgU2cHCOSE3816KKFs9c+oO3RTmTOB8ZYU0WmLZa15OXc18Ol7hHTfIBCps9HiLizU12vXFqIET4V2t60UGeNxaHz1Loqq73c5QsxLHhB+MxZAgHuKg8MxWYEUAjkYbgaIWUg/5Szi4iEOzp2T8p8tjLgHO1tSnM1ln84y7SCRMEPFwC2qEYhjmDa37VxgLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791981567; c=relaxed/relaxed;
	bh=xs23ZCbOpRQvVMNf4hJDdJp9/IHWSovb0CNsgvI34vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNvUce7vwWPkvXwSTkGfI7ActwL9U2yaPtgevOsdjeZ6lzxycpLYwiD76UlIcKtnMBivvLDOGwtPQh56hGQPhN9qCd/0PH1QjM2w46cwr5ENredtAUeCas5zfJn6OcOFl//b9VUNuHXJMFc/eLh5G/gaoyoA1KpKyPXQpUsA/TSF4PsjhbQw4ZKsJ+7JmqVn5aBGrRp4o8wqzPo8dSqEHEKu46Sp1TfAjCsPwR9zO/dBHOa7MHdjw0dwYDf2hsh/5E5D0anuMe8YOX+JMAIqKqGP6xrxsMx6l8+5gSryoirQyQR+qqN4bgIghPMpzPgm52t+taHGRV3Lz5LFt00kCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddG0OXR/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddG0OXR/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4W3y1q3pz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 23:39:26 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A335E4307B;
	Wed, 14 Oct 2026 12:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B221F000FF;
	Wed, 14 Oct 2026 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791981563;
	bh=xs23ZCbOpRQvVMNf4hJDdJp9/IHWSovb0CNsgvI34vM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ddG0OXR/A06ko6m7Cvzkqe2iSqfekBlGQTdXas3ZQMkBtnbnkAjv6bd2iwlUQBiuy
	 6mRgYfOodX3xCjBnBGjWijIE/quWBn3s7q5X/a43dziXpACZNju9GhOdXJ+X6dd7Pa
	 johR6ztmFiyfqVs/Nz7g8phXGVDFA451KRYqGGUuou7CcQrBau4WhH/KCJvEzvsBe6
	 v2AA7a5dOR+ypmQ4vftqcAVlc3z8qGPhbYPnO/EAxN1YlnKKZB9SubSoMDFwF7UyDy
	 jNHoPEIZjDP4erNAqf1s6OUsg4wHrH7dwT5prBYHJBpWMQOxEVVa3uLdESgZHrbH77
	 i2Zux7wBr/CEw==
Message-ID: <c373cb30-a505-414b-850f-4356aa68595a@kernel.org>
Date: Wed, 14 Oct 2026 14:39:18 +0200
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
Subject: Re: [PATCH] powerpc/Kconfig: limit the PPC_85xx DATA_SHIFT range to
 STRICT_KERNEL_RWX
To: Julian Braha <julianbraha@gmail.com>, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261011113108.539470-1-julianbraha@gmail.com>
 <af5559f0-89f8-42d7-a43b-068bbd183161@kernel.org>
 <7eafa839-ef4e-4856-be6d-d8e0a9ab3030@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <7eafa839-ef4e-4856-be6d-d8e0a9ab3030@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/10/2026 à 13:23, Julian Braha a écrit :
> On 10/12/26 11:28, Christophe Leroy (CS GROUP) wrote:
>> Le 11/10/2026 à 13:31, Julian Braha a écrit :
>>> On PPC_85xx, enabling DEBUG_PAGEALLOC without STRICT_KERNEL_RWX activates
>>> the DATA_SHIFT range of 20..24, but since the PAGE_SHIFT default is
>>> outside the range (12), kconfig adjusts it to 20, causing 1mb alignment
>>> instead of 4kb. However, the larger alignment is only needed for the
>>> separate kernel permissions provided by STRICT_KERNEL_RWX.
>>>
>>> Since PPC_85xx uses page poisoning for DEBUG_PAGEALLOC and does not
>>> support KFENCE, let's restrict this range to STRICT_KERNEL_RWX.
>>>
>>> This out-of-range default was detected by kconfirm, a static analysis
>>> tool
>>> for Kconfig.
>>
>> Looks like with this change I'm now able to set DATA_SHIFT to any value
>> when STRICT_KERNEL_RWX is not set and DEBUG_PAGEALLOC is set.
>>
>> The range used to protect against that.
> 
> Sorry, yeah kconfig can be tricky...
> 
>> +    range 20 24 if STRICT_KERNEL_RWX && PPC_85xx
> I think if we keep this ^ and then add another range:
> 
>      range PAGE_SHIFT 24 if !STRICT_KERNEL_RWX && PPC_85xx
> 
> this would cover your STRICT_KERNEL_RWX=n and DEBUG_PAGEALLOC=y
> configuration while resolving the 12 -> 20

Yes I think that should work.

Christophe

