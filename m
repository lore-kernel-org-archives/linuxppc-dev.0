Date: Tue, 8 Aug 2000 00:02:48 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Henry Worth <haworth@ncal.verio.com>
cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org,
        matthias pfisterer <matthias.pfisterer@gmx.de>
Subject: Re: CDDA playback on Pismo (and other newer models)
In-Reply-To: <Pine.SOL.4.10.10008071429060.8244-100000@ncal.verio.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000807235036.689a-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Aug 2000, Henry Worth wrote:

> It looks like esd is going for simplicity. Since they are mixing
> digital sound streams to integrate sound sources on the desktop,
> they ultimately need to get all the incoming data streams into native
> endiness to do the mixing. I assume they just chose to put the
> burden on the clients (I'll be charitable and not assume LE blindness
> and that the setting to native endiness was a quick hack when the
> endiness issue was brought to their attention). They would also
> need common sample rates, but I haven't looked into how much the
> daemon will do to up/down-convert, but expect that is limited as
> well.
>
> I'll put together a patch for the XMMS esd plugin, but I
> need to look into portability issues for the endiness test and
> optimal byte swapping, any suggestions?  It could also
> use an unsigned->signed conversion.

Ultimately, byte swapping and conversion should take place in esd, but
there is a bit of problems in its API (maybe easily extensible but it
looks convoluted somehow), and API change will break the binary
compatibility with the existing apps quite possibly.  Well, esd is an
alpha app, so the changes are somewhat expected, but...

Anyhow, attached is a quick hack to the xmms' esd plugin (s<->u conv is
completely untested).


Takashi Oe

--- xmms-1.2.2.ORIG/Output/esd/audio.c	Sat Jul  8 09:35:11 2000
+++ xmms-1.2.2-000807/Output/esd/audio.c	Mon Aug  7 23:58:25 2000
@@ -31,6 +31,7 @@
 static gchar *hostname;
 static pthread_t buffer_thread;
 static gboolean realtime = FALSE;
+static void *(*esd_translate)(void *, gint);

 static gint get_latency(void)
 {
@@ -73,20 +74,78 @@
 	return amount;
 }

+static void *esd_stou8(void *data, gint length)
+{
+	int len = length;
+	unsigned char *dat = (unsigned char *)data;
+
+	while (len-- > 0)
+		*dat++ ^= 0x80;
+
+	return data;
+}
+
+static void *esd_utos16sw(void *data, gint length)
+{
+	int len = length;
+	unsigned char *dat = (unsigned char *)data;
+	unsigned short sdat;
+
+	while (len >= 2) {
+		sdat = (dat[0] << 8 | dat[1]) ^ 0x8000;
+		*dat++ = sdat & 0xff;
+		*dat++ = (sdat >> 8) & 0xff;
+		len -= 2;
+	}
+	return data;
+}
+
+static void *esd_utos16(void *data, gint length)
+{
+	int len = length;
+	unsigned short *sdat = (unsigned short *)data;
+
+	while (len >= 2) {
+		*sdat++ ^= 0x8000;
+		len -= 2;
+	}
+	return data;
+}
+
+static void *esd_16sw(void *data, gint length)
+{
+	int len = length;
+	unsigned char *dat = (unsigned char *)data;
+	unsigned short sdat;
+
+	while (len >= 2) {
+		sdat = (dat[0] << 8 | dat[1]);
+		*dat++ = sdat & 0xff;
+		*dat++ = (sdat >> 8) & 0xff;
+		len -= 2;
+	}
+	return data;
+}
+
 static void esdout_setup_format(AFormat fmt,gint rate, gint nch)
 {
+	gboolean swap_sign = FALSE;
+	gboolean swap_16 = FALSE;
+
 	format = fmt;
 	frequency = rate;
 	channels = nch;
 	switch (fmt)
 	{
-		case FMT_U8:
 		case FMT_S8:
+			swap_sign = TRUE;
+		case FMT_U8:
 			esd_format = ESD_BITS8;
 			break;
 		case FMT_U16_LE:
 		case FMT_U16_BE:
 		case FMT_U16_NE:
+			swap_sign = TRUE;
 		case FMT_S16_LE:
 		case FMT_S16_BE:
 		case FMT_S16_NE:
@@ -94,6 +153,29 @@
 			break;
 	}

+#ifdef WORDS_BIGENDIAN
+	if (fmt == FMT_U16_LE || fmt == FMT_S16_LE)
+#else
+	if (fmt == FMT_U16_BE || fmt == FMT_S16_BE)
+#endif
+		swap_16 = TRUE;
+
+	esd_translate = (void*(*)())NULL;
+	if (esd_format == ESD_BITS8) {
+		if (swap_sign == TRUE)
+			esd_translate = esd_stou8;
+	} else {
+		if (swap_sign == TRUE) {
+			if (swap_16 == TRUE)
+				esd_translate = esd_utos16sw;
+			else
+				esd_translate = esd_utos16;
+		} else {
+			if (swap_16 == TRUE)
+				esd_translate = esd_16sw;
+		}
+	}
+
 	bps = rate * nch;
 	if (esd_format == ESD_BITS16)
 		bps *= 2;
@@ -205,7 +287,11 @@
 	}
 	if(effects_enabled() && ep && ep->mod_samples)
 		length = ep->mod_samples(&data,length, input_format, input_frequency, input_channels);
-	output_bytes += write(fd,data,length);
+	if (esd_translate)
+		output_bytes += write(fd,esd_translate(data,length),length);
+	else {
+		output_bytes += write(fd,data,length);
+	}
 }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
