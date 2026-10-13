Return-Path: <linuxppc-dev+bounces-29342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C58CC6B03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 05:51:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3k3X4x2Mz3bsm;
	Tue, 13 Oct 2026 16:51:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791870680;
	cv=none; b=PylCTlqgyt7N7chUeTOERnV2sZ7p8Oi9+95+WbGihqliJmMZb7Iu3IpAxhncNm+7PwHjYY789YSTo6AzIqdaLkB8/KTugevn3rlJ9QJ3Ddx85zyfTaOe7U6VbU1EeNvmPzv7LeJGOBszZ5AcfHVAZz/R8uS9cLsu5/hLcJ/EaAdKA/TQCnwe+KIbESD6JGR8B81sDa/kFEpBS4NUI2mLOYZuovXD6HJrzmbmIeNn0C+/dOyOfDtdk2ZloiK8Q/My8pQPuUIOWajrjoTlMD0uL6rAKWXDqQwSj7TiBujmZuZqaratLSL53S9gjEcQYcXEGgmR6XwHbk0j2KIHJbV2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791870680; c=relaxed/relaxed;
	bh=5lKjYh2cMM6S8ZPayvGpCsHYlLA6nMPRcFjg2e/vTg0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOBG+Tp7C+je9+qa/xyG/ktu3Q9UNY8blNgF6To8vxQUXjvEU8b8ZRlRglvwXQDO0wn1LrbWyw0fhYzIjv4aSGuXJqOIFX0HpmDc50Owx+mLRNDZRFbxs4OVaJVcS0vAyrHH+Nzyx0NXrdOD1cjWPP6UTYUA/cLnxbZ8EWKXi/EWNiLOqVYolyDeONjT10wSBXZo6RKB2qtrJnZDp/auI269NcYLRFc7AIyHHpO/49zSjjs08pXvcZbmR+OTsnYilD8p1YTGrIJVqT6Xd1q7Hhj03FMC0ufCmLbhRh2NyIH45V2x1O8l9npy2LhMkNsS75gxWXHQexIrijQM5eYcng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNpqUk+A; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNpqUk+A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3k3W4YjTz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 16:51:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5EDBA60A52;
	Tue, 13 Oct 2026 05:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D146E1F00893;
	Tue, 13 Oct 2026 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870675;
	bh=5lKjYh2cMM6S8ZPayvGpCsHYlLA6nMPRcFjg2e/vTg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oNpqUk+A8uKZTP5ZUErbEiq+mylHoRY/nBJDhapTuKgk2jElls9J6OJlzZtDouIZI
	 Ho7brP33IIe3e/qyx4JCIVlYmltCMcedx7SObsl7EFcr2657df9zbIq2wQMXNZ1Uao
	 T2oFYuVro8hUFpcwaIuZxDtz3weZDTxpie41yDYvbpOOlSzzBJgKI8MqGgrqiBasOR
	 bXZ9dOERRPAj0fUWJGCsl4zEuxByE708CRSTVZcLdKEmN3OK9XtwLHkFk5w6oiBV7r
	 zymqFAWZq/3rtlINP732MLu/mZhbSYeot63k8jb3BvVhGSv9eloO1VJo04TqIrN8O/
	 zbchBwj/GwJpg==
Subject: Re: [PATCH net-next v4 6/9] ibmveth: return the error when
 set_channels cannot add TX queues
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, brking@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com, jmaxwell37@gmail.com, zdai@us.ibm.com,
 marcelo.leitner@gmail.com, ksiva@linux.vnet.ibm.com
Date: Tue, 13 Oct 2026 05:51:13 +0000
Message-ID: <179187067343.434549.13620281833326474487@kernel.org>
In-Reply-To: <20261012050518.88858-7-mmc@linux.ibm.com>
References: <20261012050518.88858-7-mmc@linux.ibm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "ibmveth: return the error when
  set_channels cannot add TX queues" says the bug was "Found by AI-…

--

ibmveth: return the error when set_channels cannot add TX queues

If ibmveth_set_channels() fails to allocate a TX long term buffer for a
new queue, it falls back to the old queue count. The successful
netif_set_real_num_tx_queues() call then overwrote rc, so ethtool -L
reported success. This patch saves the allocation error in alloc_rc and
returns it when the fallback succeeds.

> Found by AI-assisted review of the ibmveth multi-queue RX series and
> confirmed by code inspection. Tested on a POWER10 LPAR with the TX
> buffer allocation forced to fail by a test-only module parameter (not
> part of this patch): ethtool -L tx 8 now fails with -ENOMEM and the
> device keeps its four queues and passes traffic. No kernel selftests
> cover ibmveth.
>
> Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>

[Severity: Low]
This isn't a bug, but should the trailer block carry an Assisted-by tag?

The message body says the bug was found by AI-assisted review. The
trailers only have Fixes: and Signed-off-by:.

Documentation/process/submitting-patches.rst, in "Using Assisted-by:",
says:

  If you used any sort of advanced coding tool in the creation of your
  patch, you need to acknowledge that use by adding an Assisted-by tag.
  Failure to do so may impede the acceptance of your work.

Documentation/process/coding-assistants.rst gives the format:

  Assisted-by: LLM [TOOL1] [TOOL2]

Step 6 of its "Procedure for finding and fixing bugs" section also says
a fix for an AI-found bug should add an Assisted-by tag.

Could an Assisted-by: trailer be added to this commit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012050518.88858-1-mmc%40linux.ibm.com

