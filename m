Return-Path: <linuxppc-dev+bounces-29570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B664DCC6B38
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:34:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5FYg2xJjz2xb9;
	Fri, 16 Oct 2026 04:34:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792085655;
	cv=none; b=ZdZaRh2ctAar2RWljuu19DKVD42goRsWKTf8UZlqqLlOA2gxeV8085rO+xCsHIe80Ju+XqDtZrKeN7zJ0EWid2N3WSak/iXwpxtOeTv7n4amMPCIUN9xqGolVL+8R4wNYOp6nitc7O8EqojVSdHs4ID8UYPD5jejf7JaLa3Dpql2+Ct1D60+0YZIoo1zmnUXRJomYCY83lVVaJdM6dL1C/lhfaBsFGiklJaw3VPyH/6ybGx0ClSKhELjHENHg0acwtfcYMMhn3Ac0dh2Bn9iBOB3BdKoC2AaBZ5D8qgVKMgJd6wBQqdjXSueHlEMo13MC9cRjGwQ5uS1jZpmDfb7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792085655; c=relaxed/relaxed;
	bh=6SLE0Fy67GOA2mayZg94htIlK7vPp6C0A4dq0yw0XmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFmSrKra4F0vXZlokN0h6RJlt20c96+0kJ7lUVUYeNoIhHqMjgME8w0anzrBv0n3lOsjf48dTkjkkBYRiZ3dnsDOtbsSa5soUzHiVS3R1dYucdgTrUJ4HM2/aB6g6mmwTkgwnw/0SUqzoYCMb6m2/PdnusmLLKPQekVlX/oa0W/07LqxfF34s5yC0YLs9WJzj0OSp1WTRuZ8lrKYu3BCztsnOEyZI3Q172u3iIVNcIFfVZCCEzC7rN8RCyZCpYDr1E/Vo7CqWle4eZgqUPmXwMMT4yjdLYrRBu02F07tYY8xpp8d+tbjFsVg4zDFToxbbEZhZ3ZHQRpYmB2zvxnNXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiJkGwXl; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiJkGwXl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5FYf4G3Sz2xSZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 04:34:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C1D242DC6;
	Thu, 15 Oct 2026 17:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1161F000C5;
	Thu, 15 Oct 2026 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792085652;
	bh=6SLE0Fy67GOA2mayZg94htIlK7vPp6C0A4dq0yw0XmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UiJkGwXluuOqrdSZjy62Zr7hB3n+g5I81o2ehLfnOp7+cbkSb4VDKizrwE6s6iJFH
	 pfbY1cjVa2Y8YYd4hGBRhdXFTJKcq045m5kHAMAPij3t1pwt8SvhCSsEB4GzbMpF/P
	 C/me63nagkLM6OF3XHLSxlkFr+AKuMeWGSC4b6uo+PcacNGELU1R1IGSpz8OI0VpW9
	 u9ucmPBFluN0C++mhblbfmSRjT+1uuSYebqEvy6eqhtJDqJRKrFkIA/AkqwF7XYMet
	 558gPskr0K/InX2Jkgy0DMR0bMQJLm8LycPaYk/kWGLR7e7GRxcbiCmxn5i6b7n6TH
	 82h6dRUCnSnbQ==
Date: Thu, 15 Oct 2026 10:34:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Qingfang Deng <qingfang.deng@linux.dev>, Jiri
 Pirko <jiri@resnulli.us>, Brad Spengler <spender@grsecurity.net>, PaX Team
 <pageexec@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org, Yeswanth
 Krishna Tellakula <yeswanth@linux.ibm.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC in netdev_from_priv()
Message-ID: <20261015103410.15ae1b8e@kernel.org>
In-Reply-To: <202610151006.E2F587A60@keescook>
References: <20261015165959.i.798-kees@kernel.org>
	<202610151006.E2F587A60@keescook>
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

On Thu, 15 Oct 2026 10:07:06 -0700 Kees Cook wrote:
> geh, for the subject "net" and "net-next" glitch: I've poked my 
> subject-building tooling again, this should be for "net", not
> "net-next"... 

:) Ack. Just missed today's PR but looks like this is 2 releases 
old so not _extremely_ urgent. If you think it is we can also ask
Linus to take it direct

