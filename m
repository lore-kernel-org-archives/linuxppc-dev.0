Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E02011A0221
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 14:25:35 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99866140784
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 21 Aug 2015 14:25:32 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AAF633578052
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7L4PLDL64946246
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7L4OuAr006657
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:24:56 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com
Subject: [PATCH v2 0/2] powerpc/xmon: Paged output for paca display
Date: Fri, 21 Aug 2015 14:24:26 +1000
Message-Id: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>




Changes v1 -> v2:

* Removed pagination parameters from commands, replaced with new command to set
  page size. This works better for multiple commands and produces simpler code.
* Switched from encoding the page position in the command buffer to using some
  globals. Saves some memory and is less invasive to the command code.
* Added a patch to paginate the kernel log buffer display.


Sam Bobroff (2):
  powerpc/xmon: Paged output for paca display
  powerpc/xmon: Paginate kernel log buffer display

 arch/powerpc/xmon/xmon.c | 89 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 16 deletions(-)

-- 
2.1.4
