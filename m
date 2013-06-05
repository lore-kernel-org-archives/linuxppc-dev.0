Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5A9F2C00A7
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 05:01:09 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 6 Jun 2013 00:24:43 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B46BBE004C
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 00:33:51 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r55J0wEg1835510
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2013 00:30:58 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r55J11Op001869
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2013 05:01:03 +1000
Message-ID: <51AF8AEA.4030702@linux.vnet.ibm.com>
Date: Thu, 06 Jun 2013 00:30:58 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
Subject: Re: [RFC PATCH 0/3] Nvram-to-pstore: compression support for oops data
References: <20130426094923.14323.80567.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130426094923.14323.80567.stgit@aruna-ThinkPad-T420>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, keescook@chromium.org,
 mahesh@linux.vnet.ibm.com, cbouatmailru@gmail.com, anton@samba.org,
 ccross@android.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

There is no change in this patchset and it applies cleanly on top of
v4 of Nvram-to-pstorepatches.

> The patchset takes care of compressing oops messages while writing to NVRAM,
> so that more oops data can be captured in the given space.
>
> big_oops_buf (2.22 * oops_data_sz) is allocated for compression.
> oops_data_sz is oops header size less of oops partition size.
>
> Pstore will internally call kmsg_dump to capture messages from printk
> buffer. While returning the data to nvram it adds is own header.
>
> For compression:
> 	Register pstore with big_oops_buf.
>
> In case compression fails, copy header added by pstore and
> last oops_data_sz bytes (recent messages) of big_oops_buf to
> nvram for which we need to know header size.
> 	
> patch 01/03 will add a function in pstore to return the header size.
>
> pstore read callback of nvram will read the compressed data and return the
> decompressed data so that dmesg file (under /dev/pstore) is readable.
>
> In case decompression fails, instead of having the compressed data (junk) in the
> dmesg file it will skip and continue reading other partitions. This results in
> absence of dmesg file but will still have files relating to other parititons.
>
>
> ---
>
> Aruna Balakrishnaiah (3):
>        Retreive header size from pstore.
>        powerpc/pseries: Re-organise the oops compression code
>        powerpc/pseries: Support compression of oops text via pstore
>
>
>   arch/powerpc/platforms/pseries/nvram.c |  236 +++++++++++++++++++++++---------
>   fs/pstore/platform.c                   |    7 +
>   include/linux/pstore.h                 |    6 +
>   3 files changed, 182 insertions(+), 67 deletions(-)
>
