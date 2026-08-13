Return-Path: <linuxppc-dev+bounces-25823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B72C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLLNM3qByz2yKD;
	Thu, 13 Aug 2026 19:56:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614979;
	cv=none; b=TN9bpI/p8izU/nf+hTSgqWpHxWI0b2OvIHxmvt/7EdnEIol3wWzM1QsmDSTK0JjBrUDkMGeDq1tlYOaTFjh0xxju3i3CAZGQF+KC5jW8YQ6zt3JEMu5vrO4+2WUPnVGHrP9XzXh+NPlhWHIitCVKMuMbwNO0MKVN/tsEC38Vj+d1s1W96PLijqXWZHpQzQoXQKAmE7Eanlm066OI3kItZAyrbVa0mkrEtKlRtFAVlc/yuMeyTSQGa2lULrU0H9T6zGZR510Wy+oJnIyBhLhmS18kf0CzrCVhRaOHhRKMDzHU6wx6ogFhJi92WSV9KbO6arSmfLxEjzsUu4lyJYImUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614979; c=relaxed/relaxed;
	bh=tZpZjc7lV7hex9a/WMSkgBgO3Uo0E+LaPx8CBfGeU9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHVJclT5Co2MFk3oluqyaA1WsOPl8EU2NwL9ZI+80fmQkOEml/kpw75urCZHVBAxy0SsjybePo8bZfZksO63RENzMAOL9M8Ii0b2ustWI/7y/7APt8FMc3LjZhyJaREKCMOIEFTAP/4qHhp1vlt05ThdGgl+hf1aSsO+ZeL5ZaSf+9VW9833g5J+FU+YZt7uMQCZubMO98c4U63/XayVPawPTkEbKJApXfUMyUCwEI11/914B9ZTiwv/wNkytfpDKZPdqHIyJG7jMkKUe0YSDfqMygl00QzOQkjUzuD/duUmexq8Vn+nynWYG4m8AV9zxA/x5v+pzdQUZ90C50utvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7Rq7ka4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7Rq7ka4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLLNL5671z2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:56:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37B6A43A1C;
	Thu, 13 Aug 2026 09:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A831F000E9;
	Thu, 13 Aug 2026 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614976;
	bh=tZpZjc7lV7hex9a/WMSkgBgO3Uo0E+LaPx8CBfGeU9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f7Rq7ka4mPVQpbSNU4DEA3OBqJs1OcMFrBGQBuqMbzMCuQ4rAf+xp4cNNSSug/WtB
	 WItV6JKLN3JzDHJNKJDwokANQXZ9lLcfscMEiu0US5eE8z7WnZtVF1BFjzLaE4DjHB
	 I+J9EPImAtZ/eZ3gNdezczlizm7gpSLexTnZBCnHXC9MctvN3xj3pRwE/eSs9f9syP
	 vELeURe+XOPI4P7lj/QctE8FUFJONbPgP7YawkNZbGaM42mGvjtrwdiSY+sAFsAyrw
	 gc60F5Ur3c19PiApN2r0R3wJlh60mlhsBHBCNFggdRKG41YlApJfcGzpY8joz6W9kg
	 WQwXsRkz1Ottw==
Message-ID: <3086e4a1-58c4-461d-909e-d31671a4eb4c@kernel.org>
Date: Thu, 13 Aug 2026 11:56:11 +0200
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
Subject: Re: [PATCH] MAINTAINERS : Add myself as reviewer for PPC KVM
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20251103094243.57593-1-gautam@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20251103094243.57593-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/11/2025 à 10:42, Gautam Menghani a écrit :
> I have been contributing to PPC KVM for sometime now and would like to get
> notified of incoming changes to help with code reviews as well.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46bd8e033042..3f2f60486222 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13701,6 +13701,7 @@ F:	arch/mips/kvm/
>   KERNEL VIRTUAL MACHINE FOR POWERPC (KVM/powerpc)
>   M:	Madhavan Srinivasan <maddy@linux.ibm.com>
>   R:	Nicholas Piggin <npiggin@gmail.com>
> +R:	Gautam Menghani <gautam@linux.ibm.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   L:	kvm@vger.kernel.org
>   S:	Maintained (Book3S 64-bit HV)


