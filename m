Return-Path: <linuxppc-dev+bounces-19327-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E022E6401A
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:02:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpWLQ1Yd6z2yjs;
	Sun, 05 Apr 2026 22:02:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775390574;
	cv=none; b=RZj/G41RXjw2g9+WHq81U0yk4/nH1MI2KldzjM8gxUKgLfaWBsIbmWooh5Ke3twFB2lcgk4SRtUDhG3tVBF25PJMa+Zvgt10FR4sjmoUnjK5RTpBNzNwGHLzHlCqHls4R6s041EAJtS6FL7AJxlyuKXsBday3UkWS/e8+ERLfLlvbPgKOu9AkEqQZZAJG/oOkrP8t1C3DTItj4F/uNdYuxX/z3ib9/0CmD1PD2eIlu+vAcx+iUrtBuTTLZhAltmg9TfbiB1cBQ+HSKMMK0OqsCw+LMRwLYk7mxzlnr0dNgp7jTiZLgtVPiUau6SJn9GZJ3AQzUzIhvU7YW5f58Cuig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775390574; c=relaxed/relaxed;
	bh=VwXIPBbp0EIzPNtpB2Kh8OUpJCymQVJw7CRWHLQnyH0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DCUlC3XlN9UQbsFvbqjZVHtuSgQNvQE30SXynPQY0ImTNraj+UUGMI+YSPOQQQTVH3WWOJFb9lDQdHUTqbZmBSiIU+CK+E2Il3lTErhig5SNmMo6Exqd6cO3kUUb4yEMMZVIjc/knHOlSmtpRI2AMbSeCY0+l2ardCiwoe1gE8/Yc/SoYu7qC0iTkvE4LLP73U+gjIaxJhI3jkldXVbnSiOlarAASlNv6z6A+pqxo0ALrwdjVD3utYE7OuevA2vBaeGsyngmnPYMJNbCGaqf2JoNsZPYA4M6fK8cX1QQJFyUC9C2fDGHdWVoF/lDkB98eTV9tCtL5cqZRRJBoHNDdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qQwwCeNj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qQwwCeNj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpWLP3T1cz2ySV;
	Sun, 05 Apr 2026 22:02:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E0569436C8;
	Sun,  5 Apr 2026 12:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E64C19424;
	Sun,  5 Apr 2026 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775390569;
	bh=VwXIPBbp0EIzPNtpB2Kh8OUpJCymQVJw7CRWHLQnyH0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qQwwCeNj+saJT57yAG47jboL8X78w4/j6WpBJ1RZ4sp8PWbMz7XsL9EDbWtj55Eiv
	 28aGEHxX84zqCSRKzt5WxDYhK2mKne18FSkXEYY++OZ6+IBYaBKFZkA86MS9bLh9Oc
	 BYyORiDakrz6RnLk4LVZHvUx8P1LQpa7pCp8fHnA1nA9F6ZvrAlepEALLMXhhTHNG5
	 7JaVWay0RJB3NcEhdmqtS8VF3DnUGPXm4QkCgawXIaUT/QfRxlFCiXeEIfDZt6r6xg
	 I3uj6fM0ROLbqxk5+qZJNhPISl9Q1iNQvp6vF94UFTOtVMPHy01bKsqbxAmGzThrrM
	 mtqWeRGNpMg3w==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 14:02:33 +0200
Message-Id: <DHL7FCNQ20PA.2K03T8MNSO9TT@kernel.org>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
Cc: "Douglas Anderson" <dianders@chromium.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>, "Saravana
 Kannan" <saravanak@kernel.org>, "Christoph Hellwig" <hch@lst.de>, "Eric
 Dumazet" <edumazet@google.com>, "Johan Hovold" <johan@kernel.org>, "Leon
 Romanovsky" <leon@kernel.org>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Alexey Kardashevskiy" <aik@ozlabs.ru>,
 "Robin Murphy" <robin.murphy@arm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <Frank.Li@kernel.org>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <alex@ghiti.fr>, <alexander.stein@ew.tq-group.com>,
 <andre.przywara@arm.com>, <andrew@codeconstruct.com.au>, <andrew@lunn.ch>,
 <andriy.shevchenko@linux.intel.com>, <aou@eecs.berkeley.edu>,
 <ardb@kernel.org>, <bhelgaas@google.com>, <brgl@kernel.org>,
 <broonie@kernel.org>, <catalin.marinas@arm.com>, <chleroy@kernel.org>,
 <davem@davemloft.net>, <david@kernel.org>, <devicetree@vger.kernel.org>,
 <dmaengine@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <gbatra@linux.ibm.com>, <gregory.clement@bootlin.com>,
 <hkallweit1@gmail.com>, <iommu@lists.linux.dev>, <jirislaby@kernel.org>,
 <joel@jms.id.au>, <joro@8bytes.org>, <kees@kernel.org>,
 <kevin.brodsky@arm.com>, <kuba@kernel.org>, <lenb@kernel.org>,
 <lgirdwood@gmail.com>, <linux-acpi@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mips@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-serial@vger.kernel.org>, <linux-snps-arc@lists.infradead.org>,
 <linux-usb@vger.kernel.org>, <linux@armlinux.org.uk>,
 <linuxppc-dev@lists.ozlabs.org>, <m.szyprowski@samsung.com>,
 <maddy@linux.ibm.com>, <mani@kernel.org>, <maz@kernel.org>,
 <miko.lenczewski@arm.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
 <npiggin@gmail.com>, <osalvador@suse.de>, <oupton@kernel.org>,
 <pabeni@redhat.com>, <palmer@dabbelt.com>, <peter.ujfalusi@gmail.com>,
 <peterz@infradead.org>, <pjw@kernel.org>, <robh@kernel.org>,
 <sebastian.hesselbarth@gmail.com>, <tglx@kernel.org>,
 <tsbogend@alpha.franken.de>, <vgupta@kernel.org>, <vkoul@kernel.org>,
 <will@kernel.org>, <willy@infradead.org>, <yangyicong@hisilicon.com>,
 <yeoreum.yun@arm.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260404000644.522677-1-dianders@chromium.org>
 <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>

On Sun Apr 5, 2026 at 7:27 AM CEST, Greg Kroah-Hartman wrote:
> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Sounds good, for the series:

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

