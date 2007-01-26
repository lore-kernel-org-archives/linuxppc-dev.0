Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADA01DE0B7
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 14:14:48 +1100 (EST)
Date: Fri, 26 Jan 2007 04:14:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 8/9] ps3: cleanup ps3fb before clearing HPTE
Message-ID: <20070126031438.GH18537@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251851160.24610@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0701251851160.24610@pademelon.sonytel.be>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 06:51:50PM +0100, Geert Uytterhoeven wrote:
> PS3: Cleanup the frame buffer device before clearing the HPTE mapping
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/ps3/htab.c |    5 +++++
>  1 files changed, 5 insertions(+)
> 
> --- ps3-linux.orig/arch/powerpc/platforms/ps3/htab.c
> +++ ps3-linux/arch/powerpc/platforms/ps3/htab.c
> @@ -234,6 +234,11 @@ static void ps3_hpte_invalidate(unsigned
>  
>  static void ps3_hpte_clear(void)
>  {
> +	extern void ps3fb_cleanup(void);

Externs belong into headers.

> +
> +#ifdef CONFIG_FB_PS3
> +	ps3fb_cleanup();
> +#endif

And well, adding framebuffer calls into the mmu code is rather fucked.
This at least needs a big comment explaning the hypervisor braindamage
that is responsible for this in colourfull language.
