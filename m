Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A8971A000A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 12:16:50 +1000 (EST)
Message-ID: <1404440209.18906.1.camel@concordia>
Subject: Re: [PATCH 1/3] powerpc/kvm: Remove redundant save of SIER AND MMCR2
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>
Date: Fri, 04 Jul 2014 12:16:49 +1000
In-Reply-To: <1404367956-19515-2-git-send-email-joel@jms.id.au>
References: <1404367956-19515-1-git-send-email-joel@jms.id.au>
 <1404367956-19515-2-git-send-email-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-03 at 15:42 +0930, Joel Stanley wrote:
> These two registers are already saved in the block above. Aside from
> being unnecessary, by the time we get down to the second save location
> r8 no longer contains MMCR2, so we are clobbering the saved value with
> PMC5.

MMCR2 primarily consists of counter freeze bits. So restoring the value of PMC5
into MMCR2 will most likely have the effect of freezing counters.

Fixes: 72cde5a88d37 ("KVM: PPC: Book3S HV: Save/restore host PMU registers that are new in POWER8")
Cc: stable@vger.kernel.org

With the above added:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
