Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4013Qn2TSdzDrBv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 05:33:52 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, Michal Suchanek <msuchanek@suse.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Tobin C. Harding" <me@tobin.cc>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Neuling <mikey@neuling.org>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Russell Currey <ruscur@russell.cc>,
 Joe Perches <joe@perches.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/8] powerpc barrier_nospec
Date: Tue, 13 Mar 2018 19:32:58 +0100
Message-Id: <cover.1520965380.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

this is patchset adding barrier_nospec on powerpc. It is based on the
out-of-tree gmb() patch and the existing rfi patches.

I do not have the tests for the Spectre/Meltdown issues available so this is
untested.

Feedback on the general approach as well as actual effectivity is welcome.

Thanks

Michal


Michal Suchanek (8):
  powerpc: Add barrier_nospec
  powerpc: Use barrier_nospec in copy_from_user
  powerpc/64: Use barrier_nospec in syscall entry
  powerpc/64s: Add support for ori barrier_nospec
  powerpc/64: Patch barrier_nospec in modules
  powerpc/64: barrier_nospec: Add debugfs trigger
  powerpc/64s: barrier_nospec: Add hcall triggerr
  powerpc/64: barrier_nospec: Add commandline trigger

 arch/powerpc/include/asm/barrier.h        |  9 ++++
 arch/powerpc/include/asm/feature-fixups.h |  9 ++++
 arch/powerpc/include/asm/setup.h          | 11 +++++
 arch/powerpc/include/asm/uaccess.h        | 11 ++++-
 arch/powerpc/kernel/entry_64.S            |  3 ++
 arch/powerpc/kernel/module.c              |  6 +++
 arch/powerpc/kernel/setup_64.c            | 72 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |  7 +++
 arch/powerpc/lib/feature-fixups.c         | 38 ++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c    | 38 ++++++++++------
 10 files changed, 190 insertions(+), 14 deletions(-)

-- 
2.13.6
