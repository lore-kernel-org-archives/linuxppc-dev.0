Return-Path: <siccegge@cs.fau.de>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5394DB7D61
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 20:04:48 +1000 (EST)
Date: Wed, 9 Jun 2010 11:58:35 +0200
From: Christoph Egger <siccegge@cs.fau.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Albert Herranz <albert_herranz@yahoo.es>,
	Grant Likely <grant.likely@secretlab.ca>,
	Li Yang <leoli@freescale.com>, Tejun Heo <tj@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Huang Weiyi <weiyi.huang@gmail.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Removing dead code
Message-ID: <cover.1275925219.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vamos@i4.informatik.uni-erlangen.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all!

        As part of the VAMOS[0] research project at the University of
Erlangen we are looking at multiple integrity errors in linux'
configuration system.

	      I've been running a check on the arch/powerpc sourcetree
	      for
config Items not defined in Kconfig and found5 such chases. Sourcecode
blocks depending on these Items are not reachable from a vanilla
kernel -- dead code. I've seen such dead blocks made on purpose
e.g. while integrating new features into the kernel but generally
they're just useless. 

	Each of the patches in this patchset removes on such dead
config Item, I'd be glad if you consider applying them. I've been
doing deeper analysis of such issues before and can do so again but
I'm not so sure they were fastly usefull. However I've done a
testbuild on ppc with allmodconfig so it should at least build.

        Please keep me informed of this patch getting confirmed /
merged so we can keep track of it.

Regards

        Christoph Egger

[0] http://vamos1.informatik.uni-erlangen.de/

Christoph Egger (5):
  Removing dead BOOK3E_MMU_TLB_STATS
  Removing dead CONFIG_HIGHPTE
  Removing dead CONFIG_SMP_750
  Removing dead CONFIG_SERIAL_TEXT_DEBUG
  Removing dead CONFIG_PPC47x

 arch/powerpc/include/asm/exception-64e.h |   38 ------------------------------
 arch/powerpc/kernel/head_40x.S           |   19 ---------------
 arch/powerpc/mm/44x_mmu.c                |    4 ---
 arch/powerpc/mm/pgtable_32.c             |    4 ---
 arch/powerpc/mm/tlb_hash32.c             |    4 ---
 arch/powerpc/mm/tlb_low_64e.S            |    9 -------
 6 files changed, 0 insertions(+), 78 deletions(-)
