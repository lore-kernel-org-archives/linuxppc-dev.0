Return-Path: <linuxppc-dev+bounces-19830-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93702F4368B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxs7H2QWLz2xpt;
	Fri, 17 Apr 2026 20:48:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776422923;
	cv=none; b=UFb6wPt04OUPF4szP+QWk6EyLJFTJ/5Aoc+O8eknrokk4ZFg6wB4N/UxS8Aiarf1lPy83DYSYCu1jHBGnPtshIrkIrTOTH4Dv8tpF6t3sMaHTQjCaYb5D4BmGteHo/VvZm5U3rjhWGXWDj5S1xtD+2aM2u+X+CGCTZeOkpAL4dw9wE9TDsayuq3JGWX9KZYMW4m5oPIjG2B//4u0ozzMjWrQ/7cw0bpjx18G5fju2cJSBp5oUJSgHh4LeWB48uN9CheP6+9p6yuKQSLRM45YruJeIGpTyuMy20jH7cP9kZ3A6cHdAVF1QCTO2qYVPPEn0q1omI9fvfqsXxxPuNjqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776422923; c=relaxed/relaxed;
	bh=cdxkvMXloa0lftgfdFZXEeeEtJD0+9fzNZGgu7kKc7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/Ilr/Eo2a1nzGMXmMBtS1DHwYnJuV2XTRYPL0/A2iPUg3cgfyQUq4uDxERdEp5NpI6KIyIuUKK99RpQE0j/uhjH72G+lhwdXZ/P7WGO5M2sZc8F4R9HCW7bvAc1WXoIA2cRXlo61BLSVYxyArO1QJ9ZuRs3eZeOmcyBHYKO0evcDmbEKeNcrPVCV8S1CeTSifL4FWrkBSYiUiuIlp6xgJ1o+yYI9EEazfQwRoT4udHl9PbYX1V/hACLI6GcIdNMElK/70+HqNG4Ptqrbulp2/SZ0Gs4Nz+fhogcO1qFUQe6Xc40PlgjjxwFyXbeLW5NR46xqAS2auwwGoWb7D24Ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V1BOBzqu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V1BOBzqu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxs7G5FjPz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 20:48:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4284460139;
	Fri, 17 Apr 2026 10:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE93CC19425;
	Fri, 17 Apr 2026 10:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776422920;
	bh=NZ4L5TbaryQyemnvmTo0G7UCfCM0zTYTfU0gMp+J5zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1BOBzquaNxV3WPHm/o4jp4vDitleIK+cdy0/Bx5aIGXy3iKZsLYRTF883ul1SQ3h
	 v4Co5SpnbaEGEs0dad17Pc7L74SMR8QB6wdqBPcaE3ySu/WWplvgctNaDsDmoWBPdg
	 RRrDN6lPu05Kub391Mr1YIP6vBFrbaGofifgVoesvdYpwYSpTP0kaOXcHRB4NdmP10
	 l5B4U1luxObFMziVO9xXlDFWx8m/vQj2T9VsbjKmtHCEFEJk9qLvzxhTcA7GsND3F4
	 TKmet+i/EWVu5+glrHgNMvgvIi0iTyWNPns6RzIjFa1F6h179mRpssDGjrpIBtp7Qr
	 lF67Bv4Q2INcg==
Date: Fri, 17 Apr 2026 19:48:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 12/24] alpha/PCI: Use BAR index in sysfs attr->private
 instead of resource pointer
Message-ID: <20260417104838.GC1625998@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <20260411080148.471335-13-kwilczynski@kernel.org>
 <36cdf28b-281f-46c7-d4b5-083675b61660@linux.intel.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36cdf28b-281f-46c7-d4b5-083675b61660@linux.intel.com>

Hello,

> > While at it, add parentheses around the bitwise flag test in
> > pci_mmap_resource() to make the precedence explicit, and to
> > match the preferred style.
> 
> Probably not necessary to touch this line now at all as you're going to 
> replace it two patches later anyway so it just adds noise.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Makes sense.  Taken care of this in v5.

Thank you!

	Krzysztof

