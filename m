Message-ID: <3AB6ADA5.286F3132@routefree.com>
Date: Mon, 19 Mar 2001 17:08:53 -0800
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: Ralph Blach <rblach@intrex.net>
Cc: Brad Parker <brad@parker.boston.ma.us>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: es1371.o sound module on a IBM405 gp walnut
References: <200103191113.GAA58475@p2.parker.boston.ma.us> <3AB6ABF6.253DFF8D@intrex.net>
Content-Type: multipart/mixed;
 boundary="------------BB53B16ABDB32ECB47E7E1CA"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------BB53B16ABDB32ECB47E7E1CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ralph Blach wrote:
>
> Brad,
>
> Well it was endian problems.  I ran an mp3 to wav conversion that sox
> recomended.  I then had to do a word swap on the 16 bit data and it
> sounded fine.  Is there anyway to tell the driver that the samples are
> byte reversed?
>

I repeat the problem is in sox not the driver since sox is sending big
endian samples while telling the driver it is little endian.  Attached
is a patch to sox-12.17.1 oss.c that fixes sox.

cd sox-12.17.1; patch -p0 < sox.patch

	david
--------------BB53B16ABDB32ECB47E7E1CA
Content-Type: text/plain; charset=us-ascii;
 name="sox.patch"
Content-Disposition: inline;
 filename="sox.patch"
Content-Transfer-Encoding: 7bit

--- oss.c	Sun Aug 13 11:04:30 2000
+++ ../../sox-12.17.1/oss.c	Sun Jan 28 15:44:19 2001
@@ -5,9 +5,8 @@
  * any purpose.  This copyright notice must be maintained.
  * Chris Bagwell And Sundry Contributors are not
  * responsible for the consequences of using this software.
- */
-
-/* Direct to Open Sound System (OSS) sound driver
+ *
+ * Direct to Open Sound System (OSS) sound driver
  * OSS is a popular unix sound driver for Intel x86 unices (eg. Linux)
  * and several other unixes (such as SunOS/Solaris).
  * This driver is compatible with OSS original source that was called
@@ -44,12 +43,13 @@
 static int ossdspinit(ft)
 ft_t ft;
 {
-    int samplesize = 8, dsp_stereo;
-    int tmp;
+    int sampletype, samplesize, dsp_stereo;
+    int tmp, rc;

     if (ft->info.rate == 0.0) ft->info.rate = 8000;
     if (ft->info.size == -1) ft->info.size = ST_SIZE_BYTE;
     if (ft->info.size == ST_SIZE_BYTE) {
+	sampletype = AFMT_U8;
 	samplesize = 8;
 	if (ft->info.encoding == -1)
 	    ft->info.encoding = ST_ENCODING_UNSIGNED;
@@ -60,6 +60,7 @@
 	}
     }
     else if (ft->info.size == ST_SIZE_WORD) {
+	sampletype = (ST_IS_BIGENDIAN) ? AFMT_S16_BE : AFMT_S16_LE;
 	samplesize = 16;
 	if (ft->info.encoding == -1)
 	    ft->info.encoding = ST_ENCODING_SIGN2;
@@ -70,6 +71,8 @@
 	}
     }
     else {
+	sampletype = (ST_IS_BIGENDIAN) ? AFMT_S16_BE : AFMT_S16_LE;
+	samplesize = 16;
         ft->info.size = ST_SIZE_WORD;
 	ft->info.encoding = ST_ENCODING_SIGN2;
 	st_report("OSS driver only supports bytes and words");
@@ -84,26 +87,61 @@
 	st_fail("Unable to reset OSS driver.  Possibly accessing an invalid file/device");
 	return(ST_EOF);
     }
-    ft->file.size = 0;
-    ioctl (fileno(ft->fp), SNDCTL_DSP_GETBLKSIZE, &ft->file.size);
-    if (ft->file.size < 4 || ft->file.size > 65536) {
-	    st_fail("Invalid audio buffer size %d", ft->file.size);
-	    return (ST_EOF);
-    }
-    ft->file.count = 0;
-    ft->file.pos = 0;
-    ft->file.eof = 0;
-
-    if ((ft->file.buf = malloc (ft->file.size)) == NULL) {
-	st_fail("Unable to allocate input/output buffer of size %d", ft->file.size);
-	return (ST_EOF);
-    }

     if (ioctl(fileno(ft->fp), SNDCTL_DSP_SYNC, NULL) < 0) {
 	st_fail("Unable to sync dsp");
 	return (ST_EOF);
     }

+#if defined(SNDCTL_DSP_SETFMT) && defined(SNDCTL_DSP_GETFMTS)
+    /* Query the supported formats and find the best match
+     */
+    rc = ioctl(fileno(ft->fp), SNDCTL_DSP_GETFMTS, &tmp);
+    if (rc == 0) {
+    	if ((tmp & sampletype) == 0)
+	{
+	    /* is 16-bit supported? */
+	    if (samplesize == 16 && (tmp & (AFMT_S16_LE|AFMT_S16_BE)) == 0)
+	    {
+		/* Must not like 16-bits, try 8-bits */
+		ft->info.size = ST_SIZE_BYTE;
+		ft->info.encoding = ST_ENCODING_UNSIGNED;
+		st_report("OSS driver doesn't like signed words");
+		st_report("Forcing to unsigned bytes");
+		tmp = sampletype = AFMT_U8;
+		samplesize = 8;
+	    }
+	    /* is 8-bit supported */
+	    else if (samplesize == 8 && (tmp & AFMT_U8) == 0)
+	    {
+		ft->info.size = ST_SIZE_WORD;
+		ft->info.encoding = ST_ENCODING_SIGN2;
+		st_report("OSS driver doesn't like unsigned bytes");
+		st_report("Forcing to signed words");
+		sampletype = (ST_IS_BIGENDIAN) ? AFMT_S16_BE : AFMT_S16_LE;
+		samplesize = 16;
+	    }
+	    /* determine which 16-bit format to use */
+	    if (samplesize == 16)
+	    {
+	    	if ((tmp & sampletype) == 0)
+		{
+		    sampletype = (ST_IS_BIGENDIAN) ? AFMT_S16_LE : AFMT_S16_BE;
+		    ft->swap = ft->swap ? 0 : 1;
+		}
+	    }
+	}
+	tmp = sampletype;
+	rc = ioctl(fileno(ft->fp), SNDCTL_DSP_SETFMT, &tmp);
+    }
+    /* Give up and exit */
+    if (rc < 0 || tmp != sampletype)
+    {
+	st_fail("Unable to set the sample size to %d", samplesize);
+	return (ST_EOF);
+    }
+#else
+    /* Odd dumb interface */
     tmp = samplesize;
     if (ioctl(fileno(ft->fp), SNDCTL_DSP_SAMPLESIZE, &tmp) < 0)
     {
@@ -115,7 +153,7 @@
     {
 	if (tmp == 16)
 	{
-	    st_warn("Sound card appears to only support singled word samples.  Overriding format");
+	    st_warn("Sound card appears to only support signed word samples.  Overriding format");
 	    ft->info.size = ST_SIZE_WORD;
 	    ft->info.encoding = ST_ENCODING_SIGN2;
 	}
@@ -126,6 +164,7 @@
 	    ft->info.encoding = ST_ENCODING_UNSIGNED;
 	}
     }
+#endif

     if (ft->info.channels == 2) dsp_stereo = 1;
     else dsp_stereo = 0;
@@ -160,6 +199,24 @@
 		     ft->info.rate, tmp);
 	    ft->info.rate = tmp;
 	}
+    }
+
+    /* Find out block size to use last because the driver could compute
+     * its size based on specific rates/formats.
+     */
+    ft->file.size = 0;
+    ioctl (fileno(ft->fp), SNDCTL_DSP_GETBLKSIZE, &ft->file.size);
+    if (ft->file.size < 4 || ft->file.size > 65536) {
+	    st_fail("Invalid audio buffer size %d", ft->file.size);
+	    return (ST_EOF);
+    }
+    ft->file.count = 0;
+    ft->file.pos = 0;
+    ft->file.eof = 0;
+
+    if ((ft->file.buf = malloc (ft->file.size)) == NULL) {
+	st_fail("Unable to allocate input/output buffer of size %d", ft->file.size);
+	return (ST_EOF);
     }

     /* Change to non-buffered I/O */

--------------BB53B16ABDB32ECB47E7E1CA--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
