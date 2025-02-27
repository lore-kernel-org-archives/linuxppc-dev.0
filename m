Return-Path: <linuxppc-dev+bounces-6539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFA3C19F2E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2025 16:50:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z3clp3q6Lz3bqh;
	Fri, 28 Feb 2025 03:50:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740675030;
	cv=none; b=NGONwaU4cR0P2OuauMSg5cifgBIYg/c8hsSHmNGwtiBm+QPFnhGYK3qfduetM8QGHBO97X82Y9JfLSArVp+RKeJo8rH1+NZ7PS0rPv1JWGmqeb3cNJZiVxAEIERH87GT9k8FJQR51fmLzzwI10ZH0nv1Ymxd3UD0x8e88GaMiiyiQw8hwJTWDZbrLjph9nK+dWwSE50u5HAiTtLVIgOW1uOc+MZ9oLYJMvDxu6mn1Qe7QQePwLG4TEYkmw7WlLHuZMl9dlCYgnYEsTrLIwY69xDOpNEaIYQDfFk42HR54Us37vqGe5w3TxH3zcm/gWVPTPIEUyR5QhUQaXY/yELUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740675030; c=relaxed/relaxed;
	bh=HRRUpfinSt9rguJpboaKd81UUXibO8eZpGY7oUlBV0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LmwtVjRtdneWd9O9nvmVyFJzgOsErQKFiyd88WE4N4pN+5XoYQ5Goo5lWD2uydRYmQ7XzdRkBFjlDPHwqPyREvwLKm5ntf3pnSCsSyWS3rRScMT4X9FwnnxByCN1Sk7tjrRt+wIfTdgWmod63lvaxc3YAgeDxd8E4Dme2HufmfPYW0nIHQ+CecFqjpt9yHE1j2fYXYtkEJYf/0sw7Rryn3/pLth3B2uzPWQ/bcUE8N0roZtphUO2LR5PcGnWyMa3wQa15bPv5jnSPnlxCa1Tdx0L8oJSuo/J6I8TJhoj7yEogWp5zt9eoi0bqHHGTHuQH/LmIaId7cg4O2CbimHVpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cC6HvZqv; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cC6HvZqv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z3cln451Fz3bnx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2025 03:50:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D50F561F2E;
	Thu, 27 Feb 2025 16:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A263C4CEE7;
	Thu, 27 Feb 2025 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675026;
	bh=ozrrYtu+cfLJ1sRnT+ydPr30N8DWZmXs461xzzLHj8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cC6HvZqvw4dn886MoImzK0LhAWorYFEHMqDJQdHDQ09lJ7FPUfx7sVSWWO16q3/Rn
	 SfIRKX8aeK+9EgoMn9BsYLpO58pS/wjyOyIG1ssEraOlultmtvbNGNG2OIGMm8VFq9
	 a+Wy01TRZh/XFzQRpK1kwV81SB4co4xog0FvBvOBcbmA/ZepVjLqb73A92HPmvfoOd
	 YDd4u008TOJFYKp1dnQZRPjlESHlhdbSrgRQJ9T2TxVP58bHPetS5a95+iezoG6jhq
	 V+91oas5aF8jm667rYGjXqZJ9jyTJGxyWUS/n1loDMuErOr2RtvtYB4GrcHKf3BY72
	 OTaxxtJCc3ucg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
 hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com, Tejas.Manhas1@ibm.com, 
 mhiramat@kernel.org
In-Reply-To: <20250225123042.37263-1-atrajeev@linux.ibm.com>
References: <20250225123042.37263-1-atrajeev@linux.ibm.com>
Subject: Re: [PATCH V2] tools/perf: Pick the correct dwarf die while adding
 probe point for a function
Message-Id: <174067502639.1401960.11262307392537559075.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 08:50:26 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 25 Feb 2025 18:00:42 +0530, Athira Rajeev wrote:
> Perf probe on vfs_fstatat fails as below on a powerpc system
> 
> ./perf probe -nf --max-probes=512 -a 'vfs_fstatat $params'
> Segmentation fault (core dumped)
> 
> This is observed while running perftool-testsuite_probe testcase.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



