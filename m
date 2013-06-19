Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40BF12C034C
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Jun 2013 16:34:11 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 11:59:14 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A2946394005B
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Jun 2013 12:04:03 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J6Y9HJ32505992
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Jun 2013 12:04:09 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J6Y1Aw017138
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Jun 2013 16:34:02 +1000
Message-ID: <51C150D8.2070706@linux.vnet.ibm.com>
Date: Wed, 19 Jun 2013 12:04:00 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v4 0/8] Nvram-to-pstore
References: <20130605184756.25794.43872.stgit@aruna-ThinkPad-T420>
 <1822.1371622503@ale.ozlabs.ibm.com>
In-Reply-To: <1822.1371622503@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, keescook@chromium.org,
 mahesh@linux.vnet.ibm.com, ccross@android.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
 cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wednesday 19 June 2013 11:45 AM, Michael Neuling wrote:
> Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com> wrote:
>> Currently the kernel provides the contents of p-series NVRAM only as a
>> simple stream of bytes via /dev/nvram, which must be interpreted in user
>> space by the nvram command in the powerpc-utils package. This patch set
>> exploits the pstore subsystem to expose each partition in NVRAM as a
>> separate file in /dev/pstore. For instance, Oops messages will be stored
>> in a file named [dmesg-nvram-2].
>>
>> Changes from v3:
>> 	- Change filename prefix for of-config and common partition
>>
>> Changes from v2:
>> 	- Fix renaming of pstore type ids in nvram.c
>>
>> Changes from v1:
>> 	- Reduce #ifdefs by and remove forward declarations of pstore callbacks
>> 	- Handle return value of nvram_write_os_partition
>> 	- Remove empty pstore callbacks and register pstore only when pstore
>> 	  is configured
> When booted on pHyp, I see /dev/nvram but not /dev/pstore, even if I
> turn on CONFIG_PSTORE.  Is there something else I need to add?

You need to mount pstore to access the files.

# mkdir /dev/pstore
# mount -t pstore - /dev/pstore

to unmount

# umount /dev/pstore

References: http://lwn.net/Articles/421297/
Documentation/ABI/testing/pstore

>
> Should we update pseries_defconfig to include CONFIG_PSTORE (which it
> doesn't include currently)?  Maybe turn on panic/oops via
> CONFIG_PSTORE_RAM too?

Yes. We should enable CONFIG_PSTORE by default in pseries_defconfig.
We need not enable CONFIG_PSTORE_RAM for our case. Its for systems with
persistent RAM.

> Other than that, the series looks clean.  It's passes my build and boot
> tests.
>
> I've not reviewed the contents of the patches.
>
> Mikey
>
>> ---
>>
>> Aruna Balakrishnaiah (8):
>>        powerpc/pseries: Remove syslog prefix in uncompressed oops text
>>        powerpc/pseries: Add version and timestamp to oops header
>>        powerpc/pseries: Introduce generic read function to read nvram-partitions
>>        powerpc/pseries: Read/Write oops nvram partition via pstore
>>        powerpc/pseries: Read rtas partition via pstore
>>        powerpc/pseries: Distinguish between a os-partition and non-os partition
>>        powerpc/pseries: Read of-config partition via pstore
>>        powerpc/pseries: Read common partition via pstore
>>
>>
>>   arch/powerpc/platforms/pseries/nvram.c |  353 +++++++++++++++++++++++++++-----
>>   fs/pstore/inode.c                      |    9 +
>>   include/linux/pstore.h                 |    4
>>   3 files changed, 313 insertions(+), 53 deletions(-)
>>
>> -- 
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
