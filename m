Return-Path: <linuxppc-dev+bounces-20093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840FBFF8850
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2026 02:51:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2Z8w5gg4z2ydj;
	Sat, 25 Apr 2026 12:51:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777085488;
	cv=none; b=Qd9NdFateGUdSrvWogjLWYabtuxu7yoBQlScQlH187YQJbDagsynnOhuZR0SKOLgLlWgfttw0XwQ4jEVgAyPkXyEW71ps2wXxsj3TN/AeycXBUa1LmP2FtTcI+LgD75QlbGuULcjEliriXE6dKrm9xuSoSptKTxdgse+Canp+n8TXkcGIxDF7QrA+2wflSWk3WEkTtZQIASDoypLXX1BnVdzlERwwXW/Yg1C6XrKw13jMpldNB1wxlFSSSbxNxtTTOYQvQj4YMJZGiv7KsnVzi0wjsTAEoTO028lD+r5kliq11K/820olnSavbCj2jIN80d8Ch71JV2hppalFbL3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777085488; c=relaxed/relaxed;
	bh=R76C4bnqOQs+cMjOhoT54GR0DG0T3SlQNkGL43cCC0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX3mv8qnLAKWi4ChcsRldNalcTzI506eHP91LS4xJ9pM5tcRkKyUIZQB2SNVqg6MMgMO7sGu39gBlV11D2LYjYfpkuU+2Il7HKfDevjpuplEZERabKBxuPQIABIOpIBX+O97KgmK9iT5yGb6Q9xfgyIrYui8ipz4pV1v4MnkvYFxMmn1pvbabnsbXw8Qgom0lmpo9MVqx39+32b/sh66a+RK7i6yGtE+eliGwi6GV9GAR7ixZK63/6dXshmDq89awfeJgpozOI2ENTe3ag2NMGroxbGcUQQvKyRmDYSUFi4xzXJmhm/1V0vd0JUPw32MrqsKNS9AZpi70rF3NsX9uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2Z8v0F5Fz2yTK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 12:51:25 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63P2ok5R315434;
	Fri, 24 Apr 2026 21:50:46 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 63P2oiZh315433;
	Fri, 24 Apr 2026 21:50:44 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 24 Apr 2026 21:50:44 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org,
        "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: KVM-PR no longer works when compiled with new GCC compilers
Message-ID: <aewsBF4zLRE7ZMuc@gate>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
 <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
 <eee732904c2a7ccce9b496b05f988a36d8a9883e.camel@physik.fu-berlin.de>
 <5da12382-5424-4bd9-981f-359e4dc1fa67@xenosoft.de>
 <a584b7a1-fc25-a475-099a-634159b6ffe8@xenosoft.de>
 <d9ad0cd6fa640f23c396778bce2aa322e40e7e88.camel@physik.fu-berlin.de>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9ad0cd6fa640f23c396778bce2aa322e40e7e88.camel@physik.fu-berlin.de>

On Fri, Apr 24, 2026 at 05:48:37PM +0200, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-04-24 at 16:47 +0200, Christian Zigotzky wrote:
> > I compiled it with "mtune=power4" today but without any success.
> > 
> > Error messages:
> > 
> > [  800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> > [  800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (00000000)
> 
> What exactly are you running inside the KVM? 0x00000000 doesn't seem like
> a valid instruction and a quick Google research reveals that this triggers
> a SIGLL trap.

By definition anything with primary op 0 (the first six bits 0) is
invalid.  It isn't super unusual to (accidentally) try to execute a zero
as an instruction ;-)


Segher

