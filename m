Return-Path: <dave@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B64FB700E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 03:52:10 +1100 (EST)
Received: from /spool/local by us.ibm.com with XMail ESMTP
	for <linuxppc-dev@lists.ozlabs.org> from <dave@linux.vnet.ibm.com>;
	Wed, 5 Oct 2011 10:52:08 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p95Gq2XO193308
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Oct 2011 10:52:03 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p95Gq2aP025685
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Oct 2011 10:52:02 -0600
Subject: Re: Defintion of kernstart_addr
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Suzuki Poulose <suzuki@in.ibm.com>
In-Reply-To: <4E8C525F.4090000@in.ibm.com>
References: <4E8C525F.4090000@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 Oct 2011 09:51:58 -0700
Message-ID: <1317833518.7842.92.camel@nimitz>
Mime-Version: 1.0
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-10-05 at 18:19 +0530, Suzuki Poulose wrote:
> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) -
>                                                 PHYSICAL_START + KERNELBASE)
> 
> where,
>         PHYSICAL_START is #define'd to kernstart_addr variable, updated at boot 

Where kernstart_addr is the physical address of where we loaded the
kernel.  But, this has the side-effect of also shifting the kernel's
identity mapping (the 1:1 virtual-to-physical map) up by that amount.

I'm unconvinced that this movement of the identity mapping is necessary.

Even if it is, Suzuki mentions:

> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - 
>                                                 PHYSICAL_START + KERNELBASE)
> where:
>  PHYSICAL_START is kernstart_addr - a variable updated at runtime.
>  KERNELBASE     is the compile time Virtual base address of kernel.
> 
> This won't work for us, as the kernstart_addr may change at runtime, even
> though the mapping doesn't change.

That seems to tell me that PHYSICAL_START and kernstart_addr shouldn't
be the same variable.  We should break them apart so that we can move
the kernel's starting physical address without changing the virt/phys
mapping.

Which, I'm fearing, was what Suzuki's first patch did, and I failed to
grok it.

-- Dave
