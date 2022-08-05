Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50017C25B06
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Aug 2022 00:26:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LzRGm1yJYz3bcZ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Aug 2022 10:26:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LzRGD6Z5xz2xrR
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2022 10:25:55 +1000 (AEST)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2750JNpl009247;
	Thu, 4 Aug 2022 19:19:24 -0500
Message-ID: <4715518d0a6ec60349c76414815ae3f6e4ed977e.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 10/10] drm/ofdrm: Support color management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        paulus@samba.org, geert@linux-m68k.org, mark.cave-ayland@ilande.co.uk
Date: Fri, 05 Aug 2022 10:19:22 +1000
In-Reply-To: <20220720142732.32041-11-tzimmermann@suse.de>
References: <20220720142732.32041-1-tzimmermann@suse.de>
	 <20220720142732.32041-11-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2022-07-20 at 16:27 +0200, Thomas Zimmermann wrote:
> +#if !defined(CONFIG_PPC)
> +static inline void out_8(void __iomem *addr, int val)
> +{ }
> +static inline void out_le32(void __iomem *addr, int val)
> +{ }
> +static inline unsigned int in_le32(const void __iomem *addr)
> +{
> +       return 0;
> +}
> +#endif

These guys could just be replaced with readb/writel/readl respectively
(beware of the argument swap).

Cheers,
Ben.

