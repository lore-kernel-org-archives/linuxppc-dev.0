Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.TU-Cottbus.De
	[141.43.120.68]) by ozlabs.org (Postfix) with ESMTP id 0CB4467BBE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 00:51:06 +1000 (EST)
Message-ID: <44FEDF5D.9060707@s5r6.in-berlin.de>
Date: Wed, 06 Sep 2006 16:46:53 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [Fwd: Re: ohci1394: steps to implement suspend/resume]
Content-Type: multipart/mixed; boundary="------------080506040702080707030201"
Cc: linux1394-devel@lists.sourceforge.net, Pavel Machek <pavel@ucw.cz>,
	Bernhard Kaindl <bk@fsfe.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080506040702080707030201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello LinuxPPC-dev,

we have now patches coming in to fix up the lack of generic suspend +
resume support in drivers/ieee1394/ohci1394. Attached is the latest and
by far most functional one by Bernhard Kaindl. A big question is how
this relates to the already existing PPC-PMAC platform code in
ohci1394's suspend and resume hooks.

 - Which functionalities does the existing platform code provide in
   detail?

 - Do we have to keep platform code and generic code separate? I.e.
#ifdef CONFIG_PPC_PMAC
	...pmac_call_feature...
#else
	...new generic code...
#endif

 - Or are parts of the until now missing, new generic code necessary
   for PMacs too? If yes, is the platform code treated to be the lowest
   level as far as the oreder of code is concerned?

 - Or would the platform code be obsolete?

We already broke your platform code once by what was meant as a bugfix
for non-PMacs. It'd be good to know enough to not repeat such mistakes...

Thanks in advance,
-- 
Stefan Richter
-=====-=-==- =--= --==-
http://arcgraph.de/sr/

--------------080506040702080707030201
Content-Type: message/rfc822;
 name="Re: ohci1394: steps to implement suspend/resume"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: ohci1394: steps to implement suspend/resume"

Return-Path: <linux1394-devel-bounces@lists.sourceforge.net>
Received: from einhorn.in-berlin.de ([unix socket])
	by einhorn (Cyrus v2.1.17-IPv6-Debian-2.1.17-3) with LMTP; Wed, 06 Sep 2006 14:58:43 +0200
X-Sieve: CMU Sieve 2.2
Received: from gnu.in-berlin.de (gnu.in-berlin.de [192.109.42.4])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k86CwfYo019200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <stefanr@s5r6.in-berlin.de>; Wed, 6 Sep 2006 14:58:41 +0200
X-Envelope-From: linux1394-devel-bounces@lists.sourceforge.net
X-Envelope-To: <stefanr@s5r6.in-berlin.de>
Received: from lists-outbound.sourceforge.net (lists-outbound.sourceforge.net [66.35.250.225])
	by gnu.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k86CwcWK005283
	for <stefanr@s5r6.in-berlin.de>; Wed, 6 Sep 2006 14:58:38 +0200
Received: from sc8-sf-list1-new.sourceforge.net (unknown [10.3.1.93])
	by sc8-sf-spam2.sourceforge.net (Postfix) with ESMTP
	id EE3661274B; Wed,  6 Sep 2006 05:58:37 -0700 (PDT)
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GKwzE-0006B6-1m for linux1394-devel@lists.sourceforge.net;
	Wed, 06 Sep 2006 05:58:36 -0700
Received: from apunkt.ffii.org ([217.72.130.54] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GKwzB-000240-Fr
	for linux1394-devel@lists.sourceforge.net;
	Wed, 06 Sep 2006 05:58:36 -0700
Received: from bkaindl (helo=localhost)
	by apunkt.ffii.org with local-esmtp (Exim 4.50)
	id 1GKwz8-0007O3-Dd; Wed, 06 Sep 2006 14:58:30 +0200
Date: Wed, 6 Sep 2006 14:58:30 +0200 (CEST)
From: Bernhard Kaindl <bk@fsfe.org>
To: linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394: steps to implement suspend/resume
In-Reply-To: <Pine.LNX.4.64.0608250010080.29016@jbgna.fhfr.qr>
Message-ID: <Pine.LNX.4.64.0609061417580.32750@apunkt.ffii.org>
References: <20060627200745.771284000@sous-sol.org>
	<20060627201539.350588000@sous-sol.org>
	<44A1AC3D.6080801@s5r6.in-berlin.de>
	<Pine.LNX.4.64.0608250010080.29016@jbgna.fhfr.qr>
MIME-Version: 1.0
X-Spam-Score: (0.001) BAYES_50
X-BeenThere: linux1394-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: Linux IEEE 1394 development list
	<linux1394-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux1394-devel-bounces@lists.sourceforge.net
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.4

Hi,

I did a quick shot on what I described and the appended patch
does the first thing needed for working suspend/resume
in ohci1394 which is HW de- and re-initialisation.

It works with suspend2disk on my Ricoh R5C552 IEEE 1394 Controller
with the 2.6.17 kernel to the extent that if I call dvgrab --interactive
after suspend2disk without unloading ohci1394, it does not lock up
dvgrab with 100% CPU but properly connects to the camera, given
that I first unplug and plug the camera after coming back from
suspend.

I guess that could be fixed by forcing a bus reset in the resume
function.

I cannot test suspend to RAM here at the moment and should
follow the guidelines in Documentation/power/pci.txt also,
so this is rather a quick report than a finished patch and
there are some rough edges:

However, with this patch, I have to unload at least some in-kernel
users of ohci1394 like dv1394 or video1394 before suspending.

Not doing that caused an Oops and a bad tasklet error, probably from
not handling ISO tasklets during suspend/resume properly.

Maybe these can be temporarily cleared or unregistered and
re-registered for suspend/resume with help from the other
layers or from the highlevel 1394 core, but I do not really
know what these do.

But this patch provides a useful base to start from and is
already of much help for people which do not need dv1394
and video1394 or can unload them at least during suspend.

I cannot test function with sbp2 at the moment, but raw1394
seems to work fine.

Bernhard

PS: ohci1394-suspendresume-v1.patch:

Signed-Off-By: Bernhard Kaindl <bk@fsfe.org>

(I'm only a normal paying FSFE-Fellow)

--- drivers/ieee1394/ohci1394.c
+++ drivers/ieee1394/ohci1394.c
@@ -3528,6 +3530,8 @@
 
 static int ohci1394_pci_resume (struct pci_dev *pdev)
 {
+	struct ti_ohci *ohci;
+	
 #ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
 		struct device_node *of_node;
@@ -3541,12 +3545,41 @@
 
 	pci_enable_device(pdev);
 
+	ohci = pci_get_drvdata(pdev);
+	if (!ohci)
+		return -1; // or which exit status to use?
+
+	PRINT(KERN_DEBUG, "resume called");
+
+	/* The following lines are copied from ohci1394_pci_probe(): */
+
+	/* Start off with a soft reset, to clear everything to a sane
+	 * state. */
+	ohci_soft_reset(ohci);
+
+	/* Now enable LPS, which we need in order to start accessing
+	 * most of the registers.  In fact, on some cards (ALI M5251),
+	 * accessing registers in the SClk domain without LPS enabled
+	 * will lock up the machine.  Wait 50msec to make sure we have
+	 * full link enabled.  */
+	reg_write(ohci, OHCI1394_HCControlSet, OHCI1394_HCControl_LPS);
+
+	/* Disable and clear interrupts */
+	reg_write(ohci, OHCI1394_IntEventClear, 0xffffffff);
+	reg_write(ohci, OHCI1394_IntMaskClear, 0xffffffff);
+
+	mdelay(50);
+
+	ohci_initialize(ohci);
+
 	return 0;
 }
 
 
 static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
+	struct ti_ohci *ohci;
+
 #ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
 		struct device_node *of_node;
@@ -3558,6 +3591,44 @@
 	}
 #endif
 
+	ohci = pci_get_drvdata(pdev);
+	if (!ohci)
+		return -1; // Not sure if this is the correct return code
+
+	PRINT(KERN_DEBUG, "suspend called");
+
+	/* clear the async DMA contexts and stop using the controller: */
+	hpsb_bus_reset(ohci->host);
+
+	/* The following calls are from ohci1394_pci_remove(): */
+
+	/* Clear out BUS Options */
+	reg_write(ohci, OHCI1394_ConfigROMhdr, 0);
+	reg_write(ohci, OHCI1394_BusOptions,
+		  (reg_read(ohci, OHCI1394_BusOptions) & 0x0000f007) |
+		  0x00ff0000);
+
+	/* Clear interrupt registers */
+	reg_write(ohci, OHCI1394_IntMaskClear, 0xffffffff);
+	reg_write(ohci, OHCI1394_IntEventClear, 0xffffffff);
+	reg_write(ohci, OHCI1394_IsoXmitIntMaskClear, 0xffffffff);
+	reg_write(ohci, OHCI1394_IsoXmitIntEventClear, 0xffffffff);
+	reg_write(ohci, OHCI1394_IsoRecvIntMaskClear, 0xffffffff);
+	reg_write(ohci, OHCI1394_IsoRecvIntEventClear, 0xffffffff);
+
+	/* Disable IRM Contender */
+	set_phy_reg(ohci, 4, ~0xc0 & get_phy_reg(ohci, 4));
+
+	/* Clear link control register */
+	reg_write(ohci, OHCI1394_LinkControlClear, 0xffffffff);
+
+	/* Let all other nodes know to ignore us */
+	ohci_devctl(ohci->host, RESET_BUS, LONG_RESET_NO_FORCE_ROOT);
+
+	/* This stops all DMA contexts, disables interrupts,
+	 * and clears linkEnable and LPS: */
+	ohci_soft_reset(ohci);
+
 	return 0;
 }
 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
mailing list linux1394-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux1394-devel

--------------080506040702080707030201--
