Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Enable and fix -Wcast-qual warnings 
In-reply-to: <20080707001415.GD6267@yookeroo.seuss> 
References: <20080707001415.GD6267@yookeroo.seuss>
Date: Mon, 14 Jul 2008 14:01:21 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KITIX-0006ss-Be@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Enabling -Wcast-qual warnings in dtc shows up a number of places where
> we are incorrectly discarding a const qualification.  There are also
> some places where we are intentionally discarding the 'const', and we
> need an ugly cast through uintptr_t to suppress the warning.  However,
> most of these are pretty well isolated with the *_w() functions.  So
> in the interests of maximum safety with const qualifications, this
> patch enables the warnings and fixes the existing complaints.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Guess which follow-on patch didn't apply for the same reason?
Needed to look like this hand-modified hunk...

> Index: dtc/Makefile
> ===================================================================
> --- dtc.orig/Makefile	2008-07-04 16:54:38.000000000 +1000
> +++ dtc/Makefile	2008-07-04 16:54:38.000000000 +1000
> @@ -16,7 +16,7 @@
>  CONFIG_LOCALVERSION =
>  
>  CPPFLAGS = -I libfdt
> -CFLAGS = -Wall -g -Os -Wpointer-arith
> +CFLAGS = -Wall -g -Os -Wpointer-arith -Wcast-qual
>  
>  BISON = bison
>  LEX = flex

Applied.

jdl
