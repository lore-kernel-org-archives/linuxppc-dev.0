From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15042.57778.640138.923390@pizda.ninka.net>
Date: Wed, 28 Mar 2001 23:18:10 -0800 (PST)
To: Daniel Berlin <dan@www.cgsoftware.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 fixed soon...
In-Reply-To: <Pine.LNX.4.10.10103290147210.18522-100000@www.cgsoftware.com>
References: <15042.55896.10936.34707@pizda.ninka.net>
	<Pine.LNX.4.10.10103290147210.18522-100000@www.cgsoftware.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Berlin writes:
 > If the patches + removing the bitfields for self-id
 > (which it sounds like you already did) give you the ability to
 > at least attempt to send packets (IE it runs the dma programs),
 > you are in very good shape.  I had to get the byteswapping basically
 > perfect to even get it to not just laugh at me and do nothing when we told
 > ia dma context to run.

What do you mean specifically when you say "removing the bitfields fo
self-id"?  I notice in your patches that you don't byte swap
q[0] and q[1] when they arrive for a self-id interrupt.  Are these
quadlets supposed to be big-endian in memory?  Here is the change I made:

@@ -326,7 +326,7 @@
 inline static int handle_selfid(struct ti_ohci *ohci, struct hpsb_host *host,
 				int phyid, int isroot)
 {
-	quadlet_t *q = ohci->selfid_buf_cpu;
+	quadlet_t val, *q = ohci->selfid_buf_cpu;
 	quadlet_t self_id_count=reg_read(ohci, OHCI1394_SelfIDCount);
 	size_t size;
 	quadlet_t lsid;
@@ -337,12 +337,13 @@
 	   stage */

 	/* Check status of self-id reception */
+	val = le32_to_cpu(q[0]);
 	if ((self_id_count&0x80000000) ||
-	    ((self_id_count&0x00FF0000) != (q[0]&0x00FF0000))) {
+	    ((self_id_count&0x00FF0000) != (val&0x00FF0000))) {
 		PRINT(KERN_ERR, ohci->id,
 		      "Error in reception of self-id packets"
 		      "Self-id count: %08x q[0]: %08x",
-		      self_id_count, q[0]);
+		      self_id_count, val);

 		/*
 		 * Tip by James Goodwin <jamesg@Filanet.com>:
@@ -366,18 +367,22 @@
 	q++;

 	while (size > 0) {
-		if (q[0] == ~q[1]) {
+		quadlet_t q0, q1;
+
+		q0 = le32_to_cpu(q[0]);
+		q1 = le32_to_cpu(q[1]);
+		if (q0 == ~q1) {
 			PRINT(KERN_INFO, ohci->id, "selfid packet 0x%x rcvd",
-			      q[0]);
-			hpsb_selfid_received(host, cpu_to_be32(q[0]));
-			if (((q[0]&0x3f000000)>>24)==phyid) {
-				lsid=q[0];
+			      q0);
+			hpsb_selfid_received(host, cpu_to_be32(q0));
+			if (((q0&0x3f000000)>>24)==phyid) {
+				lsid=q0;
 				PRINT(KERN_INFO, ohci->id,
 				      "This node self-id is 0x%08x", lsid);
 			}
 		} else {
 			PRINT(KERN_ERR, ohci->id,
-			      "inconsistent selfid 0x%x/0x%x", q[0], q[1]);
+			      "inconsistent selfid 0x%x/0x%x", q0, q1);
 		}
 		q += 2;
 		size -= 2;

And this seems to work just fine.

There are some problems I have with your patch, and some fixes in mine
that are not in yours (using pci_alloc_consistent more efficiently)
which ought to be integrated.

For one thing, in your stuff, the comments and code near the comment
"Pretty heinous." are totally bogus and wrong:

	p->value &= cpu_to_le32(0xfffffff0);

works _PERFECTLY_ fine.  As does:

	p->value |= cpu_to_le32(0x1);

You don't need to do all the stuff like this:

	p->value = cpu_to_le32(le32_to_cpu(p->value) | 0x1);

You only need to do this kind of thing when non-logical operations
(such as addition/subtraction etc.) need to be done on the
byte-swapped value.

It would really be nice if the IEEE1394 developers kept on top of
our patches and merged them to Linus soon.

 > I also assumed readl/writel do byteswapping, and thus, there was no need
 > to swap the register reads/writes since they would be swapped for us.

Right, readl/writel push little-endian onto little-endian busses like
PCI.

 > At the absolute least, it'll give you an idea of what needs to be swapped
 > for big endian architectures.

I know what needs to be swapped thats why I did the patches I did :-)

 > I have
 > patches to do this somewhere, it didn't matter for powerppc, so it was
 > only a half hearted attempt.

Please push it to the ieee1394 maintainers, so the work need not
be duplicated by others.  Thanks.

Later,
David S. Miller
davem@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
