Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4S3m0J1nzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 17:12:04 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id gh9so2957007pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 00:12:03 -0700 (PDT)
Message-ID: <1462950715.20338.3.camel@gmail.com>
Subject: Re: [v2,2/2] powerpc/mm: Ensure "special" zones are empty
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Oliver O'Halloran
 <oohall@gmail.com>,  linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Date: Wed, 11 May 2016 17:11:55 +1000
In-Reply-To: <3r3fQw4Xbnz9t79@ozlabs.org>
References: <3r3fQw4Xbnz9t79@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-10 at 09:55 +1000, Michael Ellerman wrote:
> On Thu, 2016-05-05 at 07:54:09 UTC, Oliver O'Halloran wrote:
> > 
> > The mm zone mechanism was traditionally used by arch specific code to
> > partition memory into allocation zones. However there are several zones
> > that are managed by the mm subsystem rather than the architecture. Most
> > architectures set the max PFN of these special zones to zero, however on
> > powerpc we set them to ~0ul. This, in conjunction with a bug in
> > free_area_init_nodes() results in all of system memory being placed in
> > ZONE_DEVICE when enabled. Device memory cannot be used for regular kernel
> > memory allocations so this will cause a kernel panic at boot.
> This is breaking my freescale machine:
> 
>   Sorting __ex_table...
>   Unable to handle kernel paging request for data at address 0xc000000101e28020
>   Faulting instruction address: 0xc0000000009ab698
>   cpu 0x0: Vector: 300 (Data Access) at [c000000000acbb30]
>       pc: c0000000009ab698: .reserve_bootmem_region+0x64/0x8c
>       lr: c0000000009883d0: .free_all_bootmem+0x70/0x200
>       sp: c000000000acbdb0
>      msr: 80021000
>      dar: c000000101e28020
>    dsisr: 800000
>     current = 0xc000000000a07640
>     paca    = 0xc00000003fff5000	 softe: 0	 irq_happened: 0x01
>       pid   = 0, comm = swapper
>   Linux version 4.6.0-rc3-00160-gc09920947f23 (michael@ka1) (gcc version 5.3.0 (GCC) ) #5 SMP Tue May 10 09:44:11 AEST 2016
>   enter ? for help
>   [link register   ] c0000000009883d0 .free_all_bootmem+0x70/0x200
>   [c000000000acbdb0] c000000000988398 .free_all_bootmem+0x38/0x200 (unreliable)
>   [c000000000acbe80] c00000000097b700 .mem_init+0x5c/0x7c
>   [c000000000acbef0] c000000000971a0c .start_kernel+0x28c/0x4e4
>   [c000000000acbf90] c000000000000544 start_here_common+0x20/0x5c
>   0:mon> ? 
> 
> I can give you access some time if you need to debug it.
> 


Could you also please post the bits on the boot containing the zone
and node information. That would provide some information about what
is broken. Or you could just send the whole dmesg

Thanks,
Balbir Singh
