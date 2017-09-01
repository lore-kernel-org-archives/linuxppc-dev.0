Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkG1d0X3fzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 20:38:45 +1000 (AEST)
Date: Fri, 1 Sep 2017 20:38:41 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.com, mpe@ellerman.id.au
Subject: Re: [PATCH RFC] KVM: PPC: Book3S: Add MMIO emulation for VMX
 instructions
Message-ID: <20170901103841.GA29876@fergus.ozlabs.ibm.com>
References: <1504045082-16178-1-git-send-email-joserz@linux.vnet.ibm.com>
 <1504045082-16178-2-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504045082-16178-2-git-send-email-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 29, 2017 at 07:18:02PM -0300, Jose Ricardo Ziviani wrote:
> This patch provides the MMIO load/store vector indexed
> X-Form emulation.
> 
> Instructions implemented: lvx, stvx
> 
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Thanks for the patch.  The basic outline of it looks fine.  The parts
where you are accessing the VMX register image in memory are a bit
hard to follow, and I'll have to check them in detail.

Longer term, I want to switch over to using the instruction emulation
infrastructure in arch/powerpc/lib/sstep.c that I have recently
expanded to handle almost all load and store instructions.  That will
reduce duplication and should simplify all of this code enormously.

Regards,
Paul.
