Return-Path: <linuxppc-dev+bounces-8253-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5750C3ABA3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 May 2025 09:50:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZpmPp2Wtnz30Sv;
	Fri,  2 May 2025 19:50:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.236.30
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746179438;
	cv=none; b=PZ75WVXUjG70LEWYgwGJPDzKWKcATjJTw/tIDiwXNpkUy3TkY4S0p2dYNhUHDZW8/CcwxeyX3l7/dGBBxsvzh4AdHDGZRRc40LewsQQ2qub0LzA0old+cLjF6nkhwMc1H2ydtUPJ8eb3T5fVE36ewhZ+QQ95C4cCHgq1+kLuCAecibPOXhlguGeaNOFGdjNKZSgqnJnOkFJeUFsZWowRjVOaLRDKMKu/gx8mW9tH6QriQ8KuYrGfA7zBNz1beMEizMwSNM0cTrMPtChIIImQau88o1Fto0G4bePZlaVXZw5F6wzLxL5q8CK5AzjJ2yfTFUqXqCmH6f1O+63r9S6fFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746179438; c=relaxed/relaxed;
	bh=lzSno6rRSayf/UEJk2+uVMe9ZaMTzfso9CG0VamVVdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR1JuEM9dLI1P9MsD1kS2MphlmuEPuO98vk5QWY4YntuQOxTGdtst+F4SML5Ejf9lXmZXc8LSUJtgA6NlpuYW6znfnHaBACRyTCLeWEnlitIvHOFz3/dGevrILTT2ZePwV0GP2P55rcM+HtZknHttMoA5f7IiGcmSXbwbtgBdPB4hVB+YcG3YYm8A0qtv30mrbUqcTe4BPvMkuVd/1I7zKhKEC/uELKsVLDm4MOTMSwLchLnhVdTJ5z48KbCR1+QZKvZiV/f9O5XIuoqj44Q+SSQyRw9xMsgq/nZXSfGMCSFVLjjseK2AptdDmwgEBRuRUYqeqkLA1pkxe13nPfkEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZpmPn2f3Jz30LS
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2025 19:50:36 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Zpm0p2R7Zz9sVS;
	Fri,  2 May 2025 11:32:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zcdAzJ89m-7Z; Fri,  2 May 2025 11:32:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Zpm0T386Wz9sYQ;
	Fri,  2 May 2025 11:32:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 670DC8B765;
	Fri,  2 May 2025 11:32:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wmcughdSQ2WZ; Fri,  2 May 2025 11:32:09 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DA1DF8B763;
	Fri,  2 May 2025 11:32:08 +0200 (CEST)
Message-ID: <4d6de524-82b7-41b3-af67-29dcf6f8c0cf@csgroup.eu>
Date: Fri, 2 May 2025 11:32:08 +0200
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
Subject: Re: [PATCH v2 2/5] powerpc: 83xx/gpio: use new line value setter
 callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250502-gpiochip-set-rv-powerpc-v2-0-488e43e325bf@linaro.org>
 <20250502-gpiochip-set-rv-powerpc-v2-2-488e43e325bf@linaro.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250502-gpiochip-set-rv-powerpc-v2-2-488e43e325bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/05/2025 à 10:59, Bartosz Golaszewski a écrit :
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> index 4d8fa9ed1a678..6e37dfc6c5c9e 100644
> --- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> +++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> @@ -92,10 +92,11 @@ static void mcu_power_off(void)
>   	mutex_unlock(&mcu->lock);
>   }
>   
> -static void mcu_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +static int mcu_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
>   {
>   	struct mcu *mcu = gpiochip_get_data(gc);
>   	u8 bit = 1 << (4 + gpio);
> +	int ret;
>   
>   	mutex_lock(&mcu->lock);
>   	if (val)
> @@ -103,14 +104,16 @@ static void mcu_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
>   	else
>   		mcu->reg_ctrl |= bit;
>   
> -	i2c_smbus_write_byte_data(mcu->client, MCU_REG_CTRL, mcu->reg_ctrl);
> +	ret = i2c_smbus_write_byte_data(mcu->client, MCU_REG_CTRL,
> +					mcu->reg_ctrl);
>   	mutex_unlock(&mcu->lock);
> +
> +	return ret;
>   }
>   
>   static int mcu_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>   {
> -	mcu_gpio_set(gc, gpio, val);
> -	return 0;
> +	return mcu_gpio_set(gc, gpio, val);
>   }
>   
>   static int mcu_gpiochip_add(struct mcu *mcu)
> @@ -123,7 +126,7 @@ static int mcu_gpiochip_add(struct mcu *mcu)
>   	gc->can_sleep = 1;
>   	gc->ngpio = MCU_NUM_GPIO;
>   	gc->base = -1;
> -	gc->set = mcu_gpio_set;
> +	gc->set_rv = mcu_gpio_set;
>   	gc->direction_output = mcu_gpio_dir_out;
>   	gc->parent = dev;
>   
> 


