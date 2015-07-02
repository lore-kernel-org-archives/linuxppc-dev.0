Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 112951A0FFD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 21:35:49 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66B391402BD
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 21:35:48 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 17:05:42 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5BC4DE005B
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 17:09:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t62BZfoj51445882
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 17:05:42 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62ARDvp016521
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 15:57:14 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v4 0/4] GPT fixes and LVM support with FAT
Date: Thu,  2 Jul 2015 17:05:34 +0530
Message-Id: <1435836938-22889-1-git-send-email-nikunj@linux.vnet.ibm.com>
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
	 can be used both from GPT code and "fat-bootblock?"

patch 4: Implement GPT FAT for LVM suport and make GPT detection code
	 robust

Changelog v3:
* Dropped patch for renaming "block" variable
* Fix bug in seek-pos updation code

Changelog V2:
* Optimize gpt detection code
* Fixed stack comments
* Rename verify-gpt-partition, as it was doing more than that. Added
  comments.

Nikunj A Dadhania (4):
  disk-label: simplify gpt-prep-partition? routine
  introduce 8-byte LE helpers
  disk-label: introduce helper to check fat filesystem
  disk-label: add support for booting from GPT FAT partition

 slof/fs/little-endian.fs       |   6 ++
 slof/fs/packages/disk-label.fs | 162 +++++++++++++++++++++++++++--------------
 2 files changed, 112 insertions(+), 56 deletions(-)

-- 
2.4.3
