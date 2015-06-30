Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C50C41A1024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 21:02:19 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 987CC1402C0
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:19 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 21:02:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 869703578052
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:15 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5UB26uC45547764
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:02:15 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5UB1gBu028791
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:01:42 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v3 0/5] GPT fixes/cleanup and LVM support with FAT
Date: Tue, 30 Jun 2015 16:31:16 +0530
Message-Id: <1435662081-4293-1-git-send-email-nikunj@linux.vnet.ibm.com>
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

patch 3: Rename block / read-sector to indicate it a allocated buffer

patch 4: As we need to detect FAT partition, implement a helper that
	 can be used both from GPT code and "fat-bootblock?"

patch 5: Implement GPT FAT for LVM suport and make GPT detection code
	 robust

Changelog V2:
* Optimize gpt detection code
* Fixed stack comments
* Rename verify-gpt-partition, as it was doing more than that. Added
  comments.

Nikunj A Dadhania (5):
  disk-label: simplify gpt-prep-partition? routine
  introduce 8-byte LE helpers
  disk-label: rename confusing "block" word
  disk-label: introduce helper to check fat filesystem
  disk-label: add support for booting from GPT FAT partition

 slof/fs/little-endian.fs       |   6 ++
 slof/fs/packages/disk-label.fs | 211 ++++++++++++++++++++++++++---------------
 2 files changed, 138 insertions(+), 79 deletions(-)

-- 
2.4.3
