Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C78A52C0495
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 16:22:59 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 16:20:11 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8261A3578052
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 16:22:53 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5O685Wj37814498
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 16:08:05 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5O6Mo6x021311
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 16:22:52 +1000
Subject: [RESEND PATCH 0/3] Nvram-to-pstore: compression support for oops data 
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 11:52:46 +0530
Message-ID: <20130624061936.12963.72529.stgit@aruna-ThinkPad-T420>
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
	
patch 01/03 will add a function in pstore to return the header size.

pstore read callback of nvram will read the compressed data and return the
decompressed data so that dmesg file (under /dev/pstore) is readable.

In case decompression fails, instead of having the compressed data (junk) in the
dmesg file it will skip and continue reading other partitions. This results in
absence of dmesg file but will still have files relating to other parititons.

---

Aruna Balakrishnaiah (3):
      Retreive header size from pstore
      powerpc/pseries: Re-organise the oops compression code
      powerpc/pseries: Support compression of oops text via pstore


 arch/powerpc/platforms/pseries/nvram.c |  236 +++++++++++++++++++++++---------
 fs/pstore/platform.c                   |    7 +
 include/linux/pstore.h                 |    6 +
 3 files changed, 182 insertions(+), 67 deletions(-)

-- 
