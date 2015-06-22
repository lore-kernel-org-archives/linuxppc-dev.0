Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 567011A0F49
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 18:00:13 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6B8D8140311
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 18:00:06 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 13:29:54 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9AC6CE0064
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:33:25 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5M7xpBC1573238
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:29:51 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5M7xnAW008346
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2015 13:29:50 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com
Cc: benh@kernel.crashing.org, aik@ozlabs.ru, dvaleev@suse.com,
 nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF 0/5] GPT fixes/cleanup and LVM support with FAT
Date: Mon, 22 Jun 2015 13:29:42 +0530
Message-Id: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Following patchset implements some improvements and cleanup for the
GPT booting code:

patch 1: Simplify the gpt detection code with lesser scopes and add
         comments.
patch 2: Introduce 8byte LE helpers: x@-le and x!-le
patch 3: As we need to detect FAT partition, implement a helper that
      	 can be used both from GPT code and "try-dos-files"
patch 4: Implement GPT FAT for LVM suport.
patch 5: Make GPT detection code robust 

Nikunj A Dadhania (5):
  disk-label: simplify gpt-prep-partition? routine
  introduce 8-byte LE helpers
  disk-label: introduce helper to check fat filesystem
  disk-label: add support for booting from GPT FAT partition
  disk-label: make gpt detection code more robust

 slof/fs/little-endian.fs       |   6 ++
 slof/fs/packages/disk-label.fs | 141 +++++++++++++++++++++++++++--------------
 2 files changed, 101 insertions(+), 46 deletions(-)

-- 
1.8.3.1
