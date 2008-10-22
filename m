Return-Path: <nyet@mrv.com>
Received: from chmailsrv.int.mrv.com (ns1.mrv.com [66.43.110.3])
	by ozlabs.org (Postfix) with ESMTP id 9E82CDDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Oct 2008 08:36:41 +1100 (EST)
Date: Wed, 22 Oct 2008 14:24:34 -0700
From: Nye Liu <nyet@mrv.com>
To: crossgcc@sourceware.org
Subject: Re: powerpc 860 and glibc sysdeps/powerpc/power3/memset.S: CPU15
	"dcbX"  errata
Message-ID: <20081022212434.GA18508@mrv.com>
References: <48FD7C30.1010505@mrv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48FD7C30.1010505@mrv.com>
Cc: "Nye Liu \(nyet.org\)" <nyet@nyet.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 20, 2008 at 11:52:32PM -0700, nyet wrote:
> I am working on a powerpc 860 toolchain, but I am having problems  
> convincing glibc to not emit code that uses the dcbz instruction (CPU15  
> dcbX bug). The source of the problem is sysdeps/powerpc/power3/memset.S
>
> in crosstool, we had something like this:
>
> Index: crosstool.sh
> ===================================================================
> --- crosstool.sh	(.../vendor/crosstool/current)	(revision 6652)
> +++ crosstool.sh	(.../trunk/tools/crosstool)	(revision 6652)
> @@ -529,6 +529,11 @@
> 	export libc_cv_forced_unwind libc_cv_c_cleanup
>     fi
>
> +    case ${TARGET} in
> +       # remove inline asm powerpc memset, which is broken for 8xx
> +        powerpc-8* ) rm -f ${GLIBC_DIR}/sysdeps/powerpc/powerpc32/memset.S ;;
> +    esac
> +
>     BUILD_CC=gcc CFLAGS="$TARGET_CFLAGS $EXTRA_TARGET_CFLAGS" CC="${TARGET}-gcc $GLIBC_EXTRA_CC_ARGS" \
>     AR=${TARGET}-ar RANLIB=${TARGET}-ranlib \
>         ${GLIBC_DIR}/configure --prefix=/usr \
>
> but i dont know what the proper place is to put the equivalent in crosstool-ng
>
> see also my crosstool patch here
>
> http://sourceware.org/ml/crossgcc/2006-12/msg00057.html
>
> and a discussion of the CPU15 errata here
>
> http://mlblog.osdir.com/linux.ports.ppc.embedded/2005-04/index.shtml
>
> It is worth noting that according to freescale, dcbi, dcibst, dcbf, and  
> icbi are similarly affected, whch means  
> sysdeps/powerpc/powerpc32/dl-machine.c might also cause problems, since  
> it uses dcbst and icbi.
>
> the glibc maintainers seem aware of the problem, but don't seem to think  
> anybody uses glibc with the 860 series. wolfgang denk is also apparently  
> doing his own workarounds for the toolchains he builds for eldk.
>

This is what i ended up with. I have no idea if there is a better way;
I'd rather fix this up in a glibc patch but the way sysdeps works is
beyond my knowledge.

Index: scripts/build/libc/glibc.sh
===================================================================
--- scripts/build/libc/glibc.sh	(revision 1113)
+++ scripts/build/libc/glibc.sh	(working copy)
@@ -386,6 +386,15 @@
         echo libc_cv_c_cleanup=yes
     fi >config.cache
 
+    case ${CT_TARGET} in
+	# Remove inline asm powerpc memset, which is broken for FreeScale 8xx
+	# (CPU15 errata)
+	# http://sourceware.org/ml/crossgcc/2006-12/msg00057.html
+	# http://mlblog.osdir.com/linux.ports.ppc.embedded/2005-04/index.shtml
+	# http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016351.html
+        powerpc-8* ) rm -f ${CT_SRC_DIR}/${CT_LIBC_FILE}/sysdeps/powerpc/powerpc32/memset.S ;;
+    esac
+
     # Configure with --prefix the way we want it on the target...
     # There are a whole lot of settings here.  You'll probably want
     # to read up on what they all mean, and customize a bit, possibly by setting GLIBC_EXTRA_CONFIG

-- 
Nye Liu
nliu@mrv.com
(818) 772-6235x248
(818) 772-0576 fax

"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote
