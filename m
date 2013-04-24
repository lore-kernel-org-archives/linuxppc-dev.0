Return-Path: <keescook@google.com>
Received: from mail-oa0-f49.google.com (mail-oa0-f49.google.com
 [209.85.219.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0955E2C00EB
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 06:45:08 +1000 (EST)
Received: by mail-oa0-f49.google.com with SMTP id j1so2213338oag.36
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 13:45:06 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
References: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
Date: Wed, 24 Apr 2013 13:45:06 -0700
Message-ID: <CAGXu5jLrtMFXh28b2uV6+U8vdXRfLxmjKRo8i5YF8bmkeK_sKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] powerpc/pseries: Nvram-to-pstore
From: Kees Cook <keescook@chromium.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Tue, Apr 23, 2013 at 11:19 PM, Aruna Balakrishnaiah
<aruna@linux.vnet.ibm.com> wrote:
> Currently the kernel provides the contents of p-series NVRAM only as a
> simple stream of bytes via /dev/nvram, which must be interpreted in user
> space by the nvram command in the powerpc-utils package. This patch set
> exploits the pstore subsystem to expose each partition in NVRAM as a
> separate file in /dev/pstore. For instance Oops messages will stored in a
> file named [dmesg-nvram-2].
>
> Changes from v1:
>         - Reduce #ifdefs by and remove forward declarations of pstore callbacks
>         - Handle return value of nvram_write_os_partition
>         - Remove empty pstore callbacks and register pstore only when pstore
>           is configured
>
> ---
>
> Aruna Balakrishnaiah (8):
>       powerpc/pseries: Remove syslog prefix in uncompressed oops text
>       powerpc/pseries: Add version and timestamp to oops header
>       powerpc/pseries: Introduce generic read function to read nvram-partitions
>       powerpc/pseries: Read/Write oops nvram partition via pstore
>       powerpc/pseries: Read rtas partition via pstore
>       powerpc/pseries: Distinguish between a os-partition and non-os partition
>       powerpc/pseries: Read of-config partition via pstore
>       powerpc/pseries: Read common partition via pstore
>
>
>  arch/powerpc/platforms/pseries/nvram.c |  353 +++++++++++++++++++++++++++-----
>  fs/pstore/inode.c                      |    9 +
>  include/linux/pstore.h                 |    4
>  3 files changed, 313 insertions(+), 53 deletions(-)

This series looks good! Other than the naming conventions (are these
new pstore types really PPC-only?) I think it's a fine addition.

Thanks!

-Kees

--
Kees Cook
Chrome OS Security
