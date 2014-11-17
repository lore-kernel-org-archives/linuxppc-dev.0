Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE0E71A018F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 04:42:25 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 17:42:21 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A3F192190043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 17:41:53 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAHHgKQI1311070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 17:42:20 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAHHgJNU027097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 10:42:19 -0700
Subject: [PATCH REPOST 0/3] VPHN parsing fixes
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Nov 2014 18:42:16 +0100
Message-ID: <20141117174216.7717.10926.stgit@bahia.local>
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

Repost with Cc: for Michael and Ben...

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


 arch/powerpc/mm/numa.c | 62 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

--
Greg
