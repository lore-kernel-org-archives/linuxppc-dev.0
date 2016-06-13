Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSkJB369czDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:03:06 +1000 (AEST)
Date: Mon, 13 Jun 2016 15:02:58 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] kexec_file_load implementation for PowerPC
Message-ID: <20160613070258.GA4974@dhcp-128-65.nay.redhat.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/16 at 12:10am, Thiago Jung Bauermann wrote:
> Hello,
> 
> This patch series implements the kexec_file_load system call on PowerPC.
> 
> It starts by removing an x86 assumption from kexec_file: kexec_add_buffer uses
> iomem to find reserved memory ranges, but PowerPC uses the memblock subsystem.
> Hooks are added so that each arch can specify how memory ranges can be found.
> 
> Also, the memory-walking logic in kexec_add_buffer is useful in this
> implementation to find a free area for the purgatory's stack, so that same
> patch moves that logic to kexec_locate_mem_hole.
> 
> The kexec_file_load system call needs to apply relocations to the purgatory
> but adding code for that would duplicate functionality with the module loading
> mechanism, which also needs to apply relocations to the kernel modules.
> Therefore, this patch series factors out the module relocation code so that it
> can be shared.
> 
> One thing that is still missing is crashkernel support, which I intend to
> submit shortly.

But seems there's no error handling in patches about KEXEC_ON_CRASH?
It would be good to either sending out the whole set or handle the error
cases correctly.

[snip]

Thanks
Dave
