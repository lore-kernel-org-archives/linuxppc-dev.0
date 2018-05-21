Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q6295YrZzF0dS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:56:49 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4L4rWe6133894
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:56:47 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j3jqk8bdp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:56:47 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 21 May 2018 05:56:45 +0100
Subject: Re: [PATCH-RESEND] cxl: Disable prefault_mode in Radix mode
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>, stable@vger.kernel.org
References: <20180518094223.786-1-vaibhav@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 21 May 2018 14:56:40 +1000
MIME-Version: 1.0
In-Reply-To: <20180518094223.786-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <aef09638-d78d-afe3-71fe-99805d7b5225@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/05/18 19:42, Vaibhav Jain wrote:
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
>      pc: c00800000bcf3b20: cxl_load_segment+0x178/0x290 [cxl]
>      lr: c00800000bcf39f0: cxl_load_segment+0x48/0x290 [cxl]
>      sp: c00000037f003a80
>     msr: 9000000000009033
>     dar: 80
>   dsisr: 40000000
>    current = 0xc00000037f280000
>    paca    = 0xc0000003ffffe600   softe: 3        irq_happened: 0x01
>      pid   = 3529, comm = afp_no_int
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
> ---
> Change-log:
> 
> Resend  ->  Updated the commit description to add more info on the
> 	    issue seen [Andrew]

Thanks for redoing the commit message.

This looks good to me.

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
