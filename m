Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C89606A31F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2BGeVUp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFs0B5YRnz30Sv;
	Fri, 30 Oct 2026 04:38:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793295514;
	cv=none; b=oCreRM9l11j7UAt8QhuiiA4lg2FuiGgDRsbkprnFW1CTsUwUKmxFoZ6vtX8FgfMmdZ2f8wrVvnTyOvIFjwo5sazhDz34s6DpxHf3a03ZvFQPUT+MGDNUWfZphffBJ1yG5zdwktyU9JrDSRQi/y6RpQ6XWwvhEOcWbkVQLzictISWxr+Rl1qdWYuqm5Paemf9ApE1+0D8/TO9RPaPGG4AZ89YFdZ/UgiKN9nHbfjaDdq4irQhMB9G/TgfxIWQFZTSAZlp1e00/lHCeLdndeUDPvcjNIxTQMjgiAhh4Zf6hcg5kFe/8TMOk/YY2JRXF/zS52hb6TYs2pSZHcuJ6S14nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793295514; c=relaxed/relaxed;
	bh=/KEC84hmoiSqAMPb0/WNJj6+/aU+u2mLmnNoCNNmZpY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dm2Ah4Sq6/0V2aowQTXaENlDvHcQ3CGXlieQMTwWj5Fm46hde/LWLrW5Jpv1z3XcsSjtmhCCoSWHAQImM1ecGvhhb5puzCsIBG4nBt3Q3reeSmh086F2jZ5SRcu2QbHrYHR2OtlT/cJh5cc8OXc9gH2tdcT5at2F0KTns/bzNynB2XbxYw6Ftbla3w/bkwACGpy0UeBIiSQ6ba+tF1oJwPY1VBtC/3G7Yv9D6optRR4bfoTLhahmsQKwrgQshz/7cCtBGL2aJb6QX2SKF2v7z1mMkHmxAR33A6n5bp34irsKWhITnQEiXl2QaSGSVfgB5jYsD6olDmahmtqk9sEQaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2BGeVUp; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2BGeVUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFs095CYFz2yql
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 04:38:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D119A40485;
	Thu, 29 Oct 2026 17:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7706E1F01826;
	Thu, 29 Oct 2026 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793295510;
	bh=/KEC84hmoiSqAMPb0/WNJj6+/aU+u2mLmnNoCNNmZpY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=X2BGeVUpZHoGajAQeQzH20EQSs95tIj1nCOEkAxuv3bdZFkgBT3F1oQphYaKbfZc9
	 rR9pXZmm8yihu6ppjvGoZ2oXEG+uTJuki8pvFHhRtEq1gF1uC5dwE25wPV2jKntI37
	 rGBjCVVYHu8X3PNlL0/xPxB58Lu2LDaL9VtOrGy4KbEvEvullSTPX05EUmsqlhhYnk
	 caxq/vugvm3w6bPfXGUtkGVvXpSEbDtCk10AEBGgbp0KrIUlCzJ1M7hvqCUJpgHMPn
	 wLV1Zy5fVR+JnKDVJQxrsMHtFTIQK0vR1rIWSxWI1BTnav0A1lYH5Q32uFV8a5dlWO
	 +hHWjhnsOTcbA==
Date: Thu, 29 Oct 2026 12:38:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk@kernel.org, linuxppc-dev@lists.ozlabs.org, chleroy@kernel.org, 
 npiggin@gmail.com, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, 
 ritesh.list@gmail.com, conor+dt@kernel.org, mpe@ellerman.id.au, 
 devicetree@vger.kernel.org, sshegde@linux.ibm.com, maddy@linux.ibm.com
To: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
In-Reply-To: <20261029112742.10238-1-lefteris.koutrakis@gmail.com>
References: <20261029112742.10238-1-lefteris.koutrakis@gmail.com>
Message-Id: <179329529616.3541731.13593434719099067546.robh@kernel.org>
Subject: Re: [PATCH v2] powerpc: dts: Add support for WatchGuard Firebox
 T30
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 29 Oct 2026 07:27:41 -0400, Lefteris Koutrakis wrote:
> Add initial device tree support for the WatchGuard Firebox T30 board.
> Enable building firebox-t30.dtb under CONFIG_MPC85xx_RDB in the
> arch/powerpc/boot/dts/fsl/Makefile. Document the watchguard vendor
> prefix in vendor-prefixes.yaml.
> 
> Signed-off-by: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/powerpc/boot/dts/fsl/Makefile            |   1 +
>  arch/powerpc/boot/dts/fsl/firebox-t30.dts     | 386 ++++++++++++++++++
>  3 files changed, 389 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/fsl/firebox-t30.dts
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/vendor-prefixes.yaml:2022:1: [error] missing document start "---" (document-start)
./Documentation/devicetree/bindings/vendor-prefixes.yaml:2022:3: [error] syntax error: expected '<document start>', but found '<block mapping start>' (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/vendor-prefixes.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/vendor-prefixes.yaml: error loading YAML: expected a single document in the stream
  in "./Documentation/devicetree/bindings/vendor-prefixes.yaml", line 4, column 1
but found another document
  in "./Documentation/devicetree/bindings/vendor-prefixes.yaml", line 2022, column 3
./Documentation/devicetree/bindings/vendor-prefixes.yaml:2022:3: but found another document

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261029112742.10238-1-lefteris.koutrakis@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


