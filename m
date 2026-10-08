Return-Path: <linuxppc-dev+bounces-29064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF9BCA600D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 17:09:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0xKw2bZ5z30Vs;
	Fri, 09 Oct 2026 04:09:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791479348;
	cv=none; b=XNbdhMD15zNNc9k8Lz87/k4zMQGnZk0f3ABFPh+rgeqV2wlX9dUQm4aDPyQPdeCefHwG7E5LmY+lkV8Y/L1usigLFqhESSX5Lp3LpK9bYw102u8LvJOiIjyCkoHphXCqCMRTGp5IVSbTs35CRusSOpsL8KrxGpElwjRoh0CH6/OymlhxSTwSWixQ23eCMztt+8xNyVASuvMwFATSq2Z6IXCvq+nioQuRGemXFqHev3sDxFCz86PMVxAo2ZVelKMWRsdH6N0oFjwQVTuMMHQVOlMGNrNTQ0EJoZld4/Wq3z36AM7/PAyJkP3Rm7ixfwlMUksElmE07SfP+rD99ZIbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791479348; c=relaxed/relaxed;
	bh=LUiHH3i1cpV1opUDZgMH1uHOC1nsLlpdYBsXQMPkMIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4WWyH/bC323Ea4a07mjexpHSKY5gOkWZNXSZWgoBDvZK3bTyZGObAhWLz+d1j6cgGJZEX7T6MXhFKEv2Db4Me4CetuVDB4Khfy/dtpDhEkd2FgJqRWKxR31kRH5OzkhwJPNiHhQDbL2CvKzs/O/xp6AgIOeZFViYQv/pURBuDFIe7sTXeFMluIdG5K8rWc8ugfizgrPChiqGcXHUOs/d04mWbDL+cvF21cuDzxJEh7XXx6JaXmHWH3KjPqMjzO/trdvwAbaG0cbEDV9CtXsZtcsdoky0R8WJskVgkGi1X8sIrYGdUFfxknDMAYcSd3WLVWXR7+X99R4Gu21Of4grQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0xKt6vxxz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 04:09:06 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 5554CC37;
	Thu, 08 Oct 2026 19:09:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3333560CF5D2; Thu,  8 Oct 2026 19:09:00 +0200 (CEST)
Date: Thu, 8 Oct 2026 19:09:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <asfOLOMCKt2ZxrJv@wunner.de>
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <CADnq5_PVD6G_VMepJ3mAz=60vM1PHtun51Kccxyz9sdBsx_7wA@mail.gmail.com>
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
In-Reply-To: <CADnq5_PVD6G_VMepJ3mAz=60vM1PHtun51Kccxyz9sdBsx_7wA@mail.gmail.com>

On Thu, Oct 08, 2026 at 11:19:22AM -0400, Alex Deucher wrote:
> On Thu, Oct 8, 2026 at 8:26???AM Lukas Wunner <lukas@wunner.de> wrote:
> > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > recover from a Firmware First reported Fatal Error.
> >
> > However all status registers in the Root Port's AER Extended Capability
> > are blank, so apparently the platform firmware raised a false alarm.
[...]
> > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > actually signaled.
[...]
> > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> 
> FWIW, I only tested this patch in conjunction with the other two
> patches you had posted on the ticket.  I haven't tried just this patch
> alone.

This patch alone should avoid the issues you're seeing both
on the Vega20 system (the first one you reported in the bugzilla) and
on the Navi10 system (the second one).

On both systems, the BIOS is signaling a Fatal Error via Firmware First
error handling even though the error status registers are blank.

The Vega20 log says that error recovery failed because no driver was
bound to the GPU.  The two additional patches you tested with avoid this
error message because they change error recovery to tolerate unbound
devices.  But by not attempting recovery on false alarms in the first
place, it becomes irrelevant whether the device is bound.

I had skimmed the log after your initial report, saw the message about
recovery failing for unbound devices and hence pointed you to the
patches which tolerate unbound devices on error recovery.

Then on closer inspection of the logs I realized that the error status
registers are completely blank, so the error reported by firmware is
bogus and attempting recovery is pointless.

For native error handling (i.e. not Firmware First), we already check
whether "status & ~mask" is zero in aer_get_device_error_info() and
skip recovery if so.  This patch aligns Firmware First error handling
with native error handling in that regard.

Thanks,

Lukas

