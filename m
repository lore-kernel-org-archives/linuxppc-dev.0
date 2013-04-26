Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 20D192C00F4
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 19:56:02 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 15:21:33 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EFB113940059
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 15:25:56 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q9tqG666977942
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 15:25:52 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q9tstS006162
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 19:55:56 +1000
Subject: [RFC PATCH 0/3] Nvram-to-pstore: compression support for oops data
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 26 Apr 2013 15:25:54 +0530
Message-ID: <20130426094923.14323.80567.stgit@aruna-ThinkPad-T420>
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
      Retreive header size from pstore.
      powerpc/pseries: Re-organise the oops compression code
      powerpc/pseries: Support compression of oops text via pstore


 arch/powerpc/platforms/pseries/nvram.c |  236 +++++++++++++++++++++++---------
 fs/pstore/platform.c                   |    7 +
 include/linux/pstore.h                 |    6 +
 3 files changed, 182 insertions(+), 67 deletions(-)

-- 
