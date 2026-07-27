Return-Path: <linuxppc-dev+bounces-24865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10E5C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 09:42:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7ttg2MPvz2yhD;
	Mon, 27 Jul 2026 19:42:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785145371;
	cv=none; b=TkVUWSoUUSr0YvRcD40BeLblLa65EC1NFx5VFsPVpmHqhK2GGIaHM3ro55DuW6/FrKICBQvR/nz+o1MFwRpaYHNdsZWjeLgX+Y6LP6+rwMvq0aAbQnhPe+dRK42rnBKLyqPpbjr8HDaUJRi8q8Rkk9+peQDXQN9QA2PpiwrAljyILzwYNvc4hdwazqWHfGT2agHFOljncrt4PU+W+/XtTAoAxhhhzqkQKWIIUwaxn5U8w6SIHIIMzm7csEK1V+Wa8+fh/h/Ks9hygMnsazsTbDf5PM5CZz5ALvXOM31QOWNk1fDlBmxYZvMZfrNzrLyA791v08mO+uI1u11nYEwwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785145371; c=relaxed/relaxed;
	bh=+x0fIqNoM4+JsgNd51OWVrGZnJKWa/vi5y3lZsQ0fJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AV0crqPeh5m7MxM70PCwa5i6reuNAkAKwovxSohANcuW1fhDOSPuCc3MIWtTmpKZ8ScC9AwTMWRzdncMKMRi2tmnvLim2vobgNAdozeY8PRn1r/oftnKYmmHyAWtcxrGjYeEOPELxgQFj9HgwgyAVHZzSwN0ek0AUBnMUHNCpsg8IDdvezuZ/X4lJfadnoBjQ2fDywfRvUT8yOu94CZUiK4zpIOUlMGwOzD6MBQk17Wfal6CfDQx/RisZiHoaZ3SkXZGHlyQx9IxvnsAxlCfQHSIFZM0JylrFTVEOQ+gSDUNeaef7CbDccIWh2OC8y2oFlq4oafjAWM61zXB+eUH9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Z1x5B4lo; dkim-atps=neutral; spf=pass (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=jk@ozlabs.org; receiver=lists.ozlabs.org) smtp.mailfrom=ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Z1x5B4lo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ozlabs.org (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=jk@ozlabs.org; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7ttd2vMjz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 19:42:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785145367;
	bh=+x0fIqNoM4+JsgNd51OWVrGZnJKWa/vi5y3lZsQ0fJc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z1x5B4loN/5n/JiWZbxMEqLa2BKNta8Qtkc8nLpM5aV6fECIMbO4DxTd/Rz7l2K0p
	 RFRWD21jO/p3hPbhowKTvOXx5pSlvJ9ijLfpYlryhuxYiGq+gHnGOL8SUu+wX3JSJ3
	 icAqCJjESC8a+0IH/c1FMExdqiCTqXstll+2bHbf/Is5G3dKQDfrlVOyHwQnvxglNy
	 gsBt+MakzW84iFPdRkCbweafXWP/2xE/jBQt8lH8zqT1z1sRznVakzFl46vdyW1/UL
	 yKWm+dX8f0JetCJ9tP18HOAwBzjz39jRVeKxq1VEuN1YvaM2LEusHjl3IuqiB5qwqP
	 EMM5Xa/2YYTmw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h7ttb3GGzz4w2B;
	Mon, 27 Jul 2026 19:42:47 +1000 (AEST)
Message-ID: <9f14b4080d6581db6ccdd61dd0fef938d79ff10f.camel@ozlabs.org>
Subject: Re: Ozlabs patchwork very very slow very often
From: Jeremy Kerr <jk@ozlabs.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Stephen Rothwell
	 <sfr@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Date: Mon, 27 Jul 2026 17:42:46 +0800
In-Reply-To: <13ad3474-77c1-4edf-9d35-5af102bf7d43@kernel.org>
References: <8f6e5825-9468-4499-9bbd-4588a1eccc94@cs-soprasteria.com>
	 <13ad3474-77c1-4edf-9d35-5af102bf7d43@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Christophe,

> Since some time now, I regularly observe very slow response from=20
> patchwork, to the point that my browser times out before getting a=20
> response from the server.

I've just had a similar email from Maddy. Looks like we had a large
number of active TCP connections, hitting Apache's listen backlog limit.

We had a batch of this happen a while ago, mostly from scraper loads,
but was resolved with the introduction of the Anubis frontend. I'll have
a look into what's causing the more recent connection floods.

Cheers,


Jeremy

