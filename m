Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D99C54E58
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2024 02:13:26 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=afLtE0T0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V15Td3MSRz3vd8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2024 13:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=afLtE0T0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V15S26l5Hz3vYC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2024 13:12:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D9BDACE16D6;
	Fri, 22 Mar 2024 02:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB13FC433F1;
	Fri, 22 Mar 2024 02:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711073521;
	bh=83nutzeefgsOE5CnvYG798Q0O8Wla+1+5aZYf7V8tL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afLtE0T0j/XfJkMMdDNkeaRrj1xuQ87Gs3WgccYlaqcIIS36e3KPftIhmnSmw3Gwp
	 Kv6f8YAwUAyl9s88Ibwkmr/0irZ8roqDT1pfe1uYSKf0balWVFcTQEG/9l5ObOZ+L0
	 olwWgDVlPrHFNPSHh/wt1MeZ61F7Nx71rk0DsT8y3CAm5hr4WMAgA11wBc09rMdV3q
	 DFTDOZd2FWtSn1bEbvyOSzHYv1alOdfx7Gflbh5PbXbpicpunXf00OA3e5J/UCtKsF
	 hQwUK3uILtiNHP8B4ml2RgOOoihF3KXmfI0d/GPLHDwaY/sK5yTOF+lQ/2FYC4izH3
	 HUxuIm6p4m0xA==
Date: Thu, 21 Mar 2024 21:11:58 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: hwmon: ibm,p8-occ-hwmon: move to
 trivial devices
Message-ID: <171107351631.3413678.6212026381128408904.robh@kernel.org>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
 <20240321-hwmon_dtschema-v1-5-96c3810c3930@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-hwmon_dtschema-v1-5-96c3810c3930@gmail.com>
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
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On Thu, 21 Mar 2024 19:43:46 +0100, Javier Carrasco wrote:
> This binding meets the requirements to be converted to dtschema
> via trivial-devices.yaml.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt | 25 ----------------------
>  .../devicetree/bindings/trivial-devices.yaml       |  2 ++
>  2 files changed, 2 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

