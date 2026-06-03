Return-Path: <linuxppc-dev+bounces-21958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984C2CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 07:42:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVfmC0w9Zz2yH5;
	Wed, 03 Jun 2026 17:42:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780472523;
	cv=none; b=FT9LGONKalYUGhDmy+o4JrWDW6o0pcSamvNN5aWAJkambxJXJnz0M+ogTBpCA6L1JbBYA1ExEmFK4EJA1FZEpdwMxWs1Sb+xhHjVgtC56jp08tMSjtxRo4Oec+PAoj7XWQk3Wv/izqGKzIYA429F2JnSIH7kGGeIFP04kn1mgSQMZdCm/8YQA+6YQkfIh7wS0IumEKhiEP7hPGEXmaSTo477jLDccu5aonxBC6NJEqGh71tyXFPLBolkMFOLtgSFebVPGYxAOeSWgx6ltZ/l7aW/YihQc++Zkwp1tYilZ9cXtOgYJ6KF6/FwoPOWDWpsXy/BU2RqADRmFgK4PKwTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780472523; c=relaxed/relaxed;
	bh=iIWCNeOlHWpHrU2XHMhyzU74jL/SRw5S/1AXW3LPs8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS6vxW93EqQ49sjyPLwFDdBcp8p5mPs3OwxNEle/zLJMIvy6lKgg2HuCkK19YogXKfwAAZVRlO29KLKblW3vp7fzZacDUEb6Q837ykChk3Y4eiZPQssl6HS86DPjOOANzICCkeiWuDbFRABSxyAoMi8xYQbXwV2g7ui6n5m5etUVtZrR6f9DTKl8zSou0QNcJrxfiZdlBRvolSWbVtktyH855p3IXwj1+zqNKL6hVioJGuayUKhAsExcLzmqr0UwQJY9Y/I6xEUsS2VsDmOtUl9SFrsEQqArAuMocQGMezTJx6bHVLznQ+LchxZRbekZKb7kuROg2aYz9m1rl1XCzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ep7dnyWo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ep7dnyWo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVfmB1Tbxz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 17:42:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AFE9060222;
	Wed,  3 Jun 2026 07:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518271F00893;
	Wed,  3 Jun 2026 07:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780472519;
	bh=iIWCNeOlHWpHrU2XHMhyzU74jL/SRw5S/1AXW3LPs8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ep7dnyWouDjL/Gn6Tf8Rq5/PT6yyvwKIYN20BdfZFBICgvzu/eidLkIF0BUsvW3bE
	 2rTck0ybwwSahYByvROtHbc/iYbIwMQexrOIZmLiAv32KfxqUqmL2NcgG1PkkXkINx
	 tZelfbNBXCdDogSP9fCiMcfK8oxW80bYfk+4NuvN8YW89xEp1pTxXbfnLWuCDYwdkc
	 /ogqCuOjgq42xDiDIgsgpeTZGOfVIG7yg83pQebJJRtsg9NnS+s6FtRNMhIxT8N1jR
	 NccMD27gpNfG8IqWQjqblUCP40RbZifCeHwa2OjDiNQhIelAqvCG/WRsYF0ambufj8
	 H3HRLYvLRkeKA==
Date: Wed, 3 Jun 2026 00:40:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: ppc64le kunit test failure: guest_state_buffer_test
Message-ID: <20260603074035.GA1148188@sol>
References: <20260603064225.GC18149@sol>
 <87ecioyt6y.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecioyt6y.fsf@vajain21.in.ibm.com>

On Wed, Jun 03, 2026 at 01:03:09PM +0530, Vaibhav Jain wrote:
> Hi Eric,
> 
> Thanks for trying and reporting this. This kunit test depends on
> availablility of Qemu commit 5f7d861e("spapr: nested: Add support for
> reporting Hostwide state counter ") [1] that was merged in v10.0.0.
> 
> Since you havent mentioned the qemu version used I assume its a version
> < v10.0.0 . With the qemu patch available you should see this test
> passing with results similar to as originally described in original
> cover letter of the patch series at [2] that introduced this kunit test.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/commit/5f7d861e65d90e0446b8f22a0bc859a5d8058ea6
> 
> [2] https://lore.kernel.org/all/20250416162740.93143-1-vaibhav@linux.ibm.com/

Nope, it fails even on the master branch of QEMU.

- Eric

