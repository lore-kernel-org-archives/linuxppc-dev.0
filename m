Return-Path: <linuxppc-dev+bounces-27265-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBDFC88E6F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 19:00:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkDxY4DyLz30W5;
	Tue, 15 Sep 2026 05:00:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789412433;
	cv=none; b=PFmrx/4U8arTIps0EiwRL37pqNUEAPychbP3UHn6xHs164jDIgba+DDW9710qYcfuauM6DMhnM9v5bgW1Q8IwdN/SdFON9eCPffmgAtUVe9VnmDeIIiP844rJ3fMUrfZNDF+QDHNplqjXIaXojajOgc4N+oBntCgSyJVS0upZ32WfNnrjw0gefl8DhwRPKAvHUSqEzMCalGlC0nMLerC2vpQ98cOHDzsK5ANE6QUI1bpLnaBhAA4w7vlRhaKVxWgbIpl9Y4uUBcVUeb1Pn5DRDR077LX/2WWobYNrTIwGK8Vcf3GCi22XPAb6aNRIGPhm/Q7K+5UFQX4ivNH0g511Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789412433; c=relaxed/relaxed;
	bh=NbtN13PWQSVAvRZH+CoCA78d0mM+5H17kgV/5pIPbNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7BUyMNJFjORHvK6nG51WMU1ozsDhpagZm0FjPJkE17An2f3zXkw2XEPeWXgl+f50CvEP+Z0DR1geZXpx37CfGhDIc/WtTCmPjVSlT8Sli4tREdPpbSDCay/IMtK4NqMB/Fq0b3xDChEnG9MTsPDoiPTs2bNyW4PqudI01MjRXcoZXejM3E1qDzRj6HuFD1aeQsGp0Tbq0fBWl6kClQV8OLrQ1XJo7d2JhOmn/eT0mBDjUYpLgEB/NOMwhBf9GGgtNn1FhqwkuDjECVui3tyaRg7BX94f8ZpwC3QWVPfUTicBO8og8gq03M8LgEUs3b2c9B2v1aOVJ3ZqrWn4DeXqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmXw8V07; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jpoimboe@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmXw8V07;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jpoimboe@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkDxX5CmFz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 05:00:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DEBDC60142;
	Mon, 14 Sep 2026 19:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173291F000FF;
	Mon, 14 Sep 2026 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789412429;
	bh=NbtN13PWQSVAvRZH+CoCA78d0mM+5H17kgV/5pIPbNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VmXw8V07dSdDTIHDKRMZpSoWtfg13PFpqBuryVNGJL8sSORlLEdf2o8oz8Td+gsFa
	 0R5MpEYkKBNMb3Y3vK9nxR8HXsGLkg3vBdAvA/2fcJqmV0qjcPiMYKCQc7LUFjAcAZ
	 Ip1/v/FD0gUr3j3TLYWZCx/ssy79dAb7dkWD27wvPs/EbvfjuJKEpNvGi+s7KgkaqK
	 eTJKuMYcRR6GF6JE6kxsU/+luQWRrH0UKWw3MZq/3KUNC/o8dNyq85wnL9q1rLOa7S
	 /dquBMnVRQlrkYed9yauOE8Bt9+g7apk9ilnE6rpexS/2tP0tVK+jYUF7Rh5W3pfrE
	 ul0w1ReCPDCgg==
Date: Mon, 14 Sep 2026 12:00:26 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/faddr2line: Combine three readelf calls
 into one"
Message-ID: <aqhDm60zSZIazrnC@jpoimboe>
References: <20260905012449.3872882-2-srikar@linux.ibm.com>
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
In-Reply-To: <20260905012449.3872882-2-srikar@linux.ibm.com>

On Sat, Sep 05, 2026 at 06:54:49AM +0530, Srikar Dronamraju wrote:
> This reverts commit b8d9d9496c1e ("scripts/faddr2line: Combine three
> readelf calls into one")
> 
> scripts/faddr2line stopped working on PowerPc systems with this commit.
> 
> Output  of scripts/faddr2line on latest kernel sources
> $ scripts/faddr2line ./vmlinux need_active_balance+0x1d4/0x21c
> $
> Output of scripts/faddr2line with revert
> $ scripts/faddr2line ./vmlinux need_active_balance+0x1d4/0x21c
> need_active_balance+0x1d4/0x21c:
> imbalanced_active_balance at kernel/sched/fair.c:12047
> (inlined by) need_active_balance at kernel/sched/fair.c:12061
> $
> 
> readelf on Powerpc when passed with --file-header --section-headers
> --symbol --wide option doesnt show the line
>  "There are 62 section headers, starting at offset 0x16f1a850:"
> 
> Hence faddr2line parsing gets broken.
> 
> It could be a bug in Powerpc readelf that this line doesnt get printed.
> However since its breaking with existing readelf, its better to be
> reverted.
> 
> With the revert, we end up calling readelf three times but this should
> still be fine since calling faddr2line is a debug tool.
> 
> Fixes: b8d9d9496c1e ("scripts/faddr2line: Combine three readelf calls into one")
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>

Can you run

  bash -x scripts/faddr2line ./vmlinux need_active_balance+0x1d4/0x21c

to see what line it's failing at?

Any chance the below fixes it?

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 622875396bcfc..550c0f9b9d473 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -78,7 +78,7 @@ GREP="grep"
 
 # Enforce ASCII-only output from tools like readelf
 # ensuring sed processes strings correctly.
-export LANG=C
+export LC_ALL=C
 
 command -v ${AWK} >/dev/null 2>&1 || die "${AWK} isn't installed"
 command -v ${READELF} >/dev/null 2>&1 || die "${READELF} isn't installed"

