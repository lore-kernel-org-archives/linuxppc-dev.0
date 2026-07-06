Return-Path: <linuxppc-dev+bounces-23635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1EAC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 14:40:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv6TT2gJXz3bby;
	Tue, 07 Jul 2026 00:40:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783348813;
	cv=none; b=jYI/2JeqnhH5tK5DsoG0//WjTEbgxWtv1RdV0f213YvfAcJk/yuwWiXi5ZGQlLu69C43SMqTUbyLPQMqjKkH3zBko//dOLrkSdVHPhGRcXkiHrboN9R9DIzccJIMwei5LA5IYI8TWs7HM6wHLaF8J2JCYFsrZObexznM9tHZ1IBydbd1nYW1k/rGincG57mOlovTpbSGAvnP1STDQay4lMZXAFWb4/BGwzGIdaJNrvigLrqLqkpL+NhKVUTgAcfwvMOJBD/P0DIi7PdhXMrVwegcaxuXBGmFYPUbjGA8GIYfmVUyT/WTMSdFBZ+IDguBJ+0/x+KzpB4E7cShhdLOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783348813; c=relaxed/relaxed;
	bh=PTWGfLdwlWAV/LMkx8q6n+16+BLtwX+Uw6eFuSY1pwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZSRn35gTBYzJ8A1K/ljsB6ntJnrkheLeViq7C+06+h4eFollyxT0qS0ad7HTqj09bZg/l0NHmwNgp7ivOpqU/VK9ZcFrXLc27/Jnc3PzSeFISrSl3rG7agQs6vToV9IHn9ZCFyo5ZazzUxrMjmPiiOnSSGF1aRgSthN224KeLM89mBNOuwIJitkEOPFAiwvpDPPWrG6Le9S/P4agb+QsMNl+hi0BAGk1J9/srDB/V4s3nXBntQTXc4rbZKLT4guMUNGQOIbeiYyRtDJW1oPwBg4DMK5nsN7e8C/AYiRvT5voFTuruV1r9uxWUwOTKCPWSBLD20XctgY1A48H5kOC3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass (client-ip=80.241.56.152; helo=mout-p-102.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=80.241.56.152; helo=mout-p-102.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv6TQ0t35z2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 00:40:07 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gv6TB3Q84zKv2g;
	Mon, 06 Jul 2026 16:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783348798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTWGfLdwlWAV/LMkx8q6n+16+BLtwX+Uw6eFuSY1pwE=;
	b=OIh2q5NoOb8/zfHzXHh6+EFxzLMaDkzPcbVgv5xkovZYR/4JA9SFzE0VU9VAm1rNRZLR0S
	AX9n6t6Qdg/BHwG8GIE0XsFgInmrRdJCk1rI7C64cKOlIyq4TCeFWdyPovr+dbaBZvE7Xw
	3Gt8jIfDUCNo/K6k+YRQVDybeevZzGh0XtuQ2zVUtN5hCMOWCq8qaO0uMb1bLR1G0foLqN
	KuGMynijGMoLzFJiCQ/pxQVYlrrpwux9nHY20wk2i5B2W/3iVCLsdvpCsubihHUwhDMw1G
	ARSB7sTYnBnOH85aXuiUq7w/RlmGL22TeStMe6dbMo/bP0D6ZZw0KkWwo9maXg==
Message-ID: <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
Subject: Re: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
From: Manuel Ebner <manuelebner@mailbox.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones	
 <lee@kernel.org>, Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Srinivas Kandagatla	 <srini@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul	 <vkoul@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	
 <dakr@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan	
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)"	 <chleroy@kernel.org>, Andi Shyti
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
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, 	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	mfd@lists.linux.dev
Date: Mon, 06 Jul 2026 16:39:00 +0200
In-Reply-To: <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
	 <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
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
X-MBO-RS-ID: dd8ce0f1dac3e9f612a
X-MBO-RS-META: 1q71yutefcf1nyjzwoom4gu47fi8rss3

Hi Bartosz,

On Mon, 2026-07-06 at 14:44 +0200, Bartosz Golaszewski wrote:
> Encapsulate the reference counting logic for OF nodes assigned to
> platform devices created with platform_device_alloc() in a helper
> function. Make the kerneldoc state that this is the proper interface for
> assigning OF nodes to dynamically allocated platform devices. This will
> allow us to switch to counting the references of the device's firmware
> nodes, not only the OF nodes.
>=20
> Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> =C2=A0drivers/base/platform.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 18 ++++++++++++++++++
> =C2=A0include/linux/platform_device.h |=C2=A0 4 ++++
> =C2=A02 files changed, 22 insertions(+)
>=20
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index fb9120b0bcfe0e7dd9dfc0d29b91e0ad40a01440..3188d5aba5f90622f821c6950=
49cacda030204fb
> 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device =
*pdev, const
> void *data,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(platform_device_add_data);
> =C2=A0
> +/**
> + * platform_device_set_of_node - assign an OF node to device
> + * @pdev: platform device to add the node for
> + * @np: new device node
> + *
> + * Assign an OF node to this platform device. Internally keep track of t=
he
> + * reference count. Devices created with platform_device_alloc() must us=
e this
> + * function instead of assigning the node manually.

I did some more pondering about this patch and concluded the right place
for a warning would be the lines been read right before or after assigning
a node manually.=20
I think this would be in platform_device_alloc() (as I suggested in v2).

BUT my knowledge in C isn't sound. So if it's good as is keep it. If it isn=
't
add or move the remark.

Either way Thanks and
 Reviewed-by Manuel Ebner.

---
Note:
I removed Mark Brown <broonie@opensource.wolfsonmicro.com> from recipients =
because:
=E2=80=9CRCPT TO <broonie@opensource.wolfsonmicro.com> failed:
<broonie@opensource.wolfsonmicro.com>: Recipient address rejected: Domain n=
ot found=E2=80=9D.


> + */
> +void platform_device_set_of_node(struct platform_device *pdev,
> +				 struct device_node *np)
> +{
> +	of_node_put(pdev->dev.of_node);
> +	pdev->dev.of_node =3D of_node_get(np);
> +	pdev->dev.fwnode =3D of_fwnode_handle(np);
> +}
> +EXPORT_SYMBOL_GPL(platform_device_set_of_node);
> +
> =C2=A0/**
> =C2=A0 * platform_device_add - add a platform device to device hierarchy
> =C2=A0 * @pdev: platform device we're adding
> diff --git a/include/linux/platform_device.h b/include/linux/platform_dev=
ice.h
> index 8c566f09d04efe420d85ffa046f92c44c6d08526..e9f7baceeb4c8269dbc0143c4=
d8fc9d73ba024ca
> 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -19,6 +19,8 @@
> =C2=A0struct irq_affinity;
> =C2=A0struct mfd_cell;
> =C2=A0struct property_entry;
> +struct platform_device_id;
> +struct device_node;
> =C2=A0
> =C2=A0struct platform_device {
> =C2=A0	const char	*name;
> @@ -262,6 +264,8 @@ extern int platform_device_add_resources(struct platf=
orm_device
> *pdev,
> =C2=A0					 unsigned int num);
> =C2=A0extern int platform_device_add_data(struct platform_device *pdev,
> =C2=A0				=C2=A0=C2=A0=C2=A0 const void *data, size_t size);
> +void platform_device_set_of_node(struct platform_device *pdev,
> +				 struct device_node *np);
> =C2=A0extern int platform_device_add(struct platform_device *pdev);
> =C2=A0extern void platform_device_del(struct platform_device *pdev);
> =C2=A0extern void platform_device_put(struct platform_device *pdev);

