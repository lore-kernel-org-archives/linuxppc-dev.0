Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c4sm2qZJzF2Tk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 16:26:20 +1000 (AEST)
Date: Thu, 3 May 2018 15:58:14 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/11] KVM: PPC: add GPR RA update skeleton for MMIO
 emulation
Message-ID: <20180503055814.GF6795@fergus.ozlabs.ibm.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-6-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524657284-16706-6-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2018 at 07:54:38PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> To optimize kvm emulation code with analyse_instr, adds new
> mmio_update_ra flag to aid with GPR RA update.
> 
> This patch arms RA update at load/store emulation path for both
> qemu mmio emulation or coalesced mmio emulation.

It's not clear to me why you need to do this.  The existing code
writes RA at the point where the instruction is decoded.  In later
patches, you change that so the RA update occurs after the MMIO
operation is performed.  Is there a particular reason why you made
that change?

Paul.
