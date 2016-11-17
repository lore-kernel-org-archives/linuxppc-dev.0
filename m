Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKPfZ59SvzDvrq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 02:09:10 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAHF8gmt131617
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:08 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26sern8qjm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 10:09:07 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 20:39:04 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7A9B03940062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAHF91i839583896
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:01 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAHF8vB1004118
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:39:00 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [RFC PATCH 0/4] Blacklist powerpc exception vectors from kprobes
Date: Thu, 17 Nov 2016 20:38:29 +0530
Message-Id: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the beginning of work to come up with a more relevant kprobe
blacklist on powerpc. In this series, we primarily blacklist exception
vectors and kernel entry code.

Naveen N. Rao (4):
  powerpc: asm: introduce new macros for assembly globals
  powerpc: kprobe: add arch specific blacklist
  powerpc: mm/slb: convert slb_low.S to use the new macros
  powerpc: mm/slb: blacklist symbols from kprobe

 arch/powerpc/include/asm/ppc_asm.h | 19 +++++++++++++++++--
 arch/powerpc/kernel/entry_32.S     |  2 ++
 arch/powerpc/kernel/entry_64.S     |  2 ++
 arch/powerpc/kernel/kprobes.c      | 10 ++++++++++
 arch/powerpc/mm/slb_low.S          | 30 +++++++++++++-----------------
 5 files changed, 44 insertions(+), 19 deletions(-)

-- 
2.10.2
