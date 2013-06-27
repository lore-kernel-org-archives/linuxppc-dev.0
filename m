Return-Path: <keescook@google.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13B162C0084
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 01:36:08 +1000 (EST)
Received: by mail-ie0-f180.google.com with SMTP id f4so1801739iea.39
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 08:36:05 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20130627082941.16749.67023.stgit@aruna-ThinkPad-T420>
References: <20130627082941.16749.67023.stgit@aruna-ThinkPad-T420>
Date: Thu, 27 Jun 2013 08:36:05 -0700
Message-ID: <CAGXu5j+5G9uwV+NVW1E3YzQtGqJnm0vV1eZWuPEtTC=2wmyG8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Nvram-to-pstore: compression support for oops data
From: Kees Cook <keescook@chromium.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jkenisto@linux.vnet.ibm.com, Tony Luck <tony.luck@intel.com>,
 Anton Vorontsov <cbouatmailru@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, Colin Cross <ccross@android.com>, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 27, 2013 at 1:32 AM, Aruna Balakrishnaiah
<aruna@linux.vnet.ibm.com> wrote:
> Changes from v1:
>                 - Add header size argument in the pstore write callback
>                 instead of a separate API to return header size.
>
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
>         Register pstore with big_oops_buf.
>
> In case compression fails, copy header added by pstore and
> last oops_data_sz bytes (recent messages) of big_oops_buf to
> nvram for which we need to know header size.
>
> patch 01/03 adds an additional argument for header size in pstore_write callback.
>
> pstore read callback of nvram will read the compressed data and return the
> decompressed data so that dmesg file (under /dev/pstore) is readable.
>
> In case decompression fails, instead of having the compressed data (junk) in the
> dmesg file it will skip and continue reading other partitions. This results in
> absence of dmesg file but will still have files relating to other parititons.

This seems good to me. I'm starting to ponder if we need to have some
kind of regular header structure that backends can extend, but that
doesn't need to be part of this series. :)

Acked-by: Kees Cook <keescook@chromium.org>

Thanks,

-Kees

--
Kees Cook
Chrome OS Security
