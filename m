Return-Path: <linuxppc-dev+bounces-29670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA590CCA490
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 19:43:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j78Gz5pYzz2xqh;
	Mon, 19 Oct 2026 06:43:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792352587;
	cv=none; b=WlCwdSgfCvOay9BVeSxk1PspwfGbBnGhXK8Mx+WWN3CqNLUVhH6myf+I/gY526AS/0kTfw4gwuT+0482T+DvgTPQoyHOx4sP+ajS4eT+obK9j/v+G+aLOaRU2Lw0vnkwWbmT8hcVod1og411FvXUH8lZ/U6o6VbKMB+Wiebb80PbxrTH8eldJIWVUIMkdxjHe2DoURWkatWa0YkErcWA90xFEZMsUhqLDtATjgRwuwJca4UhLd8B62Sq5e2yE9n4tw7XZ29NuypFdTtB+e+z2FnKgs/ijQbbd1mzhcOw893OH6oPNQIJxA7kc5/CzHXzhzBOPoEuf9yNHnP8vc7XfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792352587; c=relaxed/relaxed;
	bh=K8OTffWF8ukjcWaybjMzefKafbzxl6mVnAd2P1r2qSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrOTxeDaJfbgYgQgqGxyusHeXpn2bbP6lUZ3Dx7Qx/wYHIr22W02RuVEp3p+rujQ6vXteUXxQZ5KwuhdAro7vWFeVN6NL9oVU1rlmSk/PTqa0MC2kn4/FwzkveJxHprmdbBJL/2zobpc7ozLidyPbQKTdNHtS71BYpZvUEI4wI4+BDII+ieiAqbuVrL3sTo23ECp/QNMQsVIvXfP95EoEvicW2UT/eYawET/O/eU6GX9sAmQgGEQg5r67qxIR6JxbbmBWwFz0b63xPYZM0VzwujOe1LqQ8ZQ53xl+m2CGPc7jZFAQ7CzN80LKFEZaScLZe4Binb6k/8R9xPprP03BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzAjqaAM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzAjqaAM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j78Gy5SQrz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 06:43:06 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C672260D9D;
	Sun, 18 Oct 2026 19:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7981F000C4;
	Sun, 18 Oct 2026 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792352583;
	bh=K8OTffWF8ukjcWaybjMzefKafbzxl6mVnAd2P1r2qSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzAjqaAMeLVPzFPOoLoqvaFVyKVJzlDlMFVJDfGEeGwh/wjvubLhZKELRQinDAxLH
	 DpnKU/pjJD9DCNX/38GD11YaVhbjGYGz4n1j+SHAo0o3aLIH9GsUH0ef6q5r7bjfgb
	 GOpl2lBnU+BLjEB99/p0N+FvLJW1Fb9o6NIrnuRVXKs9+8CRWX4H9PmTh3SsSflaJe
	 NzAAvBbfFa7PAUmuoDxok7IOl9LCsV+v/jDT9L9TMLap6n4bIdyQbAr4PpekXhEyWH
	 VliMLSK/0EwlDFepHJT6rK3GzYzjdK7Q0EAqz4wC+acnMpMFsN3UrB1eAfuuPF7Sqp
	 mv6cBfmzbZcYQ==
Date: Sun, 18 Oct 2026 20:42:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next,PATCH 1/2] dt-bindings: net: enetc-mdio: Document
 optional MDC clock
Message-ID: <20261018-hug-disgrace-9554d903c8cd@spud>
References: <20261016193344.115518-1-marex@nabladev.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/BUjjasNvBLCNQUr"
Content-Disposition: inline
In-Reply-To: <20261016193344.115518-1-marex@nabladev.com>

--/BUjjasNvBLCNQUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/BUjjasNvBLCNQUr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUhPgAKCRB4tDGHoIJi
0mYUAP0cgpOV4cp2J5EY7SC64vT+TyNBYGE2nv1GcnKlTteVsgEAqwc0rEwEbpR7
1gHzLECDwo8gwL49yELw1MAfSVG5OA0=
=A5Rp
-----END PGP SIGNATURE-----

--/BUjjasNvBLCNQUr--

