Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8F5ADDFAB
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 08:11:03 +1000 (EST)
Date: Tue, 12 May 2009 15:05:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 3/6] powerpc: add memory map support to Freescale
	RapidIO block
Message-Id: <20090512150552.a98dca64.akpm@linux-foundation.org>
In-Reply-To: <1242117363-14949-3-git-send-email-leoli@freescale.com>
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<1242117363-14949-2-git-send-email-leoli@freescale.com>
	<1242117363-14949-3-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: zw@zh-kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, leoli@freescale.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 12 May 2009 16:36:00 +0800
Li Yang <leoli@freescale.com> wrote:

> +	align = (size < 0x1000) ? 0x1000 : 1 << (__ilog2(size - 1) + 1);
> +
> +	/* Align the size */
> +	if ((lstart + size) > (_ALIGN_DOWN(lstart, align) + align)) {

__ilog2() and _ALIGN_DOWN() are powerpc-specific functions.  It would
be preferable to use more general helpers if possible.  ALIGN() and ilog2()
might suit here.
