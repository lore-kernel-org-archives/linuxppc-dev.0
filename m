Return-Path: <B16395@freescale.com>
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <Linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/4] powerpc/mpic: Enhancements for FSL MPIC. 
Date: Tue, 27 Mar 2012 17:44:58 +0530
Message-ID: <1332850498-23449-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds/fixes the following functionality specific to the
FSL MPIC:
1. Fix support for timer group B interrupts. Previously these were
not getting initialized.

2. Use the MPIC_LARGE_VECTORS flag while intializing FSL MPIC.
This prevents us from eating in to hardware vector number
space (MSIs) while setting up internal sources.

3. Cleanup MPIC internal source vector allocation, by moving it to a
separate function.

4.Cascaded handling for the MPIC error interrupt. This is possible
with FSL MPIC version >= 4.1.

The patches are based on "next" branch of Benjamin Herrenschmidt's powerpc
linux tree.

Varun Sethi (4):
  Support timer group B on Freescale chip.
  Use the MPIC_LARGE_VECTORS flag for FSL MPIC.
  Move internal interrupt source vector allocation to a separate
  function.
  Mpic error interrupt support.

 arch/powerpc/include/asm/mpic.h |   30 +++++-
 arch/powerpc/sysdev/mpic.c      |  245 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 241 insertions(+), 34 deletions(-)

-- 
1.7.2.2
