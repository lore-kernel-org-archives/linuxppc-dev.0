Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DD7732C0089
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:21:00 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 17:15:21 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0BCC72BB0057
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:20:56 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A77bDK41156714
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:07:37 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A7Ks1t016133
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:20:55 +1000
Subject: [PATCH 0/8] Nvram-to-pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 10 Apr 2013 12:50:47 +0530
Message-ID: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kernel provides the contents of p-series NVRAM only as a
simple stream of bytes via /dev/nvram, which must be interpreted in user
space by the nvram command in the powerpc-utils package.  This patch set
exploits the pstore subsystem to expose each partition in NVRAM as a
separate file in /dev/pstore. For instance Oops messages will stored in a
file named [dmesg-nvram-2].

---

Aruna Balakrishnaiah (8):
      Remove syslog prefix in uncompressed oops text
      Add version and timestamp to oops header
      Introduce generic read function to read nvram-partitions
      Read/Write oops nvram partition via pstore
      Read rtas partition via pstore
      Distinguish between a os-partition and non-os partition
      Read of-config partition via pstore
      Read common partition via pstore


 arch/powerpc/platforms/pseries/nvram.c |  329 ++++++++++++++++++++++++++++----
 fs/pstore/inode.c                      |    9 +
 include/linux/pstore.h                 |    4 
 3 files changed, 304 insertions(+), 38 deletions(-)

-- 
