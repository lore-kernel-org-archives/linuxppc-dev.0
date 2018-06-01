Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86V3LywzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:54:58 +1000 (AEST)
In-Reply-To: <20180518094223.786-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH-RESEND] cxl: Disable prefault_mode in Radix mode
Message-Id: <40y86S5lLMz9s2S@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-18 at 09:42:23 UTC, Vaibhav Jain wrote:
> From: Vaibhav Jain <vaibhav@linux.ibm.com>
> 
> Currently we see a kernel-oops reported on Power-9 while attaching a
> context to an AFU, with radix-mode and sysfs attr 'prefault_mode' set
> to anything other than 'none'. The backtrace of the oops is of this
> form:
> 
> Unable to handle kernel paging request for data at address 0x00000080
> Faulting instruction address: 0xc00800000bcf3b20
> cpu 0x1: Vector: 300 (Data Access) at [c00000037f003800]
>     pc: c00800000bcf3b20: cxl_load_segment+0x178/0x290 [cxl]
>     lr: c00800000bcf39f0: cxl_load_segment+0x48/0x290 [cxl]
>     sp: c00000037f003a80
>    msr: 9000000000009033
>    dar: 80
>  dsisr: 40000000
>   current = 0xc00000037f280000
>   paca    = 0xc0000003ffffe600   softe: 3        irq_happened: 0x01
>     pid   = 3529, comm = afp_no_int
> <snip>
> [c00000037f003af0] c00800000bcf4424 cxl_prefault+0xfc/0x248 [cxl]
> [c00000037f003b50] c00800000bcf8a40 process_element_entry_psl9+0xd8/0x1a0 [cxl]
> [c00000037f003b90] c00800000bcf944c cxl_attach_dedicated_process_psl9+0x44/0x130 [cxl]
> [c00000037f003bd0] c00800000bcf5448 native_attach_process+0xc0/0x130 [cxl]
> [c00000037f003c50] c00800000bcf16cc afu_ioctl+0x3f4/0x5e0 [cxl]
> [c00000037f003d00] c00000000039d98c do_vfs_ioctl+0xdc/0x890
> [c00000037f003da0] c00000000039e1a8 ksys_ioctl+0x68/0xf0
> [c00000037f003df0] c00000000039e270 sys_ioctl+0x40/0xa0
> [c00000037f003e30] c00000000000b320 system_call+0x58/0x6c
> --- Exception: c01 (System Call) at 0000000010053bb0
> 
> The issue is caused as on Power-8 the AFU attr 'prefault_mode' was
> used to improve initial storage fault performance by prefaulting
> process segments. However on Power-9 with radix mode we don't have
> Storage-Segments that we can prefault. Also prefaulting process Pages
> will be too costly and fine-grained.
> 
> Hence, since the prefaulting mechanism doesn't makes sense of
> radix-mode, this patch updates prefault_mode_store() to not allow any
> other value apart from CXL_PREFAULT_NONE when radix mode is enabled.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: f24be42aab37 ("cxl: Add psl9 specific code")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b6c84ba22ff3a198eb8d5552cf9b8f

cheers
