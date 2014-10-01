Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 771601A0507
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 12:33:47 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BF9031400F1
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2014 12:33:46 +1000 (EST)
Message-ID: <1412129393.4285.195.camel@pasglop>
Subject: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 01 Oct 2014 12:09:53 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>,
 Yijing Wang <wangyijing@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The chipset has a limitation in the number of address bits it
can generate. The graphics portion uses a specific mask of
40 or 48 bits depending on the generation. For audio, it's a bit
less of an issue, so just mark them as no-64bit for now.

Without this, it crashes on POWER machines which can use high bits
in the DMA address to distinguish between DMA windows. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3e6d22d..2b679d5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -297,7 +297,7 @@ enum {
 /* quirks for ATI/AMD HDMI */
 #define AZX_DCAPS_PRESET_ATI_HDMI \
 	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
-	 AZX_DCAPS_NO_MSI64)
+	 AZX_DCAPS_NO_MSI64 | AZX_DCAPS_NO_64BIT)
 
 /* quirks for Nvidia */
 #define AZX_DCAPS_PRESET_NVIDIA \
