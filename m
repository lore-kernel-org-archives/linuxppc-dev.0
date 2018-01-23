Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQpHz4hcMzDrCf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 23:58:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh
 <brijesh.singh@amd.com>, devicetree@vger.kernel.org, Albert Herranz
 <albert_herranz@yahoo.es>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, linux-gpio@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/6] resource: Extend the PPC32 reserved memory hack
In-Reply-To: <20180122050411.32460-2-j.neuschaefer@gmx.net>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-2-j.neuschaefer@gmx.net>
Date: Tue, 23 Jan 2018 23:58:06 +1100
Message-ID: <871sigwx41.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> On the Nintendo Wii, there are two ranges of physical memory, and MMIO
> in between, but Linux on ppc32 doesn't support discontiguous memory.
> Therefore a hack was introduced in commit c5df7f775148 ("powerpc: allow
> ioremap within reserved memory regions") and commit de32400dd26e ("wii:
> use both mem1 and mem2 as ram"):
>
>  - Treat the area from the start of the first memory area (MEM1) to the
>    end of the second (MEM2) as one big memory area, but mark the part
>    that doesn't belong to MEM1 or MEM2 as reserved.
>  - Only on the Wii, allow ioremap to be used on reserved memory.
>
> This hack, however, doesn't account for the "resource"-based API in
> kernel/resource.c, because __request_region performs its own checks.
>
> Extend the hack to kernel/resource.c, to allow more drivers to allocate
> their MMIO regions on the Wii.

Hi Jonathan,

Sorry but I can't merge a hack like this in generic code.

Has anyone looked at adding proper discontig mem support to PPC32?

Or can we punch a hole in the resource in the right place? Maybe from
add_system_ram_resources() ?

cheers
