Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3C1A1A072B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:46:37 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 83B7D1402ED
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:37 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 16:46:35 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D605A2CE8056
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:32 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P6kOIn64487522
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:46:33 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P6jx2C021948
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:45:59 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com, segher@kernel.crashing.org
Cc: aik@ozlabs.ru, dvaleev@suse.com, nikunj@linux.vnet.ibm.com
Subject: [PATCH SLOF v2 0/5] GPT fixes/cleanup and LVM support with FAT
Date: Thu, 25 Jun 2015 12:15:24 +0530
Message-Id: <1435214729-15952-1-git-send-email-nikunj@linux.vnet.ibm.com>
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

Nikunj A Dadhania (5):
  disk-label: simplify gpt-prep-partition? routine
  introduce 8-byte LE helpers
  disk-label: rename confusing "block" word
  disk-label: introduce helper to check fat filesystem
  disk-label: add support for booting from GPT FAT partition

 slof/fs/little-endian.fs       |   6 ++
 slof/fs/packages/disk-label.fs | 209 +++++++++++++++++++++++++----------------
 2 files changed, 136 insertions(+), 79 deletions(-)

-- 
2.4.3
