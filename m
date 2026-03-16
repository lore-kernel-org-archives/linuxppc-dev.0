Return-Path: <linuxppc-dev+bounces-18218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F9CF013D4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 08:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ7mQ1D9Rz2xln;
	Mon, 16 Mar 2026 19:39:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773650342;
	cv=none; b=XVusTEnLlhh9k+ZWJ7KAGKfifgmRpg90N35/Dajvb5aSLvgfMaS3OkhLFhf5C1NfT4uC6dadxVkHJQy88ZlrvXxZ2mA2KMYVCKGAvrsMAPj2xME1MrqZd8tU0rcBqDgaAvTDr91GW9lOXp9IH4wpcik4lzbcrG0K8+Hlldue3QyYjflmdv4J028IstMcGBe8EJtGJsp9kDMcrcROZ1RachtQZTSB+NkoLnqGADjdbkzsAqmFC2xhwYYHOvXNMfkf5TcR+ilcQwXc28X1GsHSI6dxCSQ8GdRXmI5++CBJHeOfDx52bpSy05fvlUKNw2aDflkCNX/NqKbDP/xA5VidMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773650342; c=relaxed/relaxed;
	bh=V96CIUlR+qKpqcsbJ7QQgPxxBdQqkfPBggaGNnMwS4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrtuxetL0HlOCNNgHtA8GyC1UrMLDhS6gFgq9s5p2sFLWDu548/mYGDGyhUWmJum0vPS6J2uU8hRj8pVdcbwC0zXawXbRCkINnkZsVaVDNuAPMzjAU58zPMdNyTp2yJ0HdVDf5A8QqcGHfGWGQblV2V2DH628Ox7beLqJyCK5YDCQg9R5rk2+Hchpu6u+zN/qiYFaP/Fi/kxa/GL3kbl8x4L/wBSxT4KvyXWHO+2KZnJ5Atlyqni0aSrfjQxtMP8nN5rLH9ezOFj1/cXkxPzrzYAXyzKCcIQIqWL3wnV+Q3P2Rmm42MCH7485JZZ4HdQmHvCoE544JBfF+BAurTX8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=hjpgeXH2; dkim-atps=neutral; spf=pass (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=sang-engineering.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=hjpgeXH2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sang-engineering.com (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org)
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ7mK1v7Yz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 19:38:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=V96C
	IUlR+qKpqcsbJ7QQgPxxBdQqkfPBggaGNnMwS4w=; b=hjpgeXH2qeJdxe0TDWI9
	5itL1/4hc9D2a+V4RZhgtiB9CWGMEHN9LA7J+EoA5+baPk8u931NSMNhU3DZPRRC
	rg8V5cjBbEgBgcQOcA3YNSZNVKzGPZo6C0ytU1lBlga9C8r6ycobgEnybDjcv8iO
	Xtf7m2JOUC+hCz4oY/iSrfpDW9ZNvwSYJkuYIAMpHSA+XVdAGOPpaOI6acGak1m7
	n63NcrXCvaq/G6tI70iIXARunUvgyhZDU68XVEoZnxCwcOrK3ebrjkSYHylQmRla
	g2f5ZxyWE3AcVqSgCZlMP4v75LsEkLRwnStHk4T0oN8cDzzPYkhkeMgGudo3Aj3C
	Hw==
Received: (qmail 1334043 invoked from network); 16 Mar 2026 09:38:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Mar 2026 09:38:48 +0100
X-UD-Smtp-Session: l3s3148p1@+MK+JSBNsKQ+XdJ7
Date: Mon, 16 Mar 2026 09:38:42 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Khalil Blaiech <kblaiech@nvidia.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 01/13] media: saa7134: rename i2c_dbg() to
 saa7134_i2c_dbg()
Message-ID: <abfBkg8YpDKIlOVu@shikoro>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <20260223-i2c-printk-helpers-v2-1-13b2a97762af@oss.qualcomm.com>
 <76fd11b2-7789-47c1-a832-12907155ead1@kernel.org>
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
In-Reply-To: <76fd11b2-7789-47c1-a832-12907155ead1@kernel.org>

Hi Hans,

> Do you want to merge this through the i2c subsystem? Or do you want me to
> merge this patch through the media subsystem?

The rest of this series has been dropped in favor of a different
approach. I still think this single patch here is useful, so if you
could pick it up, that would make a potential future change easier.

Thanks and happy hacking,

   Wolfram


