Date: Wed, 27 Oct 1999 15:41:20 +0200 (CEST)
From: Michael Schmitz <schmitz@amber.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IR on lombard?
In-Reply-To: <19991026144416.027540@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.9910271522480.9045-100000@amber.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >ttyS1 isn't recognized as IR port on my lombard. How do I dump the device
> >tree? 
> 
> Get lsprop from ftp://devel.linuxppc.org/users/paulus/misc
> 
> and use it from /proc/device-tree

Ok, here's a patch for proper IrDA detection on the Lombard:

--- drivers/macintosh/macserial.c.org	Wed Oct 27 00:16:02 1999
+++ drivers/macintosh/macserial.c	Wed Oct 27 00:50:09 1999
@@ -2237,7 +2237,7 @@
 	  struct mac_zschannel *zs_chan_a)
 {
 	struct device_node *ch = zss->dev_node;
-	char *conn;
+	char *conn, *slot_name;
 	int len;
 
 	zss->irq = ch->intrs[0].line;
@@ -2264,6 +2264,15 @@
 	   should do no harm anyway */
 	conn = get_property(ch, "AAPL,connector", &len);
 	zss->is_pwbk_ir = conn && (strcmp(conn, "infrared") == 0);
+
+	/* 
+	 * MSch: tested on Lombard; the AAPL,connector property does't exist there 
+	 * so we evaluate the slot-names property instead. 
+	 */
+	slot_name = get_property(ch, "slot-names", &len);
+	if (slot_name && len > 4 && (unsigned char) slot_name[3] == 1) {
+		zss->is_pwbk_ir      |= (strncmp(&slot_name[4], "IrDA", len-4) == 0);
+	}
 
 	if (zss->has_dma) {
 		zss->dma_priv = NULL;

It seems that the slot-names property is relevant on the Lombard. I'm too
lazy to turn the above slot-names evaluation into a proper OF probe
function. The first four bytes seem too hold the number of names, followed
by that many null terminated strings. Modem and IrDA have a single slot
name of Modem and IrDA (surprise, surprise). 

With this patch, the second SCC port is properly identified as IR port,
but that's as far as I can test it. The serial driver contains code to
enable the IR LED, but I recall BenH saying that the PMU hook may need
work on the Lombard. 

I might get an IrDA equipped printer soon, until then please try the 
above patch and experiment with ttyS1. 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
