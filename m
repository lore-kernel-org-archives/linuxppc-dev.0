Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB0492C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 06:29:11 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 00:59:05 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E4D61E0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 01:02:14 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s13JT4fH2752928
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 00:59:05 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s13JT2aK000639
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 00:59:02 +0530
Received: from [192.168.1.7] ([9.79.188.145])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s13JT2qg000628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 00:59:02 +0530
Subject: [PATCH V4 0/3] powerpc/powernv: Error logging interfaces 
To: linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 04 Feb 2014 00:59:23 +0530
Message-ID: <20140203192915.7790.20325.stgit@deepthi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series defines generic interfaces for error logging to
push down critical errors from powernv platform to FSP.

Also, it contains few minor fixes for the exisiting error logging
framework that retrieves error logs from FSP.

Changes from V3:
* Change memory allocation to GFP_ATOMIC, to generate
  errors in bad context
* Move all error log generation related code to arch/powernv
  rename it from opal_* to pnv_* .

Changes from V2:
* Review comments from V2 have been addressed
  includes comment formats, changing naming
  conventions and incorporated error handling
  of the buffers.
* Minor typo fix and use of pr_err/pr_fmt to
  log errors.

 Deepthi Dharwar (3):
      powernv: Push critical error logs to FSP
      powernv: Correct spell error in opal-elog.c
      powernv: Have uniform logging of errors in opal-elog.c


 arch/powerpc/include/asm/opal.h                |   36 +++++++++
 arch/powerpc/platforms/powernv/opal-elog.c     |   93 +++++++++++++++++++++---
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 -
 arch/powerpc/platforms/powernv/powernv.h       |   84 ++++++++++++++++++++++
 4 files changed, 203 insertions(+), 12 deletions(-)


-- Deepthi
