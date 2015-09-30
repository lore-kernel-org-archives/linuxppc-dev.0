Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2264C1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 21:22:18 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C2898140D19
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 21:22:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 21:22:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 493952BB004D
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 21:22:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8UBM4H663963226
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 21:22:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8UBLd0J012197
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 21:21:40 +1000
Message-ID: <560BC5B1.1050609@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 16:51:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux PPC dev <linuxppc-dev@ozlabs.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Regarding DSISR value of 0xa410
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Ben/Michael,

Why does 0xa410 value of DSISR called weird here ? What does this
signify ? Just wondering if we can replace it with a meaningful
macro instead.

arch/powerpc/kernel/exceptions-64s.S

/*
 * Hash table stuff
 */
        .align  7
do_hash_page:
        std     r3,_DAR(r1)
        std     r4,_DSISR(r1)

        andis.  r0,r4,0xa410            /* weird error? */

Regards
Anshuman
