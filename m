Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id 9A249DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 02:29:25 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id b25so48317rvf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:29:24 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Mar 2009 09:29:24 -0600
Message-ID: <fa686aa40903170829m4ca9def0k4e33b1012f654fa8@mail.gmail.com>
Subject: Please pull mpc52xx-next - CPU_FTR_NEED_COHERENT fixes for 2.6.29
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Piotr Ziecik <kosmo@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Here are 2 coherency related fixes that need to go into 2.6.29.  The
first is the patch we discussed last night about setting
CPU_FTR_NEED_COHERENT when the 5200 is selected.  After discussing it
with galak, we agreed to stick with the ugly way for 2.6.29 and then
fix all of them at once in 2.6.30 (CONFIG_PPC_83XX, CONFIG_PPC_8260
and CONFIG_PPC_MPC52xx).

Second is Kumar's page table _PAGE_COHERENT fix.  I've tested it on MPC5200.

Cheers,
g.

The following changes since commit 5bee17f18b595937e6beafeee5197868a3f74a06:
  Kyle McMartin (1):
        parisc: sba_iommu: fix build bug when CONFIG_PARISC_AGP=y

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git merge

Kumar Gala (1):
      powerpc/mm: Respect _PAGE_COHERENT on classic ppc32 SW

Piotr Ziecik (1):
      powerpc/5200: Enable CPU_FTR_NEED_COHERENT for MPC52xx

 arch/powerpc/include/asm/cputable.h |    4 +++-
 arch/powerpc/kernel/head_32.S       |    6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
