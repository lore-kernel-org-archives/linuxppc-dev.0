Return-Path: <linuxppc-dev+bounces-1813-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3B0CED26F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Oct 2024 06:33:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN5n96Y6zz2xHt;
	Tue,  8 Oct 2024 17:33:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728369197;
	cv=none; b=YXVm1rG8Bob6PZcdb0l/9r0E9r5A6zO39UMoOnKAFFWhIut8mMkVQmz1FfMVoEKeZPsg94YgPT6CoWDxQnZf3uTu641kOCnzI0iagDzphY/pxaBge9XRSuDJdQxU8kmmbDuIMvl7OmzrGsPuIYii8Y2c5ykbVgT58NuODhSm5yyZoIVy2bHnxildlAtM6kDmMFztu05R3l5TqPHl1kQBDHw+WrCmQE8Vr9Eav8FA0sRGPq7ncIwVvBLFTXQ1BrfSiWvZYdtMc9w/d/JPn7GL8wFGZPULFZ1CuyLc57bi0PIOdpnoo7kp2wAb8mPbFWVuq7nnupw9erP3iY/fKFdjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728369197; c=relaxed/relaxed;
	bh=uwV10IJZeQnf1cK10vvFWzrCG6D1nZse6Z7j/E6+ibg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpfUql/qVfKtsHS0cakqfgcDRMvXMuAcw/iZ2aQxsItVSnCedRMJrr2UNbQFTvlz5jMpMnlULuPtQuYhfF4dYixsM2SQessxYcXRCmpU+RsMyJ1+hO28HQcyUR/och7HwokSvjbgEbGV2F4/CpH4cbZK2tDz5iBnSWw51jJF5HgA6F63Xo1Bs+scd6XpIcFCcidzmOMvPw86td+gBaGri3ZVOZVHg3i21HlZreDyHT4rvewBC7Udkeku4B58JpU0nW6Jj/F5v1weE0W7lTP0x0+Gq1Sch5WCIcYxtdN0Mlxie0N+Karz4LZ8FH39uzbothQBjJxEpsHEQMt3R9Es3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN5n812ZNz2xHr
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2024 17:33:15 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E083227A8E; Tue,  8 Oct 2024 08:33:08 +0200 (CEST)
Date: Tue, 8 Oct 2024 08:33:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
	brauner@kernel.org, sfr@canb.auug.org.au
Subject: Re: [linux-next][20241004]BUG: KFENCE: memory corruption in
 xfs_iext_remove+0x288/0x2c8 [xfs]
Message-ID: <20241008063307.GA22312@lst.de>
References: <ae6217b4-7b62-4722-9afe-f8379201cc9e@linux.vnet.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6217b4-7b62-4722-9afe-f8379201cc9e@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 07, 2024 at 07:34:18PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
>
> Observing Kfence errors, while running fsstress test on Power PC platform

Is this new or is this the first time you run kfence?  Any chance you
could bisect it?


