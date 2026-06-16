Return-Path: <linuxppc-dev+bounces-22718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BAFCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 13:55:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfpR90Q8kz2yRF;
	Tue, 16 Jun 2026 23:55:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618132;
	cv=none; b=Efcp/XFayFyrMQ2Ux55lQpxCBfrVBe8LVNb1JC0RwYq6AJE9WiBHVS58Sz5urcDQd8ZNUuGQ6WtMAH7CP30AyspHE4Wu9EMrAHkMnfvDx5Y1hb65FpqkvJk9trsGLSYjHFjgd0ww67Hxus3h8wpbBSIZtsWwufJNB+k/F5zoyotd8lCWIvehDyo7u8zRg139AMgVvWFowtiUkAbhgKKOU0yyFexvV+Aoufd738xh2vWuNXXgZIxAnvMmE9szC4HzyZLDudqSt/yzkEv4/N2I82pix6BG1Oc+NQQhy4e/AAbVb0mbgMW+YYi8t7ql6BFVPHlbKRXowb3xr1JxyO1Z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618132; c=relaxed/relaxed;
	bh=QyF84nqSk9ebDNws1PdrM6L0rUUvlTQZheOw/Il6Zbg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BGTvJFqXs6WfuVDARFi1nLABuSLV4tYwWW/iVY0IeQiwmrJuvFjb1qMuGDrKRxYSrjXWduHmxusnTQ1jdZr+ZhSZc8I3pGv8iM8jdjlR1E3aTQ/GJvRdV+RGqNwmuZZcVd65BDB7jTE9M1qiM1y0Cj2I8gs6FdY7it3JoaLHgvVTwf9vgtfAgRCFLUXzG6Usbcbd/9DVwB/uJhn0/NL0e7csa4Wwx+0rxHgG4yak42SpxRqhPbbgDQiUVDW3+Z6W9GD4uCf3RtufyxVsFf3bZ3xL3lgebz0/k1tuOGGrflAWfUz9SH7gLE/wWG8yliPUEYIhl55po6EhVR9LKfXW8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHtswDRL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHtswDRL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfpR80ghVz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 23:55:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF204600B0;
	Tue, 16 Jun 2026 13:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3931F000E9;
	Tue, 16 Jun 2026 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618128;
	bh=QyF84nqSk9ebDNws1PdrM6L0rUUvlTQZheOw/Il6Zbg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fHtswDRL+VZvqlH6MaqUfWr91+VRYWrJc0UX0mpeCqETVowWwLdywrv1toWQJ18wL
	 RJwsSyBfzLtAloKRY0EwCIk+yml43WKHjG6LkjCakmXrKGBKpDsfVB98tlSyiQhgD2
	 60EI6JLWtPq0nw9sXaiAJOMb048QoiXn9eSWGSJjsX3Jm1uvNkD0qr5c6oeTQZgyT1
	 VJwGMBpOGRW1EoQ/u0Q1L/33eznB7Ib4YS/jYY1RWc9NAb7oQxaUV4ffAr1/EpZd2+
	 gvaEI9mqH5AkYPYo6o4mDDk6utOWBVV85zCBC+LQy70ROWS7+9J9j4pT43P5OAfl+m
	 ci8uj//KUNjxA==
Content-Type: multipart/mixed; boundary="===============8414396918092606343=="
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
Message-Id: <22624c18aedcefcada9ef30f7b9b2d03bf228d0314de708c5474f9115680d319@mail.kernel.org>
In-Reply-To: <20260616164741.32252-6-adubey@linux.ibm.com>
References: <20260616164741.32252-6-adubey@linux.ibm.com>
Subject: Re: [bpf v8 5/7] powerpc64/bpf: fix compare instruction emitted for tailcall
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 13:55:27 +0000 (UTC)

--===============8414396918092606343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The tail_call_info field can contain either a scalar counter
> value or a 64-bit pointer to the counter, using a 32-bit
> compare (cmplwi) only checks the lower 32 bits, which can lead
> to incorrect comparisions when location of counter is near 4GB
> boundary. Use instruction cmpldi for accurate comparision in
> all cases.

The change now uses cmpldi on ppc64 and cmplwi on ppc32 through the new
PPC_RAW_CMPLLI macro, so should this sentence read "Use cmpldi/cmplwi
instruction" rather than "Use instruction cmpldi"?

This wording was raised in the v7 review by Hari Bathini
<hbathini@linux.ibm.com>:

https://lore.kernel.org/bpf/5c095e3d-d554-4506-9dbc-96d568b4be5e@linux.ibm.com/

  This should be "Use cmpldi/cmplwi instruction" instead of "Use
  instruction cmpldi"

The technical part of that feedback (defining PPC_RAW_CMPLLI rather than
using PPC_RAW_CMPLDI directly in the shared file) appears to be addressed
in this version, but the wording still reads "Use instruction cmpldi".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27620315552
--===============8414396918092606343==--

