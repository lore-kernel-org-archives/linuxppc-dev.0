Date: Mon, 11 Oct 1999 23:10:39 -0400
From: Eric Dorland <dorland@lords.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Elliot Lee <sopwith@redhat.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
Message-ID: <19991011231039.A526@HSE-MTL-ppp4363.qc.sympatico.ca>
References: <19991011154325.A14359@HSE-MTL-ppp4363.qc.sympatico.ca> <Pine.LNX.4.10.9910111308380.802-100000@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
In-Reply-To: <Pine.LNX.4.10.9910111308380.802-100000@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii

On Mon, Oct 11, 1999 at 01:09:12PM -0700, Tom Rini wrote:
> 
> On Mon, 11 Oct 1999, Eric Dorland wrote:
> 
> > It appears I spoke to soon about sound working perfectly. Whenever esd plays
> > a 16bit wav file, the sound plays at about half speed. Ugg. At least its not
> > static anymore. I'm going to see if I can track down why this is happening
> > (maybe its some on-the-fly endianess swaping slowing it down), but I don't
> > know sound code all that well, so anyone that does, please lend a hand.
> 
> Elliot has the old set of patches ported up to 0.2.15, and hopefully will
> be in 0.2.16 :)

Which old set of patches? I've tried Elliot's 0.2.15 and it doesn't fix 
the playing of 16bit sounds. BTW, you need a patch to be able to compile 
Elliot's 0.2.15. It seems the configure file assumes that a ppc linux is 
MkLinux, and uses its driver instead of OSS. It appears its MkLinux that has 
the little-endian sound driver, not linuxppc. Anyway the attached patch 
changes removes the MkLinux testing (I don't know how to tell the
difference), and just uses OSS.

Also, passing the -b switch forces esd to use 8bit samples, so even the
16bit sounds play properly (albeit at 8bits). Unfortunately, for some reason
esd reverts to 16bit after a while, and 16bit sounds play slowly once again.

Please, anyone who knows anything about esd or sound programming in general,
mail me and help me fix this :)

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="esound-0.2.15.ppc.patch"

--- configure.old	Mon Oct 11 16:14:40 1999
+++ configure	Mon Oct 11 16:14:46 1999
@@ -3073,19 +3073,12 @@
       test "${ac_cv_header_soundcard_h}" = "yes" || \
       test "${ac_cv_header_machine_soundcard_h}" = "yes"; then
 
-            if test "${host_cpu}" = "powerpc"; then
-        found_sound=yes
-        cat >> confdefs.h <<\EOF
-#define DRIVER_MKLINUX 1
-EOF
-
-      else
-        found_sound=yes
-        cat >> confdefs.h <<\EOF
+      found_sound=yes
+      cat >> confdefs.h <<\EOF
 #define DRIVER_OSS 1
 EOF
 
-      fi
+  
    fi
 
    if test "${ac_cv_header_sys_audio_h}" = "yes"; then
--- configure.in.old	Mon Oct 11 16:07:55 1999
+++ configure.in	Mon Oct 11 16:21:49 1999
@@ -116,14 +116,9 @@
       test "${ac_cv_header_soundcard_h}" = "yes" || \
       test "${ac_cv_header_machine_soundcard_h}" = "yes"; then
 
-      dnl Platform mklinux/powerpc needs special care and feeding
-      if test "${host_cpu}" = "powerpc"; then
-        found_sound=yes
-        AC_DEFINE(DRIVER_MKLINUX)
-      else
-        found_sound=yes
-        AC_DEFINE(DRIVER_OSS)
-      fi
+      found_sound=yes
+      AC_DEFINE(DRIVER_OSS)
+     
    fi
 
    if test "${ac_cv_header_sys_audio_h}" = "yes"; then
--- esdfile.c.old	Mon Oct 11 16:16:07 1999
+++ esdfile.c	Mon Oct 11 16:21:48 1999
@@ -157,8 +157,12 @@
     length = afGetTrackBytes( in_file, AF_DEFAULT_TRACK );
     afGetSampleFormat( in_file, AF_DEFAULT_TRACK, &in_format, &in_width );
 
-    /* TODO: should this be set to the native endian order of the playing machine? */
-    afSetVirtualByteOrder( in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_LITTLEENDIAN );
+     /* TODO: should this be set to the native endian order of the playing machine? */
+#if defined(__powerpc__)
+    afSetVirtualByteOrder( in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_BIGENDIAN );
+#else /* #if !defined(__powerpc__) */
+     afSetVirtualByteOrder( in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_LITTLEENDIAN );
+#endif
 
     /*  printf ("frames: %i channels: %i rate: %f format: %i width: %i\n",
      *	        frame_count, in_channels, in_rate, in_format, in_width);
--- esdplay.c.old	Mon Oct 11 16:16:24 1999
+++ esdplay.c	Mon Oct 11 16:21:44 1999
@@ -51,8 +51,13 @@
   in_rate = afGetRate (in_file, AF_DEFAULT_TRACK);
   afGetSampleFormat (in_file, AF_DEFAULT_TRACK, &in_format, &in_width);
 
-  afSetVirtualByteOrder (in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_LITTLEENDIAN);
-
+/* TODO: should this be set to the native endian order of the playing machine? */
+#if defined(__powerpc__)
+    afSetVirtualByteOrder( in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_BIGENDIAN );
+#else /* #if !defined(__powerpc__) */
+     afSetVirtualByteOrder( in_file, AF_DEFAULT_TRACK, AF_BYTEORDER_LITTLEENDIAN );
+#endif
+  
   printf ("frames: %i channels: %i rate: %f format: %i width: %i\n",
     frame_count, in_channels, in_rate, in_format, in_width);
 

--Dxnq1zWXvFF0Q93v--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
