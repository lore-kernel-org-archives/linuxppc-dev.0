Return-Path: <linuxppc-dev+bounces-22683-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B88CD98D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 05:34:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfbKT1rYZz3bpx;
	Tue, 16 Jun 2026 15:34:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781588093;
	cv=none; b=HQjUDPkMkP/46GG1u9DCzpfi66754GRhkbS+CWEANsXV76jaqNFioxp/19Nxx9BFnSVJVxO8fl1qhS7hEHhwk+tvPwWRIjJOdYUfYg32nWo8Z66PkcJunPdZO0d/VLFro5tqn5eV/5LiDUz09XSmkNp1Mp5uwM0WaukO8bsmWFGm+lfIiXg4spDHmCV4BLimrFjb7U8D/ddnKPtdf6WjTTU0L9ugVhMHxATx3IYRq+e13QstUF3UyAO++rErGPTWdeEl2O8fC81UeTAzJpBNqyVAi9nC8uko5dXWVfZ2aDGZcuGxkirAJukIF4+gsZNQ7WT+uMe/3q7jP34+4ahQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781588093; c=relaxed/relaxed;
	bh=kRgeD23SDOXTEaBOW3fA+2SN+82jwDbS4FXKc7M2R2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nkabe+P3057t8tohP4vI+7Qf+fr5PtT8HpBddhfw/FM+ejLrKEVyeDgZxw8zoEOTt8yB+W3lpdlrEHUhG0OW9B/GAd/CJ8soCgLm1O9nOjxChdbKzjBlwWUzkyHXGEhP1zkUaMvo0z1FcxFPIPMn5KujUpReTa4J83Kjot4+0ir6G13Miw1rArg1odcBcUU0OlqCJlnFS8HPYnYfVGr3vV/jTqKAPz62oKKMaaqoGurCxcHrwtB9nF8ynuoRrpgsLdBU0p5eFaj1z+xlYn7vS98c/UDQ1UV1xKJfXAhXI1QR10Clz3662zqxUKYLGwD1dyJarsDQRc3qsRdK5nHUjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGe+T+Gt; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGe+T+Gt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfbKS1HTfz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 15:34:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B1214001C;
	Tue, 16 Jun 2026 05:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11321F00A3A;
	Tue, 16 Jun 2026 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781588088;
	bh=kRgeD23SDOXTEaBOW3fA+2SN+82jwDbS4FXKc7M2R2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lGe+T+Gtixkz1cmQhwOapVfCYwxS5P1xxHtqk4gh/xGreBY+ooSaKPz5MEh94MLOK
	 AajxufIEP+BqlipeKj8abAu2kcNoOnPOwy2ffzml4hQfmBOR/rg9l/D7mQF2KZdC7m
	 h11vL8ZasN8Wd5OnsGMfg2ecGGu5l22hvrAFPLiWpAxi3qf2gWZBgofP7Z+d7JPiK3
	 BsfRgEQx1IdIGOkJ0Jcbg41+YnJwjDgUW3AmxBPkV89TqBZA1zxEQAnTcb/oodWirc
	 9JcUDbatjMxjUZ8d7qQkPqnyAI5Y8KcQN0JuL4FvXnlaMcDYUsNbr5wgJgLW3rYTL3
	 RcsIQci5aezgA==
Message-ID: <095d4604-b3d7-492e-b119-2bedcb63217e@kernel.org>
Date: Tue, 16 Jun 2026 07:34:44 +0200
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
Subject: Re: [PATCH v2] powerpc/uaccess: correct check for CONFIG_PPC_E500 in
 mask_user_address()
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20260615233729.29386-1-enelsonmoore@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260615233729.29386-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/06/2026 à 01:37, Ethan Nelson-Moore a écrit :
> mask_user_address() incorrectly checks for CONFIG_E500 instead of
> CONFIG_PPC_E500, causing mask_user_address_isel() to not be used on
> E500 hardware. Fix the check to use the correct name.
> 
> Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> Cc: stable@vger.kernel.org # 7.0+
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> Changes in v2: Correct explanation and Fixes tag (thanks Christophe)
> 
>   arch/powerpc/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index e98c628e3899..619270bb7380 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -511,7 +511,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
>   
>   	if (IS_ENABLED(CONFIG_PPC64))
>   		return mask_user_address_simple(ptr);
> -	if (IS_ENABLED(CONFIG_E500))
> +	if (IS_ENABLED(CONFIG_PPC_E500))
>   		return mask_user_address_isel(ptr);
>   	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
>   		return mask_user_address_simple(ptr);


