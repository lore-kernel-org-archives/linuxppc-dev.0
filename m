Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93B57B6F65
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 17:45:47 +1000 (EST)
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <linuxppc-dev@ozlabs.org> from <prasad@linux.vnet.ibm.com>;
	Fri, 19 Aug 2011 08:42:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7J7iQFD1044710
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 17:44:26 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7J7jZFb017756
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 17:45:35 +1000
Date: Fri, 19 Aug 2011 13:15:27 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] Changes to PowerPC ptrace flags using watchpoints
Message-ID: <20110819074527.GA21817@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>, dwg@au1.ibm.com
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,
        Please find a set of two patches that introduce generic
hw-breakpoint interfaces for a couple of ptrace flags used by server-class
processors and another change to advertise a feature to user-space hitherto
available and used, but not claimed as supported.

GDB, which recently began using the
PPC_PTRACE_GETHWDBGINFO/PPC_PTRACE_SETHWDEBUG/PPC_PTRACE_DELHWDEBUG
flags on BookS processors is presently unable to set watchpoints. The
changes in Patch1, will fix that issue and help it use a common set of code
across BookE and BookS.

K.Prasad (2):
  [hw-breakpoint] Use generic hw-breakpoint interfaces for new PPC
    ptrace flags
  [PowerPC Book3E] Introduce new ptrace debug feature flag

 Documentation/powerpc/ptrace.txt  |   16 ++++++
 arch/powerpc/include/asm/ptrace.h |    1 +
 arch/powerpc/kernel/ptrace.c      |  105
++++++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 8 deletions(-)

Thanks,
K.Prasad
