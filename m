Date: Sun, 16 Nov 2003 17:49:26 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031116164926.GA32276@suse.de>
References: <20031115210449.GA10105@suse.de> <16310.51046.819605.41542@cargo.ozlabs.ibm.com> <20031116014525.GA23307@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20031116014525.GA23307@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sun, Nov 16, Olaf Hering wrote:

>
>  On Sun, Nov 16, Paul Mackerras wrote:
>
> > Olaf,
> >
> > > 	lswi 9,31,8
> > > 	stswi 9,28,8
> > >
> > > s = r31. How can gcc be sure that s aligned?
> >
> > What machine is this?  I looked at the manuals for 750, 7450, POWER4
> > and they all handle unaligned string ops in hardware.  The alignment
> > handler doesn't handle string ops, I believe, although it could.  And
> > which arch (ppc32 or ppc64)?
>
> Its a 7200/90 with 601 cpu. And I'm afraid, the zlib.c needs also
> tweaking. I think the gcc built-in memcpy is used in the bootloader.
> Same issue, 'DEFAULT CATCH!, code=FFF00600' without this change (adds
> also zlib debugging, but doesnt work for prepboot right now, if enabled).

This patch allows zlib debugging, defines a dummy printf for prep,
prints all 4 bytes of a pointer in the coff bootloader.


diff -x bin -x ash -x klibc-0.81 -purNX /home/olaf/kernel/kernel_exclude.txt linuxppc-2.5_2.6.0-test9-bk.orig/arch/ppc/boot/common/misc-common.c linuxppc-2.5_2.6.0-test9-bk/arch/ppc/boot/common/misc-common.c
--- linuxppc-2.5_2.6.0-test9-bk.orig/arch/ppc/boot/common/misc-common.c	2003-09-12 19:39:38.000000000 +0200
+++ linuxppc-2.5_2.6.0-test9-bk/arch/ppc/boot/common/misc-common.c	2003-11-16 17:42:36.000000000 +0100
@@ -67,6 +67,8 @@ extern unsigned char serial_getc(unsigne
 extern void serial_putc(unsigned long com_port, unsigned char c);
 #endif

+int printf(const char *fmt, ...) { return 0; }
+
 void pause(void)
 {
 	puts("pause\n");
diff -x bin -x ash -x klibc-0.81 -purNX /home/olaf/kernel/kernel_exclude.txt linuxppc-2.5_2.6.0-test9-bk.orig/arch/ppc/boot/lib/zlib.c linuxppc-2.5_2.6.0-test9-bk/arch/ppc/boot/lib/zlib.c
--- linuxppc-2.5_2.6.0-test9-bk.orig/arch/ppc/boot/lib/zlib.c	2003-09-12 18:26:51.000000000 +0200
+++ linuxppc-2.5_2.6.0-test9-bk/arch/ppc/boot/lib/zlib.c	2003-11-16 17:35:40.000000000 +0100
@@ -1,3 +1,7 @@
+#if 0
+#define DEBUG_ZLIB 1
+#define verbose 1
+#endif
 /*
  * This file is derived from various .h and .c files from the zlib-0.95
  * distribution by Jean-loup Gailly and Mark Adler, with some additions
@@ -85,16 +89,16 @@ extern char *z_errmsg[]; /* indexed by 1

 /* Diagnostic functions */
 #ifdef DEBUG_ZLIB
-#  include <stdio.h>
+#  include <nonstdio.h>
 #  ifndef verbose
 #    define verbose 0
 #  endif
-#  define Assert(cond,msg) {if(!(cond)) z_error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
+#  define Assert(cond,msg) {if(!(cond)) printf(msg);}
+#  define Trace(x) printf x
+#  define Tracev(x) {if (verbose) printf x ;}
+#  define Tracevv(x) {if (verbose>1) printf x ;}
+#  define Tracec(c,x) {if (verbose && (c)) printf x ;}
+#  define Tracecv(c,x) {if (verbose>1 && (c)) printf x ;}
 #else
 #  define Assert(cond,msg)
 #  define Trace(x)
@@ -311,7 +315,7 @@ int inflateReset(
   z->msg = Z_NULL;
   z->state->mode = z->state->nowrap ? BLOCKS : METHOD;
   inflate_blocks_reset(z->state->blocks, z, &c);
-  Trace((stderr, "inflate: reset\n"));
+  Trace(("inflate: reset\n"));
   return Z_OK;
 }

@@ -328,7 +332,7 @@ int inflateEnd(
     inflate_blocks_free(z->state->blocks, z, &c);
   ZFREE(z, z->state, sizeof(struct internal_state));
   z->state = Z_NULL;
-  Trace((stderr, "inflate: end\n"));
+  Trace(("inflate: end\n"));
   return Z_OK;
 }

@@ -372,7 +376,7 @@ int inflateInit2(
     inflateEnd(z);
     return Z_MEM_ERROR;
   }
-  Trace((stderr, "inflate: allocated\n"));
+  Trace(("inflate: allocated\n"));

   /* reset state */
   inflateReset(z);
@@ -437,7 +441,7 @@ int inflate(
         z->state->sub.marker = 5;       /* can't try inflateSync */
         break;
       }
-      Trace((stderr, "inflate: zlib header ok\n"));
+      Trace(("inflate: zlib header ok\n"));
       z->state->mode = BLOCKS;
     case BLOCKS:
       r = inflate_blocks(z->state->blocks, z, r);
@@ -482,7 +486,7 @@ int inflate(
         z->state->sub.marker = 5;       /* can't try inflateSync */
         break;
       }
-      Trace((stderr, "inflate: zlib check ok\n"));
+      Trace(("inflate: zlib check ok\n"));
       z->state->mode = DONE;
     case DONE:
       return Z_STREAM_END;
@@ -766,7 +770,7 @@ local void inflate_blocks_reset(
   s->read = s->write = s->window;
   if (s->checkfn != Z_NULL)
     s->check = (*s->checkfn)(0L, Z_NULL, 0);
-  Trace((stderr, "inflate:   blocks reset\n"));
+  Trace(("inflate:   blocks reset\n"));
 }


@@ -789,7 +793,7 @@ local inflate_blocks_statef *inflate_blo
   s->end = s->window + w;
   s->checkfn = c;
   s->mode = TYPE;
-  Trace((stderr, "inflate:   blocks allocated\n"));
+  Trace(("inflate:   blocks allocated\n"));
   inflate_blocks_reset(s, z, &s->check);
   return s;
 }
@@ -822,7 +826,7 @@ local int inflate_blocks(
       switch (t >> 1)
       {
         case 0:                         /* stored */
-          Trace((stderr, "inflate:     stored block%s\n",
+          Trace(("inflate:     stored block%s\n",
                  s->last ? " (last)" : ""));
           DUMPBITS(3)
           t = k & 7;                    /* go to byte boundary */
@@ -830,7 +834,7 @@ local int inflate_blocks(
           s->mode = LENS;               /* get length of stored block */
           break;
         case 1:                         /* fixed */
-          Trace((stderr, "inflate:     fixed codes block%s\n",
+          Trace(("inflate:     fixed codes block%s\n",
                  s->last ? " (last)" : ""));
           {
             uInt bl, bd;
@@ -850,7 +854,7 @@ local int inflate_blocks(
           s->mode = CODES;
           break;
         case 2:                         /* dynamic */
-          Trace((stderr, "inflate:     dynamic codes block%s\n",
+          Trace(("inflate:     dynamic codes block%s\n",
                  s->last ? " (last)" : ""));
           DUMPBITS(3)
           s->mode = TABLE;
@@ -874,7 +878,7 @@ local int inflate_blocks(
       }
       s->sub.left = (uInt)b & 0xffff;
       b = k = 0;                      /* dump bits */
-      Tracev((stderr, "inflate:       stored length %u\n", s->sub.left));
+      Tracev(("inflate:       stored length %u\n", s->sub.left));
       s->mode = s->sub.left ? STORED : TYPE;
       break;
     case STORED:
@@ -884,12 +888,16 @@ local int inflate_blocks(
       t = s->sub.left;
       if (t > n) t = n;
       if (t > m) t = m;
+#if 0
       zmemcpy(q, p, t);
+#else
+      { int i; for(i=0;i <t;i++)q[i]=p[i]; }
+#endif
       p += t;  n -= t;
       q += t;  m -= t;
       if ((s->sub.left -= t) != 0)
         break;
-      Tracev((stderr, "inflate:       stored end, %lu total out\n",
+      Tracev(("inflate:       stored end, %lu total out\n",
               z->total_out + (q >= s->read ? q - s->read :
               (s->end - s->read) + (q - s->window))));
       s->mode = s->last ? DRY : TYPE;
@@ -917,7 +925,7 @@ local int inflate_blocks(
       s->sub.trees.nblens = t;
       DUMPBITS(14)
       s->sub.trees.index = 0;
-      Tracev((stderr, "inflate:       table sizes ok\n"));
+      Tracev(("inflate:       table sizes ok\n"));
       s->mode = BTREE;
     case BTREE:
       while (s->sub.trees.index < 4 + (s->sub.trees.table >> 10))
@@ -939,7 +947,7 @@ local int inflate_blocks(
         LEAVE
       }
       s->sub.trees.index = 0;
-      Tracev((stderr, "inflate:       bits tree ok\n"));
+      Tracev(("inflate:       bits tree ok\n"));
       s->mode = DTREE;
     case DTREE:
       while (t = s->sub.trees.table,
@@ -1002,7 +1010,7 @@ local int inflate_blocks(
           r = t;
           LEAVE
         }
-        Tracev((stderr, "inflate:       trees ok\n"));
+        Tracev(("inflate:       trees ok\n"));
         if ((c = inflate_codes_new(bl, bd, tl, td, z)) == Z_NULL)
         {
           inflate_trees_free(td, z);
@@ -1025,7 +1033,7 @@ local int inflate_blocks(
       inflate_trees_free(s->sub.decode.td, z);
       inflate_trees_free(s->sub.decode.tl, z);
       LOAD
-      Tracev((stderr, "inflate:       codes end, %lu total out\n",
+      Tracev(("inflate:       codes end, %lu total out\n",
               z->total_out + (q >= s->read ? q - s->read :
               (s->end - s->read) + (q - s->window))));
       if (!s->last)
@@ -1068,7 +1076,7 @@ local int inflate_blocks_free(
   inflate_blocks_reset(s, z, c);
   ZFREE(z, s->window, s->end - s->window);
   ZFREE(z, s, sizeof(struct inflate_blocks_state));
-  Trace((stderr, "inflate:   blocks freed\n"));
+  Trace(("inflate:   blocks freed\n"));
   return Z_OK;
 }

@@ -1230,7 +1238,7 @@ local uInt cpdext[] = { /* Extra bits fo
 #define N_MAX 288       /* maximum number of codes in any set */

 #ifdef DEBUG_ZLIB
-  uInt inflate_hufts;
+  local uInt inflate_hufts;
 #endif

 local int huft_build(
@@ -1687,7 +1695,7 @@ local inflate_codes_statef *inflate_code
     c->dbits = (Byte)bd;
     c->ltree = tl;
     c->dtree = td;
-    Tracev((stderr, "inflate:       codes new\n"));
+    Tracev(("inflate:       codes new\n"));
   }
   return c;
 }
@@ -1743,7 +1751,7 @@ local int inflate_codes(
       if (e == 0)               /* literal */
       {
         c->sub.lit = t->base;
-        Tracevv((stderr, t->base >= 0x20 && t->base < 0x7f ?
+        Tracevv((t->base >= 0x20 && t->base < 0x7f ?
                  "inflate:         literal '%c'\n" :
                  "inflate:         literal 0x%02x\n", t->base));
         c->mode = LIT;
@@ -1764,7 +1772,7 @@ local int inflate_codes(
       }
       if (e & 32)               /* end of block */
       {
-        Tracevv((stderr, "inflate:         end of block\n"));
+        Tracevv(("inflate:         end of block\n"));
         c->mode = WASH;
         break;
       }
@@ -1779,7 +1787,7 @@ local int inflate_codes(
       DUMPBITS(j)
       c->sub.code.need = c->dbits;
       c->sub.code.tree = c->dtree;
-      Tracevv((stderr, "inflate:         length %u\n", c->len));
+      Tracevv(("inflate:         length %u\n", c->len));
       c->mode = DIST;
     case DIST:          /* i: get distance next */
       j = c->sub.code.need;
@@ -1809,7 +1817,7 @@ local int inflate_codes(
       NEEDBITS(j)
       c->sub.copy.dist += (uInt)b & inflate_mask[j];
       DUMPBITS(j)
-      Tracevv((stderr, "inflate:         distance %u\n", c->sub.copy.dist));
+      Tracevv(("inflate:         distance %u\n", c->sub.copy.dist));
       c->mode = COPY;
     case COPY:          /* o: copying bytes in window, waiting for space */
 #ifndef __TURBOC__ /* Turbo C bug for following expression */
@@ -1860,7 +1868,7 @@ local void inflate_codes_free(
 )
 {
   ZFREE(z, c, sizeof(struct inflate_codes_state));
-  Tracev((stderr, "inflate:       codes free\n"));
+  Tracev(("inflate:       codes free\n"));
 }

 /*+++++*/
@@ -1995,7 +2003,7 @@ local int inflate_fast(
     if ((e = (t = tl + ((uInt)b & ml))->exop) == 0)
     {
       DUMPBITS(t->bits)
-      Tracevv((stderr, t->base >= 0x20 && t->base < 0x7f ?
+      Tracevv((t->base >= 0x20 && t->base < 0x7f ?
                 "inflate:         * literal '%c'\n" :
                 "inflate:         * literal 0x%02x\n", t->base));
       *q++ = (Byte)t->base;
@@ -2010,7 +2018,7 @@ local int inflate_fast(
         e &= 15;
         c = t->base + ((uInt)b & inflate_mask[e]);
         DUMPBITS(e)
-        Tracevv((stderr, "inflate:         * length %u\n", c));
+        Tracevv(("inflate:         * length %u\n", c));

         /* decode distance base of block to copy */
         GRABBITS(15);           /* max bits for distance code */
@@ -2024,7 +2032,7 @@ local int inflate_fast(
             GRABBITS(e)         /* get extra bits (up to 13) */
             d = t->base + ((uInt)b & inflate_mask[e]);
             DUMPBITS(e)
-            Tracevv((stderr, "inflate:         * distance %u\n", d));
+            Tracevv(("inflate:         * distance %u\n", d));

             /* do the copy */
             m -= c;
@@ -2069,7 +2077,7 @@ local int inflate_fast(
         if ((e = (t = t->next + ((uInt)b & inflate_mask[e]))->exop) == 0)
         {
           DUMPBITS(t->bits)
-          Tracevv((stderr, t->base >= 0x20 && t->base < 0x7f ?
+          Tracevv((t->base >= 0x20 && t->base < 0x7f ?
                     "inflate:         * literal '%c'\n" :
                     "inflate:         * literal 0x%02x\n", t->base));
           *q++ = (Byte)t->base;
@@ -2079,7 +2087,7 @@ local int inflate_fast(
       }
       else if (e & 32)
       {
-        Tracevv((stderr, "inflate:         * end of block\n"));
+        Tracevv(("inflate:         * end of block\n"));
         UNGRAB
         UPDATE
         return Z_STREAM_END;
diff -x bin -x ash -x klibc-0.81 -purNX /home/olaf/kernel/kernel_exclude.txt linuxppc-2.5_2.6.0-test9-bk.orig/arch/ppc/boot/openfirmware/coffmain.c linuxppc-2.5_2.6.0-test9-bk/arch/ppc/boot/openfirmware/coffmain.c
--- linuxppc-2.5_2.6.0-test9-bk.orig/arch/ppc/boot/openfirmware/coffmain.c	2003-10-14 13:33:50.000000000 +0200
+++ linuxppc-2.5_2.6.0-test9-bk/arch/ppc/boot/openfirmware/coffmain.c	2003-11-16 17:22:48.000000000 +0100
@@ -60,7 +60,7 @@ void boot(int a1, int a2, void *prom)
 	a1 = initrd_start;
 	a2 = initrd_size;
 	claim(initrd_start, ram_end - initrd_start, 0);
-	printf("initial ramdisk moving 0x%x <- 0x%p (%x bytes)\n\r",
+	printf("initial ramdisk moving 0x%08x <- 0x%p (%08x bytes)\n\r",
 	       initrd_start, (char *)(&__ramdisk_begin), initrd_size);
 	memcpy((char *)initrd_start, (char *)(&__ramdisk_begin), initrd_size);
 	prog_size = initrd_start - prog_start;

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
