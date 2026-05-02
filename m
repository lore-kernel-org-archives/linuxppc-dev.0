Return-Path: <linuxppc-dev+bounces-20384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B642CD3423
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2026 17:15:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g7F095sB7z2xpn;
	Sun, 03 May 2026 03:15:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777742105;
	cv=none; b=VkX8aSZAx+ksw+FAuS2ATZv9dnbABagemxI7C8nfjZB5PlSLlw8JBu3OyxX4cSJqE9fkh9XfwNOCHvHzr5HHYg4TWWqWoqC1DDCcC/aX0nUEbKQeWNTYt/AZRuZ+4dILJ3N7fpM8uCveaTA0epa9mrU6WigJrG1CX1KApkX+yRuDZkVSlKSWcKRsnaeJpIB29uYNbgcMRkJo1M92ItVhfxo5DerygKeNxUtTjJCCCLjHoE7AUkvD3SlNrk7D7Q+t5vGfoOrYfRCmyiLHIqEq8SkQccIopdcXVKhgPWkUJdj8j0lpBP7CPRlHYh3ovACTcYV3VpsnfiKgtqWhz4km2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777742105; c=relaxed/relaxed;
	bh=OXaAjo67SbYNrCeiFpKv/+MBUhbwES7JSeMF/GAOe4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmkTcAL9IZHs1O2IDYEfaVx1imXgCJKOsx5/yhB9XiG1TDAfUmxY1Z49411zgZq5a6eqKnQJBmACvZA3AotsQwEXty2Ebp35KvZto6phN9vHdd+2Q5R2095VdYS0UVSbtCdWIJmPhNYSDJaiq7ib0/GhD/kM4Xe1bsktmLRT2TMJJWLkZVklXl4CVfjJD2b7vc3M5DVf03Rkvz0wU2gisyaj8AM1kvr8BGfEPNw9M1YAALUS9/o0zx2pvUoudrZ88F0hwPkOWSMK7TsdWyAVDN0+l5H3XkZ01ZOSUPFAPhfERp2eyZ9F1vjUzwIGxfhz8akr7HUIKJC88Eg+b3qZ0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bnRwgJ3Q; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bnRwgJ3Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g7F083mHQz2xnk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 03:15:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 55EEC443F9;
	Sat,  2 May 2026 17:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D487EC19425;
	Sat,  2 May 2026 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777742101;
	bh=OXaAjo67SbYNrCeiFpKv/+MBUhbwES7JSeMF/GAOe4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bnRwgJ3QZH2XBbWLr4/CJCtiFD7a+PwFtEg5RievyY6FXoHmjy5hwpKFmfAOHTdDS
	 dATsN2mRYNJ+qTgT5COpQkpMPARzzZ3NzoqofanfJyTYV3Mv7+wSY9seWhzxVwnKQd
	 Htd9+gsl3MuLwJSZCdaH/AqIjcZ96U9mdwEXnJf5BxhlcoJ2zgapWLfm3iyAYXBE7R
	 5Ni6cHodsGfNWv/H34cgdyHzy3svjO+eRWiG52tTHHm4gE30qRhPyL2OnkKvb2ci2u
	 9/KnigW7+9K7rNUBztQUyZcVEhdQOae1VYZEIg7EJIfEkmpph7o5mzFXa7sDeIA3s0
	 73BY4wXlcxXOA==
Date: Sat, 2 May 2026 10:14:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, chleroy@kernel.org,
 qiang.zhao@nxp.com
Subject: Re: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Message-ID: <20260502101459.46e9de13@kernel.org>
In-Reply-To: <20260501122756.GB15617@horms.kernel.org>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
	<20260501122756.GB15617@horms.kernel.org>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 May 2026 13:27:56 +0100 Simon Horman wrote:
> Fixes: ca20e191eed0 ("net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove")

This appears to be a SHA of the second patch in some local tree.
Supposedly the correct tag is:

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")

