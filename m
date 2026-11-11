Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572FA606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xtfTnkaP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPV1c31BXz2xWR;
	Wed, 11 Nov 2026 14:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794369076;
	cv=none; b=fgMjkGGxryRjeQ83T/qMpWRN8e3AS7VwoIjokllyhwP7nmqk0ano76gJuxzicDvOZcoo6VwQuytu4AQBxD4JD/CYKft80BnLKvQKIdbu5xdat7/IhNtZm+6vux1Ny40wu/70OALewuVWvfLzVfWBz9+3VGMqJrTkTuxXv2Eg9HYjCa60aiJu5AGhQsLpTCNwX+eMc/XFQNho45P+uHxvzrVNbQN2UNUbmjyoaZej+V04gdKYMXvMsdxCkKemeTD0wN2pRdSJUZzzhYCD4gVEuWgppMOc3bsWMmDQ+4Ggka9np0rmV2pxK6s6sggajITVJ8341EgLri5RziHnOGJiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794369076; c=relaxed/relaxed;
	bh=HvaacBMlWwgNBh4QAndXTXTObG2KN5tcLo6cqns2s2w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=XusOMRA8vNrBbUUZ33Z8dRyweQL5Wg2678HC2wKronrBx/YhuaWDPyzMso1yOF7QoqVYpyFmkIiZLR341rnq6GseXtu9yeYeBGiHSC4V3r2WGhCsTPD8dpq3mXYJSJq7OzpvyOGbPY567x+meUGyNDtVZSXfw0lYuvQl378JVNw3Mo5ZStI52JpxCfrL5PQ9tMS81lIC15qGKiuM0rtgxiuSai41pgtiDCowJdakEqbFaKWy37Ajb++/LJIqJTqukKayh+uNaMQHeam6M9Z2230GONpIv63hM5qsqW5Qq2nh5MK43zivqJk3yWbdRBrfRmSCE4jB6chnHEHmxEVuuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xtfTnkaP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xtfTnkaP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPV1b3hyLz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:51:14 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-3720addb068so5008529eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 19:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794369072; x=1794973872; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HvaacBMlWwgNBh4QAndXTXTObG2KN5tcLo6cqns2s2w=;
        b=xtfTnkaPuMoG0ilCr79lbRHEtuc2ZuZIMBdOGxPfSK3/J5dJDXNm80c/zgPY0XarCl
         IRkMHM1JbX6nT68Tdm+XH/GCH8Mj2Zt8i+sOtjuO8w8IQVPIE0syPTW3ibTCECMtTO0f
         Kq+//AXg0MTnBjiIDG+w7DAV+e/40bM2D7sdXTT9F5QKPYfW0BJMVxpq2xiZW3oVGGIo
         l/3YZsaAbSZwn/onvlru8xShUw9zusMpekJSJfqwpBeOp2RhoLV8/NDSanMqyg8Sw+8X
         ZV38x69NvqOHGnIoc1qOI6skBk//fYpUgyacIwnNW7WV1TErjtx91grMPTTMJoarfQs7
         M8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794369072; x=1794973872;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvaacBMlWwgNBh4QAndXTXTObG2KN5tcLo6cqns2s2w=;
        b=Hhvp5vANMWyblmdgcfIZkVQqqLlLxpI1R8R99ilPOUBpDthFK1UzixMIVH2JmQ9/PQ
         ryVN9SvqgA8/irRY87dwNKd15bjIPIR04pSfNEKfJCPGjTgZkpGuneT1hR5kGqpl4Ji5
         g9pZluZFPc4tUNsBHZ7TSJuduc5mGH4TmROcatsEvc6aUbNz3KYs2AU5cH6LjQLrwKmG
         e70SDFGIRkpGzMER8iiWwFF78vYii9sOmMEAKDNUSC0tY5mLSPtnD525vtQf1wbbFW2+
         zZv4j+RBcCSU1EQ2fexyxbP4P+iZxTDsIfeiRfxJ7weY5e9WuTOzP9rSJumIYAzbpgli
         XteA==
X-Forwarded-Encrypted: i=1; AL+hErGNOkACqgC0y0KNCf7S994hh5bgENT71rfsQCmQSpuSrtGLe900C2AbubBrrdXMyHw9Z/FTg2jTqVXZltc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/FYA6Pl0BtTexsMS/ubIAxfmO3J+JUn6Jw7YihFa47vnH7vtZD
	6NwZIbl81kS2i8XxmAJEAr/bnc9yGsuRahbUj6t7vJFHiEVpCp5jZwjOFOKzdiPP
X-Gm-Gg: AYBFou0yWFs0VQ4EGjHhEzI3bNjgihtVkyjIjdNV0mLjjb4JyjM2r7E8U19yVBrEt9s
	GyE/OISsodI5eHSRFZXKq9gM1LCtntDUYL7a4kyDWeTV7n1srpN1vfF34PY5/ekpRoiVaA1SU00
	MSBKRgnQy3MKQ/54GLU4X0M6ahFj7w0F2GL7tCnGIl4t7eCpre8H9AyGRPl+UB+1vcHDnOBYhvb
	gl0ZB6WeZVQiq7JbDnO3zYV0lPRmUv4xmt4H4Qqqd1tvu0HM/IVHaDCvCMISEHRM8hI35gYDhsE
	NBijVCvCDbeU6jNeU1mf10JsyD1B25yLLLP0S/s+SC3kL1SquvwCaZEXwWWjfyvrRoZBqc6NEYH
	MJg+6nvwalqCGCzDU5ewxwcgWJgk2L7l46ypbTKY1wyvVsATLPzTVTy+LGK0/BLd+ZuViVMdhoo
	EMsAyNqo5wR0Fef9kUp+zhZn/3sGMc6wLONkPFSvEaQnRjARTcEVHD7aYKafb2KIbvFb24Nevba
	YFVvnyWpjHXH0wRuRV7iSpnL96Qi1LI3WHM4U0Z5pX3oLaabaSPXY1i22VkJ1XAvWt5Dc1dOG8r
	1A/VsSe+BAyJRAM4INjrIlhod38=
X-Received: by 2002:a05:7300:8a19:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-376854b7fbamr1628661eec.8.1794369072223;
        Tue, 10 Nov 2026 19:51:12 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe3261csm10158221eec.4.2026.11.10.19.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:51:11 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Bradley Morgan <brads@mainlining.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, brads@mainlining.org
Subject: Re: [PATCH] powerpc32/modules: Reserve a PLT entry for ftrace_regs_caller
In-Reply-To: <20260923175631.235276-1-brads@mainlining.org>
Date: Wed, 11 Nov 2026 09:18:41 +0530
Message-ID: <jymk81uu.ritesh.list@gmail.com>
References: <20260923175631.235276-1-brads@mainlining.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Bradley Morgan <brads@mainlining.org> writes:

> Commit 7dfbfb87c243 ("powerpc/ftrace: Activate
> HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32") made count_relocs()
> undercount the PLT entries the loader
> consumes: module_finalize_ftrace() now creates two trampolines
> (mod->arch.tramp for ftrace_caller() and mod->arch.tramp_regs for
> ftrace_regs_caller()), while count_relocs() reserves only one entry
> for ftrace.
>
> So the core .plt ends up one ppc_plt_entry (16 bytes) short. The
> walk in do_plt_call() scans for a free slot with
> "while (entry->jump[0])" and has no bound check, so once the last
> reserved slot is used up, the walk steps past the end of the section
> and patch_instruction() writes the 4-instruction trampoline into
> whatever module memory follows the .plt.
>
> Count the second entry, mirroring what module_64.c does for the same
> pair of stubs.
>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/powerpc/kernel/module_32.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Do we also need fixes and stable tag here?

Fixes: 7dfbfb87c243 ("powerpc/ftrace: Activate HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32")
Cc: stable@vger.kernel.org


-ritesh

