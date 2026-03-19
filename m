Return-Path: <linuxppc-dev+bounces-18450-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026031090239
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 14:59:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc8474BLCz2ypV;
	Fri, 20 Mar 2026 01:59:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773932375;
	cv=none; b=W+lSFeDqNESDO1vr9AH1XzxWM4YJe1vUODrl38bMNYa2URIA/nl2erfVpg02tyDLORkF2LbxDNWgrr/VUi3uf3BNShMm7/+pGxkhmmQtoday9sWEW5GL0v33fhiHPDwBLaVMHEQy4hCRz3q9+Ut0eQg5sIEg1fPDHgrJ0PCQNspQhiZBzU76PkPDvVuNhyedCFFsqumK+SCig1KlDhYekLM8R3gslS1gKez9Ddf+1xABEgEkIeVcFOKzofreWJwnqh+6e9MY1onfepxqZlHivrbO67zMzM7JlcIeUIe++HPasbd2noFXoVhuWx2G4bUSBQsx7TOFsvZ+GAGIvPPevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773932375; c=relaxed/relaxed;
	bh=Sqg7Bg6kJ/lBh3mPGVMcJxUkJteTeiLK4JhXhZl+frg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQAeDZjhvvcy1EFljTAHyNfHgM9Cy7abZkNbDgB/sSohc5qw2Tb0hIPklpVgFs4mq9V93pItLzU+b3ABu7KI9WwPjGXhLPC6jxBoijzuCoRhBtH5FktJbhN/9OXsXID/ng3god/qJwvlTP8NmE3IPCtzLWuzf3u4whkS3vKLR3gwYINoXFR+hll4Fnx5pOWB9uX1y0X8d+8radRiMTTXD2VTQ02yP4T6VtceJjtWm4iEGg+etIkOr7JXjlLSh7VVz0GPhgQVx2/HVJ9kYxJU99807mQ4c0gMRYb1tbL+pSbN5da5niL2m7HnZS/G3FPejAMMnpPtLTUic4qgOZo0Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jW7rO0Qy; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jW7rO0Qy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc8465sxjz2ynv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 01:59:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 91A36438AA;
	Thu, 19 Mar 2026 14:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53334C19424;
	Thu, 19 Mar 2026 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773932372;
	bh=wRKFuj1RBd5OZOCmeqHIDv8olqwZDaGYrjqF4N72VFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jW7rO0Qydnm24fZKKcNCk97+5Di3gMM+w16JSsYYW7tDtJp8J3pvi9WBBBzht7Zxh
	 dNFCYlDNcdV+fZwaxhrxXOFxyAJhHxe+vHCiZdVszjUQ5eoOuoP9OmqFA0zGMVzliZ
	 h3HPi7AKag3uiE8aF1QXJXkXLsNp0vgEZ+WH7Qmfw4+ljSIfnVFtuMu0/REh97DcxT
	 7iR6kJkVmbQgIKxp3tA04eOS4QpiNxsJ9oUo+gVw6J6QA+5Mg3ZILbvmV+swM1MKj/
	 XjUC87ffsuXDpc8EQPT37CLR67gh92yBtV1tpDAr22vxx6BSKO/Joi/klO/asPmBES
	 zjxeZO8y0oMVw==
Date: Thu, 19 Mar 2026 14:59:18 +0000
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: wei.fang@nxp.com, netdev@vger.kernel.org, xiaoning.wang@nxp.com,
	vladimir.oltean@nxp.com, kuba@kernel.org, davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org, krzk+dt@kernel.org, frank.li@nxp.com,
	claudiu.manoil@nxp.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, imx@lists.linux.dev, pabeni@redhat.com,
	f.fainelli@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
	conor+dt@kernel.org, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next,13/14] net: dsa: netc: initialize buffer bool table
 and implement flow-control
Message-ID: <20260319145918.GF1753385@horms.kernel.org>
References: <20260316094152.1558671-14-wei.fang@nxp.com>
 <20260318145452.1898637-2-horms@kernel.org>
 <3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>
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
In-Reply-To: <3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>

On Wed, Mar 18, 2026 at 03:56:39PM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2026 15:54, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> 
> Why are you removing the "PATCH" part in the email subject?
> 
> This completely messes up with the filters and causes this email to pop
> up in places it should not.

Thanks for pointing this out.

I sent this patch using some tooling.
I'll look into why this happened.

