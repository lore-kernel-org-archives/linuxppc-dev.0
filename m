Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 431372C00C6
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Aug 2013 20:40:17 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 1 Aug 2013 20:33:25 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EDC6B3578051
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Aug 2013 20:40:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r71AdxrX6881624
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Aug 2013 20:39:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r71Ae8Ah029400
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Aug 2013 20:40:09 +1000
Message-ID: <51FA3B02.7060004@linux.vnet.ibm.com>
Date: Thu, 01 Aug 2013 16:10:02 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, tony.luck@intel.com, keescook@chromium.org
Subject: Re: [PATCH 00/11] Add compression support to pstore
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com, ccross@android.com,
 anton@samba.org, cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tony/Kees,

     Could you please review and let me know your comments!!

Regards,
Aruna

On Monday 15 July 2013 10:25 PM, Aruna Balakrishnaiah wrote:
> The patchset adds compression support to pstore.
>
> As the non-volatile storage space is limited, adding compression
> support results in capturing more data within limited space.
>
> Size of dmesg file in a powerpc/pseries box with nvram's
> oops partition (to store oops-log) size 4k:
>
> Without compression:
> dmesg-nvram-1:  ~ 4k (3980)
> WIth compression:
> dmesg-nvram-1: ~8.8k (8844)
>
> Writing to persistent store
> ----------------------------
> Compression will reduce the size of oops/panic report to atmost 45% of its
> original size. (Based on experiments done while providing compression support
> to nvram by Jim keniston).
> Hence buffer of size ( (100/45 approx 2.22) *<registered_buffer> is allocated).
> The compression parameters selected based on some experiments:
> compression_level = 6, window_bits = 12, memory_level = 4  which achieved a
> significant compression of 12 % of uncompressed buffer size tried upto 36k.
> Data is compressed from the bigger buffer to registered buffer which is
> returned to backends.
> Pstore will indicate that with a flag 'compressed' which is passed to backends.
> Using this flag, backends will add a flag in their header to indicate the data
> is compressed or not while writing to persistent store.
>
>
> Reading from persistent store
> -----------------------------
> When backends read data from persistent store it will use the flag added by it
> while writing to persistent store to determine if the data is compressed or not.
> Using the information, it will set the flag in pstore's read call back.
> Pstore will decompress the data based on the flag and writes decompressed data
> to the file.
>
> Test results:
>
> Have tested the patches on powerpc/pseries.
> On Intel have only tested with erst backend.
>
> Efi-pstore and RAM persistent buffer requires testing.
>
>
> ---
>
> Aruna Balakrishnaiah (11):
>        powerpc/pseries: Remove (de)compression in nvram with pstore enabled
>        pstore: Add new argument 'compressed' in pstore write callback
>        pstore/Kconfig: Select ZLIB_DEFLATE and ZLIB_INFLATE when PSTORE is selected
>        pstore: Add compression support to pstore
>        pstore: Introduce new argument 'compressed' in the read callback
>        pstore: Provide decompression support to pstore
>        pstore: Add file extension to pstore file if compressed
>        powerpc/pseries: Read and write to the 'compressed' flag of pstore
>        erst: Read and write to the 'compressed' flag of pstore
>        efi-pstore: Read and write to the 'compressed' flag of pstore
>        pstore/ram: Read and write to the 'compressed' flag of pstore
>
>
>   arch/powerpc/platforms/pseries/nvram.c |  131 ++++----------------
>   drivers/acpi/apei/erst.c               |   21 ++-
>   drivers/firmware/efi/efi-pstore.c      |   27 +++-
>   fs/pstore/Kconfig                      |    2
>   fs/pstore/inode.c                      |    9 +
>   fs/pstore/internal.h                   |    5 -
>   fs/pstore/platform.c                   |  214 ++++++++++++++++++++++++++++++--
>   fs/pstore/ram.c                        |   41 +++++-
>   include/linux/pstore.h                 |    6 -
>   9 files changed, 307 insertions(+), 149 deletions(-)
>
