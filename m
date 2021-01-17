Return-Path: <SRS0=TEE+=GU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2525C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Jan 2021 20:46:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65DA21D7A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Jan 2021 20:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65DA21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DJn5Z2N03zDrdH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Jan 2021 07:46:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532;
 helo=mail-ed1-x532.google.com; envelope-from=jbx6244@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Z3jIlgWo; dkim-atps=neutral
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DJfyj2k3SzDrQK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2021 03:10:16 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id by27so14857425edb.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jan 2021 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AC5FWFmc+QTt0xSwIGW5Ve415efkuLFNzYSONRpyY3A=;
 b=Z3jIlgWoZFgSihGakcm0/3i9PnUa5Mldf0etdusMFVD6qeABjeb9Bzg/TMV0v8wYS7
 2YP50bGWIYaL7bDG1A1C9LnD9ZDKvcns0g8fxORrfS70yeEq6uaani6aQ4ce63nWqZKb
 XcRC/Pr8aIsx4GyJF0QB1RqXm12XctFH99pmdZvc1cH6qiGGqN9stfgt8w/jFf2icHZb
 hb2cA8rzhusgWU52WHErYn0VksmsInJEjY9qAF/yNxCEVtbK3Jn6ltVhxyX5o2RBbroG
 DHHceUgDFwGHPn740YhOjzdXPNZQcrH4Kv1g9PU/4mi9lRUplXaHt71bJU1jLl9p11xf
 wuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AC5FWFmc+QTt0xSwIGW5Ve415efkuLFNzYSONRpyY3A=;
 b=D4Ct9XxVn3I98WIHS3PnnU9R2RLO66SkgL8Y5DRgOGPaR7WKNW+Ot6/2edf5wLhFCZ
 GoD1JHrlW1kckkfhD1trOAqYyYFofjQCwBAg7s5hC4hl3ztv5g1LWc8H0MZPTQE4g95j
 s2fRi0Iq9tEe2tuT3y09KkNGEQiVDt16AI0caSosZ5I1lBadBsbc4C1gD92S81x54R72
 TBuTthOs0bflIzcFAq2x+HJ+nx7v/0Y0s9uP7vXdqe7A3eok+udPkMX90svAsq+SRBf7
 Xm4XWAGfk1jtB74DI9lK5a/pXKjANkwkOtfTEgCZcWu6cmQssakqjV39hxXf+phyy/HY
 okFA==
X-Gm-Message-State: AOAM532uoq9+gT/JCu6Rblq830LGqqjNGcT5a6SlIB8hJQKa5i+1/Eq5
 THWZB3jx8aHir5vWfnvgOe0=
X-Google-Smtp-Source: ABdhPJyg8dZx1Wx6RZW2DUzsycvLMXgXRa57jQLGpJv594NuwqT+1gHHzty/XrnPy/vGD3Kc0WjhEA==
X-Received: by 2002:a05:6402:17cb:: with SMTP id
 s11mr16034374edy.119.1610899807548; 
 Sun, 17 Jan 2021 08:10:07 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 dm6sm4885472ejc.32.2021.01.17.08.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Jan 2021 08:10:06 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: powerpc: Add a schema for the 'sleep'
 property
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20201008142420.2083861-1-robh@kernel.org>
From: Johan Jonker <jbx6244@gmail.com>
Message-ID: <752e9355-defb-6d3c-248b-f626247d4cee@gmail.com>
Date: Sun, 17 Jan 2021 17:10:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008142420.2083861-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 18 Jan 2021 07:44:59 +1100
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
Cc: Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

This patch generates notifications in the Rockchip ARM and arm64 tree.
Could you limit the scope to PowerPC only.

Kind regards,

Johan Jonker

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml

Example:

/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dt.yaml: pinctrl:
sleep: {'ddrio-pwroff': {'rockchip,pins': [[0, 1, 1, 168]]},
'ap-pwroff': {'rockchip,pins': [[1, 5, 1, 168]]}} is not of type 'array'
	From schema: /Documentation/devicetree/bindings/powerpc/sleep.yaml

On 10/8/20 4:24 PM, Rob Herring wrote:
> Document the PowerPC specific 'sleep' property as a schema. It is
> currently only documented in booting-without-of.rst which is getting
> removed.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/powerpc/sleep.yaml    | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/sleep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/sleep.yaml b/Documentation/devicetree/bindings/powerpc/sleep.yaml
> new file mode 100644
> index 000000000000..6494c7d08b93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/sleep.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/sleep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PowerPC sleep property
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +description: |
> +  Devices on SOCs often have mechanisms for placing devices into low-power
> +  states that are decoupled from the devices' own register blocks.  Sometimes,
> +  this information is more complicated than a cell-index property can
> +  reasonably describe.  Thus, each device controlled in such a manner
> +  may contain a "sleep" property which describes these connections.
> +
> +  The sleep property consists of one or more sleep resources, each of
> +  which consists of a phandle to a sleep controller, followed by a
> +  controller-specific sleep specifier of zero or more cells.
> +
> +  The semantics of what type of low power modes are possible are defined
> +  by the sleep controller.  Some examples of the types of low power modes
> +  that may be supported are:
> +
> +   - Dynamic: The device may be disabled or enabled at any time.
> +   - System Suspend: The device may request to be disabled or remain
> +     awake during system suspend, but will not be disabled until then.
> +   - Permanent: The device is disabled permanently (until the next hard
> +     reset).
> +
> +  Some devices may share a clock domain with each other, such that they should
> +  only be suspended when none of the devices are in use.  Where reasonable,
> +  such nodes should be placed on a virtual bus, where the bus has the sleep
> +  property.  If the clock domain is shared among devices that cannot be
> +  reasonably grouped in this manner, then create a virtual sleep controller
> +  (similar to an interrupt nexus, except that defining a standardized
> +  sleep-map should wait until its necessity is demonstrated).
> +
> +select: true
> +
> +properties:
> +  sleep:
> +    $ref: /schemas/types.yaml#definitions/phandle-array
> +
> +additionalProperties: true
> 

