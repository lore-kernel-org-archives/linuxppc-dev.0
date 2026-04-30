Return-Path: <linuxppc-dev+bounces-20344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FFBFF8873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 15:00:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5y5n2vVnz2xKh;
	Fri, 01 May 2026 01:00:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777561229;
	cv=none; b=J7zwvkxeJptsvTJyqtm3dgqeZTQ3c/zTfBG12TKDcX9siaT/7vyRidoD1vxIX1wwYeemWtkhJ4N8li+eKg80QDlFhsNI+87iDVuj7Aol9rsX0ZaA4P2h5DJVmTYoUUCbnTZ/V+vxoqIwVIwTGNSAAmcK49b15IMgvE39Wo10eX+ux9pRUjsCBSHi3xrzcwV69UA7akoYb9iyO6PVySgp9hLMTXj28lr7t32LtDbSaukNIWZVvj6pmbY3sa9R1XtEIevfoRGeIhlZxLqJXFkAHEBhLozCGGAhthTqeAnA7198AwWu8t35XLatvMBH2m41FZANI43ufixqqfHSdqPpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777561229; c=relaxed/relaxed;
	bh=R3Dmfxje96M0Qcg1Qv3id0BFsms3q4fmv4N2CerTyEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0Et1DpwjnMuJ3sOE9J+CiDkXE7ZON+uBrzYnoPelFGINqnDfkFNvWsxYoLukbQC8Gn19luEB0UtK+yDc/iOTv6YwXkRXkAgd+A4+3oDR4eHA1CoegxeNoQnVZvcqvlTUhUvrrJ7ttwrgChuvqZtjz9wLqyR6GglvQWHbe0dlLUPyaOzYP2JLur36tld2F186MBTAGA5UIFXoC90iWf+gECDCT/E1Fl0fs0DJcW6OMlNP63JmAMy1lhIAfrUFnwKHkL3AtYtchHgOO1ayMD+XVyvP05LwmbLpNPsv1kRCNcxV1CzcEeXpScJRxEp5GCbCTJLxMP3su7dowF47yBggA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t55mjbee; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=jnmd=c5=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t55mjbee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=jnmd=c5=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5y5m0Wd3z2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 01:00:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A76886015B;
	Thu, 30 Apr 2026 15:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56644C2BCB3;
	Thu, 30 Apr 2026 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561220;
	bh=NIpBbsTVJAPA1LbGLLmEMRWHJX+8fdw+OfgAkskpcEQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=t55mjbee1vXMVJyHEeEn0P8FI8bsYPXfabVw7eCjPFiizXuDUdAK/L+jI9fQK9KS7
	 qvG9ZEwKvSc1VWEGNWZC4tFLsGO6/CSezgvxys2Vjxm1G9BCqC8ftD1SUdpZUjv2sS
	 O0xlD15qrjow9JwOs5diImGaL8cq7hyzFtgo7ocohp1gkXIAOlDXqtyuc+cYjfJKuS
	 xDoeFDB3chbtG5AtdvfOui0E7Pe5vBlgQYBWWP6k5cacldnVikQobM16nG3lcB4wtQ
	 KMk5vRqwaUXQsYN/gOZwPJgrOtCg03D2Vk0AkdqvQEWcLDuZl48VXtEImepCQYumks
	 Bs5cgZ4Kab1Pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D31DCCE04A5; Thu, 30 Apr 2026 08:00:19 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:00:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Samir M <samir@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun@kernel.org>
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
Message-ID: <16676927-5a4a-4007-9ece-593a4699adb0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
 <ae-EP1BpXgnEWCt4@tardis.local>
 <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
 <5ab8d72e-1a93-4d50-b097-0dde35d81f25@linux.ibm.com>
 <6c51cebc-3b98-439d-adcd-a0f382b98f40@linux.ibm.com>
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
In-Reply-To: <6c51cebc-3b98-439d-adcd-a0f382b98f40@linux.ibm.com>

On Thu, Apr 30, 2026 at 11:49:02AM +0530, Samir M wrote:
> 
> On 29/04/26 11:21 pm, Shrikanth Hegde wrote:
> > Hi Samir.
> > 
> > On 4/29/26 3:46 PM, Samir M wrote:
> > > 
> > > Hi Boqun,
> > > 
> > > Thank you for pointing me to the existing patches. I have tested
> > > both Paul's patch [1] and TJ's workqueue patch [2] on my PowerPC
> > > system (80 CPUs), and can confirm that the workqueue lockup issue is
> > > not observed.
> > > 
> > 
> > Can you try only paul's patch and confirm if the issue is fixed?
> > 
> 
> Hi Shrikanth,
> 
> I have verified Paul’s “alone” patch, and it resolves the issue no workqueue
> lockups are observed.

Thank you, Samir!  May I add your Tested-by?

							Thanx, Paul

> Regards,
> Samir.
> 
> 
> > > Test Environment:
> > > - System: PowerPC with 80 CPUs ( e.g. PowerPC LPARs with 80 online
> > > and 384 possible CPUs)
> > > - Kernel version: Latest upstream (7.1-rc1)
> > > 
> > > Regression Testing Results:
> > > All tests completed successfully with no issues observed:
> > > - Hackbench
> > > - Kernel selftests
> > > - LTP scheduler tests
> > > 
> > > The workqueue lockup that was previously occurring is no longer
> > > present with the patches applied.
> > > 
> > > References:
> > > [1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-
> > > d699ca496f83@paulmck-laptop/
> > > [2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/
> > > 
> > > Best regards,
> > > Samir
> > 

