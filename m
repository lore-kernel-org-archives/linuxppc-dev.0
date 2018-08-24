Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xdkM3y0SzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 21:06:03 +1000 (AEST)
Date: Fri, 24 Aug 2018 06:05:48 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drivers/video/fbdev: use ioremap_wc() instead of
 __ioremap(_PAGE_NO_CACHE)
Message-ID: <20180824110548.GV24439@gate.crashing.org>
References: <0fe514f6e105a2c7f773679a14fce80216594a9b.1535103285.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0fe514f6e105a2c7f773679a14fce80216594a9b.1535103285.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2018 at 10:16:22AM +0000, Christophe Leroy wrote:
> _PAGE_NO_CACHE is a target specific flag. Prefer generic functions.

>  #ifdef CONFIG_PPC
> -	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
> +	p->screen_base = ioremap_wc(addr, 0x200000);
>  #else

But that is not the same.  I think you want ioremap_nocache?


Segher
