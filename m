Return-Path: <linuxppc-dev+bounces-26054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27371C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Aug 2026 14:37:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hSc7r2L9gz2xnQ;
	Mon, 24 Aug 2026 00:37:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787495832;
	cv=none; b=nGcSfq+UAsxfOaGAf87hRqpKaJnoCiLcwnjBqcAl6ee+MwGtEH3s0XMbqDZiK5irK1Q2DvDoI0vo3M0ixw+vnUfXrgRnX7DoYiGdYFSkcApzvtC9+SvAQ7UXBkT6QcppJkBW/hvaJ0loufC1OzhT1MX/dx/I46tFxZltznIFebKYIl007/qYu4/mNR3d8jgAivduMvMTjQP36PD3E0JaNLtVILdkNs00Ixg87bhf1+AzM+eObdaoXI5YtROEbCQs25UTkVv1yjUTY7kXe9KIXHSOz9tZN/czOlPL7jY9MLOBEAYWFJJnqNxu8+u7AnSosadgOPBBbjC+17QuybIMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787495832; c=relaxed/relaxed;
	bh=IjVwgap47YOeIukz8yw67SDCadu22oFRx+M5RlZB4jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFX3VGdXxfHjCmb0ZxYeKYbEyamKhh+76IexZrOOsgyPNlCE5XiW+QfOLNMeFZE/zcfqkXnSKeRcWufHEsOJJtQHYGvZz/xl2cE6d01HVcU7ZzmQBupfyW/iLlI0vx3foTgbuSI6U+zCBQhBOxzqVh6ClXhkfvGCN9QK87oqnK1jGin8J4BgcR1IJRIP79Ldt/zNwxmSXbxFvxfs3fGlliii6GCci4RbxdvdsKlPPMRWSK1lX6uhMQl/e3IL7GOUMlq7XEzAJ5xipEFwBlARjHD6/Q88M+0S4BVWqdwtVCV6DAOwMNxrTpam+giJIYC1cWTR+bBke0wIioelB91BoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0JF3wsr; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0JF3wsr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hSc7n5gP0z2xQ7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 00:37:08 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2355856f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Aug 2026 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787495824; x=1788100624; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjVwgap47YOeIukz8yw67SDCadu22oFRx+M5RlZB4jk=;
        b=i0JF3wsr7hlzWiqDMOm1riXrSTy2Wbr6UoL2QZ/8wUn4a9qMmwL+w3LpSsyiSoCVkT
         AMn6UEjyckA3Ny9Ob34eXdtxeyigDBpt9wE1Xst6xIA+Vnc/b8og9Cu4EXVFvoVVFg1v
         VBTWSl4hPNxBKGvehtjNjaXbYeRsz73hk6AVTpte+78sS8y0wX6nrm4G6VWhDSOup8Ov
         B5fFSS1FiYtJXkEhAQi28rC2lwXEDLv/Pv3yE/IfuSTfx4wry/2O3BazqwFdbUPQas8Q
         roc65PvA3DPxYviGKfB68Dxd5SJyanJHTULVVi7Jmh33LzkUG3vuQxR0D8KvDGbyin6F
         +U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787495824; x=1788100624;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IjVwgap47YOeIukz8yw67SDCadu22oFRx+M5RlZB4jk=;
        b=rHY+7kEJuZD8qDk8Dvws5zTYoQqwX9+0L8E3aSGP6RWWaMGyFhgEEiMiwARof6HoKM
         a+NisL0DJpA25c6biWuTbfBYnMR5Bn/mZEdfJdOSI+kubgCO8XqRV8Sq9wjP7PHOQU+H
         B7Y0YPWjxTPN1LLY6jZm1e6VU11CX7WowIvW/2C72cgs/GcGc1zxkkoNssNJVxU23YJg
         WlpGjz1tgjiCweqU+Hi31mTaorjZpPHYZtv7phc3m3bXr04m6vNhIRN6EmbN3DZ64ubD
         3UHznQCjZXQxzxAs8orQGLAPPuuX/giwfxSEuqzsAXQD2ZV+ocR8LiAIfmJX8mZ6d7BM
         ISiA==
X-Forwarded-Encrypted: i=1; AHgh+RrlYnIFeuZ2uAhPRr/f8OXgh7rrIMMTt6gCipgZ1J1XOxZG6vYWDZvQRLQUhKlyrPwD3c+pLiFituO7J0g=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nSiJ5yMIlEoPXkIzbl7b4Vby+C8vwVNKse+R6y7+XfXmQBXRim
	UrDUJ1w37nx3DS+X10izvhZprmk8dQNFvgpzHEqHzg7eeuYRyfK7xQOZ
X-Gm-Gg: AR+sD10fKQ+iD8+dU8vslSo81t5sl42TAI/90iYfmoxrXWBroITsjJGa/i5YB8m3jXd
	fIRLSW5B2SMyj1zZbZnnysaL1zb5GwwDxnAKzT5btaelpBnPcM/MUNH9EGhPUgQ59+YIU/XjNFA
	Tg2zI4Drhw5+ocHa1Pj9gS8u5VBedxh0LyH2xJCHIOKsg3JUpQxidmL8AR5cKdGbYmjGjPPLPi/
	0/8Aomp3f/tpw20Uq+ozUZnftO0BxmVcW0Sw4ByYUdsgjcxwrplApROpLfqbA3BuBKuzmqNtKoo
	bf94VmGU/0Hgorq4/umHw0jU7wmYejd7t3FtIJAv+kwy6NOIuOzSCAD9zmVcJwlBpgqjuCrVDeC
	lO7IKGZUGw08MYtA5MLXZLTTfZpGDlU2huXe8hueeQTTlQ1JtTxAVJMGFHb9LGk2s8zhnfi0ah2
	CEdeyhu//wQY7v+4Du/mTPHvz5PB51mo9+k1eBp7Gs1F5gwD+XHCk2Sds+3GUtrAqbOhQS9/lK6
	ffuQvTuUuZBsOmDlZPOgVznYcyyvNyBt17n8BIjSAHOGafZGPHAX/gHKw==
X-Received: by 2002:a05:6000:46c2:b0:482:c650:8c89 with SMTP id ffacd0b85a97d-482c6508d4emr12735930f8f.9.1787495824002;
        Sun, 23 Aug 2026 07:37:04 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b69b3csm5404807f8f.3.2026.08.23.07.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 07:37:03 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <f66f3199-df76-4158-9ddd-23e9096a1fd4@gmail.com>
Date: Sun, 23 Aug 2026 15:37:01 +0100
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
Subject: Re: [PATCH] powerpc: remove dead 440SP code
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, Frank.Li@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linusw@kernel.org, kees@kernel.org, colin.i.king@gmail.com,
 rosenp@gmail.com, joao@joaoff.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260816125615.985387-1-julianbraha@gmail.com>
 <c4d970dd-cb54-4530-9491-01b6d90e4a2b@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <c4d970dd-cb54-4530-9491-01b6d90e4a2b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christophe,

On 8/17/26 07:29, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 16/08/2026 à 14:56, Julian Braha a écrit :
>> The 440SP config option can never be enabled, making all references to it
>> dead code.
>>
>> Let's remove support for 440SP, since nobody can be using it anyway.
>>
>> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> It would be good to include history in the commit description:
> 
> As far as I can see, users of CONFIG_440SP were commented out by commit
> f65573314e4e ("[POWERPC] Re-organize Kconfig code for 4xx in arch/
> powerpc") and removed by commit ff5f483f3091 ("powerpc: 4xx: remove
> commented out Kconfig entries")
> 
> 
>>
>> Signed-off-by: Julian Braha <julianbraha@gmail.com>
>> ---
>>   arch/powerpc/boot/cuboot-katmai.c   |  2 +-
>>   arch/powerpc/include/asm/async_tx.h |  2 +-
>>   arch/powerpc/include/asm/dcr-regs.h | 10 +++++-----
>>   arch/powerpc/kernel/cpu_specs_44x.h | 12 ------------
>>   arch/powerpc/platforms/44x/Kconfig  |  3 ---
>>   drivers/dma/Kconfig                 |  2 +-
>>   drivers/dma/ppc4xx/adma.c           |  9 ---------
>>   drivers/dma/ppc4xx/adma.h           |  2 +-
>>   drivers/dma/ppc4xx/dma.h            |  9 ---------
>>   drivers/net/ethernet/ibm/emac/mal.h |  2 +-
>>   10 files changed, 10 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/cuboot-katmai.c b/arch/powerpc/boot/
>> cuboot-katmai.c
>> index 034a748fde24..fcd71e76309f 100644
>> --- a/arch/powerpc/boot/cuboot-katmai.c
>> +++ b/arch/powerpc/boot/cuboot-katmai.c
>> @@ -31,7 +31,7 @@ static void katmai_fixups(void)
>>   {
>>       unsigned long sysclk = 33333000;
>>   -    /* 440SP Clock logic is all but identical to 440GX
>> +    /* 440SPe Clock logic is all but identical to 440GX
>>        * so we just use that code for now at least
>>        */
>>       ibm440spe_fixup_clocks(sysclk, 6 * 1843200, 0);
>> diff --git a/arch/powerpc/include/asm/async_tx.h b/arch/powerpc/
>> include/asm/async_tx.h
>> index a14758426dd5..1ff5b2ca3ed1 100644
>> --- a/arch/powerpc/include/asm/async_tx.h
>> +++ b/arch/powerpc/include/asm/async_tx.h
>> @@ -7,7 +7,7 @@
>>   #ifndef _ASM_POWERPC_ASYNC_TX_H_
>>   #define _ASM_POWERPC_ASYNC_TX_H_
>>   -#if defined(CONFIG_440SPe) || defined(CONFIG_440SP)
>> +#if defined(CONFIG_440SPe)
> 
> Replace by #ifdef CONFIG_440SPe

Thanks for your feedback, will send a v2!

- Julian Braha


