Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8FF942C00F8
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:20:07 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 11:45:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id ABEB5394004F
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 11:50:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O6JsJS41287744
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 11:49:55 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O6JwFI019569
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:20:00 +1000
Subject: [PATCH v2 0/8] powerpc/pseries: Nvram-to-pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 11:49:58 +0530
Message-ID: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
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
separate file in /dev/pstore. For instance Oops messages will stored in a
file named [dmesg-nvram-2].

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
