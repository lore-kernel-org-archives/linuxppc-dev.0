Return-Path: <linuxppc-dev+bounces-19509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1C31073CBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 13:43:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frPRD6Qwjz2yDk;
	Wed, 08 Apr 2026 23:43:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775655816;
	cv=none; b=IEktYOUCp3jP4M1Uxz9aE1MYBIX1pBeN11dfUKQL2TtlkfjCaCFK4FSZFMSooZtpeRegCo0NNW+0Cbm51gDbZ9Y+hWSjCKQEYYQHlaz0S+zI63liQUD1YnWmCJZDhw6EtuiaIotQKQKniy5mSCp9hAkWZd0vVdiNwRNut0qIjsUUVHfGITQ5zVxrSjvqmWtnepIwTBkD+Gf8v/9yf+lzqtLt9Ybtlx9q8ou8OE/j4Z5EoxIvCw3XjLYytfbOibi24rr/mP0Vxk0ZDHYb057iPShWu+1AGZ6SnhpwQ9lKN0vLfScpIZ9CnVeuOog/jNtccW+qaRH0OeX41z+g/sbWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775655816; c=relaxed/relaxed;
	bh=Fxn/SE4idi6R+P8P55VqxVaXio9KzyvR3eDsoiQUFGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BonDNlj3Y34GRJDrvfgZHQCsDvzwgrK6n7yp47/lKNyB0n/Zljt3HvUCvm3NYoenU+WSN2QFl3+zCUIC4e+ZatIESN3R8hPBZ06LXKRG3sG1HzdMXuMlD1LCX1fGepEluwqSw2e0yEQQJIdsXkPcan5AEoT/SFVjj378U5kYrNfxq4mo9R2ja9lG6zZAbPx2fBeUZ5sfpKqUIyxXwBlIKlz8/s3qYfah4cTGT1DtIKe2pyUi29Uhto8RA6nrdDJjzvTHQE8hczSInIGbr4YebuQjOipZcPEVYHtP9I20TtplDFByOhYZ4zuehYfAv4L/x5Qmgg1WF5wpYt70i3UZlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mt3bC8Xe; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mt3bC8Xe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frPRC5Lhjz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 23:43:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F0008403CA;
	Wed,  8 Apr 2026 13:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10FEC19421;
	Wed,  8 Apr 2026 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775655813;
	bh=Jnf+ozIJ0XTw1JCMnYaJZUZHhfGsLNJN8+qXwRREUr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mt3bC8Xe9YNXi3EsiPIIrgv1kM+5SxXDvsMb9MUTEOGB3pT07SjJYGbg9+3EoDK1j
	 vKdq+5bCpanKobBYgd/O41JfRtzIxnnxjZ+u76vIZnvcYXJd1BCeU9JjjwYZevpHJp
	 rCjgAuUQl1uVWtuiIKsPteMb8rQhG2JjkFSUHfqzX4mafdhXqtJFeN+XldMJd0keDJ
	 fPcUqM25T50HfFxuR68n0h7bi9HqtKYa5jcJ43na8sX3duRMt8BmntVQPT8mwJb2Jg
	 LGGfYOvAw8/wkpAO5CNSVSYHBvve9NR+cSpXeQ3zJwNhldH0IC4E5lq2EXOt0v3qq8
	 4e8sJieQoD/WA==
Date: Wed, 8 Apr 2026 08:43:31 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, f.fainelli@gmail.com, frank.li@nxp.com,
	chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 02/14] dt-bindings: net: dsa: add NETC switch
Message-ID: <20260408134331.GA1954185-robh@kernel.org>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
 <20260331113025.1566878-3-wei.fang@nxp.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331113025.1566878-3-wei.fang@nxp.com>

On Tue, Mar 31, 2026 at 07:30:13PM +0800, Wei Fang wrote:
> Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
> it supports advanced QoS with 8 traffic classes and 4 drop resilience
> levels, and a full range of TSN standards capabilities. The switch CPU
> port connects to an internal ENETC port, which is also a PCIe function
> of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
> of a back-to-back MAC, because the "pseudo MAC" provides the delineation
> between switch and ENETC, this translates to lower power (less logic and
> memory) and lower delay (as there is no serialization delay across this
> link).
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/dsa/nxp,netc-switch.yaml     | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> new file mode 100644
> index 000000000000..5577f3ef987f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NETC Switch family
> +
> +description: >
> +  The NETC presents itself as a multi-function PCIe Root Complex Integrated
> +  Endpoint (RCiEP) and provides full 802.1Q Ethernet switch functionality,
> +  advanced QoS with 8 traffic classes and 4 drop resilience levels, and a
> +  full range of TSN standards capabilities.
> +
> +  The CPU port of the switch connects to an internal ENETC. The switch and
> +  the internal ENETC are fully integrated into the NETC IP, a back-to-back
> +  MAC is not required. Instead, a light-weight "pseudo MAC" provides the
> +  delineation between the switch and ENETC. This translates to lower power
> +  (less logic and memory) and lower delay (as there is no serialization
> +  delay across this link).
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1131,eef2
> +
> +  reg:
> +    maxItems: 1
> +
> +  dsa,member:
> +    description: >
> +      The property indicates DSA cluster and switch index. For NETC switch,
> +      the valid range of the switch index is 1 ~ 7, the index is reflected
> +      in the switch tag as an indication of the switch ID where the frame
> +      originated. The value 0 is reserved for ENETC VEPA switch, whose ID
> +      is hardwired to zero.
> +
> +$ref: dsa.yaml#

Move this under the 'allOf' so all $ref's are together.

> +
> +patternProperties:
> +  "^(ethernet-)?ports$":

'ethernet-ports' for new bindings.

> +    type: object
> +    additionalProperties: true
> +    patternProperties:
> +      "^(ethernet-)?port@[0-9a-f]$":

And 'ethernet-port'

> +        type: object
> +
> +        $ref: dsa-port.yaml#
> +
> +        properties:
> +          clocks:
> +            items:
> +              - description: MAC transmit/receive reference clock.
> +
> +          clock-names:
> +            items:
> +              - const: ref
> +
> +          mdio:
> +            $ref: /schemas/net/mdio.yaml#
> +            unevaluatedProperties: false
> +            description:
> +              Optional child node for switch port, otherwise use NETC EMDIO.
> +
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - dsa,member
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ethernet-switch@0,2 {
> +            compatible = "pci1131,eef2";
> +            reg = <0x200 0 0 0 0>;
> +            dsa,member = <0 1>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_switch>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    phy-handle = <&ethphy0>;
> +                    phy-mode = "mii";
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    phy-handle = <&ethphy1>;
> +                    phy-mode = "mii";
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    clocks = <&scmi_clk 103>;
> +                    clock-names = "ref";
> +                    phy-handle = <&ethphy2>;
> +                    phy-mode = "rgmii-id";
> +                };
> +
> +                port@3 {
> +                    reg = <3>;
> +                    ethernet = <&enetc3>;
> +                    phy-mode = "internal";
> +
> +                    fixed-link {
> +                        speed = <2500>;
> +                        full-duplex;
> +                        pause;
> +                    };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 

