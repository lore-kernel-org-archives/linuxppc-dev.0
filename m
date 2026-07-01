Return-Path: <linuxppc-dev+bounces-23310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1426FC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 15:06:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr3J71THMz2yfH;
	Thu, 02 Jul 2026 01:06:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782918391;
	cv=none; b=TqfKK+OJ2UWVUfqzr5kJgLlCQC2TDnMYHluww1NsLNLRSEqVF7oO4nOH6g8xyuKzYw5eLTBl7AJmwCrT2ga3MvCf8ULa5JajFN4JPDhG8JGAAhd7GiXfhB72+xQvKoFs38sC2LVvFhu2AkUZtgQSbcWMmqKyveaETat5SULl3HbIxUycaPqtUumX4nXpz7h346KO2ZtWlS6dUcxWx56+QfLeTQUrJOCc2hSyKDwpI4IPsItJPofuGT/P0iAgzzU5+NFxDdvpOUbixaiFa5oix9FGtIXo340PRqFeuFmdkD9bdKsn1KGprjB/KRrG9/mI7qzziQ6E3iTzUit9/oLdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782918391; c=relaxed/relaxed;
	bh=7iK4BGNHJy0tB94tmLVRjvi1Oe1FniGBRLtTBxRpX9I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9oyMEUy6QJL49PRJtsuQh3jFI2hkoszLvwdMcuMizni6tx8vpuT673sK10wIEfRaRqW2kXtuh0eC5s+PLFsMttsrwFThdZkYAz3ZXWTmH/ylx1Ce+gK2zEUL0A49LyC+JmQc81psjQDcjFAkCSRimRSFr+Rz/EQs46kfZbHuT5dF50jCcZ1gOiTbmvHjC7jxH3iUlhgFG2msxG3YuJzM0QG1ID1jxWEXPl06LFIitQL9Rv5ixKtMUNovp5XoRfWmNlFSw+MHPxCYoZxJzr8Zg6BEUYvrfFvWnrq4n0/3qUMqKNmXwT31uHVM8HmIPvwTEWX5KVgzc4OTmo3tJp9Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pcd0PeJh; dkim-atps=neutral; spf=pass (client-ip=80.241.56.161; helo=mout-p-103.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pcd0PeJh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=80.241.56.161; helo=mout-p-103.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 98882 seconds by postgrey-1.37 at boromir; Thu, 02 Jul 2026 01:06:28 AEST
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr3J41T6Pz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 01:06:26 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gr3Hr4RPhz9ts8;
	Wed,  1 Jul 2026 17:06:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782918376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iK4BGNHJy0tB94tmLVRjvi1Oe1FniGBRLtTBxRpX9I=;
	b=pcd0PeJh7Iv8r/KVTFH5oFdA/lvvSyvuvKi3if55cztI2n/XSqmRdnZKteH85HKKVV85yU
	j9HVmz2EWbdR6s0CcET0z1vhIRn4hJ25bjWnCJwEuRpc0w/NW+iGM63mTUN/npapcFcSR/
	fvTXXtkA/gTpkwn7ezESk2MSMTKfcqmvoICSsIiJierSEvXB9xwtVzbElgLSVNcJv+Ritx
	B8K9i27AJIekT+XY6QmKpjCphMf9LuJwlimFmayP7Cy6geBGJUxhP+KSpU8c/IrGtSWTsI
	iKUJjdFVYMmR+verObzbMA+hWZMieIpK2Ln1S3xxLh3nAIF0DvnMe971s5Fifw==
Message-ID: <f6ce9878f3528dd026e6ca8ff56ac773a264e476.camel@mailbox.org>
Subject: Re: [PATCH v2 02/19] driver core: platform: provide
 platform_device_set_of_node()
From: Manuel Ebner <manuelebner@mailbox.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, 	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones
 <lee@kernel.org>, Thierry Reding	 <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth	 <sebastian.hesselbarth@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Srinivas Kandagatla <srini@kernel.org>, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Rob Herring <robh@kernel.org>,  Saravana Kannan
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Andy Shevchenko	
 <andriy.shevchenko@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Doug Berger
 <opendmb@gmail.com>,  Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team	 <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Matthew Brost	 <matthew.brost@intel.com>, Thomas
 =?ISO-8859-1?Q?Hellstr=F6m?=	 <thomas.hellstrom@linux.intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>,  Paul
 Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, Philipp Zabel
 <p.zabel@pengutronix.de>,  Maximilian Luz <luzmaximilian@gmail.com>, Hans
 de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 01 Jul 2026 17:05:49 +0200
In-Reply-To: <CAMRc=MdQURjypSn+QjSDJfEiOMC8bbEZmZLgjpt=EquAM1Q1pw@mail.gmail.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
		 <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com>
	 <263f58b418a27a2339fc2478f93234e0208b0ad9.camel@mailbox.org>
	 <CAMRc=MdQURjypSn+QjSDJfEiOMC8bbEZmZLgjpt=EquAM1Q1pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-MBO-RS-META: 37tty84b1zxogwptawjudbroswqcnaqn
X-MBO-RS-ID: 303d5cb0e0c41c6b372

On Tue, 2026-06-30 at 09:22 -0400, Bartosz Golaszewski wrote:
> On Tue, 30 Jun 2026 13:37:54 +0200, Manuel Ebner <manuelebner@mailbox.org=
> said:
> > On Mon, 2026-06-29 at 11:12 +0200, Bartosz Golaszewski wrote:
> > > [...]
> > >=20
> > > +/**
> > > + * platform_device_set_of_node - assign an OF node to device
> > > + * @pdev: platform device to add the node for
> > > + * @np: new device node
> > > + *
> > > + * Assign an OF node to this platform device. Internally keep track =
of the
> > > + * reference count. Devices created with platform_device_alloc() mus=
t use this
> > > + * function instead of assigning the node manually.
> >=20
> > Doesn't it make sense to add a remark to the kernel doc of platform_dev=
ice_alloc()?
> >=20
> > Thanks
> > =C2=A0Manuel
> >=20
> > > =C2=A0[...]
> >=20
>=20
> Sure, will do in the next iteration.

then you can add
Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>

 Manuel
>=20
> Bart

