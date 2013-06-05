Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E5392C0082
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 04:50:58 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 6 Jun 2013 04:42:02 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 785B23578051
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 04:50:51 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r55Ioh6Q25297070
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2013 04:50:43 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r55Ioo0k006095
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2013 04:50:51 +1000
Subject: [PATCH v4 0/8] Nvram-to-pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 06 Jun 2013 00:20:39 +0530
Message-ID: <20130605184756.25794.43872.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com,
 keescook@chromium.org
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
space by the nvram command in the powerpc-utils package. This patch set
exploits the pstore subsystem to expose each partition in NVRAM as a
separate file in /dev/pstore. For instance, Oops messages will be stored
in a file named [dmesg-nvram-2].

Changes from v3:
	- Change filename prefix for of-config and common partition

Changes from v2:
	- Fix renaming of pstore type ids in nvram.c

Changes from v1:
	- Reduce #ifdefs by and remove forward declarations of pstore callbacks
	- Handle return value of nvram_write_os_partition
	- Remove empty pstore callbacks and register pstore only when pstore
	  is configured
---

Aruna Balakrishnaiah (8):
      powerpc/pseries: Remove syslog prefix in uncompressed oops text
      powerpc/pseries: Add version and timestamp to oops header
      powerpc/pseries: Introduce generic read function to read nvram-partitions
      powerpc/pseries: Read/Write oops nvram partition via pstore
      powerpc/pseries: Read rtas partition via pstore
      powerpc/pseries: Distinguish between a os-partition and non-os partition
      powerpc/pseries: Read of-config partition via pstore
      powerpc/pseries: Read common partition via pstore


 arch/powerpc/platforms/pseries/nvram.c |  353 +++++++++++++++++++++++++++-----
 fs/pstore/inode.c                      |    9 +
 include/linux/pstore.h                 |    4 
 3 files changed, 313 insertions(+), 53 deletions(-)

-- 
