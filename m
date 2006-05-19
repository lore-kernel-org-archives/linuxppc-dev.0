Return-Path: <paul@briny.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id 4287A67A5F
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 00:43:54 +1000 (EST)
From: Paul Collins <paul@briny.ondioline.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<87wtcirw0y.fsf@briny.internal.ondioline.org>
	<1148046418.3864.14.camel@johannes.berg>
Date: Sat, 20 May 2006 00:40:27 +1000
Message-ID: <87zmhef57o.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: debian-powerpc <debian-powerpc@lists.debian.org>,
	Eddy =?utf-8?Q?Petri=C5=9For?= <eddy.petrisor@gmail.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2006-05-19 at 23:20 +1000, Paul Collins wrote:
>
>> I have a PowerBook5,4 here and I'd be happy to test support for it.
>> The hardware is identified by snd-powermac as "PowerMac Snapper" and
>> the layout ID appears to be "3".
>
> Try downloading snd-aoa and in snd-aoa-fabric-layout.c change the two
> occurrences of '70' to '3'. If it works, let me know and I'll add the
> proper entry for it.

When I probed i2sbus nothing much seemed to happen, so I added a
printk to see what layout ID was being returned, and I'm getting 51,
not 3 as found in the device tree.  However, when I use 51 instead of
3 in those two places, I still don't get much happening.

Here's the dmesg after "modprobe i2sbus":

May 20 00:35:51 briny kernel: i2sbus: mapped i2s control registers
May 20 00:35:51 briny kernel: i2sbus: control register contents:
May 20 00:35:51 briny kernel: i2sbus:    fcr0 = 0x0
May 20 00:35:51 briny kernel: i2sbus:    cell_control = 0x0
May 20 00:35:51 briny kernel: i2sbus:    fcr2 = 0x4ef1c25
May 20 00:35:51 briny kernel: i2sbus:    fcr3 = 0x0
May 20 00:35:51 briny kernel: i2sbus:    clock_control = 0x0
May 20 00:35:51 briny kernel: layout id is 51
May 20 00:35:51 briny kernel: i2sbus control destroyed

And lsmod:

Module                  Size  Used by
i2sbus                 21632  0 
soundbus                8132  1 i2sbus
radeon                129896  0 
drm                    82968  1 radeon
snd_usb_audio          90624  0 
snd_usb_lib            19232  1 snd_usb_audio
snd_rawmidi            29280  1 snd_usb_lib
snd_hwdep              11012  1 snd_usb_audio
hci_usb                14164  3 
snd_pcm_oss            50816  0 
snd_pcm               103588  3 i2sbus,snd_usb_audio,snd_pcm_oss
snd_timer              27140  1 snd_pcm
snd_page_alloc         11432  1 snd_pcm
pcmcia                 45776  0 
ehci_hcd               37224  0 
bcm43xx               448916  0 
ieee80211softmac       32384  1 bcm43xx
uninorth_agp           11112  1 
agpgart                38484  2 drm,uninorth_agp
ohci_hcd               24452  0 
ieee80211              36776  2 bcm43xx,ieee80211softmac
ieee80211_crypt         6880  1 ieee80211
yenta_socket           30412  1 
rsrc_nonstatic         13472  1 yenta_socket
pcmcia_core            49592  3 pcmcia,yenta_socket,rsrc_nonstatic

Here are the changes I made.

diff --git a/aoa/fabrics/snd-aoa-fabric-layout.c b/aoa/fabrics/snd-aoa-fabric-layout.c
index 65cda87..180dca4 100644
--- a/aoa/fabrics/snd-aoa-fabric-layout.c
+++ b/aoa/fabrics/snd-aoa-fabric-layout.c
@@ -84,7 +84,7 @@ MODULE_ALIAS("sound-layout-64");
 MODULE_ALIAS("sound-layout-65");
 MODULE_ALIAS("sound-layout-68");
 MODULE_ALIAS("sound-layout-69");
-MODULE_ALIAS("sound-layout-70");
+MODULE_ALIAS("sound-layout-51");
 MODULE_ALIAS("sound-layout-72");
 MODULE_ALIAS("sound-layout-86");
 MODULE_ALIAS("sound-layout-84");
@@ -214,7 +214,7 @@ static struct layout layouts[] = {
 	  },
 	  .busname = "digital in", .pcmid = 1 },
 	/* Early 2005 PowerBook */
-	{ .layout_id = 70,
+	{ .layout_id = 51,
 	  .codecs[0] = {
 		.name = "tas",
 		.connections = tas_connections_nolineout,
diff --git a/soundbus/i2sbus/i2sbus-core.c b/soundbus/i2sbus/i2sbus-core.c
index f6463cb..ff5b52e 100644
--- a/soundbus/i2sbus/i2sbus-core.c
+++ b/soundbus/i2sbus/i2sbus-core.c
@@ -130,7 +130,10 @@ static int i2sbus_add_dev(struct macio_d
 		u32 *layout_id;
 		layout_id = (u32*) get_property(sound, "layout-id", NULL);
 		if (layout_id) {
+			printk(KERN_INFO "layout id is %d\n", *layout_id);
 			snprintf(dev->sound.modalias, 32, "sound-layout-%d", *layout_id);
+		} else {
+			printk(KERN_INFO "no layout id!?\n");
 		}
 	}
 


-- 
Dag vijandelijk luchtschip de huismeester is dood
