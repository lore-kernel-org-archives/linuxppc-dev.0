Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FCAC1A0070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:40 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Thu, 25 Sep 2014 16:41:39 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 788472CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:37 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P6HSXF54001814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:17:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P6faEL025600
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:36 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8P6faWD025597
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:36 +1000
Received: from cyril.ozlabs.ibm.com (haven.au.ibm.com [9.190.164.82])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8BD63A004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:30 +1000 (EST)
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] fix bugs in mobility RTAS calls
Date: Thu, 25 Sep 2014 16:41:27 +1000
Message-Id: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset addresses endian issues and bugs in device tree update for
ibm,update-nodes and ibm,update-properties RTAS calls.

A subseqent patchset will deal with issues in device tree node addition
(ibm,configure-connector RTAS call) as well as more robust handling of
deleting critical device tree nodes.

v1 attempted to keep the structure of the existing code.
v2 rewrites the relevent sections of mobility.c.

Cyril Bur (3):
  drivers/of: add of_changeset_apply_locked
  powerpc/pseries: create rtas buffer accessor
  powerpc/pseries: fix bugs in mobility RTAS calls

 arch/powerpc/platforms/pseries/Makefile      |   4 +-
 arch/powerpc/platforms/pseries/mobility.c    | 406 ++++++++++++++++-----------
 arch/powerpc/platforms/pseries/pseries.h     |  41 +++
 arch/powerpc/platforms/pseries/rtas_buffer.c | 126 +++++++++
 drivers/of/dynamic.c                         |  11 +
 include/linux/of.h                           |   1 +
 6 files changed, 425 insertions(+), 164 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/rtas_buffer.c

-- 
1.9.1
