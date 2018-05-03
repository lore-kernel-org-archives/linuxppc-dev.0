Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c4sm52NmzF2Tm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 16:26:20 +1000 (AEST)
Date: Thu, 3 May 2018 16:26:12 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/11] KVM: PPC: reconstruct LOAD_VSX/STORE_VSX
 instruction mmio emulation with analyse_intr() input
Message-ID: <20180503062612.GL6795@fergus.ozlabs.ibm.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-12-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524657284-16706-12-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2018 at 07:54:44PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch reconstructs LOAD_VSX/STORE_VSX instruction MMIO emulation with
> analyse_intr() input. It utilizes VSX_FPCONV/VSX_SPLAT/SIGNEXT exported
> by analyse_instr() and handle accordingly.
> 
> When emulating VSX store, the VSX reg will need to be flushed so that
> the right reg val can be retrieved before writing to IO MEM.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Looks good, except that you shouldn't need the special case for
stxsiwx.  With size=4 and element_size=8, kvmppc_handle_vsx_store
should just do the right thing, as far as I can see.

Paul.
