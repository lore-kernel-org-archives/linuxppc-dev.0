Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76FB31A0C90
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 02:14:23 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 23 Feb 2015 15:14:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 35C6F219004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:14:09 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1NFEFrv49479722
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:14:15 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1NFEE4k014912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 08:14:15 -0700
Subject: [PATCH v3 0/5] VPHN parsing fixes
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Feb 2015 16:14:12 +0100
Message-ID: <20150223151412.21565.2251.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael,

As suggested in...

https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/124647.html

... I repost the whole series with an extra patch to implement selftests
for VPHN (this is the only change between v2 and v3).

Please review.

---

Greg Kurz (5):
      powerpc/vphn: clarify the H_HOME_NODE_ASSOCIATIVITY API
      powerpc/vphn: move endianness fixing to vphn_unpack_associativity()
      powerpc/vphn: move VPHN parsing logic to a separate file
      powerpc/vphn: parsing code rewrite
      selftests, powerpc: Add test for VPHN


 arch/powerpc/mm/Makefile                          |    1 
 arch/powerpc/mm/numa.c                            |   55 ---
 arch/powerpc/mm/vphn.c                            |   70 ++++
 arch/powerpc/mm/vphn.h                            |   16 +
 tools/testing/selftests/powerpc/Makefile          |    2 
 tools/testing/selftests/powerpc/utils.h           |    1 
 tools/testing/selftests/powerpc/vphn/.gitignore   |    1 
 tools/testing/selftests/powerpc/vphn/Makefile     |   15 +
 tools/testing/selftests/powerpc/vphn/parse-vphn.c |  403 +++++++++++++++++++++
 tools/testing/selftests/powerpc/vphn/vphn.c       |    1 
 tools/testing/selftests/powerpc/vphn/vphn.h       |    1 
 11 files changed, 513 insertions(+), 53 deletions(-)
 create mode 100644 arch/powerpc/mm/vphn.c
 create mode 100644 arch/powerpc/mm/vphn.h
 create mode 100644 tools/testing/selftests/powerpc/vphn/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/vphn/Makefile
 create mode 100644 tools/testing/selftests/powerpc/vphn/parse-vphn.c
 create mode 120000 tools/testing/selftests/powerpc/vphn/vphn.c
 create mode 120000 tools/testing/selftests/powerpc/vphn/vphn.h

--
Greg
