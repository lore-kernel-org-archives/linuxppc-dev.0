Date: Sun, 16 Nov 2003 02:45:25 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031116014525.GA23307@suse.de>
References: <20031115210449.GA10105@suse.de> <16310.51046.819605.41542@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <16310.51046.819605.41542@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sun, Nov 16, Paul Mackerras wrote:

> Olaf,
>
> > 	lswi 9,31,8
> > 	stswi 9,28,8
> >
> > s = r31. How can gcc be sure that s aligned?
>
> What machine is this?  I looked at the manuals for 750, 7450, POWER4
> and they all handle unaligned string ops in hardware.  The alignment
> handler doesn't handle string ops, I believe, although it could.  And
> which arch (ppc32 or ppc64)?

Its a 7200/90 with 601 cpu. And I'm afraid, the zlib.c needs also
tweaking. I think the gcc built-in memcpy is used in the bootloader.
Same issue, 'DEFAULT CATCH!, code=FFF00600' without this change (adds
also zlib debugging, but doesnt work for prepboot right now, if enabled).


--- ../linuxppc-2.5_2.6.0-test9-bk.orig/arch/ppc/boot/lib/zlib.c        2003-09-12 18:26:51.000000000 +0200
+++ arch/ppc/boot/lib/zlib.c    2003-11-16 02:43:22.000000000 +0100
@@ -1,3 +1,5 @@
+#define DEBUG_ZLIB 1
+#define verbose 1
 /*
  * This file is derived from various .h and .c files from the zlib-0.95
  * distribution by Jean-loup Gailly and Mark Adler, with some additions
@@ -85,11 +87,11 @@ extern char *z_errmsg[]; /* indexed by 1

 /* Diagnostic functions */
 #ifdef DEBUG_ZLIB
-#  include <stdio.h>
+#  include <nonstdio.h>
 #  ifndef verbose
 #    define verbose 0
 #  endif
-#  define Assert(cond,msg) {if(!(cond)) z_error(msg);}
+#  define Assert(cond,msg) {if(!(cond)) printf(msg);}
 #  define Trace(x) fprintf x
 #  define Tracev(x) {if (verbose) fprintf x ;}
 #  define Tracevv(x) {if (verbose>1) fprintf x ;}
@@ -884,7 +886,14 @@ local int inflate_blocks(
       t = s->sub.left;
       if (t > n) t = n;
       if (t > m) t = m;
+#if 0
       zmemcpy(q, p, t);
+#else
+      {
+       int i;
+       for(i=0;i <t;i++)q[i]=p[i];
+      }
+#endif
       p += t;  n -= t;
       q += t;  m -= t;
       if ((s->sub.left -= t) != 0)
@@ -1230,7 +1239,7 @@ local uInt cpdext[] = { /* Extra bits fo
 #define N_MAX 288       /* maximum number of codes in any set */

 #ifdef DEBUG_ZLIB
-  uInt inflate_hufts;
+  local uInt inflate_hufts;
 #endif

 local int huft_build(


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
