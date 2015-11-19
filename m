Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8398A1A0757
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 15:44:52 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org,
 paulus@samba.org
Subject: [PATCH v2 0/2] powerpc/tm: Fixes for crashes
Date: Thu, 19 Nov 2015 15:44:43 +1100
Message-Id: <1447908285-14637-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's a couple of fixes for crashes with the TM signals code.

v2:
 - Split fixes to go into stable from other patches
   - other patches will be sent separately
 - Updates based on mpe's review:
   - add correct linux version for stable tag
   - fix white space issues
   - cleanup signal_32 changes to make code easier to read
   - remove signal 64 setting local variable just before return.

Michael Neuling (2):
  powerpc/tm: Block signal return setting invalid MSR state
  powerpc/tm: Check for already reclaimed tasks

 arch/powerpc/include/asm/reg.h  |  1 +
 arch/powerpc/kernel/process.c   | 18 ++++++++++++++++++
 arch/powerpc/kernel/signal_32.c | 15 +++++++++------
 arch/powerpc/kernel/signal_64.c |  4 ++++
 4 files changed, 32 insertions(+), 6 deletions(-)

-- 
2.5.0
