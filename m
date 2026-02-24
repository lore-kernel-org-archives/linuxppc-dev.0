Return-Path: <linuxppc-dev+bounces-17090-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079E6EFB80A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 06:54:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKpNh4sKhz3cGg;
	Tue, 24 Feb 2026 17:54:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771916052;
	cv=none; b=bm67x1O+r3kS/GxsHMU5ZGuftAbzr77uxTXTywwH0LEoYh5QDyRxw1uxooJXqcT2OXl/CtmdrTQK1iBPmCx65gMOtqqn8fMKL+9xse8kHU5Wfs5Z1ZRBzLZcfp7M3RMr3MgH9cUNsn7LW8bYN+mFp2n0S5dQq6yT/YhcsdAwHfWAhfwRk5/Tvngs2VzFlEnnujvNnf6ZGGniYKkOx+/OmKJL16nTG2M+6Me73UJyhI7eXu8CEXqA/hzV+STIbQuGku7gaUPbXugncHBEJvP3sdKR1jGKmXHsSZbC/RC0XA19ouI3Xe1LStCMhunmHoRvCCE2OwI84+6kpP7lBSVLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771916052; c=relaxed/relaxed;
	bh=5mkPIWChdAQgXIFhSEQHDBSxI2g3eCHzD5QyGMhqLvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oBdzNG5uqpj3NvovP9l5Q846r2aaSdmsS1YHNJXBUYO+RcMnqjqzTHREGtofuFcabK61dM2SoVORMK30zcj5Na0cLlEE47za5IDF2uvUyDrVDwpVoFG8VRwDe/KvEPNEzdOckS9xxnNnZIBodmwax6NZsQwcfhETVHEqKnkcX+ClJm7OaBRZhN4gO8yLB2xP/PHtcwvEphvhLyh/GnBRpjoIU162A52isZKyvjdPaSPGI6EwKiwzbqVMcGEo3MOs8/vNZV+i/ArG8Yaga3BZWgN77pzF3mOAlsG/cvEhnLwKRGqAs9ZwwmDqXNlamSqMNvDZRsnyIwkwd9U3X+amGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RQ1fcg3U; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RQ1fcg3U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKpNg61m2z3cGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 17:54:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A18940180;
	Tue, 24 Feb 2026 06:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B19C116D0;
	Tue, 24 Feb 2026 06:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771916048;
	bh=5mkPIWChdAQgXIFhSEQHDBSxI2g3eCHzD5QyGMhqLvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RQ1fcg3UTCQ68dk7NYK7spWLZy7OEzlo8g5ycn27z6lx3WwtAVYxp6HHWp4IMhjjE
	 63ZbJN5w877EcoY+cByaNeIKnrQ88DGzweea2ctWKor3UfBkIbwjzwtmVf8/exjvDX
	 FTN3YRmniI/weFE2izDaOnig44plnXeXSkP3OUv25oTwXS5UUWG4sMsA8ugdMRTxeV
	 rX4S9sz1LS2Mi/4O9TagOgw4rTQ1m7YQYvEHD6R8a23qjlOhMp1K9t/S/mwm+msxzq
	 gp2byJWH48VEkq6OmAcMABuLpQwu4f7j5aSmxBi1l8CWKOODZl9a9IsmguVaV8Wekh
	 RP5jO0coti9lg==
From: Thomas Gleixner <tglx@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Marc Zyngier
 <maz@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/6] fsl-mc: Move fsl_over to device MSI
In-Reply-To: <d289cacf-043d-46f9-9337-b6249b294c24@kernel.org>
References: <20260218135203.2267907-1-maz@kernel.org>
 <kukzdg7cym2cwytx3zgbu5ik2cw7c2zq7irwp6q6o4jzupjzla@qgkrv7emus6f>
 <86ms0za8e0.wl-maz@kernel.org>
 <d289cacf-043d-46f9-9337-b6249b294c24@kernel.org>
Date: Tue, 24 Feb 2026 07:54:04 +0100
Message-ID: <87h5r6vdgz.ffs@tglx>
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
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23 2026 at 14:54, Christophe Leroy (CS GROUP) wrote:
> Le 23/02/2026 =C3=A0 14:37, Marc Zyngier a =C3=A9crit=C2=A0:
>> Thanks for giving it a go.
>
> Don't know what is your merge plan. I wanted to push it to soc fsl tree=20
> but it doesn't apply on top of v7.0-rc1:

We already established that. Marc will resend and yes, feel free to take
it through the FSL SoC tree.

