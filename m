Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AEAA0DDEE7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:10:05 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67E9vNR019336
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:09:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67E9nvO097414
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:09:49 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67E9noF024575
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:09:49 -0400
Date: Mon, 7 Jul 2008 10:06:27 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
Message-ID: <20080707100627.4be05488@zod.rchland.ibm.com>
In-Reply-To: <20080701043607.07484DDED7@ozlabs.org>
References: <20080701043607.07484DDED7@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 01 Jul 2008 14:35:42 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This is some preliminary work to improve TLB management on SW loaded
> TLB powerpc platforms. This introduce support for non-atomic PTE
> operations in pgtable-ppc32.h and removes write back to the PTE from
> the TLB miss handlers. In addition, the DSI interrupt code no longer
> tries to fixup write permission, this is left to generic code, and
> _PAGE_HWWRITE is gone.

I tried testing this on a Sequoia board this morning.  Kernel boots,
but then it hangs when starting the init process.  The last message
seen is:

INIT: version 2.86
booting                                                      

The setup is an tftp'd kernel via U-Boot using cuImage, nfsroot
filesystem.  Sequoia has an FPU, and CONFIG_PPC_FPU is set.

I reverted this patch and used the latest powerpc-next branch and it
boots fine.

Seems something is wrong here still.  I suspect the DSI handler
changes, but I have no proof and haven't debugged it yet.  Until we
get it fixed, I don't feel overly comfortable putting it in the next
branch.  Which board and setup did you test with?

josh
