Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402JGt6JZZzF15q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 06:16:22 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 David Gibson <david@gibson.dropbear.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Tobin C. Harding" <me@tobin.cc>, Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 0/9] powerpc barrier_nospec
Date: Thu, 15 Mar 2018 20:15:49 +0100
Message-Id: <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, it is good idea to add some commit messages.

Also I rebased the patches on top v3 of series

Setup RFI flush after PowerVM LPM migration

Thanks

Michal

Michal Suchanek (9):
  powerpc: Add barrier_nospec
  powerpc: Use barrier_nospec in copy_from_user
  powerpc/64: Use barrier_nospec in syscall entry
  powerpc/64s: Use barrier_nospec in RFI_FLUSH_SLOT
  powerpc/64s: Add support for ori barrier_nospec patching
  powerpc/64: Patch barrier_nospec in modules
  powerpc/64: barrier_nospec: Add debugfs trigger
  powerpc/64s: barrier_nospec: Add hcall triggerr
  powerpc/64: barrier_nospec: Add commandline trigger

 arch/powerpc/include/asm/barrier.h        |  9 ++++
 arch/powerpc/include/asm/exception-64s.h  |  2 +-
 arch/powerpc/include/asm/feature-fixups.h |  9 ++++
 arch/powerpc/include/asm/setup.h          | 11 ++++
 arch/powerpc/include/asm/uaccess.h        | 11 +++-
 arch/powerpc/kernel/entry_64.S            |  3 ++
 arch/powerpc/kernel/module.c              |  6 +++
 arch/powerpc/kernel/setup_64.c            | 87 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |  7 +++
 arch/powerpc/lib/feature-fixups.c         | 47 ++++++++++++++---
 arch/powerpc/platforms/pseries/mobility.c |  2 +-
 arch/powerpc/platforms/pseries/pseries.h  |  2 +-
 arch/powerpc/platforms/pseries/setup.c    | 37 +++++++++----
 13 files changed, 213 insertions(+), 20 deletions(-)

-- 
2.13.6
