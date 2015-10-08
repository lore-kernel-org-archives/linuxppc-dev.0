Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2C961A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 11:51:26 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC093140273
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 11:51:26 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 8 Oct 2015 10:51:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 95CF02BB0052
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 11:51:23 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t980pFSS61276296
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 11:51:23 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t980ooRE009539
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 11:50:51 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: khandual@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v3 0/2] powerpc/xmon: Paged output for paca display
Date: Thu,  8 Oct 2015 11:50:22 +1100
Message-Id: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>




Changes v2 -> v3:

Moved the pagination implementation from xmon.c to nonstdio.c where it's much
easier to do and the code is significantly simplified.

As it's now trivial to do, add the capability to truncate the output or to stop
pagination and dump the rest of the output.

Changed function naming scheme to read more easily (e.g.
xmon_start_pagination()).


Changes v1 -> v2:

* Removed pagination parameters from commands, replaced with new command to set
  page size. This works better for multiple commands and produces simpler code.
* Switched from encoding the page position in the command buffer to using some
  globals. Saves some memory and is less invasive to the command code.
* Added a patch to paginate the kernel log buffer display.


Sam Bobroff (2):
  powerpc/xmon: Paged output for paca display
  powerpc/xmon: Paginate kernel log buffer display

 arch/powerpc/xmon/nonstdio.c | 57 ++++++++++++++++++++++++++++++++++++++++++--
 arch/powerpc/xmon/nonstdio.h |  3 +++
 arch/powerpc/xmon/xmon.c     | 18 ++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.1.4
