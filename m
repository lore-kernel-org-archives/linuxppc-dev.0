Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404VjK1q5xzF0xF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 20:13:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2J99bHm094745
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 05:13:22 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gt51s2xxu-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 05:13:22 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 19 Mar 2018 09:13:20 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH 0/2] Disable ftrace during kvm guest entry/exit
Date: Mon, 19 Mar 2018 14:42:59 +0530
Message-Id: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a follow on from the RFC posted at:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg130047.html

This series implements a new field in paca called 'ftrace_disabled' to 
be set whenever we want to skip function tracing. This is currently only 
used by KVM guest entry/exit and as such, it is guarded in CONFIG_KVM as 
suggested by Steven Rostedt. This has had some minimal testing, and I 
will continue to test it this week and report back if I see any issues.

- Naveen


Naveen N. Rao (2):
  powerpc64/ftrace: Add a field in paca to disable ftrace in unsafe code
    paths
  powerpc64/ftrace: Disable ftrace during kvm guest entry/exit

 arch/powerpc/include/asm/paca.h                |  1 +
 arch/powerpc/kernel/asm-offsets.c              |  1 +
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 13 +++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  6 ++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |  8 ++++++++
 5 files changed, 29 insertions(+)

-- 
2.16.2
