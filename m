Return-Path: <linuxppc-dev+bounces-23841-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F150FC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 19:25:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwSk32FRsz2xpn;
	Thu, 09 Jul 2026 05:25:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783538747;
	cv=none; b=jWoaZbeGOWtBJCQ49hrl00alA9Zw18x0emfYiIEzv23LxMrTW0cqx/wnOqM14qv62f4EFcO2YMU2FHMXtM+rA2glJ+3/bJ+Uhdby3ZkN/suOYla0hLPlq2iR6wXCMyn55Fle3chpp5rgKnhuBgSmOm70iKg5DkS+DFAPdrmIa4ACKdTn3nBAcSjxOANCTQUO72Q/dpHfurkLzdVK0V5CFPMvcd5awxbw6xj5zECjpaEt1bKz1HSQ4eYydnPemPNbu5t+8IQcccdRdaiifIGFAb/a9BL0w3g+XlKf0Syn1ruBSxyzDMQ7eWVRx5w5QTBstVjMESiFADi271S4Nzph/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783538747; c=relaxed/relaxed;
	bh=EE4vI/piTDLsoauUfA6gjJmO0J2gvrIIdPjhWXkf7NM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UhWkosZd8Rj4oii/fAGW6f3v8HP7ndHgkfjbfPO9mmDXaR4Drhfk/DpnSZwveXP4OaeLzdPI65lfWdMrZyc8bd7fFz/SJbKR+2Gcysr9oZAQgtKzZC+G7L5uulyaRMFcA3wFPPnQ/86V+TqxM/Gr8NK41na0BClQ1GxOgQTKW68eNSQhXJi3SR9iMJdVME1X1vNZkRDFUZKUwu9e7oRLcX1rMD3vG6SYDm8F3qLheTlYpux3Y524gZexfOTNEt3qHLD0tOLpflOBpq8qD+EPFaQYOptLUzm7dKIADh5iwDpt9eBxKAUP0FV4mHUoUaJ+EQbuJw7TX7fCJ/QDzffjpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mULnlvx0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mULnlvx0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwSk20G3Hz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 05:25:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7CC6E600C3;
	Wed,  8 Jul 2026 19:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB31F00A3D;
	Wed,  8 Jul 2026 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783538743;
	bh=EE4vI/piTDLsoauUfA6gjJmO0J2gvrIIdPjhWXkf7NM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mULnlvx0Cqt+mQYewMLD8bqRaMo7PRiALU5WRJDaEEE1yAoKxTBi8Q8e0xLtgYN/L
	 UoWmwEkQ5zK9gzJxtH3Fi6wUYjxRPTPjB/1l2hQqBL/U+dz74edl16xhMQ3/gDCMGs
	 Vl70Gv1EUNURnRE5tZAd5qhWhtTCZM/VPOlYccRGsSfCM9PU5ycvmcJQLpvsZLQKyJ
	 vPwDsNYyfoVRywNYRpvAu6CRVb9DLhL0aQe7S3vBqV+qA+yOUjSEup7JeIsLnw/oTA
	 NrAaYUyulxRXuyzRVisyqp66zq9Kk4fpZiBtpClir2xtqq68/gEHy5+ZsSW6KwO/96
	 /4hJJrtNUzF8Q==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
 maddy@linux.ibm.com, irogers@google.com, 
 Tanushree Shah <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com, 
 Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
In-Reply-To: <20260604065519.112101-1-tshah@linux.ibm.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-Id: <178353874278.478719.17250628813855454145.b4-ty@kernel.org>
Date: Wed, 08 Jul 2026 12:25:42 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 04 Jun 2026 12:25:19 +0530, Tanushree Shah wrote:
> Unlike the in-kernel trace_seq which uses a statically allocated buffer,
> the userspace traceevent library's trace_seq uses a dynamically allocated
> one. Therefore, every trace_seq_init() call must be paired with a
> trace_seq_destroy(), otherwise it produces a memory leak.
> 
> In process_sample_event(), a trace_seq is initialized for each field when
> formatting tracepoint raw_data, but the matching trace_seq_destroy() is
> never called, leaking memory for every field of every sample processed.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



