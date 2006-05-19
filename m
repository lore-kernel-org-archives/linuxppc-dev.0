Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 370EF67C35
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:08:18 +1000 (EST)
Date: Fri, 19 May 2006 16:43:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 02/14] powerpc: reintroduce HvCallPci_configLoad32
Message-Id: <20060519164358.6ff099d6.sfr@canb.auug.org.au>
In-Reply-To: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
References: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This function was removed during iSeries cleanup but will prove useful
in the following patches.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/call_pci.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

59ad1dcb0d8d81e3a96f869109315652abf271f7
diff --git a/arch/powerpc/platforms/iseries/call_pci.h b/arch/powerpc/platforms/iseries/call_pci.h
index 59d4e0a..dbdf698 100644
--- a/arch/powerpc/platforms/iseries/call_pci.h
+++ b/arch/powerpc/platforms/iseries/call_pci.h
@@ -145,6 +145,25 @@ static inline u64 HvCallPci_configLoad16
 	return retVal.rc;
 }
 
+static inline u64 HvCallPci_configLoad32(u16 busNumber, u8 subBusNumber,
+		u8 deviceId, u32 offset, u32 *value)
+{
+	struct HvCallPci_DsaAddr dsa;
+	struct HvCallPci_LoadReturn retVal;
+
+	*((u64*)&dsa) = 0;
+
+	dsa.busNumber = busNumber;
+	dsa.subBusNumber = subBusNumber;
+	dsa.deviceId = deviceId;
+
+	HvCall3Ret16(HvCallPciConfigLoad32, &retVal, *(u64 *)&dsa, offset, 0);
+
+	*value = retVal.value;
+
+	return retVal.rc;
+}
+
 static inline u64 HvCallPci_configStore8(u16 busNumber, u8 subBusNumber,
 		u8 deviceId, u32 offset, u8 value)
 {
-- 
1.3.1.ge923
