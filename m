Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3960A4AF1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfsj3laC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j89tp20wTz2xwL;
	Tue, 20 Oct 2026 22:59:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792497554;
	cv=none; b=M0zDK3Z902W05fEMCLGufwY0BgvhfX6nEVHhq9yl8CvQgikI1qNs6yN9LAiZOxa9lbjKjq2j0Bs7TtsO+44r2sDF1EI0/jrqPitwy/mKT4xu5JBWjo/rKAdsKzEclDRgVAVJFh6CoJPf+njBd/bBU17wbb2VQCXRXrl0q1KSXTDASiRL33voe9cgAI2NROCiot98T8vRQ5Ry4U2a1eLUxNOBAby1Ktdfnm4V1U2ypeo1dU1YCgT6osHFNiGiC3YoCm1m60VwTHx+eyQHmnzVhAwb53ghAZnJmwzJJw66E0uPX7dgOQ36yJITfFLlso56exxle+kppFqaB0/xjZ5KJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792497554; c=relaxed/relaxed;
	bh=sFwjGh8mwTc2qDN9bDjr3wPuxEY2xkCD8PBrZzmGrbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZYcFqd9usMAE3m9cuJZXiGXZWBk7c5KejFy81FWAyhAcBmuoKwS2b+FT5xDS8jR+LhEGnDCudewKGHpgyO94/gek2NISRhIGdguRhKG6NwUzOiI3a8c5gb3FnJOGP1itDguir4j8/hXXiQEDQ1CR2cNrgzmdYercib2tLKm1cYH1yPVbYen8+kcVPkYPG5sFCD/iGGXndHFdB9sM1ifbMoHxF5UkV5qtr//laeuhwo6HkbLFk2gyrAhAjFMys+TI2VKuzqPRcnJwua8nl8zorMl7NN+19y0aiDkls8hI3wh+7bTptboTpltsa29vCwNQYFmt/+NKLZQ1ZJIDF6anA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfsj3laC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfsj3laC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j89tn2pHkz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 22:59:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0CF14447BC;
	Tue, 20 Oct 2026 11:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AEE1F000C9;
	Tue, 20 Oct 2026 11:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497550;
	bh=sFwjGh8mwTc2qDN9bDjr3wPuxEY2xkCD8PBrZzmGrbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zfsj3laCAuwdCXuxH+eynJMPH67fqPW9J2rRVwtoSJ/c0BNDGwaH/rBh7WBJoAPNR
	 mKWmuwURr/ph7CVGKf5oQuiKKtsfPZwOSBo3g0ogohzzW6WsJIUO5nYe9rsO+IT6KS
	 QU7toCWpQF5t7Jw0gqS9xwAKuc/L94q0+7GupCySHerCvkokY2tZCBMT0m47YGgk3S
	 GtU0xjkJJQ2pffKOriTd8Jx/ra0kkeNF5N3RpD/3XQDryUG59xMy/KMgitoeKnR0GV
	 jTFn3ImD1Y6QWKqZRrlc+FAYSZo+/fi7Rpe/r9qLabWIqCfUjXPxtVwrqSQcxC0G7A
	 XQCW+s0difjvg==
Date: Tue, 20 Oct 2026 13:59:05 +0200
From: Thorsten Blum <blum@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec_file: Simplify add_usable_mem()
Message-ID: <atdXiXc_ZtCS9fhi@kernel.org>
References: <20260916153149.127278-3-blum@kernel.org>
 <eff3cd57-7b84-4718-85ef-e1fa1c6ad4e3@linux.ibm.com>
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
In-Reply-To: <eff3cd57-7b84-4718-85ef-e1fa1c6ad4e3@linux.ibm.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sourabh,

On Fri, Sep 25, 2026 at 01:04:52PM +0530, Sourabh Jain wrote:
> On 16/09/26 21:01, Thorsten Blum wrote:
> > Use max() and min() to calculate loc_base and loc_end, respectively.
> > Skip to the next range if loc_base > loc_end and drop the now-obsolete
> > boolean add variable.
> > 
> > Signed-off-by: Thorsten Blum <blum@kernel.org>
> > ---
> >   arch/powerpc/kexec/file_load_64.c | 29 +++++++++--------------------
> >   1 file changed, 9 insertions(+), 20 deletions(-)

[...]

> So, the changes look good to me. Feel free to add:
> 
> Reviewed-by: Sourabh Jain sourabhjain@linux.ibm.com

Thank you for your review. This should have been:

  Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Without angle brackets <..>, b4 ignores the tag:

NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Reviewed-by: Sourabh Jain sourabhjain@linux.ibm.com
     Msg From: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks,
Thorsten

