Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id F2237DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 23:05:59 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g37so2792771rvb.1
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 05:05:58 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 31 Mar 2009 08:05:50 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: galak@kernel.crashing.org
Subject: [PATCH] powerpc: Make LOWMEM_CAM_NUM depend on FSL_BOOKE
Message-ID: <20090331120550.GA2332@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The recent addition of CONFIG_LOWMEM_CAM_BOOL and
CONFIG_LOWMEM_CAM_NUM cause the latter to show up in configs
that do not need it during 'make oldconfig'.  Make LOWMEM_CAM_NUM
depend on FSL_BOOKE.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ad6b1c0..7d1a535 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -772,6 +772,7 @@ config LOWMEM_CAM_NUM_BOOL
          Say N here unless you know what you are doing.
 
 config LOWMEM_CAM_NUM
+       depends on FSL_BOOKE
        int "Number of CAMs to use to map low memory" if LOWMEM_CAM_NUM_BOOL
        default 3
