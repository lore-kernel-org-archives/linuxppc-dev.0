Date: Mon, 18 Mar 2002 14:25:07 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org, Armin <akuster@pacbell.net>
Subject: Re: [PATCH] another for ibm_ocp_enet gzip'd
Message-ID: <20020318142507.A6687@ecam.san.rr.com>
References: <20020315114137.A26609@ecam.san.rr.com> <20020315200558.GG691@opus.bloom.county> <20020315142542.A27043@ecam.san.rr.com> <20020315223140.GA1643@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
In-Reply-To: <20020315223140.GA1643@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii

On Fri, Mar 15, 2002 at 03:31:40PM -0700, Tom Rini wrote:
> On Fri, Mar 15, 2002 at 02:25:42PM -0800, andrew may wrote:
> > On Fri, Mar 15, 2002 at 01:05:58PM -0700, Tom Rini wrote:
> > > On Fri, Mar 15, 2002 at 11:41:37AM -0800, andrew may wrote:
> > >
> > > > 3. added mal.sh to generate a new ibm_ocp_mal.c
> > >
> > > This looks very cool.  Can you add in some comments to the shell script,
> > > and I didn't see any bashisms in there, can you verify it works with
> > > pdksh or one of the other script shells which can be /bin/sh ?
> >
> > I am not sure how I can check against other shells since I don't
> > have them on my machine. Is sh --posix good enough?
>
> It depends on what 'sh' is.

Well I just have bash 2.05a.0(1)-release as a debian package.

Here is a patch for the Config.help and the Makefile

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ocp_enet-5.diff"

diff -u linux-base/Documentation/Configure.help linux-ppc/Documentation/Configure.help
--- linux-base/Documentation/Configure.help	Wed Mar 13 19:52:39 2002
+++ linux-ppc/Documentation/Configure.help	Mon Mar 18 13:53:19 2002
@@ -24099,6 +24099,21 @@
   Number of ethernet transmit (write) buffers.  Unless you know what
   you are doing the default should be fine.

+PowerPC 405 on-chip ethernet -- Amount of bytes to Reserve on a skb
+CONFIG_IBM_OCP_ENET_SKB_RES
+  Many standard ethernet drivers need to reserve 2 bytes of data
+  on the skb before giving the data ptr to the hardware. This is
+  so the IP data will be 16-byte aligned when it goes up the stack.
+  This is a requirement for some processors and it can cause major
+  slow downs on others. The 405GP dose not have problems with the
+  misaligned data so the default is 0. If you need to route the
+  incoming ethernet packets to another device that has alignment
+  requirements this can help remove a data copy. A value of 2 can
+  help at getting 16-byte aligned IP data for another device. A
+  larger value can be used when routing to a IP tunnel device.
+  Make sure XXX_DESC_SIZE - XXX_SKB_RES >= 1514, or larger if VLANS
+  are used.
+
 PPC 405 I2C Algorithm
 CONFIG_PPC405_I2C_ALGO
   Enable this option to use the built-in I2C on your 405.
diff -ur linux-base/drivers/net/ibm_ocp/Makefile linux-ppc/drivers/net/ibm_ocp/Makefile
--- linux-base/drivers/net/ibm_ocp/Makefile	Wed Mar 13 19:52:33 2002
+++ linux-ppc/drivers/net/ibm_ocp/Makefile	Mon Mar 18 13:49:18 2002
@@ -19,3 +19,10 @@
 obj-$(CONFIG_IBM_OCP_ENET) += ibm_ocp_enet.o ibm_ocp_phy.o ibm_ocp_mal.o

 include $(TOPDIR)/Rules.make
+
+#This will generate code for 2MALs this works for the 405GP even
+#though it has only one since the 2nd is defined at offset 0
+#Do we want CONFIG_IBM_OCP_MAL_CNT ?
+ibm_ocp_mal.c: mal.sh
+	$(SH) ./mal.sh 2 >ibm_ocp_mal.c
+

--X1bOJ3K7DJ5YkBrT--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
