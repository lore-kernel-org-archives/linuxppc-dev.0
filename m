Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZpKq2jtVzDrGC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 05:27:58 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6OJNdXb044088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:27:56 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ke8hjvnck-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:27:55 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Tue, 24 Jul 2018 15:27:55 -0400
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/7] powerpc: Modernize unhandled signals message
Date: Tue, 24 Jul 2018 16:27:13 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180724192720.32417-1-muriloo@linux.ibm.com>
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

The "unhandled signal NN" is not very informative.  We thought it would
be helpful adding a human-readable message describing what the signal
number means, printing the VMA address, and dumping the instructions.

We can add more informative messages, like informing what each code of a
SIGSEGV signal means.  We are open to suggestions.

I have collected some early feedback from Michael Ellerman about this
series and would love to hear more feedback from you all.

Before this series:

    Jul 24 13:01:07 localhost kernel: pandafault[5989]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00003fff85a75100 code 2

After this series:

    Jul 24 13:08:01 localhost kernel: pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
    Jul 24 13:08:01 localhost kernel: Instruction dump:
    Jul 24 13:08:01 localhost kernel: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
    Jul 24 13:08:01 localhost kernel: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

Cheers
Murilo

Murilo Opsfelder Araujo (7):
  powerpc/traps: Print unhandled signals in a separate function
  powerpc/traps: Return early in show_signal_msg()
  powerpc/reg: Add REG_FMT definition
  powerpc/traps: Use REG_FMT in show_signal_msg()
  powerpc/traps: Print VMA for unhandled signals
  powerpc/traps: Print signal name for unhandled signals
  powerpc/traps: Show instructions on exceptions

 arch/powerpc/include/asm/reg.h        |  6 +++
 arch/powerpc/include/asm/stacktrace.h |  7 +++
 arch/powerpc/kernel/process.c         | 28 +++++-----
 arch/powerpc/kernel/traps.c           | 73 +++++++++++++++++++++++----
 4 files changed, 89 insertions(+), 25 deletions(-)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

-- 
2.17.1
