Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Increase namespace-pollution paranoia 
In-reply-to: <20080709041024.GB29648@yookeroo.seuss> 
References: <20080709041024.GB29648@yookeroo.seuss>
Date: Mon, 14 Jul 2008 14:02:12 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KITJM-0006tO-MR@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> libfdt is supposed to easy to embed in projects all and sundry.
> Often, it won't be practical to separate the embedded libfdt's
> namespace from that of the surrounding project.  Which means there can
> be namespace conflicts between even libfdt's internal/static functions
> and functions or macros coming from the surrounding project's headers
> via libfdt_env.h.
> 
> This patch, therefore, renames a bunch of libfdt internal functions
> and macros and makes a few other chances to reduce the chances of
> namespace collisions with embedding projects.  Specifically:
> 	- Internal functions (even static ones) are now named _fdt_*()
> 
> 	- The type and (static) global for the error table in
>           fdt_strerror() gain an fdt_ prefix
> 
> 	- The unused macro PALIGN is removed
> 
> 	- The memeq and streq macros are removed and open-coded in the
>           users (they were only used once each)
> 
> 	- Other macros gain an FDT_ prefix
> 
> 	- To save some of the bulk from the previous change, an
>           FDT_TAGALIGN() macro is introduced, where FDT_TAGALIGN(x) ==
>           FDT_ALIGN(x, FDT_TAGSIZE)
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
