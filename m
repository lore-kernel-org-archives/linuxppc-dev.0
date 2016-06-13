Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT2QR0fDbzDqcG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 05:09:34 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DJ8lNO002070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 15:09:32 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gf58sq0t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 15:08:36 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 16:08:24 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0051D1DC0072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 15:08:15 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DJ8M4g4960492
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 16:08:22 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DJ8Lu1017357
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 16:08:21 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/8] kexec_file: Generalize kexec_add_buffer.
Date: Mon, 13 Jun 2016 16:08:19 -0300
In-Reply-To: <20160613072939.GD4974@dhcp-128-65.nay.redhat.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1465701022-11601-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160613072939.GD4974@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <11831785.bAnhpkoBlL@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Dave,

Thanks for the quick review and for your comments.

I'll separate the change to add arch_walk_system_ram and the change to add 
kexec_locate_mem_hole into different patches, and add error handling for 
KEXEC_ON_CRASH.

Am Montag, 13 Juni 2016, 15:29:39 schrieb Dave Young:
> On 06/12/16 at 12:10am, Thiago Jung Bauermann wrote:
> > Allow architectures to specify different memory walking functions for
> > kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
> > but PowerPC uses the memblock subsystem.
> 
> Can the crashk_res be inserted to iomem_resource so that only one
> weak function for system ram is needed?

Sorry, it's not clear to me what you mean by inserting crashk_res into 
iomem_resource, but I can add a bool for_crashkernel to arch_walk_system_ram 
so that it can decide which kind of memory to traverse, so the default 
implementation of kexec_file.c would be:

int __weak arch_walk_system_ram(bool for_crashkernel, unsigned long start,
				unsigned long end, bool top_down,
				void *data,
				int (*func)(u64, u64, void *))
{
	int ret;

	if (for_crashkernel)
		ret = walk_iomem_res_desc(crashk_res.desc,
					  IORESOURCE_SYSTEM_RAM |
					  IORESOURCE_BUSY,
					  start, end, data, func);
	else
		ret = walk_system_ram_res(start, end, data, func);

	if (ret != 1) {
		/* A suitable memory range could not be found for buffer */
		return -EADDRNOTAVAIL;
	}
}

and kexec_add_buffer / kexec_locate_mem_hole would call it with:

	if (image->type == KEXEC_TYPE_CRASH)
		ret = arch_walk_system_ram(true, crashk_res.start,
					   crashk_res.end, top_down, &buf,
					   locate_mem_hole_callback);
	else
		ret = arch_walk_system_ram(false, 0, -1, top_down, &buf,
					   locate_mem_hole_callback);

What do you think?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
