Return-Path: <linuxppc-dev+bounces-26176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FD8C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 03:35:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX18z3YyHz2xlZ;
	Sat, 29 Aug 2026 13:34:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787974499;
	cv=none; b=X8D/eA1X0ErXTTIDHW52KEQ/xZKDejzOdhZT07azhl8IQakO1tHcWmh8R4/4FiaGQiB38fdu48povoNWEBFe7jIeEPn+rqVlsTXWVbISZvLHW5QK91oa9qNOdZSeiifvmKYo/DJkVSP7Mw/zWdS8EKYw7zBvuvMSmKEdduON+qrv4W/gcECvuPH5bE0Jr6fIwr7a++6wrT2W7Jrj6B62lJRfAOaEeGybrcN8PdZ80GW+xNuYKQtRBT7nLv4N2Dvs84FolVq6Lg3o3rhJ9J2A4trc+lXedaccUXL8m6bxF0wsABQ6JZ3/tEBJs9Tf07PGI48EdNETMt0u76eercHEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787974499; c=relaxed/relaxed;
	bh=xbaZqm6ArufAHT/YW+nOlk/tIqrW9IH+o3BJpw65ul0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9SQUJfHFYpNZ2Iy9WMJnrXWqIhoBUqN4QwaMQ/AsJHedfL3/y5q84rB2rDMjhBJlaVCNoZ4wEIK40sg30gAc7xaCps+rxyTmrNPA15UsxDpPCpIV8UlXDDpXZI/LmlH9dRzk6rtDtps4KMYHbuddrap2lfeQGNO+CKnLpXQLkVpUfqK1S3PfhiOfI3eyJFvek0sIX4x+rpJy3uTUKdWQ2Ynl2gu/P3l6YtRodBC/LNSS9WbdDNYBZRM+G9RyMOV8YEDqtT0LXn30Oy/VWM6tmSm7bbFiUDiwRzC6U/v2v8OSYbOz1pA7PQXUk0OPV88LzB2HOTe+8NQ+WcJAgDZfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxWb7x3y; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxWb7x3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX18y3bgsz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 13:34:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AE8FF41ABC;
	Sat, 29 Aug 2026 03:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94171F00A3E;
	Sat, 29 Aug 2026 03:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974495;
	bh=xbaZqm6ArufAHT/YW+nOlk/tIqrW9IH+o3BJpw65ul0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LxWb7x3yegeaUjOO+B6/VynLCp9iV/8YpI8msRT0FuSoFh1spA71RQ8ugMVBtptyy
	 qvrV0ue0E/EKssYKbHHNgxtU3s9s89Rz2tUZ408DWYZV5DZHIZMCQOkec7kqyrAsZR
	 1SdT+F91F8bbomhbDBmPuDpy4EMqHApbLULTTeGDRTpOLYDOAm378BHDbQnJcXH5m8
	 a/1SznMLOvXmKopOAPy/yMk70UhJewQNNwJaGdg3ZWJjQa/oFyY+hEXHhZ/ABeK0Zt
	 t6u35Mgwu5dplG4kjGNrd+f67BoZkk8YNX2XRa0hwiBRdI5JmPnZouKYumGRNGmIhL
	 xmQJ1q6BeIq0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 6.1.y] Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"
Date: Fri, 28 Aug 2026 23:34:40 -0400
Message-ID: <20260828-stable-daily-0009-revert-fsl-usb-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <de6cc86708372c418d670cf8ec4d5929538c3417.1787901520.git.ralf@mandelbit.com>
References: <de6cc86708372c418d670cf8ec4d5929538c3417.1787901520.git.ralf@mandelbit.com>
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
Content-Transfer-Encoding: 8bit

> The reverted commit uses disable_delayed_work_sync, which was introduced
> by commit 86898fa6b8cd ("workqueue: Implement disable/enable for
> (delayed) work items") in v6.10. The function is therefore unavailable
> in 6.1.y, causing configurations that enable CONFIG_FSL_USB2_OTG to fail
> to build.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

