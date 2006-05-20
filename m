Return-Path: <benjamin@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36F91679F5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 01:17:12 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Benjamin Berg <benjamin@sipsolutions.net>
To: charles-debian-nospam@plessy.org
In-Reply-To: <20060518004141.GC1552@kunpuu.plessy.org>
References: <1147860564.14395.6.camel@johannes>
	<200605180002.01669.borge@arivene.net>
	<20060518004141.GC1552@kunpuu.plessy.org>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 May 2006 16:57:12 +0200
Message-Id: <1148137032.3407.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-18-05 at 09:41 +0900, Charles Plessy wrote:=20
> Hi all,
>=20
> just a "me too" mail:
>=20
> Le Thu, May 18, 2006 at 12:02:01AM +0200, B=C3=B8rge Holen a =C3=A9crit :
> > I can also remember half way throught a ogg/mp3 playlist when it also=20
> > scrambled the output, this has only happened ONCE.
>=20
> I experience the same on my 8,1 powermac, but more systematically. It
> takes usually more than one hour of continuous listening before it
> happens, and then it happens sort of stochastically. I am not using
> anything else than xmms, so I did not figure out if it is a xmms or a
> driver problem. Stop/Starting the listening stops the scrambling.

This is exactly the problem that I have experienced since a while now.
The problem is that some interrupts get lost. This results in a broken
address calculation and the new data is written to the wrong place.

The attached patch fixes this by checking the 'frame_count'.
What I don't really understand is, that the first time the interrupt
gets executed, the frame_count is 8 _less_ of what I would have expected
My guess is that the dma controller reads the last 32 bytes, and then
the interrupt gets fired.

diff --git a/soundbus/i2sbus/i2sbus-pcm.c b/soundbus/i2sbus/i2sbus-pcm.c
index 9eadf83..8511234 100644
--- a/soundbus/i2sbus/i2sbus-pcm.c
+++ b/soundbus/i2sbus/i2sbus-pcm.c
@@ -440,6 +440,11 @@ static int i2sbus_pcm_trigger(struct i2s
 			return -ENXIO;
 		}
=20
+		/* get the current frame_count - 32 bytes. This is just guessed,
+		   but it seems that the interrupt triggers as soon as the last 32 bytes
+		   are cached or something. */
+		pi->frame_count =3D in_le32(&i2sdev->intfregs->frame_count) - 0x20 / (pi=
->substream->runtime->sample_bits / 8);
+
 		/* wake up the chip with the next descriptor */
 		out_le32(&pi->dbdma->control, (RUN|WAKE) | ((RUN|WAKE)<<16));
 		/* off you go! */
@@ -488,13 +493,29 @@ static snd_pcm_uframes_t i2sbus_pcm_poin
 static inline void handle_interrupt(struct i2sbus_dev *i2sdev, int in)
 {
 	struct pcm_info *pi;
+	u32 fc;
+	u32 delta;
=20
 	get_pcm_info(i2sdev, in, &pi, NULL);
 	if (!pi->substream) {
 		printk(KERN_INFO "i2sbus: got %s irq while not active!\n", in?"rx":"tx")=
;
 		return;
 	}
-	pi->current_period =3D (pi->current_period+1) % (pi->periods);
+=09
+	fc =3D in_le32(&i2sdev->intfregs->frame_count);
+	/* a counter overflow does not change the calculation. */
+	delta =3D fc - pi->frame_count;
+=09
+	if (delta <=3D pi->substream->runtime->period_size) {
+		pi->current_period =3D pi->current_period + 1;
+		delta =3D 0;
+	} else while (delta >=3D pi->substream->runtime->period_size) {
+		pi->current_period =3D pi->current_period + 1;
+		delta =3D delta - pi->substream->runtime->period_size;
+	}
+=09
+	pi->frame_count =3D fc - delta;
+	pi->current_period =3D pi->current_period % pi->periods;
 	snd_pcm_period_elapsed(pi->substream);
 }
=20
diff --git a/soundbus/i2sbus/i2sbus.h b/soundbus/i2sbus/i2sbus.h
index b054e02..f5d16aa 100644
--- a/soundbus/i2sbus/i2sbus.h
+++ b/soundbus/i2sbus/i2sbus.h
@@ -41,6 +41,7 @@ struct pcm_info {
 	struct snd_pcm_substream *substream;
 	int current_period;
 	int periods;
+	u32 frame_count;
 	struct dbdma_command_mem dbdma_ring;
 	volatile struct dbdma_regs __iomem *dbdma;
 };
