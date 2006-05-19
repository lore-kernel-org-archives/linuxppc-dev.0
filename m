Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14B03679EA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 22:47:26 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Tony Vroon <chainsaw@gentoo.org>
In-Reply-To: <446B721D.8020203@gentoo.org>
References: <1147860564.14395.6.camel@johannes> <446B721D.8020203@gentoo.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-n0dCRPCNERRsRbT8JW5Y"
Date: Fri, 19 May 2006 12:22:07 +0200
Message-Id: <1148034127.15507.178.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-n0dCRPCNERRsRbT8JW5Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 19:57 +0100, Tony Vroon wrote:

> When writing documentation, you might want to add that the ALSA-plugin
> in XMMS & Audacious requires a period time of 100ms instead of the
> default of 50ms, as otherwise the sou*click*nd is n*click*ot ver*click*y
> good.
> (A look at the current code of that plugin, to see how the volume
> control code can be fixed would be highly appreciated)

How's that related to snd-aoa? You can currently buffer up to 131072
bytes which at 96KHz and 32 bits is ~171ms. At the regular 44100Hz/16bit
it is ~743ms. But you can easily increase that in i2sbus-pcm.c line
126ff:
        /* these are somewhat arbitrary */
        hw->buffer_bytes_max =3D 131072;
        hw->period_bytes_min =3D 256;
        hw->period_bytes_max =3D 16384;
The thing is just that this memory area is essentially mlock()ed so if I
did indeed allow 16k per period and 32 periods the stream would mlock
512K. What would others say is appropriate?

Ah then again I can see how this might be related to snd-aoa -- we only
update the pcm position on each period so maybe we should increase the
minimum number of periods. Can you try that? Go into i2sbus-pcm.c line
130 and change
        hw->periods_min =3D 3;
to maybe 6. Or just try binary search for  smallest value that makes it
work (if it ever does, but I think it should, if this is indeed the
issue). Indeed, at 50ms buffer you have just 8820 bytes which can even
be divided by 3 so that probably means that xmms used 3 periods. Maybe
that's a bit tight. Do you see the same issue with snd-powermac? (it
uses the same period setup)

> Not seen this, although I must say it does not resume from sleep as
> gracefully as I have seen you describe it.

What happens? I just fixed tas resume from sleep (by completely
re-initialising the codec) and something similar should be done for the
onyx probably (or do I do that already?) for suspend to disk, but other
than that... Oh I just realised that it'll lose some sound due to
restarting the dma command ring at the beginning. Hmm. I suppose I can
change that easily, will have to do some testing.

Benjamin (Berg), can we do that even with the lost interrupt issue?

Maybe both of these issues can be fixed by using the frame count
register instead to count how many samples were played? Below is a small
patch to print out a lot of frame count numbers, Benjamin, I'd
appreciate if you could look how this interacted with the lost
interrupts.

Note that for this to work we'd of course have to sample the frame count
register right before starting the DMA engine, it increases even while
we're not playing because we don't stop the clocks. We probably should
do that too for powersaving. Humm. Lots to do :) Oh and this probably
means that yes, it works fine even when we do lose interrupts.=20

Alternatively we could use the register just to detect if we lost
interrupts, i.e. calculate how many frames we have per period and then
see if the frame count increased approximately by that much (I've seen
+- a few frames probably due to timing, with higher samplerates we'll
probably see a bit more error) and if it increased by much more we could
estimate how many interrupts we lost. What do you think?

johannes

--- snd-aoa.orig/soundbus/i2sbus/i2sbus-pcm.c	2006-05-19 12:10:16.919474526=
 +0200
+++ snd-aoa/soundbus/i2sbus/i2sbus-pcm.c	2006-05-19 12:11:22.119474526 +020=
0
@@ -488,12 +488,17 @@ static snd_pcm_uframes_t i2sbus_pcm_poin
 static inline void handle_interrupt(struct i2sbus_dev *i2sdev, int in)
 {
 	struct pcm_info *pi;
+	u32 fc;
=20
 	get_pcm_info(i2sdev, in, &pi, NULL);
 	if (!pi->substream) {
 		printk(KERN_INFO "i2sbus: got %s irq while not active!\n", in?"rx":"tx")=
;
 		return;
 	}
+	fc =3D in_le32(&i2sdev->intfregs->frame_count);
+	printk(KERN_DEBUG "i2sbus: frame count is %d\n", fc);
+	printk(KERN_DEBUG "i2sbus: delta fc =3D %d\n", fc - i2sdev->fc);
+	i2sdev->fc =3D fc;
 	pi->current_period =3D (pi->current_period+1) % (pi->periods);
 	snd_pcm_period_elapsed(pi->substream);
 }
--- snd-aoa.orig/soundbus/i2sbus/i2sbus.h	2006-05-19 12:10:16.919474526 +02=
00
+++ snd-aoa/soundbus/i2sbus/i2sbus.h	2006-05-19 12:11:22.119474526 +0200
@@ -50,6 +50,7 @@ struct i2sbus_dev {
 	struct macio_dev *macio;
 	struct i2sbus_control *control;
 	volatile struct i2s_interface_regs __iomem *intfregs;
+	u32 fc;
=20
 	int resource_allocated; /* bitmask of resources */
 	struct resource resources[3];


--=-n0dCRPCNERRsRbT8JW5Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG2cTaVg1VMiehFYAQKyHw/+KjPPnKj3Jv8pkRKpTpAVkJkUMgr7iefT
GaZ4DBf3k+ENYo83PGr9uI28gWVTVAjIETZvLw+wTMFB3r6dXWGlUJtP/12M9Sdq
QfUV+eVtFNwykPRCeIDi/wgOOGwGUqS0YqxdinhST6dSd/wAR3wVQdc/dX6MRfWq
jPtWUSIFTv8MFQ21biM+0CPZ8mJCvutJ7Vpup0b9I9tl42Hy6wYsCaaeUmFtgq+G
V3pcYCsag2g+BnRCbcpzFLSiHt9GOKEe7+GDM7zHeZL/P9ra+OqVTIDk91NGUCji
WJ2aYvRRnzIggZE4e1nMofCQbu6LENv+uTLF9qX513hD65/3gMGynBZ+hvPrkhes
59o37MlBk/DQmqt9raPc/vYzd/pL1l8jsZiOaaBRtq1P5DjEXj3t4qcrIuMTqACN
KMLywuBMqWp8w9vuoXbYB00ks5xOs62MscCdNFi6oGFG09LbUBe5UsC3YkXhhhJ7
urs+IeJL6No0ax6+GY0T5vu72HXPDuwZGDhHQFjtBsQOw8p2X50h7L297PudKus0
OMSUX1B27kXLGcj+WuVLmnlC6/RY2wRG5PVrk2r53HACwhEDhbPt2WPeQEACo5oe
l8SAH2eyzWme3I3uvjXT5XnCSh/QuRxJ7Ob6QVL2tMg+g3Ugy0VTV9gB5wVeOAFu
oggdGXBDx5Y=
=tLLU
-----END PGP SIGNATURE-----

--=-n0dCRPCNERRsRbT8JW5Y--
