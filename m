Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0140.outbound.protection.outlook.com [157.56.111.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB01F1A0D2C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 09:43:56 +1100 (AEDT)
Message-ID: <1424731420.4698.13.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/kvm: Convert openpic lock to raw_spinlock
From: Scott Wood <scottwood@freescale.com>
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Date: Mon, 23 Feb 2015 16:43:40 -0600
In-Reply-To: <1424251955-308-2-git-send-email-bogdan.purcareata@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <1424251955-308-2-git-send-email-bogdan.purcareata@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, agraf@suse.de, mihai.caraman@freescale.com,
 pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-18 at 09:32 +0000, Bogdan Purcareata wrote:
> This patch enables running intensive I/O workloads, e.g. netperf, in a guest
> deployed on a RT host. It also enable guests to be SMP.
> 
> The openpic spinlock becomes a sleeping mutex on a RT system. This no longer
> guarantees that EPR is atomic with exception delivery. The guest VCPU thread
> fails due to a BUG_ON(preemptible()) when running netperf.
> 
> In order to make the kvmppc_mpic_set_epr() call safe on RT from non-atomic
> context, convert the openpic lock to a raw_spinlock. A similar approach can
> be seen for x86 platforms in the following commit [1].
> 
> Here are some comparative cyclitest measurements run inside a high priority RT
> guest run on a RT host. The guest has 1 VCPU and the test has been run for 15
> minutes. The guest runs ~750 hackbench processes as background stress.
> 
>                   spinlock  raw_spinlock
> Min latency (us)  4         4
> Avg latency (us)  15        19
> Max latency (us)  70        62
> 
> [1] https://lkml.org/lkml/2010/1/11/289
> 
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
> Reviewed-by: Scott Wood <scottwood@freescale.com>

Where did that Reviewed-by: come from?

A +1 in Gerrit on an internal tree does not translate into an upstream
Reviewed-by.

-Scott
