Return-Path: <linuxppc-dev+bounces-14367-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A170CF3941
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Nov 2025 15:50:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBQtP54t8z3dJq;
	Thu, 20 Nov 2025 02:50:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.235.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763567437;
	cv=none; b=XobnrbOgx011IE8Hu/5ysEwv1AjEjB3TSE9/PMZ99zEMpNvYJ0dKlekUEAULMnM04bGu34UJlWNkjS3o44UcwjYSvaXgeJb0IAvhN0tq1S91MjE9MUkARAndUX4Ni7RAqr5J49WksJq8jSfxPkyPCW1KQ+sNf8TFaL8DOq1r1/Ic5re9iVVd1BRF7BPDFe3Iuuijj7LXT9W8XsJ8VGAj69EuLdhCeISfZAK42CpTLNu0GnRnyXxbjAnfc/JMOfSJSpEfTe1+MHrJNI6sDQeQRruhOOI1iujJTEF7KpDNQaAgvWBbHelSzyRN0aM1mSltVWszKPC8GFqsazpfhPTD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763567437; c=relaxed/relaxed;
	bh=+fhO4oP/GQ5yZJWdNLL3fKxn/0g5GEwkCh7P95gGH08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axgo/ySx93zdKbH1D0RY9NssGrCLPoqTtOoi20FcWrnPMmv1xudWc52201ZgsAUsXtgIPWfljg2cjDvweT7GUWoryXxRlHYuLRpJOpCx6tTRCFwu4Vtnx3ZPgHRP/nfIgbEcgHV35H7MJ5PLXHJo8cv+JAMlynnhSoEePxC18gLzm5m4bF5kiPXs04xg2I02WiyU0Bpp2KOrFS0rnIjPBwACsQG7Nid6w0Jh/4WG+F3wqyTiIM0ni5KgRolGNQD04dg4CwOqk/e4jol24skVTOYW98QB1JRlYwhr70d93AVhE6A62zDMFiP2vdeFbt155ibBpP44Jq6tUugHENW6hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBQtP093Wz3dHL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2025 02:50:34 +1100 (AEDT)
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4dBQbr4LWxz9sTm;
	Wed, 19 Nov 2025 16:38:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOnRrJ5A7_EN; Wed, 19 Nov 2025 16:38:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4dBQbr3btHz9sSn;
	Wed, 19 Nov 2025 16:38:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 690918B76D;
	Wed, 19 Nov 2025 16:38:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id u265QodWAVzI; Wed, 19 Nov 2025 16:38:00 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E5AC98B763;
	Wed, 19 Nov 2025 16:37:59 +0100 (CET)
Message-ID: <657c8574-8844-48ef-93e1-e0df8e9cf91a@csgroup.eu>
Date: Wed, 19 Nov 2025 16:37:59 +0100
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
Subject: Re: [PATCH] powerpc/warp: Fix error handling in pika_dtm_thread
To: Ma Ke <make24@iscas.ac.cn>, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, benh@kernel.crashing.org, smaclennan@pikatech.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251116024411.21968-1-make24@iscas.ac.cn>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251116024411.21968-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/11/2025 à 03:44, Ma Ke a écrit :
> ***ATTENTION, Sopra Steria Group cannot confirm the identity of this email sender (SPF record failure). This might be a fake email from an attacker, if you have any doubts report and delete the email.***
> 
> ***ATTENTION, Sopra Steria Group ne peut pas confirmer l’identité de l’émetteur de ce message (SPF record failure). Il pourrait s’agir d’un faux message, à détruire si vous avez un doute ***
> 
> pika_dtm_thread() acquires client through of_find_i2c_device_by_node()
> but fails to release it in error handling path. This could result in a
> reference count leak, preventing proper cleanup and potentially
> leading to resource exhaustion. Add put_device() to release the
> reference in the error handling path.

It is not really an error path, it is the termination of the kthread.

> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3984114f0562 ("powerpc/warp: Platform fix for i2c change")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/platforms/44x/warp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
> index a5001d32f978..6f674f86dc85 100644
> --- a/arch/powerpc/platforms/44x/warp.c
> +++ b/arch/powerpc/platforms/44x/warp.c
> @@ -293,6 +293,8 @@ static int pika_dtm_thread(void __iomem *fpga)
>                  schedule_timeout(HZ);
>          }
> 
> +       put_device(&client->dev);
> +
>          return 0;
>   }
> 
> --
> 2.17.1
> 


