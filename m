Return-Path: <SRS0=xfkn=QI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEA5C282D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 08:37:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5104E20869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 08:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ddQtbKnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5104E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rVpZ4QgnzDqjM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 19:37:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+eb6389230dcc0ed0984a+5640+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="ddQtbKnN"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rVmb2GQBzDqfN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 19:35:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ikQmwCOudLvuAUASG4XFzhMNNaczJkM8u308x81NbX4=; b=ddQtbKnNliZGFyxl5G3Q2Mlle
 +Tf3hgkev9Wfrpjsvx6S1yP7BS8HGBqwLM9udCEoNd6veVybFNstPYQTLL1l9zSHXxABmsBJDJL80
 hLpdBY9SDU7+Iv4d1hd6x66NMA4EBNV+Qjo9b1xRCDML4PhBrsWZeoxv7b4eMQuTMjplgW0ZZow6Z
 o9uwPXkrIuRPuqLkkmmSNoResIoGjNy2oudGSTlMq2j6xw82tYJ0TqNQWn6s4AIUE6iEgjPczXlaZ
 QYBUb8Vny5/6dlkq1jr/CLA3bNywkcjrZZHG8OvAG6Nc4t8NDfVrddNbZURjZr+33TaFckKs9hEHU
 fmrTxtCaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gpUI8-0003p5-A7; Fri, 01 Feb 2019 08:35:16 +0000
Date: Fri, 1 Feb 2019 00:35:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc: drop page_is_ram() and walk_system_ram_range()
Message-ID: <20190201083516.GA21946@infradead.org>
References: <a2cf0c09e15a3f8806096df73e41fae0fa10d2bf.1548962883.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2cf0c09e15a3f8806096df73e41fae0fa10d2bf.1548962883.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 31, 2019 at 07:28:49PM +0000, Christophe Leroy wrote:
> Since commit c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
> it is possible to use the generic walk_system_ram_range() and
> the generic page_is_ram().
> 
> Fixes: c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Kconfig            |  3 ---
>  arch/powerpc/include/asm/page.h |  1 -
>  arch/powerpc/mm/mem.c           | 33 ---------------------------------
>  3 files changed, 37 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 0a26e0075ce5..0006ca6a7664 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -479,9 +479,6 @@ config ARCH_CPU_PROBE_RELEASE
>  config ARCH_ENABLE_MEMORY_HOTPLUG
>  	def_bool y
>  
> -config ARCH_HAS_WALK_MEMORY
> -	def_bool y

powerpc was the last architecture to define ARCH_HAS_WALK_MEMORY,
so the symbol can be removed now.
