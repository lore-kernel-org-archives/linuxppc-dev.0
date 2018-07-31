Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fzrc3N1czF1F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 00:50:40 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6VE8vie120644
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 10:50:38 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kjr56n11h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 10:50:37 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Tue, 31 Jul 2018 08:50:36 -0600
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Joe Perches <joe@perches.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/9] powerpc: Modernize unhandled signals message
Date: Tue, 31 Jul 2018 11:50:11 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180731145020.14009-1-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, everyone.

This series was inspired by the need to modernize and display more
informative messages about unhandled signals.

The "unhandled signal NN" is not very informative.  We thought it would be
helpful adding a human-readable message describing what the signal number
means, printing the VMA address, and dumping the instructions.

Before this series:

  pandafault32[4724]: unhandled signal 11 at 100005e4 nip 10000444 lr 0fe31ef4 code 2

  pandafault64[4725]: unhandled signal 11 at 0000000010000718 nip 0000000010000574 lr 00007fff7faa7a6c code 2

After this series:

  pandafault32[4753]: segfault (11) at 100005e4 nip 10000444 lr fe31ef4 code 2 in pandafault32[10000000+10000]
  pandafault32[4753]: code: 4bffff3c 60000000 60420000 4bffff30 9421ffd0 93e1002c 7c3f0b78 3d201000
  pandafault32[4753]: code: 392905e4 913f0008 813f0008 39400048 <99490000> 39200000 7d234b78 397f0030

  pandafault64[4754]: segfault (11) at 10000718 nip 10000574 lr 7fffb0007a6c code 2 in pandafault64[10000000+10000]
  pandafault64[4754]: code: e8010010 7c0803a6 4bfffef4 4bfffef0 fbe1fff8 f821ffb1 7c3f0b78 3d22fffe
  pandafault64[4754]: code: 39298818 f93f0030 e93f0030 39400048 <99490000> 39200000 7d234b78 383f0050

Link to v2:

  https://lore.kernel.org/lkml/20180727145811.12334-1-muriloo@linux.ibm.com/

v2..v3:

  - Dropped patch 3
  - Updated patch 4 to use %lx

Cheers!

Murilo Opsfelder Araujo (9):
  powerpc/traps: Print unhandled signals in a separate function
  powerpc/traps: Return early in show_signal_msg()
  powerpc/traps: Use %lx format in show_signal_msg()
  powerpc/traps: Print VMA for unhandled signals
  powerpc/traps: Print signal name for unhandled signals
  powerpc: Do not call __kernel_text_address() in show_instructions()
  powerpc: Add stacktrace.h header
  powerpc/traps: Show instructions on exceptions
  powerpc/traps: Add line prefix in show_instructions()

 arch/powerpc/include/asm/stacktrace.h | 13 +++++
 arch/powerpc/kernel/process.c         | 13 +++--
 arch/powerpc/kernel/traps.c           | 72 +++++++++++++++++++++++----
 3 files changed, 83 insertions(+), 15 deletions(-)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

-- 
2.17.1
