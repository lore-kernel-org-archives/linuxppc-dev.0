Return-Path: <SRS0=q90n=DN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA829C41604
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2020 08:33:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADBC20789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2020 08:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ulBkd0T6";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctGZbV8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADBC20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C59hf29lpzDqJY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2020 19:33:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kroah.com (client-ip=66.111.4.28;
 helo=out4-smtp.messagingengine.com; envelope-from=greg@kroah.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256
 header.s=fm2 header.b=ulBkd0T6; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=ctGZbV8L; 
 dkim-atps=neutral
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C59fd22GkzDqDK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2020 19:31:14 +1100 (AEDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id B79D25C00A6;
 Tue,  6 Oct 2020 04:31:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 06 Oct 2020 04:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=A0uEjs8ek2TiwpBw4iCwjm/gIfz
 YDZHLIda4slMrPSM=; b=ulBkd0T64OyDJ/OlIOUECTmcUqo2QHTWX7zo5FVgevj
 wrhSV3KJyGFQN0rurHEgjDB1jDIOJWEndsq3R0Q6xTZqcN0NNy3qr8W+yjGcQuPe
 LEVJiDh7gyRmZme2hiyfPJbSx+AtHiZMZuK5yHhoYjckyg8k9jk4iqOXz8BROjdE
 pkBAr9MRm7ZaQMtIEcVPeyEgEGZ/vu8gPW66z45Mcom2iiUthNxoLe8y4pDTy74X
 TzmdCeReg+bS6u4iLJTCm7n5E0WuVeWzHYeXhNlcrMdcIlrSzALRkZzpisIy+iZ2
 AfJF9bh3P60/ZBRHF23v/87mjJPytWGEOEDzcd1gC7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=A0uEjs
 8ek2TiwpBw4iCwjm/gIfzYDZHLIda4slMrPSM=; b=ctGZbV8LA4l7ydxU6/Vd4t
 bSZmojZ9v8MxvAqwbNzuNIpgLNfj9gYOb65xpGNf2LtBturD60mTYD7g5CdofTxH
 aGy5e8hvRGN2Cqmni9zJoW9PrP+v/ro5d5C8SMTe8SarC0CPuoFIePqosjbPHO/H
 hHs4gQ2LtBv0qXU+5522uVnXAs+bqgEdwVv21rAT4eH3n1K4g0aoK3BkJ+heiT5Q
 Ao9UnetDwnlADXCkelL87ORieofkIpWVGHLxr+2ewyZQNQChYdhigSqMJ5hUBc//
 9ZnUf5oMJ3a0eCcKqoTA9oBJXaYxrkZakQSbCS52IPgAWeexw8PHyMj+T8HzK23Q
 ==
X-ME-Sender: <xms:Tyt8X4enpkdT1-Uq0nPdeRM0MEBeV_zbl4CxeCTqSQZutMjM9-65gg>
 <xme:Tyt8X6O64gafeyQIPC7qgL4bhEfVi8CAJGqJcB64Hg0oDLNgNoKvq2w0MfjyNHCmU
 Iz4cbyKabV4VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeeggddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
 jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
 ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
 keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Tyt8X5hB3AHUz3lh9Bbc_QDl7NF4Qz2Q5EJU3zMDB80iTQAOrxYN6w>
 <xmx:Tyt8X9_puTqns5Mc0kWxLrF6ER9VRBzJp_ip2ZXCwF6h9ddl-Rs4Kg>
 <xmx:Tyt8X0uyHkGAGsu0iglT9wyzU25hqu88wZj0xuCTmXvUbHICDA5dYw>
 <xmx:UCt8X-Vk-jVakxAcWO4_F78H2lr3HXf7BDUqK3uBUv7UJGDq-aUf5Q>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9FB5F3064684;
 Tue,  6 Oct 2020 04:31:11 -0400 (EDT)
Date: Tue, 6 Oct 2020 10:21:30 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the char-misc tree with the powerpc
 tree
Message-ID: <20201006082130.GB12331@kroah.com>
References: <20201006183506.186a3562@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006183506.186a3562@canb.auug.org.au>
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Necip Fazil Yildiran <fazilyildiran@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 06, 2020 at 06:35:06PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/misc/ocxl/Kconfig
> 
> between commit:
> 
>   dde6f18a8779 ("ocxl: Don't return trigger page when allocating an interrupt")
> 
> from the powerpc tree and commit:
> 
>   4b53a3c72116 ("ocxl: fix kconfig dependency warning for OCXL")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/misc/ocxl/Kconfig
> index 0d815b2a40b3,947294f6d7f4..000000000000
> --- a/drivers/misc/ocxl/Kconfig
> +++ b/drivers/misc/ocxl/Kconfig
> @@@ -9,9 -9,8 +9,9 @@@ config OCXL_BAS
>   
>   config OCXL
>   	tristate "OpenCAPI coherent accelerator support"
>  -	depends on PPC_POWERNV && PCI && EEH && HOTPLUG_PCI_POWERNV
>  +	depends on PPC_POWERNV && PCI && EEH && PPC_XIVE_NATIVE
> ++	depends on HOTPLUG_PCI_POWERNV
>   	select OCXL_BASE
> - 	select HOTPLUG_PCI_POWERNV
>   	default m
>   	help
>   	  Select this option to enable the ocxl driver for Open

Looks good, thanks!

greg k-h
