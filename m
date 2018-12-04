Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A462BC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:41:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E893020851
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VxozRPU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E893020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438Fhw6cSmzDqgj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 19:41:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VxozRPU3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=narmstrong@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="VxozRPU3"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438Fdz5D9QzDq98
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 19:39:19 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id v13so14928666wrw.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 00:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=A6oMdVmSYFJfQ2gycASYL7IqJAeMr9us2T/RQF4Oj9Y=;
 b=VxozRPU3FYwfdViddJcG2zz4eAyGcCsIuYtwdtXw+//K3SjZf/Q2TkpcgsIGa5S1r6
 56f/m9L04PtePKPR0HrtdabxkgdACfJhv3RGXPDbr6PWPqfn7LRXiRNYHcvemPBW7vEi
 xW3VrtBMSE2mYiXKLwUKZWgGOHuPfdZQQmH9JaDR3dI7+BVPU8PpdImmiwMpxRQH90dF
 z5y1cCrSTbTEi3n+5po6FpYDmHmF7WsidJUbAXgMcE3Io1MJphr3UMZdWeOiDInZqSdT
 Tc64a9bwobkR0SlMfNflHaMCHi8TVjJ1LWumLWY0Gm2LiBoL0NlR59S6miK/Qn5emfql
 09Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=A6oMdVmSYFJfQ2gycASYL7IqJAeMr9us2T/RQF4Oj9Y=;
 b=TvPElX1U5fRRaWZKFhLqk8Kt0KdH9A14qd1DT8zNl02mDOo+8hxnaX42Hh8S2cYzCQ
 035XEmvVEtjtJSmeGTHp978J6y03qbYnxQJqqmE7ucriDEoRrBVrB6F0uBW8Dl3xA4an
 /ST0GKE3BkYVgaFhO+XYdRLhpnYKN2GJz7fzlTAESs4MEcbADt2vtrehhkah0sbnoiMu
 KYJbI3E2x6xQvHDO7CDo7KGm0fJjSVvifn31SSyD5oCq589GmBhSzaHOMmCPTqySRDiE
 8IsdGX5E+fUhgEqixuZYSULfNmY4IFiYLTVf3Y39wMmIN5TI+CypeGv07nseDbb5CFTS
 B2Og==
X-Gm-Message-State: AA+aEWb1VDhmtKMuXPS6mToYKTYwqVX1GnBdyN1E2sOulSSiCMn3VANw
 FKxZjRi1GPgaU0f19ydcrnv/OA==
X-Google-Smtp-Source: AFSGD/UWQ6h4k9Em1sCz22tcNYWTckdm43xpX6BJVGQ7R6ZVH4aFOSV3six5K+3/atv+GVMqiKcbuQ==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr18277556wrn.109.1543912756537; 
 Tue, 04 Dec 2018 00:39:16 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id n12-v6sm6905842wmi.1.2018.12.04.00.39.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 00:39:15 -0800 (PST)
Subject: Re: [PATCH v2 14/34] dt-bindings: arm: Convert Amlogic board/soc
 bindings to json-schema
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-15-robh@kernel.org>
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
Message-ID: <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
Date: Tue, 4 Dec 2018 09:39:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203213223.16986-15-robh@kernel.org>
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
 Kevin Hilman <khilman@baylibre.com>, linuxppc-dev@lists.ozlabs.org,
 Grant Likely <grant.likely@arm.com>, Carlo Caione <carlo@caione.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

You forgot linux-amlogic in CC...

On 03/12/2018 22:32, Rob Herring wrote:
> Convert Amlogic SoC bindings to DT schema format using json-schema.
> 
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/amlogic.txt       | 109 ------------------
>  .../devicetree/bindings/arm/amlogic.yaml      | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 109 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> deleted file mode 100644
> index f5c8d50a3506..000000000000
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -Amlogic MesonX device tree bindings
> --------------------------------------------
> -
> -Work in progress statement:
> -
> -Device tree files and bindings applying to Amlogic SoCs and boards are
> -considered "unstable". Any Amlogic device tree binding may change at
> -any time. Be sure to use a device tree binary and a kernel image
> -generated from the same source tree.
> -
> -Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
> -stable binding/ABI.
> -
> ----------------------------------------------------------------
> -
> -Boards with the Amlogic Meson6 SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,meson6"
> -
> -Boards with the Amlogic Meson8 SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,meson8";
> -
> -Boards with the Amlogic Meson8b SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,meson8b";
> -
> -Boards with the Amlogic Meson8m2 SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,meson8m2";
> -
> -Boards with the Amlogic Meson GXBaby SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,meson-gxbb";
> -
> -Boards with the Amlogic Meson GXL S905X SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,s905x", "amlogic,meson-gxl";
> -
> -Boards with the Amlogic Meson GXL S905D SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,s905d", "amlogic,meson-gxl";
> -
> -Boards with the Amlogic Meson GXL S805X SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,s805x", "amlogic,meson-gxl";
> -
> -Boards with the Amlogic Meson GXL S905W SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,s905w", "amlogic,meson-gxl";
> -
> -Boards with the Amlogic Meson GXM S912 SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,s912", "amlogic,meson-gxm";
> -
> -Boards with the Amlogic Meson AXG A113D SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,a113d", "amlogic,meson-axg";
> -
> -Boards with the Amlogic Meson G12A S905D2 SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "amlogic,g12a";
> -
> -Board compatible values (alphabetically, grouped by SoC):
> -
> -  - "geniatech,atv1200" (Meson6)
> -
> -  - "minix,neo-x8" (Meson8)
> -
> -  - "endless,ec100" (Meson8b)
> -  - "hardkernel,odroid-c1" (Meson8b)
> -  - "tronfy,mxq" (Meson8b)
> -
> -  - "tronsmart,mxiii-plus" (Meson8m2)
> -
> -  - "amlogic,p200" (Meson gxbb)
> -  - "amlogic,p201" (Meson gxbb)
> -  - "friendlyarm,nanopi-k2" (Meson gxbb)
> -  - "hardkernel,odroid-c2" (Meson gxbb)
> -  - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
> -  - "tronsmart,vega-s95-pro", "tronsmart,vega-s95" (Meson gxbb)
> -  - "tronsmart,vega-s95-meta", "tronsmart,vega-s95" (Meson gxbb)
> -  - "tronsmart,vega-s95-telos", "tronsmart,vega-s95" (Meson gxbb)
> -  - "wetek,hub" (Meson gxbb)
> -  - "wetek,play2" (Meson gxbb)
> -
> -  - "amlogic,p212" (Meson gxl s905x)
> -  - "hwacom,amazetv" (Meson gxl s905x)
> -  - "khadas,vim" (Meson gxl s905x)
> -  - "libretech,cc" (Meson gxl s905x)
> -
> -  - "amlogic,p230" (Meson gxl s905d)
> -  - "amlogic,p231" (Meson gxl s905d)
> -
> -  - "amlogic,p241" (Meson gxl s805x)
> -
> -  - "amlogic,p281" (Meson gxl s905w)
> -  - "oranth,tx3-mini" (Meson gxl s905w)
> -
> -  - "amlogic,q200" (Meson gxm s912)
> -  - "amlogic,q201" (Meson gxm s912)
> -  - "khadas,vim2" (Meson gxm s912)
> -  - "kingnovel,r-box-pro" (Meson gxm S912)
> -  - "nexbox,a1" (Meson gxm s912)
> -  - "tronsmart,vega-s96" (Meson gxm s912)
> -
> -  - "amlogic,s400" (Meson axg a113d)
> -
> -  - "amlogic,u200" (Meson g12a s905d2)
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> new file mode 100644
> index 000000000000..8b4b11194658
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/amlogic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic MesonX device tree bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>

The maintainer is Kevin Hilman.

> +  - Carlo Caione <carlo@caione.org>
> +description: |+
> +  Work in progress statement:
> +
> +  Device tree files and bindings applying to Amlogic SoCs and boards are
> +  considered "unstable". Any Amlogic device tree binding may change at
> +  any time. Be sure to use a device tree binary and a kernel image
> +  generated from the same source tree.
> +
> +  Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
> +  stable binding/ABI.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - geniatech,atv1200
> +          - const: amlogic,meson6
> +      - items:
> +          - enum:
> +              - minix,neo-x8
> +          - const: amlogic,meson8
> +      - items:
> +          - enum:
> +              - tronsmart,mxiii-plus
> +          - const: amlogic,meson8m2
> +      - items:
> +          - enum:
> +              - endless,ec100
> +              - hardkernel,odroid-c1
> +              - tronfy,mxq
> +          - const: amlogic,meson8b
> +      - items:
> +          - enum:
> +              - amlogic,p200
> +              - amlogic,p201
> +              - friendlyarm,nanopi-k2
> +              - hardkernel,odroid-c2
> +              - nexbox,a95x
> +              - wetek,hub
> +              - wetek,play2
> +          - const: amlogic,meson-gxbb
> +      - items:
> +          - enum:
> +              - tronsmart,vega-s95-pro
> +              - tronsmart,vega-s95-meta
> +              - tronsmart,vega-s95-telos
> +          - const: tronsmart,vega-s95
> +          - const: amlogic,meson-gxbb
> +      - items:
> +          - enum:
> +              - amlogic,p241
> +          - const: amlogic,s805x
> +          - const: amlogic,meson-gxl
> +      - items:
> +          - enum:
> +              - amlogic,p281
> +              - oranth,tx3-mini
> +          - const: amlogic,s905w
> +          - const: amlogic,meson-gxl
> +      - items:
> +          - enum:
> +              - amlogic,p212
> +              - hwacom,amazetv
> +              - khadas,vim
> +              - libretech,cc
> +              - nexbox,a95x
> +          - const: amlogic,s905x
> +          - const: amlogic,meson-gxl
> +      - items:
> +          - enum:
> +              - amlogic,p230
> +              - amlogic,p231
> +          - const: amlogic,s905d
> +          - const: amlogic,meson-gxl
> +      - items:
> +          - enum:
> +              - amlogic,q200
> +              - amlogic,q201
> +              - khadas,vim2
> +              - kingnovel,r-box-pro
> +              - nexbox,a1
> +              - tronsmart,vega-s96
> +          - const: amlogic,s912
> +          - const: amlogic,meson-gxm
> +      - items:
> +          - enum:
> +              - amlogic,s400
> +          - const: amlogic,a113d
> +          - const: amlogic,meson-axg
> +      - items:
> +          - enum:
> +              - amlogic,u200
> +          - const: amlogic,g12a

but all this feels wrong for me.

First of all, this yaml description is not human friendly and not intuitive at all,
and secondly with this conversion we loose all the comments about the SoC family relationship
with the compatible strings !

I really understand the point to have automated verification, but really it's a pain to read
(I can't imagine newcomers... the actual DT bindings are already hard to read...) and
I feel it will be a real pain to write !

Can't we mix an "humam text" with a "yaml" part on a same document ? we are in 2018 (nearly 2019),
and it should be easy to extract a yaml description from a text document without pain and
keep all the human description, no ?

What will be the case for all the bindings with ASCII art to describe the architecture of the
HW ? will you simply drop it to replace it with cold yaml description ?

Neil

> +
> +...
> 

