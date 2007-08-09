Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 65DD4DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 07:37:37 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] remove gratuitous reads from pasemi pci config space methods
Date: Thu,  9 Aug 2007 16:37:27 -0500
Message-Id: <11866954472463-git-send-email-ntl@pobox.com>
In-Reply-To: 20070809200327.GB14344@lixom.net
References: 20070809200327.GB14344@lixom.net
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pasemi pci configuration space write method reads the written
location immediately after the write is performed, presumably in order
to flush the write.  However, configuration space writes are not
allowed to be posted, making these reads gratuitous.  Furthermore,
this behavior potentially causes us to violate the PCI PM spec when
changing between e.g. D0 and D3 states, because a delay of up to 10ms
may be required before the OS accesses configuration space after the
write which initiates the transition.

Remove the unnecessary reads from pa_pxp_write_config.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/pasemi/pci.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index ab1f5f6..f7da373 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -107,15 +107,12 @@ static int pa_pxp_write_config(struct pci_bus *bus, unsigned int devfn,
 	switch (len) {
 	case 1:
 		out_8(addr, val);
-		(void) in_8(addr);
 		break;
 	case 2:
 		out_le16(addr, val);
-		(void) in_le16(addr);
 		break;
 	default:
 		out_le32(addr, val);
-		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
-- 
1.5.2.4
