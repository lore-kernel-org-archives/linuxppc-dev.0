Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 353DA2C0090
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 15:53:30 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 11:18:31 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B43E11258023
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 11:25:00 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3P5rFN848562348
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 11:23:16 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3P5rKFB028739
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 15:53:21 +1000
Message-ID: <5178C4CE.70201@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 11:23:18 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/8] powerpc/pseries: Nvram-to-pstore
References: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
 <CAGXu5jLrtMFXh28b2uV6+U8vdXRfLxmjKRo8i5YF8bmkeK_sKg@mail.gmail.com>
In-Reply-To: <CAGXu5jLrtMFXh28b2uV6+U8vdXRfLxmjKRo8i5YF8bmkeK_sKg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, Tony Luck <tony.luck@intel.com>,
 Colin Cross <ccross@android.com>, LKML <linux-kernel@vger.kernel.org>,
 Anton Vorontsov <cbouatmailru@gmail.com>, linuxppc-dev@ozlabs.org,
 paulus@samba.org, anton@samba.org, mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kees,

On Thursday 25 April 2013 02:15 AM, Kees Cook wrote:
> On Tue, Apr 23, 2013 at 11:19 PM, Aruna Balakrishnaiah
> <aruna@linux.vnet.ibm.com> wrote:
>> Currently the kernel provides the contents of p-series NVRAM only as a
>> simple stream of bytes via /dev/nvram, which must be interpreted in user
>> space by the nvram command in the powerpc-utils package. This patch set
>> exploits the pstore subsystem to expose each partition in NVRAM as a
>> separate file in /dev/pstore. For instance Oops messages will stored in a
>> file named [dmesg-nvram-2].
>>
>> Changes from v1:
>>          - Reduce #ifdefs by and remove forward declarations of pstore callbacks
>>          - Handle return value of nvram_write_os_partition
>>          - Remove empty pstore callbacks and register pstore only when pstore
>>            is configured
>>
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
> This series looks good! Other than the naming conventions (are these
> new pstore types really PPC-only?) I think it's a fine addition.
>
> Thanks!

The new pstore types are PPC specific. Hence it would be better to have the
(_PPC) in the type ids so that other does not end up using these ids.

> -Kees
>
> --
> Kees Cook
> Chrome OS Security
>
