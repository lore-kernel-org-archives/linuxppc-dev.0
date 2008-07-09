Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7819ADDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 00:26:51 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69EQg27026123
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 10:26:42 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m69EQW3I102948
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 08:26:32 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m69EQVQw017299
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 08:26:31 -0600
Date: Wed, 9 Jul 2008 10:23:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
Message-ID: <20080709102308.4735d48a@zod.rchland.ibm.com>
In-Reply-To: <20080708055449.EDFDADDEF5@ozlabs.org>
References: <20080708055449.EDFDADDEF5@ozlabs.org>
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

On Tue, 08 Jul 2008 15:54:40 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This is some preliminary work to improve TLB management on SW loaded
> TLB powerpc platforms. This introduce support for non-atomic PTE
> operations in pgtable-ppc32.h and removes write back to the PTE from
> the TLB miss handlers. In addition, the DSI interrupt code no longer
> tries to fixup write permission, this is left to generic code, and
> _PAGE_HWWRITE is gone.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Boots for me now.  So far it's surviving a dbench run, and I'll try
hackbench/kernbench shortly.

I've got this queued up in my -next branch.

josh
