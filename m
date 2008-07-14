Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Enable and fix -Wpointer-arith warnings 
In-reply-to: <20080707001048.GC6267@yookeroo.seuss> 
References: <20080707001048.GC6267@yookeroo.seuss>
Date: Mon, 14 Jul 2008 13:59:59 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KITHD-0006sd-Kq@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch turns on the -Wpointer-arith option in the dtc Makefile,
> and fixes the resulting warnings due to using (void *) in pointer
> arithmetic.  While convenient, pointer arithmetic on void * is not
> portable, so it's better that we avoid it, particularly in libfdt.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

This patch didn't apply.  I tracked it down to bad context
in the Makefile where this appeared:

>  CPPFLAGS += -std=c99 -D_XOPEN_SOURCE -D_BSD_SOURCE
>  CFLAGS += -Werror

but the file had this instead:

>  BISON = bison
>  LEX = flex

in this part:

> Index: dtc/Makefile
> ===================================================================
> --- dtc.orig/Makefile	2008-07-04 11:48:05.000000000 +1000
> +++ dtc/Makefile	2008-07-04 16:54:42.000000000 +1000
> @@ -16,7 +16,7 @@
>  CONFIG_LOCALVERSION =
>  
>  CPPFLAGS = -I libfdt
> -CFLAGS = -Wall -g -Os
> +CFLAGS = -Wall -g -Os -Wpointer-arith
>  
>  CPPFLAGS += -std=c99 -D_XOPEN_SOURCE -D_BSD_SOURCE
>  CFLAGS += -Werror

Again, I hand whacked-the patch mail and applied it.

For the love-of-Pete, please use git.

jdl
