Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLMISjxE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGNXB389Vz30Vv;
	Sat, 31 Oct 2026 01:19:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793369978;
	cv=none; b=HQLGQs3kyyAcchDAVDcJdqhSTnZaG5pYJMLE9Ja9nmxaRCO+QRV4Gb05BpnndO6RxR51Mc1OeB6xSq6hdzPRHwIj7FtSI9CT4Z7bcUvQ5nq15mtYfbBmJkMJuDNjMqzhRWrpEWQGPv7ssv5AbWBwzvWUGLj0cCayGVsTkv05Kth6o+3WtXdFfgnxcu57stMvTGYK7rGmD8e9HVVXxc/gzgqNfatQxrpZ8EDkYi0kPg6OitiqncLVWzNpkUlrGALg1jBuxL4f/DI8/UFcfEdvH4gGrwu1ipQNcOJpXmEEJPQIXwdi2MaeoAOmB0Gs4PSbvozjjCevWWp5E6D167I8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793369978; c=relaxed/relaxed;
	bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bNuuGkiF/1PSvRND/8MdyXn1JaGZWo8QYgFlq+ZyAkwhFFRM4UzLVJJtAhzBZG38rLPeC/mMdQ5Z3KYLCWXpe8GTxFNqCDnwhyZiLAVYWBUB3Ssg5/fwScGgZA+P0llsbw+48WGukA1Z/Qhy+PvK0oRF6gQ4IodNeVkufUM/0BkycK2ELMnbzCMHdg3Tx7fIbtDGpwDQXnjK+2jvRT+ULLwDLv3kbTQxYebg6H9q+uElnptAQ2yj0Of3JR9a3X+5sAFHgsJ9/SPWkd3pH4wQQppMtUZiQywKRLovwFcYY5F2wBLVsDc1Foywt0xHNoQQlkUNGGJqhzknhGpDEj+v5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLMISjxE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLMISjxE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGNX90WbPz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 01:19:36 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-36a1947498bso1978475eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793369974; x=1793974774; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
        b=yLMISjxEDrfZwydso0cuDvaSYJR41ytLgE2G08MlATixI83bh8ZEVa7uYaEa5XyCyl
         CrAoXXDhjFBpvsbrmHjkeA37DsooeVyG/360Fq5gB05E6mgCOcSq7eyPa6c6rNVF60cb
         jMqOucMFFLgYsYn+5qdB3BLRWjepcO9G1w/WxGcHGkm5yCoy8T+u/V3w9f9xMyjiOkJF
         q5pS70mhGno6D+Td7m5prFHd3UFWmfyG+pk78+6+/bb1Cs3QHQr8Gek2epCV5VT9M9AC
         4ZzG0T+kMbIx30dWDYiu/EFAzA8w5w8W682lC4K8aPpLzS0k+cpg3UDh978ffNuWsEOZ
         QLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369974; x=1793974774;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
        b=z5enCDqM7JmlYD2CZlCyOV3eLoWyu430wswYr9dv/v87q6HIycGLt5OWEZ3HjVtiAa
         D49x0IOXEKySXWV5UG52mynuTHWT8X8PpiPgepd7XPQI4RTYifGsW85H+1+3s/dJoJ4w
         3ec4F01Ofb9PsVllSHuTVV3cUYl8AWpE0ctGud6FbUBGNWsZSEnTM26BNUA8CmX+hGmo
         Q/hyYBrKYTNEgD6SWkRqPnVkWCmCtfl78cfIz9CLnYtvFkB426S2bFh7tuBoYICrzKgl
         sMCfW5qPOG7khVvpxcKujX8x2gP0LFk2OCmYbbwZbJJ0Oxt3IOqmNqrX/JzYOiOd3qoT
         pYLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQhO7WmvaxPYyfVwaNXd68L3nrGMqF5haD3mYwj1l2g4YRcooJOE08NYQCbdBiI6sPH01Usg0dakUiGvQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIWIqQ4D8Vom6a4cwgW/qAbUZSKaAyp364X8/ytML/+3PxnivnK
	PHDeMgObLP50SoDc2yy+0M7BS6VpUBJFJKmEgXN1Yb7EoM0mUwlZ24LU
X-Gm-Gg: AYBFou25avQj9xCv5DouOUCwFdeG3jU71KVI+zEl2hM2u3voxu5jEGcGPhO8SroJwib
	h1JjZhahSDq/9MbAWW6+qLtpKt943iCmZx/Z1Wqu8pjLI6okl59UK6q/qBllmob9r6yKztblA1o
	YhtXwZtuDZ1FgPl6ycs3gYki2NypxsbHmcE87Fs1/93E/1ZU+A1FlTioYq/KXRo1vWTujjMA66O
	u3LuOf15sX/8aZVwi7hh09GAuFn1trRY9NyJwxwnguhyrg+wdVeiaKfOVMNImEhBvUPoRzRDpNe
	awzhXLHs8C8UxYAWi+5v1K5Exik0A09cAqZvpHniwu4Srnfqt//l4r6vBfQq1EsZB+AgxTNSu8C
	k1sO7LSpPiHGgGFeQgrWjm4FyQU/5ObGkCXH+vYFHUX3biDYfqm6B77Immep4SbK1LTKh3yH6cP
	pIl4iJd85IppVxQMizdM0CDxg3Y9cVljcChbazlADWuwqDFBmU/7WfBoatqZdn/ilAtMANGIpvY
	XyMQumjgQand0L1QitejiAZ7/y8QoPm3Jcj6qOsfXOXJK3N2Wy2oCXtgLNAgHXM2Q7c4niqTwTs
	DTWXAI3G9ygtPAdje8s5bruLvMw=
X-Received: by 2002:a05:7301:2511:b0:36a:1872:4b35 with SMTP id 5a478bee46e88-36a42203e6fmr3338125eec.2.1793369974284;
        Fri, 30 Oct 2026 07:19:34 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm10406146eec.1.2026.10.30.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:19:30 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] KVM: PPC: Book3S: Protect TCE IOMMU table walks with RCU
In-Reply-To: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
Date: Fri, 30 Oct 2026 19:32:20 +0530
Message-ID: <5wyjwakz.ritesh.list@gmail.com>
References: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
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


Hi Narayana,

Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> Commit cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode
> handlers") moved the TCE hcalls from real mode to preemptible virtual
> mode.
>
> The stt->iommu_tables list is RCU managed. Entries are added with
> list_add_rcu(), removed with list_del_rcu(), and released after an RCU
> grace period with call_rcu().
>
> However, kvmppc_h_put_tce(), kvmppc_h_put_tce_indirect(), and
> kvmppc_h_stuff_tce() traverse iommu_tables using
> list_for_each_entry_lockless() without an RCU read-side critical
> section.
>
> A concurrent IOMMU table detach can therefore remove an entry while a
> TCE hcall is traversing or using it, without the traversal preventing
> the entry from being reclaimed.
>
> Use list_for_each_entry_rcu() under rcu_read_lock() for these walks so
> that an entry removed concurrently is not reclaimed until the reader
> has completed.
>
> Fixes: cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode handlers")

I am not sure if this is the right fix. On doing git blame, I see the
following patch introduced this:

121f80ba ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO") - Alexey Kardashevskiy


> Cc: stable@vger.kernel.org
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)


Sashiko pointed out few more bugs around this path:

Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
- [High] kvm: ppc: UAF of spapr_tce_table due to missing rcu_read_lock()
- [High] kvmppc_clear_tce: pinned memory leak on partial IOMMU map failure

So, even though these looks to be pre-existing bugs - do you think we
can address them in a single patch series itself? This will reduce your
testing/validation as well?
Also since we are anyway fixing RCU specific bugs in patch-1, so I think
we can also fix rcu handling for stt as well?

Do you mind working on v2 and addressing Sashiko review comments please?

-ritesh



