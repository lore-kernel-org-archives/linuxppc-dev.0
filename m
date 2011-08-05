Return-Path: <anton@samba.org>
Date: Fri, 5 Aug 2011 13:23:58 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, agraf@suse.de
Subject: [PATCH] powerpc: Make KVM_GUEST default to n
Message-ID: <20110805132358.086648e5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


KVM_GUEST adds a 1 MB array to the kernel (kvm_tmp) which grew
my kernel enough to cause it to fail to boot.

Dynamically allocating or reducing the size of this array is a
good idea, but in the meantime I think it makes sense to make
KVM_GUEST default to n in order to minimise surprises.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/Kconfig	2011-08-01 17:33:46.120121554 +1000
+++ linux-powerpc/arch/powerpc/platforms/Kconfig	2011-08-01 17:35:06.921772044 +1000
@@ -24,7 +24,7 @@ source "arch/powerpc/platforms/wsp/Kconf
 
 config KVM_GUEST
 	bool "KVM Guest support"
-	default y
+	default n
 	---help---
 	  This option enables various optimizations for running under the KVM
 	  hypervisor. Overhead for the kernel when not running inside KVM should
