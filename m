Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF3606A338
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYQp7BFU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPVq64hNqz2xlj;
	Wed, 11 Nov 2026 15:27:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794371234;
	cv=none; b=M4f6lvpZrPIX3/4DSXKrs0ISnABKR3Tm36fKJ1106bxJ+2gU+r64mkXl6hYXUOBqanNL2YsrnDeoFN7TMIS04D96TKHP+E0MNIvMhYFU6w/wIW/TZBmti8JaPAdVBWdzNf/dIDqAhkoMmdC77F+w1iUitco3Kv3s1qp7WzgzHiRC3t2IQD1a5GrmOZYgaM+2k4Xkv3woSZvETylGrcZDDBttMFrp4ZtZQ9jwFHPYSYS/24AraQ+uQLsFBWrIbTLAgd4KVpN1uAyCwXL+33Q3O2TMszlKprpH20vo3iLS4mTsosiWZmHw24lfQnY3ZzkAUC3cxB5YUFnNRFSIGVBGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794371234; c=relaxed/relaxed;
	bh=LGqKmclckj3cfZIxtbWVIyau2dPaTHxKuUbkCNQn1Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmRPUm9s6iwbOpFzK6GG/Pk3h+QFjjkjSGhKup38JZmfEgmMucnNDQ29YAtJHbZmR+L5rp8oWsXhU2Vjm2MxAgeWFLAwY9U0tFF+UxeBWRH4g2mVZLder7qfkJglchWJa0UzChjVyWMTL9ue+YjFvmTAh0yG25JEvU94k0KmNu6HBni3QsxQBCIkaxaZwmAR3H+vaXoEXXBIL3qNgcwdmx5BV011Uee7HyavA0RVkBrV88BnK2nd67PNlmyT9KASrEoHa65zRK3ci1xnNcTBCAOriV3M68OwSit8mDkFm+98XI29eLVEfNrvony79nEsPnQPNKPOeu1nn6xSlPvnhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYQp7BFU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYQp7BFU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPVq55gZGz2xWR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 15:27:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2D25341AAD;
	Wed, 11 Nov 2026 04:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248441F0089F;
	Wed, 11 Nov 2026 04:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371231;
	bh=LGqKmclckj3cfZIxtbWVIyau2dPaTHxKuUbkCNQn1Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nYQp7BFUFIzdRgoawdyBqYZmI+w9TfSluiBVR+T8ogoyB0/FjHao6UO8D+4rOd2ci
	 rInDmEbH4riktfAPkqHMKA53yP2clFtZOWVfuagK2zxph/Lm9wqfDTihu1dY/X9h1Z
	 sKvn+NrYWiJjguH+lHFSqTWqB/eGpyeOUx5p4rFXKiyB799NPgv+SL7vItEsDXFFdw
	 7Ww+p06xe4YYbX+ogc6c2cFzymlHXpMizpxx9FtVlLBw/JPrEjoOK869nLQNsqlVnS
	 VTPpNwFoypMMYW8Agzr7KgCA+p21WQ0cGCcvWvfb6SUdSoAlXSt1pZ3F33okfSjvnN
	 EMf8X5Agqxekw==
Date: Tue, 10 Nov 2026 22:27:06 -0600
From: Nathan Chancellor <nathan@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/smp: Handle of_property_count_u32_elems() error
 in parse_thread_groups()
Message-ID: <20261111042706.GA1385646@ax162>
References: <20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org>
 <9da4b3b5-cc9d-4a55-9aba-b491f9b222e5@linux.ibm.com>
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
In-Reply-To: <9da4b3b5-cc9d-4a55-9aba-b491f9b222e5@linux.ibm.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 02:58:32PM +0530, Shrikanth Hegde wrote:
> Looks fine to me.
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Thanks a lot for taking a look!

> Should the similar fix is needed here as well?
> 
> arch/powerpc/platforms/powernv/idle.c:
>         nr_idle_states = of_property_count_u32_elems(np,
>                                                 "ibm,cpu-idle-state-flags");
> 
>         pnv_idle_states = kzalloc_objs(*pnv_idle_states, nr_idle_states);
>         temp_u32 = kzalloc_objs(u32, nr_idle_states);
>         temp_u64 = kzalloc_objs(u64, nr_idle_states);
>         temp_string = kcalloc(nr_idle_states, sizeof(char *),  GFP_KERNEL);

More than likely. Maybe someone from IBM can validate and send a patch.

-- 
Cheers,
Nathan

