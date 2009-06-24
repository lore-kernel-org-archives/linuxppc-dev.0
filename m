Return-Path: <akirat@rd.scei.sony.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1BD76B707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 15:35:02 +1000 (EST)
Received: from ms4.sony.co.jp (ms4.sony.co.jp [211.125.136.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E29BDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 15:35:01 +1000 (EST)
Received: from mta7.sony.co.jp (mta7.Sony.CO.JP [137.153.71.12])
	by ms4.sony.co.jp (R8/Sony) with ESMTP id n5O5Yvh3017531
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 14:34:57 +0900 (JST)
Received: from mta7.sony.co.jp (localhost [127.0.0.1])
	by mta7.sony.co.jp (R8/Sony) with ESMTP id n5O5YvB8018788
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 14:34:57 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mta7.sony.co.jp (R8/Sony) with SMTP id n5O5YvP5018784
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 14:34:57 +0900 (JST)
Date: Wed, 24 Jun 2009 14:34:37 +0900
From: Akira Tsukamoto <akirat@rd.scei.sony.co.jp>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mpic: Fix mapping of "DCR" based MPIC variants
In-Reply-To: <20090623024807.170CADDD1C@ozlabs.org>
References: <20090623024807.170CADDD1C@ozlabs.org>
Message-Id: <20090624143143.408E.4D252088@rd.scei.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Benjamin,

On Tue, 23 Jun 2009 12:47:59 +1000, 
Benjamin Herrenschmidt <benh@kernel.crashing.org> mentioned: 
> Commit 31207dab7d2e63795eb15823947bd2f7025b08e2
> "Fix incorrect allocation of interrupt rev-map"
> introduced a regression crashing on boot on machines using
> a "DCR" based MPIC, such as the Cell blades.
> 
> The reason is that the irq host data structure is initialized
> much later as a result of that patch, causing our calls to
> mpic_map() do be done before we have a host setup.
> 
> Unfortunately, this breaks _mpic_map_dcr() which uses the
> mpic->irqhost to get to the device node.
> 
> This fixes it by, instead, passing the device node explicitely
> to mpic_map().
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
>  arch/powerpc/sysdev/mpic.c |   29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

I confirmed that the boot failure on IBM Cell Blades QS21/22 are fixed 
with this patch.

Acked-by: Akira Tsukamoto <akirat@rd.scei.sony.co.jp>

-- 
Akira Tsukamoto
Sony Computer Entertainment Inc. 
Architecture Lab.
Japan
