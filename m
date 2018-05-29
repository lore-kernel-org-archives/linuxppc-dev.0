Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vwph3WFwzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 11:18:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH-RESEND] cxl: Disable prefault_mode in Radix mode
In-Reply-To: <20180518094223.786-1-vaibhav@linux.vnet.ibm.com>
References: <20180518094223.786-1-vaibhav@linux.vnet.ibm.com>
Date: Tue, 29 May 2018 11:18:32 +1000
Message-ID: <871sdv5kev.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

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
  ^^^
This tells patch/git-am to drop the rest of the change log, which is not
what we want.

I tend to indent stack traces etc with two spaces, which avoids the
problem. Or in this case we can just drop the line as it's not really
that informative.

I've fixed it up.

cheers
