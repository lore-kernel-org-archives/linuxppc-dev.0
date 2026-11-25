Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70059606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZSS3Xjb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZ7wj3MH9z2yMP;
	Wed, 25 Nov 2026 16:47:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795585621;
	cv=none; b=bBQOrg4huv+pdfWOPcg+f/FpMWAOnC8Z72hNDzm28Me8ow3FwoMZeNcVZyXL5B10S29EAY2BDiRHPEOgHKjAaTR6LXKRRi5380aR5jr1gyZAoEqzg0E/fSPtdUhYisdv2gZr7ZzH9IHjBcnAudWaAzGApF1jdJuZ/wpawORGIWPn8dHHv+H0+LXFvmTiy9xLRh4mFoYYJS53BiI96KVlrD1e1wuFeQbNDrZqFnYrHmjGH7zSv1ogTbkbF2KD52JS99AUH1zmAb3mIHnQDsy9AJgCSJ0ESOcx8SQug7LGGGtgV3pPOJYcSsxg2sFDTbMDDSYzsK+tVDn/7fDNHgsUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795585621; c=relaxed/relaxed;
	bh=NZvMNl2rNVFYgW+nN3Oiao9vOrIiaQuXf3slC6NOLHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyiUupJeWjdZyfeANOEHyOV8eOtOXNBqQenOsbIOjOsSEg79RHhRiZ8OW1VRnJRrn3Sbxoxj0L7FGBlp//NIceV0g65++0nl37/daopd86UjTatjlF7SBC37vcZISIZKNp78S+b+L4BL5EvKdm0QXuuKtcZp4VWs4Iceh+NcWDitEes+WRrWbEyDvI3fh1jRwXhbg/mquvnVpaq38LdxqaCpRnCMOdaKvTkNN0QR6eI3rac/ZPV6OVg4vquaZPFY13SJqa8lkSXlsXQctyX3+lHCcIezHxKrDk4bQ5BArtWltCTpKTr6il+sK2O/YOx5+97EzqYV6PJ1iVJe7NMmqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZSS3Xjb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tzungbi@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZSS3Xjb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tzungbi@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZ7wh5SLrz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 16:47:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E116612FE;
	Wed, 25 Nov 2026 05:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A44C1F000C0;
	Wed, 25 Nov 2026 05:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795585617;
	bh=NZvMNl2rNVFYgW+nN3Oiao9vOrIiaQuXf3slC6NOLHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZSS3XjbHJB70TEIMIH5E5DolRbuhiUDofhGwQDDGnX93idGLqQZZGdbFWY9kiojd
	 3RD6bhErUoAk01krQmpoCoLon20uuKYR1REPuvhYrtTx32WyEmfp/ouz/XYlf/k/3z
	 qcHQNRu4k3CWr7jazMBR02BZ88SwHGSZ+R7OHW6LNPLo1rBYIsGUj41qHu21kfcQ6M
	 Su71AKROPAUHYdDVxOrKLdccHe1untKHTQrmR1lqr2y7KY2t0XoeBK2vGy4xVe5aTg
	 vwX+muJOS2QQbseq7smY6qzMmD2MHvRRTLchrHy/QoCa/gcagnqX95jtwPikAkEMTg
	 QzTYZZotfiRKg==
Date: Wed, 25 Nov 2026 05:46:52 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] watchdog: max63xx_wdt: Add support for specifying
 WDI logic via GPIO
Message-ID: <awZ2TJRVus2R-ePn@google.com>
References: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
 <20261124050118.87944-3-pepe.schlehofer@gmail.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124050118.87944-3-pepe.schlehofer@gmail.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 06:01:17AM +0100, Josef Schlehofer wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> On some boards the WDI (watchdog input) pin of the chip is connected to
> a GPIO, and only the SET pins are mapped to the register.
> 
> Take the GPIO from the optional wdi-gpios property. When it is present,
> ping the watchdog through it instead of the register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> [pepe.schlehofer@gmail.com: use wdi-gpios, request the GPIO as an output
>  with devm_gpiod_get_optional(), ping without the lock, include
>  linux/delay.h, update the header comment]
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

The patch looks good to me,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

