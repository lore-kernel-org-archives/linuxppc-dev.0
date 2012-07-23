Return-Path: <anton@samba.org>
Date: Mon, 23 Jul 2012 16:26:51 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Enable pseries hardware RNG and crypto modules
Message-ID: <20120723162651.40077e26@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Enable the hardware RNG and crypto modules. I verified they both
autoload via the VIO subsystem, so there is no need to build them in.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -278,7 +278,8 @@ CONFIG_HVC_RTAS=y
 CONFIG_HVC_BEAT=y
 CONFIG_HVCS=m
 CONFIG_IBM_BSR=m
-# CONFIG_HW_RANDOM is not set
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_PSERIES=m
 CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AMD8111=y
@@ -484,7 +485,8 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
+CONFIG_CRYPTO_HW=y
+CONFIG_CRYPTO_DEV_NX=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=y
Index: b/arch/powerpc/configs/pseries_defconfig
===================================================================
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -225,7 +225,8 @@ CONFIG_HVC_CONSOLE=y
 CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 CONFIG_IBM_BSR=m
-# CONFIG_HW_RANDOM is not set
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_PSERIES=m
 CONFIG_GEN_RTC=y
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=1024
@@ -366,7 +367,8 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
+CONFIG_CRYPTO_HW=y
+CONFIG_CRYPTO_DEV_NX=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=y
