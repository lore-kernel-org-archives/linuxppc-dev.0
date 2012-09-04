Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04EA42C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 19:02:01 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Sep 2012 14:31:56 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8491sEC5505518
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Sep 2012 14:31:54 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8491rif027438
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Sep 2012 19:01:53 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V7 0/12] arch/powerpc: Add 64TB support to ppc64
Date: Tue,  4 Sep 2012 14:31:17 +0530
Message-Id: <1346749289-16986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patchset include patches for supporting 64TB with ppc64. I haven't booted
this on hardware with 64TB memory yet. But they boot fine on real hardware with
less memory. Changes extend VSID bits to 38 bits for a 256MB segment
and 26 bits for 1TB segments.

Changes from V6:
 * rebase to latest upstream (5b716ac728bcc01b1f2a7ed6e437196602237c27)

Changes from v5:
 * Address review feedback

Changes from v4:
 * Drop patch "arch/powerpc: properly offset the context bits for 1T segemnts"
   based on review feedback
 * split CONTEXT_BITS related changes from patch 12
 * Add a new doc update patch

Changes from v3:
 * Address review comments.
 * Added new patch to ensure proto-VSID isolation between kernel and user space

Changes from V2:
 * Fix few FIXMEs in the patchset. I have added them as separate patch for
   easier review. That should help us to drop those changes if we don't agree.

Changes from V1:
* Drop the usage of structure (struct virt_addr) to carry virtual address.
  We now represent virtual address via vpn which is virtual address shifted
  right 12 bits.

Thanks,
-aneesh
