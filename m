Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 182D31A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 08:28:30 +1100 (AEDT)
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com
 [IPv6:2607:f8b0:4003:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6D554140275
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2015 08:28:29 +1100 (AEDT)
Received: by mail-oi0-f51.google.com with SMTP id x69so8699758oia.10
 for <linuxppc-dev@ozlabs.org>; Thu, 05 Feb 2015 13:28:23 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20150205193412.24669.8648.stgit@localhost.localdomain>
References: <20150205193412.24669.8648.stgit@localhost.localdomain>
Date: Thu, 5 Feb 2015 13:28:22 -0800
Message-ID: <CAGXu5jK-dRTBDkF_cfVuuQRXH80r2-TVTgPZ1fDqYoVMABfaHw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] powerpc/pstore: Add pstore support for nvram
 partitions
From: Kees Cook <keescook@chromium.org>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Tony Luck <tony.luck@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Anton Vorontsov <anton@enomsg.org>, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Colin Cross <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 5, 2015 at 11:35 AM, Hari Bathini
<hbathini@linux.vnet.ibm.com> wrote:
> This patch series adds pstore support on powernv platform to
> read different nvram partitions and write compressed data to
> oops-log nvram partition. As pseries platform already has
> pstore support, this series moves most of the common code
> for pseries and powernv platforms to a common file. Tested
> the patches successfully on both pseries and powernv
> platforms. Also, tested the patches successfully, on a kernel
> compiled with both CONFIG_PPC_PSERIES=y & CONFIG_PPC_POWERNV=y.
>
> Changes from v4:
> 1. Added a patch for y2038-safe code changes
>
> ---
>
> Hari Bathini (4):
>       powerpc/nvram: move generic code for nvram and pstore
>       pstore: Add pstore type id for PPC64 opal nvram partition
>       pstore: add pstore support on powernv
>       powerpc: make timestamp related code y2038-safe

Thanks! I skimmed this, and it looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
>
>  arch/powerpc/include/asm/nvram.h            |   50 ++
>  arch/powerpc/include/asm/rtas.h             |    5
>  arch/powerpc/kernel/nvram_64.c              |  677 +++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-nvram.c |   10
>  arch/powerpc/platforms/pseries/nvram.c      |  673 ---------------------------
>  fs/pstore/inode.c                           |    3
>  include/linux/pstore.h                      |    1
>  7 files changed, 754 insertions(+), 665 deletions(-)
>
> --
> -Hari
>



-- 
Kees Cook
Chrome OS Security
