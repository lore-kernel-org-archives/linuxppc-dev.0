Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 538682C0095
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 18:33:00 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 18:21:21 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 999932CE8052
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 18:32:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R8Whq54391172
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 18:32:43 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R8WpTw003678
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 18:32:52 +1000
Subject: [PATCH v2 0/3] Nvram-to-pstore: compression support for oops data
To: tony.luck@intel.com, keescook@chromium.org, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Jun 2013 14:02:47 +0530
Message-ID: <20130627082941.16749.67023.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes from v1:
		- Add header size argument in the pstore write callback
		instead of a separate API to return header size.

The patchset takes care of compressing oops messages while writing to NVRAM,
so that more oops data can be captured in the given space.

big_oops_buf (2.22 * oops_data_sz) is allocated for compression.
oops_data_sz is oops header size less of oops partition size.

Pstore will internally call kmsg_dump to capture messages from printk
buffer. While returning the data to nvram it adds is own header.

For compression:
	Register pstore with big_oops_buf. 

In case compression fails, copy header added by pstore and
last oops_data_sz bytes (recent messages) of big_oops_buf to
nvram for which we need to know header size. 
	
patch 01/03 adds an additional argument for header size in pstore_write callback.

pstore read callback of nvram will read the compressed data and return the
decompressed data so that dmesg file (under /dev/pstore) is readable.

In case decompression fails, instead of having the compressed data (junk) in the
dmesg file it will skip and continue reading other partitions. This results in
absence of dmesg file but will still have files relating to other parititons.

---

Aruna Balakrishnaiah (3):
      Pass header size in the pstore write callback
      powerpc/pseries: Re-organise the oops compression code
      powerpc/pseries: Support compression of oops text via pstore


 arch/powerpc/platforms/pseries/nvram.c |  239 +++++++++++++++++++++++---------
 drivers/acpi/apei/erst.c               |    4 -
 drivers/firmware/efi/efi-pstore.c      |    2 
 fs/pstore/platform.c                   |   10 +
 fs/pstore/ram.c                        |    3 
 include/linux/pstore.h                 |    8 +
 6 files changed, 187 insertions(+), 79 deletions(-)

-- 
