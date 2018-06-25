Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Dh9V2P70zF18l
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 17:47:58 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id g20-v6so6444195plq.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 00:47:58 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 1/2] drivers/base: only reordering consumer device when
 probing
Date: Mon, 25 Jun 2018 15:47:38 +0800
Message-Id: <1529912859-10475-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
References: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
places an assumption of supplier<-consumer order on the process of probe.
But it turns out to break down the parent <- child order in some scene.
E.g in pci, a bridge is enabled by pci core, and behind it, the devices
have been probed. Then comes the bridge's module, which enables extra
feature(such as hotplug) on this bridge. This will break the
parent<-children order and cause failure when "kexec -e" in some scenario.

The detailed description of the scenario:
An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
to some issue. For this case, the bridge is moved after its children in
devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
write back buffer in flight due to the former shutdown of the bridge which
clears the BusMaster bit.

To fix this issue, only reordering a device and all of its children
if it is a consumer.

Note, the bridge involved:
0004:00:00.0 PCI bridge: IBM Device 04c1 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        NUMA node: 0
        Bus: primary=00, secondary=01, subordinate=12, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 80000000-ffefffff
        Prefetchable memory behind bridge: 0006024000000000-0006027f7fffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM not supported, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis+, LTR-, OBFF Disabled ARIFwd+
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP+ FCP- CmpltTO+ CmpltAbrt+ UnxCmplt- RxOF- MalfTLP- ECRC+ UnsupReq- ACSViol-
                UESvrt: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
        Capabilities: [148 v1] #19

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
note: this patch points out the code where the bug is introduced.
and I hope it sketches out the scene. Will fold the series in one.

---
 drivers/base/base.h | 1 +
 drivers/base/core.c | 9 +++++++++
 drivers/base/dd.c   | 9 ++-------
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a75c302..37f86ca 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -135,6 +135,7 @@ extern void device_unblock_probing(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
+extern int device_reorder_consumer(struct device *dev);
 extern void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 36622b5..66f06ff 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -123,6 +123,15 @@ static int device_is_dependent(struct device *dev, void *target)
 	return ret;
 }
 
+/* a temporary place holder to mark out the root cause of the bug.
+ * The proposal algorithm will come in next patch
+ */
+int device_reorder_consumer(struct device *dev)
+{
+	devices_kset_move_last(dev);
+	return 0;
+}
+
 static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d72..c74f23c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -434,13 +434,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
-	/*
-	 * Ensure devices are listed in devices_kset in correct order
-	 * It's important to move Dev to the end of devices_kset before
-	 * calling .probe, because it could be recursive and parent Dev
-	 * should always go first
-	 */
-	devices_kset_move_last(dev);
+	/* only reoder consumer and its children after suppliers.*/
+	device_reorder_consumer(dev);
 
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
-- 
2.7.4
