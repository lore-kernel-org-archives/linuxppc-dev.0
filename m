Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855C3C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:47:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A3620851
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H3IU8tzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A3620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438FqX3g1ZzDqMw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 19:47:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H3IU8tzb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=narmstrong@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="H3IU8tzb"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438FkT116jzDqf2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 19:43:12 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so14943510wru.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 00:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mvkdi3q+pCk19j+OSCfIIO4IR4c7G8O0A9eW6/HhP7s=;
 b=H3IU8tzbX+K1KZGAxgcl8y+TQFRwPk/o9HFRGDIA8A/MN17BRpJls1VASuivI/q4H8
 Sz7R0XqDNbYmkk/jGBKD/E/zaDuN1+5PSfFv1XKBFWoFCi1Q5ab0ootFd3mpq8VGw7pj
 kBo7P/zm0yvM8cyaBp/rh+lVcoLu4CeDxSfrUwSX/Dt/u5USczVIRBcLYjA61vs6Nq2F
 CEigs7nGwonnLgqZzaVGR6OURed7BAm6y5oYkOhxzZhCbwt7ebpgRusmRCsJWBnUksMb
 69mVuvJsxaEKoOcDzj4XTx1PudP6US5GJ+LyvPD/QlDimfDgxlTyzmwpo7okhoLa+qZk
 Hk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mvkdi3q+pCk19j+OSCfIIO4IR4c7G8O0A9eW6/HhP7s=;
 b=s1wx+Q9vGj6rNQFtTwc+ueyCY/oFBiPs6xILTWv+UeszcFxTWGsQiKKq1D3ZCVdH2V
 WRhoBqPsjzbfJwDrqAOy6ou58jRZA3A30/y57uKECjRlEgJkctYe1qGMx7dQCNQXs5qB
 3p70jbLTZxf6GnMGekJl6d0k1KU7s4ygQlvj74Kaz0QpjNjuJcu7OOR5mhubE5Bmd3tf
 6BAQEVqdWBW8VzvnaDNnFPaM5/IGWCFB5XVUlF9lTyJuNuS/7wJfhwpyByUFJ5kN3mJS
 lsNIu9l3+ngWF/OgMdGXEm9V84lqeIysrrYh13yJCXXVFNg7hxZ8XXSK4ekVyjwMKgVk
 X5RA==
X-Gm-Message-State: AA+aEWY//57juKZjrk8F+C4D5GaD1A7YPk8OIID2qyDVnCEbim4WDRCN
 +QAqLFzHBMuB5ttK5KYuaOSmYA==
X-Google-Smtp-Source: AFSGD/W9CGJvXkWDmL2+CrcScCbawKHbOYyyQMMNdnjxECss33LNwTLqVmdaYL5HAgosqUsb0vk9Rw==
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr4149796wrj.107.1543912989653; 
 Tue, 04 Dec 2018 00:43:09 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id c13sm37317099wrb.38.2018.12.04.00.43.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 00:43:09 -0800 (PST)
Subject: Re: [PATCH v2 21/34] dt-bindings: arm: Convert Oxford Semi board/soc
 bindings to json-schema
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-22-robh@kernel.org>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <be37bd18-a573-307e-3a9e-e879010cfc89@baylibre.com>
Date: Tue, 4 Dec 2018 09:43:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203213223.16986-22-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 linux-oxnas@groups.io, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/12/2018 22:32, Rob Herring wrote:
> Convert Oxford Semi SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-oxnas@groups.io
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
>  .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
> deleted file mode 100644
> index ac64e60f99f1..000000000000
> --- a/Documentation/devicetree/bindings/arm/oxnas.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -Oxford Semiconductor OXNAS SoCs Family device tree bindings
> --------------------------------------------
> -
> -Boards with the OX810SE SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "oxsemi,ox810se"
> -
> -Boards with the OX820 SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "oxsemi,ox820"
> -
> -Board compatible values:
> -  - "wd,mbwe" (OX810SE)
> -  - "cloudengines,pogoplugv3" (OX820)
> diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
> new file mode 100644
> index 000000000000..6ae51ef513be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/oxnas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +            - wd,mbwe
> +        - const: oxsemi,ox810se
> +
> +      - items:
> +        - enum:
> +            - cloudengines,pogoplugv3
> +        - const: oxsemi,ox820
> 

We also loose all the "human friendly" description of board/SoC relationship here,
and I think it's a shame.

Neil
