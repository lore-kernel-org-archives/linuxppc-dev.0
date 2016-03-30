Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb3lF60ryzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 10:29:45 +1100 (AEDT)
In-Reply-To: <20160308090356.GA21842@linutronix.de>
To: Sebastian Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc: mm: fixup preempt undefflow with huge pages
Message-Id: <3qb3lF4HnXz9ssP@ozlabs.org>
Date: Thu, 31 Mar 2016 10:29:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-03 at 09:03:56 UTC, Sebastian Siewior wrote:
> hugepd_free() used __get_cpu_var() once. Nothing ensured that the code
> accessing the variable did not migrate from one CPU to another and soon
> this was noticed by Tiejun Chen in 94b09d755462 ("powerpc/hugetlb:
> Replace __get_cpu_var with get_cpu_var"). So we had it fixed.
> 
> Christoph Lameter was doing his __get_cpu_var() replaces and forgot
> PowerPC. Then he noticed this and sent his fixed up batch again which
> got applied as 69111bac42f5 ("powerpc: Replace __get_cpu_var uses").
> 
> The careful reader will noticed one little detail: get_cpu_var() got
> replaced with this_cpu_ptr(). So now we have a put_cpu_var() which does
> a preempt_enable() and nothing that does preempt_disable() so we
> underflow the preempt counter.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/08a5bb2921e490939f78f38fd0

cheers
