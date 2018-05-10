Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hZlw5f7TzF2Ch
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 00:06:52 +1000 (AEST)
In-Reply-To: <20180508070517.947-2-clg@kaod.org>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [v2,
 1/4] powerpc/64/kexec: fix race in kexec when XIVE is shutdown
Message-Id: <40hZlp6plSz9s1B@ozlabs.org>
Date: Fri, 11 May 2018 00:06:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-08 at 07:05:14 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> The kexec_state KEXEC_STATE_IRQS_OFF barrier is reached by all
> secondary CPUs before the kexec_cpu_down() operation is called on
> secondaries. This can raise conflicts and provoque errors in the XIVE
> hcalls when XIVE is shutdown with H_INT_RESET on the primary CPU.
> 
> To synchronize the kexec_cpu_down() operations and make sure the
> secondaries have completed their task before the primary starts doing
> the same, let's move the primary kexec_cpu_down() after the
> KEXEC_STATE_REAL_MODE barrier.
> 
> This change of the ending sequence of kexec is mostly useful on the
> pseries platform but it impacts also the powernv, ps3 and 85xx
> platforms. powernv can be easily tested and fixed but some caution is
> required for the other two.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d2b04b0c78881ef1c051cc3a4a2c61

cheers
