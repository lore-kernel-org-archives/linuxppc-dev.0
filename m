Return-Path: <linuxppc-dev+bounces-29070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B58CCA600C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 19:34:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j10Y557RBz30WQ;
	Fri, 09 Oct 2026 06:34:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791488041;
	cv=none; b=YoLo1gN6IWtnH8Gt8Rs+vx7jYv9e5p5JG/8KFZ9SzjzJt1aBmEM+6nNXKO4R6Tv26LQGaBrbQSP6IkiZIjtskHFQRSZsD0Yq/fWOuGk8+z/tO4cUa8OhkNhuvTw1XM3DFJEmH/BNUYGSACaB4FX3ZqaLHseaF/nR1pluIx+R8us8WFIScXwu5j1OTtBbPZcXAyV81VkCNcvOD6bSsA8I3RaQ5AllFgCDZ0kZBZSkHMj80d4eLgGjfn5jyCGZOLEayoUh79qk8B5PODKUPZQAKf+3aG+a2WlaltzC+ZtsHgqomc30PmiuNaSm+rhgK9GXg+LgKszBGud3cNQ4nbYoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791488041; c=relaxed/relaxed;
	bh=IJJ5yNSuhj+U00DAS2C+gX8mlhxc2VewJrIizDNf7kA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AEg5WgWNr2EZUKxq4QhAdPZFIELgLc+sFrj9Vm6+oirDbTNgriTaI+Zd4brXokUDttTOCZ3VrsvHVtT6VielMdjsd79uEVk7lpG9r/25vXeWLaO2MYGWJsWuihsPnnYdLlqrxU6MpqWoe7FR2aj2rF1C8VI8hEY1MPjaWmowdKmqOHYrrX2VvIdA6WL/ZUMe/vSOPZjD30E4gEYUH9I5NaMXnVYAiBR7rixiw93Fw6a7tLj0NLiZd54YbNr4zvCjp+V36uulgusxQPAA2uWzR8+dbGIqGp39bCuhpOVr5FkoJrmMyLrhUJg/L7KwndlCzQMX46QEX0gv7n6Feod6QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERZwJz7N; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERZwJz7N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j10Y50K6pz30Vb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 06:34:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6240941827;
	Thu,  8 Oct 2026 19:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147A81F00893;
	Thu,  8 Oct 2026 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791488038;
	bh=IJJ5yNSuhj+U00DAS2C+gX8mlhxc2VewJrIizDNf7kA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ERZwJz7N+wX+TSPIf81a+BxDW1Dxx9hAtAu5MOJanUYuVnpOb6vidAmt2wvz365Zl
	 C784VjqrHPX4XdPzEWo9ccbMmlZK8gnp1oKGEYqM37qw1jow+UVdIgBKyPbCZe+01m
	 CGLuEqD25+SlNvnkAlreiu1grazNfH/DEXsfm2guZSDUjiH2VYlcU9UUYriBWxYDMf
	 9v5biTK+W/Gtc5ynAUk3sLfeqty5EEpK59LReGV4u9uNlGd7O68m1WyzyeI7yTfwVw
	 r23cgM7Dd+3vAYmV2tD4CBua+xcomr1P3prDxmHhnw2hDkFX9aLVIPN//yGgYXcrtR
	 dSO/H1gH9VrsQ==
Date: Thu, 8 Oct 2026 14:33:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <20261008193356.GA920772@bhelgaas>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>

On Thu, Oct 08, 2026 at 03:23:34PM -0400, Alex Deucher wrote:
> On Thu, Oct 8, 2026 at 3:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > recover from a Firmware First reported Fatal Error.
> > >
> > > However all status registers in the Root Port's AER Extended Capability
> > > are blank, so apparently the platform firmware raised a false alarm.
> > >
> > > The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
> > > Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> > > Errors causes code paths to be exercised in platform firmware which
> > > were never validated before.
> > >
> > > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > > actually signaled.
> > >
> > > Note that this will also skip recovery if both the Status and Mask
> > > registers are "all ones", as would be the case for inaccessible devices.
> > > However that seems justified because it would imply either a hot-unplug
> > > event or a Surprise Down Error further up in the hierarchy.  Interfering
> > > with recovery from that seems uncalled for.
> > >
> > > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222095
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> >
> > Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-by
> > since he hasn't tested this change by itself.
> 
> FWIW, I just tested this patch by itself and it works as expected.
> Feel free to add:
> Tested-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Added, thanks very much!

