Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA56EB64DC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jul 2023 20:47:23 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IeSTTdmT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2k7F6VXLz2xgw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jul 2023 06:47:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2k6811sMz2xgw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2023 06:46:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=le4ybvADpoYVkHD+wIYkLE44RuLGjbiyDDb/dPUwbJ8=; b=IeSTTdmTC0OYlvGidk/UM7TNvs
	g/ksr0YT5pvH452fhQsbd4LNcth/0gyQ4q2L3ZOd/+O1udHExOkymIG0IlCv5a1Amp0T6opzoRZo2
	y2yDDoVdYxrd0LPEIRc2MmTFf7wKtwdn6LVtWWNn1VRgodu/IYWKZZQDzqa3F1+yaKhlMi/t/c6xZ
	qa1SkD2pQxszgtX2hyX1oreUOyYAAn85eczfppFx72acjt+3DZKZc3EtV0Vaxa0zitS/Di5xt1Xw0
	kUB1X9ap4dAcRx6qdOyFsrYdIwngMLAnKQt6gpsOcIxBLqjIqkuAcHyo33h6BXPBG3yBEhC0eMcjr
	e+hkVbYg==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKPfz-007DXO-2O;
	Fri, 14 Jul 2023 20:46:07 +0000
Message-ID: <72cdbfa2-28f0-19e9-8601-d9611da9410e@infradead.org>
Date: Fri, 14 Jul 2023 13:46:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: Tree for Jul 13 (drivers/video/fbdev/ps3fb.c)
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230713123710.5d7d81e4@canb.auug.org.au>
 <ccc63065-2976-88ef-1211-731330bf2866@infradead.org>
In-Reply-To: <ccc63065-2976-88ef-1211-731330bf2866@infradead.org>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javierm@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thomas,

On 7/13/23 09:11, Randy Dunlap wrote:
> 
> 
> On 7/12/23 19:37, Stephen Rothwell wrote:
>> Hi all,
>>

I still see this build error on linux-next  20230714.

>> Changes since 20230712:
>>
> 
> on ppc64:
> 
> In file included from ../include/linux/device.h:15,
>                  from ../arch/powerpc/include/asm/io.h:22,
>                  from ../include/linux/io.h:13,
>                  from ../include/linux/irq.h:20,
>                  from ../arch/powerpc/include/asm/hardirq.h:6,
>                  from ../include/linux/hardirq.h:11,
>                  from ../include/linux/interrupt.h:11,
>                  from ../drivers/video/fbdev/ps3fb.c:25:
> ../drivers/video/fbdev/ps3fb.c: In function 'ps3fb_probe':
> ../drivers/video/fbdev/ps3fb.c:1172:40: error: 'struct fb_info' has no member named 'dev'
>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>       |                                        ^~
> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                                     ^~~~~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>       |         ^~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1172:61: error: 'struct fb_info' has no member named 'dev'
>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>       |                                                             ^~
> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                                     ^~~~~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>       |         ^~~~~~~~
> 
> 
> Full randconfig file is attached.

-- 
~Randy
