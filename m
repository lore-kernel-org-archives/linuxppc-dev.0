Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80E606D820
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvaDYaS6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKVvV5Sntz2xcB;
	Thu, 05 Nov 2026 03:17:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793809030;
	cv=none; b=NzTXnNaYcy3svMnQww46C+G7DmLsUxXwXATmgjMhZZtWkzP5mSlwVg7zys4D7F9Em6GnQfzB8Yku7co1CqYYrfMKV/VOMb7c6hNPjcGfDB/CR1tQ9ZY6WA7uNNeez457d9MuRUze8wT/Oae64MUcetgaHPwJqrfgeHIF52e8cC9e7AJORHw4XWjPsoPvk2PfrNz8kZbskx2m4RPuppwyX54iIUj+lq6EweWTL+8VFQTU0L9mpKQm/2doB+CKciS8fmN7bDA2yK77j+rg6O0ytB0iy+s/7IvnYiQBH5rAvTLXjs3gb+SREp4AaBdDtywCUErYKST3pmXqtutsM0nxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793809030; c=relaxed/relaxed;
	bh=A3AytZ7ZaNVSp18p5DGuHQpWKC9sgEycNzeYgQtV80w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHiLvWpo+/FMM8f/xZmCx8bblHY4dheEw6PugBfwhVsSQ5+trbIgjsO5Xo57fhXpmhlHMJC/gyjCRYAIYbB9sg45FwnkNDVT/BcfvB/lXTzIEIl57dK3pZfrMmSB0tRGuHs3cYDygyDYuWeonGuSMPdBnf2V/nwJ/47YQzfX41+Ar4UUmiCWXmdjx794Cn54tzn0GfrlM/W+h25+0xgkun6G02Ex1ktPm3Nga/DTNdoHBJnWEwO0rHCWwtDUtNtzPE97HabVIl/S5OlTQlk3D2ijBlsKrHZHWwmdaBDxuJmgcsNCxSg7FwVyZ0gStqB6I/dOQaGb1/ADjl59fC7YTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvaDYaS6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvaDYaS6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKVvV07PQz2xb9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 03:17:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C79CB60609;
	Wed,  4 Nov 2026 16:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B43B1F00A02;
	Wed,  4 Nov 2026 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809026;
	bh=A3AytZ7ZaNVSp18p5DGuHQpWKC9sgEycNzeYgQtV80w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CvaDYaS6roz6OuWmaTO4onmX3U9yYr0BE8m5rm0DCkpyatubDOhAxYPtRn8l204bG
	 U3kHiBPuv+/WcQaO7+eJAyO0KuE+X8tNbiikTvL/KviFjtVr/4+j+rUTd7hJORtLNc
	 rnpzVjLPAgVbBA8fHg730iXxEMVWnkhaPBnhAaespFP1EUjZRjVRNfSqJCfQi6ghMj
	 McPc2w4flIF1Z7hrZ4u9iezPCJpD7wA3fMisMeQ20ctjfkRbuPRG4Me5epuSJAv+3B
	 AhlnJUvRTh4bD6hwEnQK1Dn8gOsrcqKN0mw7ol6g368nL2/G67E2fBK921faviYcE4
	 EOVzF6E9k4egA==
Date: Wed, 4 Nov 2026 17:17:00 +0100
From: Thorsten Blum <blum@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/wii: Remove redundant 0x prefixes
Message-ID: <autafPSMB2SdfUvz@kernel.org>
References: <20261103170305.455444-3-blum@kernel.org>
 <124acf19-a676-46bb-a414-08d957d9cc7b@infradead.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124acf19-a676-46bb-a414-08d957d9cc7b@infradead.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 12:22:18PM -0800, Randy Dunlap wrote:
> On 11/3/26 9:03 AM, Thorsten Blum wrote:
> > The %pa format specifier already includes the 0x prefix. Remove the
> > redundant prefixes to avoid printing 0x0x.
> > 
> > Fixes: 7b69600d4da0 ("powerpc/wii: fix resource printk format warnings")
> > Signed-off-by: Thorsten Blum <blum@kernel.org>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> There are other cases of this elsewhere in the kernel sources.
> Are you addressing those also?

Some yes:

https://lore.kernel.org/lkml/20261103213242.480649-2-blum@kernel.org/
https://lore.kernel.org/lkml/20261104155414.126812-3-blum@kernel.org/
https://lore.kernel.org/lkml/20261104160931.137174-3-blum@kernel.org/

I probably won't be touching any of the remaining ones in drivers/
anytime soon.

Thanks,
Thorsten

