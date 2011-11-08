Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: add KVM as module to defconfigs
Date: Tue, 08 Nov 2011 11:49:13 +1100
Message-ID: <20521.1320713353@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add HV mode KVM to Book3 server 64bit defconfigs as a module.  

Doesn't add much to the size:
   text	   data	    bss	     dec	    hex	filename
8244109	4686767	 994000	13924876	 d47a0c	vmlinux.vanilla
8256092 4691607  994128 13941827         d4bc43 vmlinux.kvm

This should enable more testing of this configuration.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/configs/ppc64_defconfig   |    4 ++++
 arch/powerpc/configs/pseries_defconfig |    4 ++++
 2 files changed, 8 insertions(+)

Index: linux-ozlabs/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-ozlabs.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-ozlabs/arch/powerpc/configs/ppc64_defconfig
@@ -485,3 +485,7 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+CONFIG_VIRTUALIZATION=y
+CONFIG_KVM_BOOK3S_64=m
+CONFIG_KVM_BOOK3S_64_HV=y
+CONFIG_VHOST_NET=m
Index: linux-ozlabs/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-ozlabs.orig/arch/powerpc/configs/pseries_defconfig
+++ linux-ozlabs/arch/powerpc/configs/pseries_defconfig
@@ -362,3 +362,7 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+CONFIG_VIRTUALIZATION=y
+CONFIG_KVM_BOOK3S_64=m
+CONFIG_KVM_BOOK3S_64_HV=y
+CONFIG_VHOST_NET=m
