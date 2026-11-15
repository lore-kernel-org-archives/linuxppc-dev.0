Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F2606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ak4ncVZc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS8MP0YGKz2xGr;
	Sun, 15 Nov 2026 22:45:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794743152;
	cv=none; b=k5PhyKHtAFMfE3GmQbwRbBgG7kxcZiFYPa6XskkqkfVugM82aCSv5TecfKnt2Lyrd9Uqj7WL4AVZdHD+hWzShKV+7vRGrAGHp4pIaAL46D+OFqsi+gLr+zDubEADDEoB5rDm18EbvvECp8fJA5bpXTBU27E9Gj6vZCGCKDVYP533GR4WK+Ly0fPa3n5RpO2iX+VR4p/fLqbEmRLyalFlD5bxcQ2q7uHs69BQuOy0nB79gF/HQm0TQe0oHeG5axrPci7PwdqkRrOvo9HuV/HPMraQFpHVo71Jt7sibkkV4EnU5XC7AftzoJo+OUCcnRs2eDOrDQIF/beoKmcZAjONZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794743152; c=relaxed/relaxed;
	bh=8ZCc0kYbccT1j2j1nFYSj16fkgBLnDHoEzJYA6Hd1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv6pbY5xS4skemnPM+QQRQu7ev/dM7Owf4PB9RrfMqYGFfemkK+UHriBDJMxnIKvI8biYNrPad3ps4GavvOzTCBPzA/1ZKlSvp+nrBvywopRmzQHx6KD6ou1lMi8VUkCXWbN67FTnxEcEdS5N6GPmBcCzfT0ZguudG0K5jE/hIk3M0iwOo+jEmmGYimTb2lCxc4hJm5mcuapgFjE1POiDB7AvrgYGN4FDenBpDTGVhjOMtqLUTKzgkgMiOMaGMkVpl/jpjDucYLoJMILtW+5LskrgdzmyrDhzT6LTFYSKB1b6b0AJbnlLH2cFDJIyzVZtnK/BOqDU31yJ6zmSaV22g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ak4ncVZc; dkim-atps=neutral; spf=pass (client-ip=212.27.42.1; helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ak4ncVZc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.1; helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS8MN1Kbpz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 22:45:52 +1100 (AEDT)
Received: from L30177.local (unknown [78.242.88.98])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4BB8AB0051B;
	Sun, 15 Nov 2026 12:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794743149;
	bh=8W7U3lk1daoKKwP7PjlQ54EL6MrGZ5IE9j29Mm2B3/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ak4ncVZcgW2qLwK9X4/zElIA1HMdni3U+8SbMT5UJn4dFCQlROXyKI8G9BQvCqj/C
	 85l6Z4oISGhzno9CeY6PTrTRE16V7rEvBAopAKZHId28/ngsYuwohsm5rhE03spsP4
	 nID1pNcGQt1JAF+7EOp6kDRnQEx8qPLR5JJB2oheBDRAzcy1WKl8vf3sph6+E6QF72
	 Oyjb3pyxSWpoFKCVmPAMDn5Eok8cg5T+kAEmQdHs7+LTQNZ+5guh1S2uQc3OBOUn5Q
	 6lMfFyadDcci1ncA09egoRaOrl0cflBClFU7y+lWlhikwoJ5lZuqMlNVeo3IrjQP72
	 SlnDToNGaCUuA==
Date: Sun, 15 Nov 2026 12:45:23 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v5 4/5] pinctrl: freescale: add the LX2160A RCW pad-mux
 driver
Message-ID: <avmbUyfeTd_VMSYH@L30177.local>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v5-0-d246166ea469@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v5-4-d246166ea469@free.fr>
 <avmX2HwOji6MBuhj@skbuf>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avmX2HwOji6MBuhj@skbuf>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vladimir,

> Did you see my feedback on this patch for v4? Comments?
> https://lore.kernel.org/lkml/avjaK3cOj3iQ6G6w@skbuf/

No !, for some reasons, I did miss it..., thanks.

I can prepare a new serie to make it a bit more generic,
but I'd need NXP/your reviews for those CPUs, since I
cannot test.

It seems to be quite easy to update, I'll just
run some basic checks.

best regards,
  Vincent

