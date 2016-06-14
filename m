Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTBjP2S7FzDqfp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:23:04 +1000 (AEST)
Date: Tue, 14 Jun 2016 09:22:55 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/8] kexec_file: Generalize kexec_add_buffer.
Message-ID: <20160614012255.GA9425@dhcp-128-65.nay.redhat.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1465701022-11601-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160613072939.GD4974@dhcp-128-65.nay.redhat.com>
 <11831785.bAnhpkoBlL@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11831785.bAnhpkoBlL@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/16 at 04:08pm, Thiago Jung Bauermann wrote:
> Hello Dave,
> 
> Thanks for the quick review and for your comments.
> 
> I'll separate the change to add arch_walk_system_ram and the change to add 
> kexec_locate_mem_hole into different patches, and add error handling for 
> KEXEC_ON_CRASH.
> 
> Am Montag, 13 Juni 2016, 15:29:39 schrieb Dave Young:
> > On 06/12/16 at 12:10am, Thiago Jung Bauermann wrote:
> > > Allow architectures to specify different memory walking functions for
> > > kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
> > > but PowerPC uses the memblock subsystem.
> > 
> > Can the crashk_res be inserted to iomem_resource so that only one
> > weak function for system ram is needed?
> 
> Sorry, it's not clear to me what you mean by inserting crashk_res into 

Hmm, I means exporting crashkernel mem to /proc/iomem like other arches
It is just oneline:
insert_resource(&iomem_resource, &crashk_res)

But your proposal below is also fine.

> iomem_resource, but I can add a bool for_crashkernel to arch_walk_system_ram 
> so that it can decide which kind of memory to traverse, so the default 
> implementation of kexec_file.c would be:
> 
> int __weak arch_walk_system_ram(bool for_crashkernel, unsigned long start,
> 				unsigned long end, bool top_down,
> 				void *data,
> 				int (*func)(u64, u64, void *))

arch_walk_mem sounds better?

> {
> 	int ret;
> 
> 	if (for_crashkernel)
> 		ret = walk_iomem_res_desc(crashk_res.desc,
> 					  IORESOURCE_SYSTEM_RAM |
> 					  IORESOURCE_BUSY,
> 					  start, end, data, func);
> 	else
> 		ret = walk_system_ram_res(start, end, data, func);
> 
> 	if (ret != 1) {
> 		/* A suitable memory range could not be found for buffer */
> 		return -EADDRNOTAVAIL;
> 	}
> }
> 
> and kexec_add_buffer / kexec_locate_mem_hole would call it with:
> 
> 	if (image->type == KEXEC_TYPE_CRASH)
> 		ret = arch_walk_system_ram(true, crashk_res.start,
> 					   crashk_res.end, top_down, &buf,
> 					   locate_mem_hole_callback);
> 	else
> 		ret = arch_walk_system_ram(false, 0, -1, top_down, &buf,
> 					   locate_mem_hole_callback);
> 
> What do you think?

Sounds good, but for_crashkernel can be image_type instead. and
image->type can be passed to the arch_walk_mem function directly.

Thanks
Dave
