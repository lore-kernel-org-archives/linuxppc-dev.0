Date: Tue, 12 Dec 2000 13:28:56 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Mac/m68k patches?
In-Reply-To: <19341106051932.29140@192.168.1.2>
Message-ID: <Pine.GSO.4.10.10012121327270.2376-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Dec 2000, Benjamin Herrenschmidt wrote:
> >-	req->nbytes = nbytes+1;
> >+	if (flags & ADBREQ_RAW) {
> >+		i = 0;
> >+		len = nbytes;
> >+	} else {
> >+		req->data[0] = ADB_PACKET;
> >+		i = 1;
> >+		len = nbytes+1;
> >+	}
> >+	req->nbytes = len;
> > 	req->done = done;
> > 	req->reply_expected = flags & ADBREQ_REPLY;
> > 	req->data[0] = ADB_PACKET;
>
> Just cosmetic: you are setting req->data[0] twice to ADB_PACKET when not
> using the ADBREQ_RAW...

Thanks! With some more work, I could get rid of the additional len and 7 lines
as well.

--- linux-2.4.0-test12/drivers/macintosh/adb.c	Sun Sep 17 18:48:05 2000
+++ linux-m68k-2.4.0-test12/drivers/macintosh/adb.c	Tue Dec 12 13:22:59 2000
@@ -61,7 +61,7 @@
 #ifdef CONFIG_ADB_IOP
 	&adb_iop_driver,
 #endif
-#ifdef CONFIG_ADB_PMU
+#if defined(CONFIG_ADB_PMU) || defined(CONFIG_ADB_PMU68K)
 	&via_pmu_driver,
 #endif
 #ifdef CONFIG_ADB_MACIO
@@ -347,13 +347,15 @@
 		req = &sreq;
 		flags |= ADBREQ_SYNC;
 	}
-	req->nbytes = nbytes+1;
+	i = (flags & ADBREQ_RAW) ? 0 : 1;
+	req->nbytes = nbytes+i;
 	req->done = done;
 	req->reply_expected = flags & ADBREQ_REPLY;
 	req->data[0] = ADB_PACKET;
 	va_start(list, nbytes);
-	for (i = 0; i < nbytes; ++i)
-		req->data[i+1] = va_arg(list, int);
+	while (i < req->nbytes) {
+		req->data[i++] = va_arg(list, int);
+	}
 	va_end(list);

 	if (flags & ADBREQ_NOSEND)
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
