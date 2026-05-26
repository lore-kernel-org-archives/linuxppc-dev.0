Return-Path: <linuxppc-dev+bounces-21513-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C1CD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 11:54:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPrkf4RlZz2y8t;
	Tue, 26 May 2026 21:54:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779796442;
	cv=none; b=kCwc2Zg9EfAJOdDcGVHHRfJh2yb8OslDY2RMtCyv841qCBBz2vp//QG/3+ajDKkJ0ZnLxlr3WSdB1IdmNp1RexB/A3mIRe38Hsm1uyystVBjZEkhJ361iN361UEscmH3D/toARugedI7BtquRbCJq+JUcFM+9dmHKPCfxqaMkMrnPBxPme5Sf5n8Vpf3Fr8LLl7rKDTmmsDgHg/7d8DGlhMrT+KAtxBz1F3qvws5NyzG4/tWdge6VLGZAds3rTSyg3aW2PWzG+Qqnt0tMwlUDbFGtCrHmr9XRdNxWmg5TZ2MYK9N7IyWuFuYjggHFWAORIG79RZIkQXAoDmHaEhecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779796442; c=relaxed/relaxed;
	bh=vRqwiyCfBhpYAPBXGHp09UX8Jjvp/LUhGejAtFhNH6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGKaaoz1PBfV2qCfz5Z9Rm7HbxYINYNjrBfzWNJ/H8vZrnJ2Xxs/yk0QnVW4Es/k9ujq/5cTunDNFlfH6UNAJIw5qTVlJ2mtGZuQEMuxNzfTor4aJad/2arzH33Zz9Mr+erCNSTfxc/7fX3Ra41iYCFzx1uTFFVZc8CB7qYX/p8JD+v+MULieu2XnjybvzweUzcDydty5II/KwfF7xictY2R3iqv2vCQG3cSEUwOCQDuaY3mYlDl6OWJK5n5U/OvInpm26lLU1Jz93YuzfbVrPZtnchZVys+T6zu53kTUiwS8K8hbLgSsz42BrE3C4IGiWZuWWvKZp9xVuY4aMBPAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkPOCGuc; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkPOCGuc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPrkd3Nmkz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 21:54:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0AD0E600AB;
	Tue, 26 May 2026 11:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F4D1F00A3A;
	Tue, 26 May 2026 11:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779796438;
	bh=vRqwiyCfBhpYAPBXGHp09UX8Jjvp/LUhGejAtFhNH6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mkPOCGucXnJqRQ+9RCxnXDA8xSXJduc1Y64fjPh6WFlYgeGpB1hHLWvqS5/olZdwY
	 z8yo0xUJPkpiV+R0/WqCUTh9kHXL+8+t81OWu0xtSly2hjFvx+MuwmsIIQHdtnKhkx
	 x0mZEoOQNenc6LY4/dxUVJrT5hdOwPqiMKZdc7RPu2WW9kYSIbgXvd1ew8Vgg4Aumx
	 70+B0rspBwTdj/QPZhDgecjDL9wQN6HrZSxDUUBRdywCOQR7Hhz3MxFJ2FK4qiesbi
	 oZiw6xPRcAUlqvGn0F/vkQHJaBNDejTp7QVV1arWuM3DXBvs7cQaQoRjXo5SxHaowB
	 axrGFKEqtc6Sg==
Message-ID: <eebe442e-eb5e-40db-b07a-f446c8f7c8db@kernel.org>
Date: Tue, 26 May 2026 13:53:50 +0200
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
Subject: Re: [PATCH 2/2] powerpc: export memory encryption helper functions
To: Arnd Bergmann <arnd@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "T.J. Mercier" <tjmercier@google.com>, Maxime Ripard <mripard@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Andrew Davis <afd@ti.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260526102113.2594501-1-arnd@kernel.org>
 <20260526102113.2594501-2-arnd@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260526102113.2594501-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arnd,

Le 26/05/2026 à 12:20, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The set_memory_encrypted/set_memory_decrypted functions are exported
> on x86 and arm64 but not on powerpc, which leads to a new build failure
> because they are now used in a loadable module:
> 
> ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> 
> Export these the same way we do on the other architectures.

The same fix was rejected already, see 
https://lore.kernel.org/all/ahPqbfH54R3JJyaV@infradead.org/

Christophe

> 
> Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/powerpc/platforms/pseries/svm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index 384c9dc1899a..ab8f8c722741 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -6,6 +6,7 @@
>    * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>    */
>   
> +#include <linux/export.h>
>   #include <linux/mm.h>
>   #include <linux/memblock.h>
>   #include <linux/mem_encrypt.h>
> @@ -50,6 +51,7 @@ int set_memory_encrypted(unsigned long addr, int numpages)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(set_memory_encrypted);
>   
>   int set_memory_decrypted(unsigned long addr, int numpages)
>   {
> @@ -63,6 +65,7 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(set_memory_decrypted);
>   
>   /* There's one dispatch log per CPU. */
>   #define NR_DTL_PAGE (DISPATCH_LOG_BYTES * CONFIG_NR_CPUS / PAGE_SIZE)


