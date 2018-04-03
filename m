Return-Path: <srs0=vg/o=gy=gmail.com=kernelfans@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FZ775hnVzF24h
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 13:18:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40FZ7730fnz8vRy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 13:18:43 +1000 (AEST)
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40FZ766dHGz9s1b
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2018 13:18:42 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id q84so20193774iod.10
 for <linuxppc-dev@ozlabs.org>; Mon, 02 Apr 2018 20:18:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152265064158.23251.10213309407765206304.stgit@jupiter.in.ibm.com>
References: <152265046485.23251.1392824827444770657.stgit@jupiter.in.ibm.com>
 <152265064158.23251.10213309407765206304.stgit@jupiter.in.ibm.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 3 Apr 2018 11:18:40 +0800
Message-ID: <CAFgQCTu0qLrHuuiaCpPPEoFesz+19V+0CCQY-rjPz2chcNL1gw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] powerpc/fadump: Do not allow hot-remove memory
 from fadump reserved area.
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I think CMA has protected us from hot-remove, so this patch is not necessary.

Regards,
Pingfan

On Mon, Apr 2, 2018 at 2:30 PM, Mahesh J Salgaonkar
<mahesh@linux.vnet.ibm.com> wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> For fadump to work successfully there should not be any holes in reserved
> memory ranges where kernel has asked firmware to move the content of old
> kernel memory in event of crash. But this memory area is currently not
> protected from hot-remove operations. Hence, fadump service can fail to
> re-register after the hot-remove operation, if hot-removed memory belongs
> to fadump reserved region. To avoid this make sure that memory from fadump
> reserved area is not hot-removable if fadump is registered.
>
> However, if user still wants to remove that memory, he can do so by
> manually stopping fadump service before hot-remove operation.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/fadump.h               |    2 +-
>  arch/powerpc/kernel/fadump.c                    |   10 ++++++++--
>  arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++--
>  3 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
> index 44b6ebfe9be6..d16dc77107a8 100644
> --- a/arch/powerpc/include/asm/fadump.h
> +++ b/arch/powerpc/include/asm/fadump.h
> @@ -207,7 +207,7 @@ struct fad_crash_memory_ranges {
>         unsigned long long      size;
>  };
>
> -extern int is_fadump_boot_memory_area(u64 addr, ulong size);
> +extern int is_fadump_memory_area(u64 addr, ulong size);
>  extern int early_init_dt_scan_fw_dump(unsigned long node,
>                 const char *uname, int depth, void *data);
>  extern int fadump_reserve_mem(void);
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 59aaf0357a52..2c3c7e655eec 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -162,13 +162,19 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
>
>  /*
>   * If fadump is registered, check if the memory provided
> - * falls within boot memory area.
> + * falls within boot memory area and reserved memory area.
>   */
> -int is_fadump_boot_memory_area(u64 addr, ulong size)
> +int is_fadump_memory_area(u64 addr, ulong size)
>  {
> +       u64 d_start = fw_dump.reserve_dump_area_start;
> +       u64 d_end = d_start + fw_dump.reserve_dump_area_size;
> +
>         if (!fw_dump.dump_registered)
>                 return 0;
>
> +       if (((addr + size) > d_start) && (addr <= d_end))
> +               return 1;
> +
>         return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
>  }
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index c1578f54c626..e4c658cda3a7 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -389,8 +389,11 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
>         phys_addr = lmb->base_addr;
>
>  #ifdef CONFIG_FA_DUMP
> -       /* Don't hot-remove memory that falls in fadump boot memory area */
> -       if (is_fadump_boot_memory_area(phys_addr, block_sz))
> +       /*
> +        * Don't hot-remove memory that falls in fadump boot memory area
> +        * and memory that is reserved for capturing old kernel memory.
> +        */
> +       if (is_fadump_memory_area(phys_addr, block_sz))
>                 return false;
>  #endif
>
>
