Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 71F802C009E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:42:41 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Sat, 18 Jan 2014 08:12:37 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 40371394004E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 08:12:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0I2gP1w64291016
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 08:12:25 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0I2gY6B022393
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 08:12:34 +0530
Subject: [PATCH V3 0/3] powerpc/powernv: Error logging interfaces 
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Sat, 18 Jan 2014 08:12:54 +0530
Message-ID: <20140118024150.13537.11381.stgit@deepthi>
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

This patch only adds the framework to log errors. Coming days this
framework will be used to report all POWERNV errors in a phased manner.
We would ideally be targeting one sub-system at a time and use these
interfaces.

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


 arch/powerpc/include/asm/opal.h                |  123 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-elog.c     |   92 ++++++++++++++++--
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 3 files changed, 207 insertions(+), 9 deletions(-)


-- Deepthi
