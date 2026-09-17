Return-Path: <linuxppc-dev+bounces-27536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03B1C982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 02:28:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlfnn3cmqz2xkr;
	Thu, 17 Sep 2026 12:28:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789612125;
	cv=none; b=P/Pq4IcVn81ZpDcG0Nua0xLNo56dNPZRQw7OH3ffzBh3teVTCIQvfo2+OYSmfZZ28wvtxc5r17dhOGqDqTBAPN14uaG5UjrQ/V6ZjS1DkHRx/grkgj7szJkIRToxoQP25oITm5VOTev+KBvzo0I3wIB+WXrr3sVYSoUVUMQoVlGpje1wDA0hiLgUc17QwJQwR1+vi092nhVxio7PH0H5wipq6mJEIkgmjNy/5dqWTHXl8PkAJsJ3rUqn/KfJDYoizAuKwuLwsB07Ki3XAXx7INTvLsjes+X7fNyd00L7CbyDvx9fj8F6Y71i0x4wqxA7RGj0/K1Dx4naEn1W/lzsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789612125; c=relaxed/relaxed;
	bh=CMua3TyWlvr3nWYiarskUz8W5kiV577yocMbTDBqi+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4y3Av1MVebf0VmK9NLJP1ZXcnqHcAMKQ6cSOlW0wyE44SWJv6LY8RrZdHYpphyhsobAHjaAAT3g8E/b+v9IXI9g8v4+yNRmFUtCAaUwGirglWy3ssA6FXrGZHIPB26cNV5Ah+px5Ms3OwRjFke2Xj6sM+nQj9A3rbKkdAmUHOLgvSFzG/sV3mOB5i4zQwASyNjtbr5U291FaMnQH9eDvEXuYEZZbqFZIyVv3RS+8JpuctnazxgN7CXTS6B0FRcWxd5yOXfa1nlQaBAc/ff4Ut11tHb+Un9saPO9Q9xFH9QNKf5aDuVsBzrJ8dQD/6UYMwEUN+GclyaDIZRua+NtRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqYGnizp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqYGnizp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlfnm4FVqz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 12:28:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AAA8A6022B;
	Thu, 17 Sep 2026 02:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC991F00898;
	Thu, 17 Sep 2026 02:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612121;
	bh=CMua3TyWlvr3nWYiarskUz8W5kiV577yocMbTDBqi+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqYGnizpXYyRIPZBc6DA30+Wa3mJUoTuiaTLfDu95Bf8rZuRO0JQOMnFwyfU3BGb7
	 nCVMRBOAclRBKp7Kyy0cs6MltkFkAybaB4u1vybB5mUTqLrLikBZrZh/sKLG72dT+n
	 zDTC8+C7WuyTi/yDvxjfOGdzl4v9T3nGLqrlZuKa2laBDwMrDwoploY/0MhN5x7DHk
	 A3ItbJNvvm3TYSMWuSFPTHb3yHtylggJLJ7Z17z0xY3w8wa+tJ/e1yv3QWHhHE2fci
	 IXsKdrrVfZwzHuOTpVvY+bfvi8IrycevIMKkmUoYRIlEprGZW/CcM3dAaj38s7PO+2
	 VAxnBjUUuMVDA==
From: "Martin K. Petersen (Oracle)" <mkp@kernel.org>
To: James.Bottomley@HansenPartnership.com,
	tyreld@linux.ibm.com,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: "Martin K . Petersen" <mkp@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pavrampu@linux.ibm.com,
	brking@linux.ibm.com,
	davemarq@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] scsi: ibmvfc: Add Kconfig dependency to fix link failure when NVME_FC=m
Date: Wed, 16 Sep 2026 22:28:22 -0400
Message-ID: <178961190577.3672510.9039790246882718532.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903074329.6705-1-venkat88@linux.ibm.com>
References: <20260903074329.6705-1-venkat88@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit

On Thu, 03 Sep 2026 13:13:29 +0530, Venkat Rao Bagalkote wrote:

> Building with CONFIG_SCSI_IBMVFC=y and CONFIG_NVME_FC=m results in a
> link failure:
> 
>   ibmvfc-nvme.o: undefined reference to `nvme_fc_register_localport'
>   ibmvfc-nvme.o: undefined reference to `nvme_fc_register_remoteport'
>   ibmvfc-nvme.o: undefined reference to `nvme_fc_unregister_localport'
>   ibmvfc-nvme.o: undefined reference to `nvme_fc_unregister_remoteport'
>   ibmvfc-core.o: undefined reference to `nvme_fc_rescan_remoteport'
> 
> [...]

Applied to 7.3/scsi-fixes, thanks!

[1/1] scsi: ibmvfc: Add Kconfig dependency to fix link failure when NVME_FC=m
      https://git.kernel.org/mkp/scsi/c/1274045b0eda

-- 
Martin K. Petersen

