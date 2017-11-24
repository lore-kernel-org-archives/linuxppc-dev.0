Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtm6X5dzDrnn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:40 +1100 (AEDT)
In-Reply-To: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powernv: Avoid calling trace tlbie in kexec path.
Message-Id: <3yjrtm43yYz9sRn@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:40 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-11-22 at 17:32:07 UTC, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Rebooting into a new kernel with kexec fails in trace_tlbie() which is
> called from native_hpte_clear(). This happens if the running kernel has
> CONFIG_LOCKDEP enabled. With lockdep enabled, the tracepoints always
> execute few RCU checks regardless of whether tracing is on or off.
> We are already in the last phase of kexec sequence in real mode with
> HILE_BE set. At this point the RCU check ends up in RCU_LOCKDEP_WARN and
> causes kexec to fail.
> 
> Fix this by not calling trace_tlbie() from native_hpte_clear().
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a3961f824cdbe7eb431254dc7d8f6f

cheers
