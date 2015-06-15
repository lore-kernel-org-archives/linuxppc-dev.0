Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B16F1A06DB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 15:40:06 +1000 (AEST)
Date: Mon, 15 Jun 2015 15:39:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mingo@kernel.org, mpe@ellerman.id.au,
 sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 warrier@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 scottwood@freescale.com
Subject: Re: [PATCH RESEND v4 1/3] kvm/powerpc: Export kvm exit reasons
Message-ID: <20150615053943.GB15637@pale.ozlabs.ibm.com>
References: <1434344169-32438-1-git-send-email-hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434344169-32438-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 15, 2015 at 10:26:07AM +0530, Hemant Kumar wrote:
> To analyze the kvm exits with perf, we will need to map the exit codes
> with the exit reasons. Such a mapping exists today in trace_book3s.h.
> Currently its not exported to perf.
> 
> This patch moves these kvm exit reasons and their mapping from
> "arch/powerpc/kvm/trace_book3s.h" to
> "arch/powerpc/include/uapi/asm/trace_book3s.h".
> Accordingly change the include files in "trace_hv.h" and "trace_pr.h".

These are not really exit reasons so much as Power ISA interrupt
vectors, defined externally to the kernel (in the Power ISA document)
and not subject to change (at least, kernel developers can't change
them).  So I don't see why this needs to be "exported" from the
kernel.

Paul.
