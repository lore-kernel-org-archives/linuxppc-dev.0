Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3B0D1A024E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 04:20:42 +1000 (EST)
Message-ID: <1401387624.6603.161.camel@snotra.buserror.net>
Subject: Re: [PATCH] pcmcia: m8xx: remove checks for four macros
From: Scott Wood <scottwood@freescale.com>
To: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 29 May 2014 13:20:24 -0500
In-Reply-To: <1400916970.31526.78.camel@x220>
References: <1400916970.31526.78.camel@x220>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-pcmcia@lists.infradead.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-05-24 at 09:36 +0200, Paul Bolle wrote:
> This driver contains checks for four Kconfig macros. But the related
> Kconfig symbols have never been part of the tree. Remove these checks
> and the code they hide.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
> This has been an issue ever since this driver was added in v2.6.15. Note
> that there is no header named "*/cpld.h", so setting PRxK can't possibly
> work.
> 
>  drivers/pcmcia/m8xx_pcmcia.c | 75 --------------------------------------------
>  1 file changed, 75 deletions(-)

Does anything in this driver still work?  It looks like bitrot from the
arch/ppc days, that sort of got updated to use the device tree -- but
even after this patch there are lots of instances of CONFIG symbols
being used to assert the exact hardware being used, rather than what
hardware is supported.

Is anyone actively maintaining/testing this code?

-Sott
