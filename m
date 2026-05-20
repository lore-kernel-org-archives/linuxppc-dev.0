Return-Path: <linuxppc-dev+bounces-21222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826BACD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 09:12:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL5Qh1Q74z2xqv;
	Wed, 20 May 2026 19:12:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779268332;
	cv=none; b=k0ttHKHAGrEAxaIbcBsyHFCrO96RwREIBZub4owFzWCJVuyDDgtEzcmOAiJEbMjDYasS+nwKrC0QKdV7QDTYLun9+F+lNrX0ejo2f9+7vSMw6DjVWoeOuuKfzjYyomeBHGGrJkfkV06VnE7DUYMFbilluOn7fTgBckFQSIuvkwcjBfIIAV29ujkZHg06EgqNmR7CahzELp6ry7A9RGTot07u43Yn9NbMlhauRfvRX3OcpvGjmpb1I3UZdxmgOMI6oxyIXhegIrDgzGhkb41G+GMdmcj3sZ0CH/M51obEEou9QkcnK2ehpdNkkn72Xd3LuOC9hXJww2TreXpFyqo0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779268332; c=relaxed/relaxed;
	bh=PtKcIqR+xSa7oD0RKobgU/8ywpJ/p3O+qtkosdenSf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkLRWY8yKtbYj8pmwXxGw3yA+B34ssrwUXKDMsPbEdLEBXwyNYPER9l8kAfoYkKVFFgATrHlXApApoDTFdYuBntkVi8IpdrYs5kuiLSVaXla32CNin1PLdsdBskoNl9Nad/AfKrRdY1mQkFKGxk1LtFOandv74rzSF/b8dm3lyM2mf/g8ga0P5komDn4sMCY+TvX4BDy9yFNzLxKD3vFLRpx9P+/MW4Y+ryfa3NEMA7zt4qBlzPI2TJUuDH5kVopM5takH9OdqM80XmI3zxBh2meCPOQ76hOd4RtZCoe8g2NoEd8YBHSE+OLcRpe5xLbQfFIZ5EILVDr/SktFv10bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 590 seconds by postgrey-1.37 at boromir; Wed, 20 May 2026 19:12:11 AEST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL5Qg3ks2z2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 19:12:11 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 26D90C85;
	Wed, 20 May 2026 11:02:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DAF866031598; Wed, 20 May 2026 11:02:12 +0200 (CEST)
Date: Wed, 20 May 2026 11:02:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Yury M." <yurypm@arista.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
Message-ID: <ag14lCLsYhyssY2v@wunner.de>
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
 <agwzHzF3bpPM6jcC@wunner.de>
 <3633b587-5782-4cfa-b967-997de86866bb@arista.com>
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
In-Reply-To: <3633b587-5782-4cfa-b967-997de86866bb@arista.com>

On Tue, May 19, 2026 at 05:05:20PM +0100, Yury M. wrote:
> [ 476.224325] pci 0000:46:00.1: AER: can't recover (no error_detected callback)
> [ 476.224333] pci 0000:46:00.2: AER: can't recover (no error_detected callback)
> [ 476.224335] pci 0000:46:00.3: AER: can't recover (no error_detected callback)
> [ 476.224338] pci 0000:46:00.4: AER: can't recover (no error_detected callback)
> [ 476.224371] pcieport 0000:06:07.0: AER: device recovery failed

One more thing, recovery is failing here because those four devices
on bus 46 are unbound.  I've got two patches under development to
allow error recovery for unbound devices.  You may want to try those
and see if error recovery succeeds:

https://github.com/l1k/linux/commits/aer_unbound

Thanks,

Lukas

