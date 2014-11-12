Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA4991A0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 19:31:34 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 08:31:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 607291B08049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 08:31:35 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC8VQoD2818326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 08:31:26 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC8VPNT025375
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 01:31:26 -0700
Subject: [PATCH 0/3] VPHN parsing fixes
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Nov 2014 09:31:23 +0100
Message-ID: <20141112083123.6492.22889.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following commit fixed an endianness issue in the VPHN code:

commit 5c9fb1899400096c6818181c525897a31d57e488
Author: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date:   Wed Oct 15 12:42:58 2014 +0200

    powerpc/vphn: NUMA node code expects big-endian

It was discussed at the time that we should patch the parsing code instead
of boldly fixing all the values returned by the hypervisor. It is the goal
of this series.

I have an extra question: PAPR+ says that H_HOME_NODE_ASSOCIATIVITY is supposed
to populate registers R4 to R9 with 16-bit or 32-bit values. This means that we
could theorically get 24 associativity domain numbers. According to this commentthe code is limited to 12 though:

/*
 * 6 64-bit registers unpacked into 12 32-bit associativity values. To form
 * the complete property we have to add the length in the first cell.
 */
#define VPHN_ASSOC_BUFSIZE (VPHN_REGISTER_COUNT*sizeof(u64)/sizeof(u32) + 1)

I could find no justification for the fact that we don't expect the registers
to hold 16-bit relevant numbers only. Have I missed something ?

---

Greg Kurz (3):
      powerpc/vphn: clarify the H_HOME_NODE_ASSOCIATIVITY API
      powerpc/vphn: simplify the parsing code
      powerpc/vphn: move endianness fixing to vphn_unpack_associativity()


 arch/powerpc/mm/numa.c |   61 ++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

--
Greg
