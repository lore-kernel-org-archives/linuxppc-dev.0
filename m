Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Address an assortment of portability problems 
In-reply-to: <20080626010349.GH308@yookeroo.seuss> 
References: <20080626010349.GH308@yookeroo.seuss>
Date: Mon, 14 Jul 2008 13:54:41 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KITC5-0006rG-EI@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Benno Rice <benno@jeamland.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I've recently worked with a FreeBSD developer, getting dtc and libfdt
> working on FreeBSD.  This showed up a number of portability problems
> in the dtc package which this patch addresses.  Changes are as
> follows:
> 
> 	- the parent_offset and supernode_atdepth_offset testcases
> used the glibc extension functions strchrnul() and strndupa().  Those
> are removed, using slightly longer coding with standard C functions
> instead.
> 
> 	- some other testcases had a #define _GNU_SOURCE for no
> particular reason.  This is removed.
> 
> 	- run_tests.sh has bash specific constructs removed, and the
> interpreter changed to /bin/sh.  This apparently now runs fine on
> FreeBSD's /bin/sh, and I've also tested it with both ash and dash.
> 
> 	- convert-dtsv0-lexer.l has some extra #includes added.  These
> must have been included indirectly with Linux and glibc, but aren't on
> FreeBSD.
> 
> 	- the endian handling functions in libfdt_env.h, based on
> endian.h and byteswap.h are replaced with some portable open-coded
> versions.  Unfortunately, these result in fairly crappy code when
> compiled, but as far as I can determine there doesn't seem to be any
> POSIX, SUS or de facto standard way of determining endianness at
> compile time, nor standard names for byteswapping functions.
> 
> 	- some more endian handling, from testdata.h using the
> problematic endian.h is simply removed, since it wasn't actually being
> used anyway.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

This patch didn't apply directly.

The problem appeared to be the  mysterious and suspect "exit 99"
in the middle of the following context.  I whacked on the patch
directly by-hand, and managed to get it to apply.

Obligatory "Not using git" grumble.

Applied after all.

jdl


> Index: dtc/tests/run_tests.sh
> ===================================================================
> --- dtc.orig/tests/run_tests.sh	2008-06-26 10:40:59.000000000 +1000
> +++ dtc/tests/run_tests.sh	2008-06-26 10:43:21.000000000 +1000

> @@ -15,19 +15,19 @@
>  tot_strange=0
>  
>  base_run_test() {
> -    tot_tests=$[tot_tests + 1]
> +    tot_tests=$((tot_tests + 1))
>      if VALGRIND="$VALGRIND" "$@"; then
> -	tot_pass=$[tot_pass + 1]
> +	tot_pass=$((tot_pass + 1))
>      else
>  	ret="$?"
>  	if [ "$ret" == "1" ]; then
> -	    tot_config=$[tot_config + 1]
> +	    tot_config=$((tot_config + 1))
>  	elif [ "$ret" == "2" ]; then
> -	    tot_fail=$[tot_fail + 1]
> +	    tot_fail=$((tot_fail + 1))
>  	elif [ "$ret" == "$VGCODE" ]; then
> -	    tot_vg=$[tot_vg + 1]
> +	    tot_vg=$((tot_vg + 1))
>  	else
> -	    tot_strange=$[tot_strange + 1]
> +	    tot_strange=$((tot_strange + 1))
>  	fi
>	exit 99
>      fi
